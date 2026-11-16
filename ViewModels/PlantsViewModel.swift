import Foundation
import Observation

@MainActor
@Observable
final class PlantsViewModel {
    private(set) var plants: [Plant] = []
    private(set) var hasStartedJourney = false
    private(set) var today = Date()
    var errorMessage: String?

    private let defaults: UserDefaults?
    private let storageKey = "savedPlants"
    private let journeyKey = "hasStartedPlantJourney"
    private var notificationTask: Task<Void, Never>?

    // MARK: - Load Data
    init(defaults: UserDefaults? = .standard) {
        self.defaults = defaults
        hasStartedJourney = defaults?.bool(forKey: journeyKey) ?? false
        guard let data = defaults?.data(forKey: storageKey) else { return }
        do {
            plants = try JSONDecoder().decode([Plant].self, from: data)
            hasStartedJourney = hasStartedJourney || !plants.isEmpty
        } catch {
            errorMessage = "Your saved plants could not be loaded."
        }
    }

    // MARK: - Daily Progress
    var todayPlants: [Plant] {
        plants.filter { $0.isDue(on: today) || $0.isWatered(on: today) }
    }

    var completedCount: Int {
        todayPlants.filter { $0.isWatered(on: today) }.count
    }

    var progress: Double {
        guard !todayPlants.isEmpty else { return 0 }
        return Double(completedCount) / Double(todayPlants.count)
    }

    var allCompleted: Bool {
        !todayPlants.isEmpty && completedCount == todayPlants.count
    }

    // MARK: - Plant Updates
    func refreshDay() {
        today = Date()
    }

    func addPlant(_ plant: Plant) {
        plants.append(plant)
        hasStartedJourney = true
        saveChanges()
    }

    func updatePlant(_ plant: Plant) {
        guard let index = plants.firstIndex(where: { $0.id == plant.id }) else { return }
        plants[index] = plant
        saveChanges()
    }

    func deletePlant(id: UUID) {
        plants.removeAll { $0.id == id }
        if defaults != nil {
            PlantoNotifications.cancel(for: id)
        }
        saveChanges()
    }

    func isWateredToday(_ plant: Plant) -> Bool {
        plant.isWatered(on: today)
    }

    func toggleWateredToday(_ plant: Plant) {
        refreshDay()
        guard let index = plants.firstIndex(where: { $0.id == plant.id }) else { return }
        if plants[index].isWatered(on: today) {
            plants[index].lastWateredAt = plants[index].previousWateredAt
            plants[index].previousWateredAt = nil
        } else {
            plants[index].previousWateredAt = plants[index].lastWateredAt
            plants[index].lastWateredAt = today
        }
        saveChanges()
    }

    // MARK: - Save Data
    private func saveChanges() {
        guard let defaults else { return }
        do {
            let data = try JSONEncoder().encode(plants)
            defaults.set(data, forKey: storageKey)
            defaults.set(hasStartedJourney, forKey: journeyKey)
        } catch {
            errorMessage = "Your changes could not be saved."
        }

        let previousTask = notificationTask
        let currentPlants = plants
        notificationTask = Task {
            await previousTask?.value
            await PlantoNotifications.synchronize(plants: currentPlants)
        }
    }
}
