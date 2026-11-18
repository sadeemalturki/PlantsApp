// أدوات البيانات والتواريخ والمعرّفات.
import Foundation

// الغرف المتاحة؛ يمكن حفظ الخيارات وعرضها في قوائم الاختيار.
enum Room: String, Codable, CaseIterable {
    case bedroom = "Bedroom"
    case livingRoom = "Living Room"
    case kitchen = "Kitchen"
    case balcony = "Balcony"
    case bathroom = "Bathroom"
}

// خيارات الإضاءة المناسبة للنبات.
enum Light: String, Codable, CaseIterable {
    case fullSun = "Full Sun"
    case partialSun = "Partial Sun"
    case lowLight = "Low Light"

    // اختيار رمز يناسب مستوى الإضاءة.
    var symbol: String {
        switch self {
        case .fullSun: return "sun.max"
        case .partialSun: return "sun.horizon"
        case .lowLight: return "moon"
        }
    }
}

// الفترات المتاحة بين مرات الري.
enum WateringDays: String, Codable, CaseIterable {
    case everyDay = "Every day"
    case everyTwoDays = "Every 2 days"
    case everyThreeDays = "Every 3 days"
    case weekly = "Once a week"
    case everyTenDays = "Every 10 days"
    case fortnightly = "Every 2 weeks"

    // تحويل فترة الري إلى عدد أيام لحساب الموعد القادم.
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

// خيارات كمية الماء لكل مرة ري.
enum WaterAmount: String, Codable, CaseIterable {
    case small = "20–50 ml"
    case medium = "50–100 ml"
    case large = "100–200 ml"
    case extraLarge = "200–300 ml"
}

// بيانات النبات؛ تدعم التعريف الفريد والحفظ والمقارنة.
struct Plant: Identifiable, Codable, Equatable {
    // معرّف ثابت لتمييز النبات وربطه بإشعاره.
    var id = UUID()
    // اسم النبات وإعدادات العناية الافتراضية.
    var name = ""
    var room: Room = .bedroom
    var light: Light = .fullSun
    var wateringDays: WateringDays = .everyDay
    var waterAmount: WaterAmount = .small
    // تاريخ آخر ري، ويكون فارغًا إذا لم يُسجّل ري.
    var lastWateringDate: Date?
}
