import Foundation

enum Room: String, Codable, CaseIterable {
    case bedroom = "Bedroom"
    case livingRoom = "Living Room"
    case kitchen = "Kitchen"
    case balcony = "Balcony"
    case bathroom = "Bathroom"
}

enum Light: String, Codable, CaseIterable {
    case fullSun = "Full Sun"
    case partialSun = "Partial Sun"
    case lowLight = "Low Light"

    var symbol: String {
        switch self {
        case .fullSun: return "sun.max"
        case .partialSun: return "sun.horizon"
        case .lowLight: return "moon"
        }
    }
}

enum WateringDays: String, Codable, CaseIterable {
    case everyDay = "Every day"
    case everyTwoDays = "Every 2 days"
    case everyThreeDays = "Every 3 days"
    case weekly = "Once a week"
    case everyTenDays = "Every 10 days"
    case fortnightly = "Every 2 weeks"

    var days: Int {
        switch self {
        case .everyDay: return 1
        case .everyTwoDays: return 2
        case .everyThreeDays: return 3
        case .weekly: return 7
        case .everyTenDays: return 10
        case .fortnightly: return 14
        }
    }
}

enum WaterAmount: String, Codable, CaseIterable {
    case small = "20–50 ml"
    case medium = "50–100 ml"
    case large = "100–200 ml"
    case extraLarge = "200–300 ml"
}

struct Plant: Identifiable, Codable, Equatable {
    var id = UUID()
    var name = ""
    var room: Room = .bedroom
    var light: Light = .fullSun
    var wateringDays: WateringDays = .everyDay
    var waterAmount: WaterAmount = .small
    var lastWateringDate: Date?
}
