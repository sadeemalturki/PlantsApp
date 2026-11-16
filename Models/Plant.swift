import Foundation

// MARK: - Care Options
enum PlantRoom: String, CaseIterable, Codable {
    case bedroom = "Bedroom"
    case livingRoom = "Living Room"
    case kitchen = "Kitchen"
    case balcony = "Balcony"
    case bathroom = "Bathroom"
}

enum LightLevel: String, CaseIterable, Codable {
    case fullSun = "Full Sun"
    case partialSun = "Partial Sun"
    case lowLight = "Low Light"

    var symbolName: String {
        switch self {
        case .fullSun: return "sun.max"
        case .partialSun: return "sun.haze"
        case .lowLight: return "moon"
        }
    }
}

enum WateringSchedule: String, CaseIterable, Codable {
    case everyDay = "Every day"
    case everyTwoDays = "Every 2 days"
    case everyThreeDays = "Every 3 days"
    case onceAWeek = "Once a week"
    case everyTenDays = "Every 10 days"
    case everyTwoWeeks = "Every 2 weeks"

    var days: Int {
        switch self {
        case .everyDay: return 1
        case .everyTwoDays: return 2
        case .everyThreeDays: return 3
        case .onceAWeek: return 7
        case .everyTenDays: return 10
        case .everyTwoWeeks: return 14
        }
    }
}

// MARK: - Plant
struct Plant: Identifiable, Codable {
    var id = UUID()
    var name: String
    var room: PlantRoom
    var light: LightLevel
    var wateringDays: WateringSchedule
    var waterAmount: WaterAmount
    var lastWateredAt: Date?
    var previousWateredAt: Date?

    func isWatered(on date: Date) -> Bool {
        guard let lastWateredAt else { return false }
        return Calendar.current.isDate(lastWateredAt, inSameDayAs: date)
    }

    func isDue(on date: Date) -> Bool {
        guard let lastWateredAt else { return true }
        let calendar = Calendar.current
        let daysSinceWatering = calendar.dateComponents(
            [.day],
            from: calendar.startOfDay(for: lastWateredAt),
            to: calendar.startOfDay(for: date)
        ).day ?? 0
        return daysSinceWatering >= wateringDays.days
    }
}

// MARK: - Water Amount
enum WaterAmount: String, CaseIterable, Codable {
    case small = "20-50 ml"
    case medium = "50-100 ml"
    case large = "100-200 ml"
    case extraLarge = "200-300 ml"
}
