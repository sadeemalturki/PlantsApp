import Foundation
import UserNotifications

// One upcoming reminder per plant. Watering or editing replaces that reminder.
struct PlantNotifications {
    static func requestPermission() async throws -> Bool {
        try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound])
    }

    static func cancel(_ plant: Plant) {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [plant.id.uuidString])
        center.removeDeliveredNotifications(withIdentifiers: [plant.id.uuidString])
    }

    static func schedule(_ plant: Plant, dueDate: Date) async throws {
        let center = UNUserNotificationCenter.current()
        let settings = await center.notificationSettings()
        guard settings.authorizationStatus == .authorized else { return }

        let calendar = Calendar.current
        let now = Date()
        var delivery = calendar.date(bySettingHour: 9, minute: 0, second: 0, of: dueDate) ?? dueDate
        // An overdue reminder is delivered at the next 9 AM.
        if delivery <= now {
            delivery = calendar.nextDate(after: now, matching: DateComponents(hour: 9), matchingPolicy: .nextTime) ?? now
        }

        let content = UNMutableNotificationContent()
        content.title = "Planto"
        content.body = "Hey! Let's water your \(plant.name)"
        content.sound = .default
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: delivery)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: plant.id.uuidString, content: content, trigger: trigger)
        try await center.add(request)
    }
}
