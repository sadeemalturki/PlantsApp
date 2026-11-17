
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
                plants = try JSONDecoder().decode(
                    [Plant].self,
                    from: data
                )
            } catch {
                errorMessage = "Your saved plants could not be loaded."
            }
        }
    }

    // Check if a plant was watered today
    func isWateredToday(_ plant: Plant) -> Bool {
        guard let date = plant.lastWateringDate else {
            return false
        }

        return Calendar.current.isDate(
            date,
            inSameDayAs: currentDate
        )
    }

    // Calculate the next watering date
    func nextWateringDate(_ plant: Plant) -> Date {
        guard let date = plant.lastWateringDate else {
            return currentDate
        }

        let calendar = Calendar.current
        let lastDay = calendar.startOfDay(for: date)

        return calendar.date(
            byAdding: .day,
            value: plant.wateringDays.days,
            to: lastDay
        ) ?? currentDate
    }

    // Check if a reminder is due today
    func needsWaterToday(_ plant: Plant) -> Bool {
        let calendar = Calendar.current

        return calendar.startOfDay(
            for: nextWateringDate(plant)
        ) <= calendar.startOfDay(for: currentDate)
    }

    // Plants with reminders for today
    var todayPlants: [Plant] {
        plants.filter {
            needsWaterToday($0) || isWateredToday($0)
        }
    }

    // Number of completed reminders today
    var completedCount: Int {
        todayPlants.filter {
            isWateredToday($0)
        }.count
    }

    // Progress from 0 to 1
    var progress: Double {
        guard !todayPlants.isEmpty else {
            return 0
        }

        return Double(completedCount) /
               Double(todayPlants.count)
    }

    // Check if all today's reminders are completed
    var allDone: Bool {
        !todayPlants.isEmpty &&
        completedCount == todayPlants.count
    }

    // Add plant
    func addPlant(_ plant: Plant) {
        plants.append(plant)
        hasStarted = true
        savePlants()
    }

    // Update plant
    func updatePlant(_ plant: Plant) {
        guard let index = plants.firstIndex(where: {
            $0.id == plant.id
        }) else {
            return
        }

        plants[index] = plant
        savePlants()
    }

    // Delete plant
    func deletePlant(_ plant: Plant) {
        plants.removeAll {
            $0.id == plant.id
        }

        PlantNotifications.cancel(plant)
        savePlants()
    }

    // Mark plant as watered or not watered
    func toggleWateredToday(_ plant: Plant) {
        guard let index = plants.firstIndex(where: {
            $0.id == plant.id
        }) else {
            return
        }

        if isWateredToday(plant) {
            plants[index].lastWateringDate = nil
        } else {
            plants[index].lastWateringDate = currentDate
        }

        savePlants()
    }

    // Save data
    func savePlants() {
        do {
            let data = try JSONEncoder().encode(plants)

            defaults.set(data, forKey: "plants")
            defaults.set(hasStarted, forKey: "hasStarted")

        } catch {
            errorMessage = "Your plants could not be saved."
        }
    }

    // Refresh watering notifications
    func refreshNotifications(
        requestPermission: Bool = false
    ) async {

        currentDate = Date()

        do {
            if requestPermission {
                let allowed = try await
                    PlantNotifications.requestPermission()

                if !allowed {
                    return
                }
            }

            for plant in plants {
                try await PlantNotifications.schedule(
                    plant,
                    dueDate: nextWateringDate(plant)
                )
            }

        } catch {
            errorMessage =
                "Your plants are saved, but a watering notification could not be scheduled."
        }
    }
}

