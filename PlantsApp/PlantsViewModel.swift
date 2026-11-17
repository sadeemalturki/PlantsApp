import Foundation
import Observation

@MainActor
@Observable
class PlantsViewModel {
    var plants: [Plant] = []
    var hasStarted = false
    var currentDate = Date()
    var errorMessage: String?
    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        hasStarted = defaults.bool(forKey: "hasStarted")
        if let data = defaults.data(forKey: "plants") {
            do {
                plants = try JSONDecoder().decode([Plant].self, from: data)
            } catch {
                errorMessage = "Your saved plants could not be loaded."
            }
        }
    }

    func isWateredToday(_ plant: Plant) -> Bool {
        guard let date = plant.lastWateringDate else { return false }
        return Calendar.current.isDate(date, inSameDayAs: currentDate)
    }

    func nextWateringDate(_ plant: Plant) -> Date {
        guard let date = plant.lastWateringDate else { return currentDate }
        return Calendar.current.date(byAdding: .day, value: plant.wateringDays.days, to: date) ?? currentDate
    }

    func needsWaterToday(_ plant: Plant) -> Bool {
        Calendar.current.startOfDay(for: nextWateringDate(plant)) <= Calendar.current.startOfDay(for: currentDate)
    }

    var todayPlants: [Plant] {
        plants.filter { needsWaterToday($0) || isWateredToday($0) }
    }

    var completedCount: Int {
        todayPlants.filter { isWateredToday($0) }.count
    }

    var progress: Double {
        guard !todayPlants.isEmpty else { return 0 }
        return Double(completedCount) / Double(todayPlants.count)
    }

    var allDone: Bool {
        !todayPlants.isEmpty && completedCount == todayPlants.count
    }

    func addPlant(_ plant: Plant) {
        plants.append(plant)
        hasStarted = true
        savePlants()
    }

    func updatePlant(_ plant: Plant) {
        guard let index = plants.firstIndex(where: { $0.id == plant.id }) else { return }
        plants[index] = plant
        savePlants()
    }

    func deletePlant(_ plant: Plant) {
        plants.removeAll { $0.id == plant.id }
        PlantNotifications.cancel(plant)
        savePlants()
    }

    func toggleWateredToday(_ plant: Plant) {
        guard let index = plants.firstIndex(where: { $0.id == plant.id }) else { return }
        plants[index].lastWateringDate = isWateredToday(plant) ? nil : currentDate
        savePlants()
    }

    func savePlants() {
        do {
            let data = try JSONEncoder().encode(plants)
            defaults.set(data, forKey: "plants")
            defaults.set(hasStarted, forKey: "hasStarted")
        } catch {
            errorMessage = "Your plants could not be saved."
        }
    }

    // Called after a change and when the app becomes active.
    func refreshNotifications(requestPermission: Bool = false) async {
        currentDate = Date()
        do {
            if requestPermission {
                let allowed = try await PlantNotifications.requestPermission()
                if !allowed { return }
            }
            for plant in plants {
                try await PlantNotifications.schedule(plant, dueDate: nextWateringDate(plant))
            }
        } catch {
            errorMessage = "Your plants are saved, but a watering notification could not be scheduled."
        }
    }
}
