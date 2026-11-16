import Foundation
import UserNotifications

@MainActor
enum PlantoNotifications {
    // MARK: - Scheduling
    static func synchronize(plants: [Plant]) async {
        let center = UNUserNotificationCenter.current()
        let pending = await center.pendingNotificationRequests()
        let oldIDs = pending.map(\.identifier).filter { $0.hasPrefix("water-") }
        center.removePendingNotificationRequests(withIdentifiers: oldIDs)
        guard !plants.isEmpty else { return }

        do {
            let allowed = try await center.requestAuthorization(options: [.alert, .sound])
            guard allowed else { return }

            for plant in plants {
                let content = UNMutableNotificationContent()
                content.title = "Planto"
                content.body = "Hey! Let's water your \(plant.name) 🌱"
                content.sound = .default

                let date = reminderDate(for: plant)
                let components = Calendar.current.dateComponents(
                    [.year, .month, .day, .hour, .minute], from: date
                )
                let trigger = UNCalendarNotificationTrigger(
                    dateMatching: components, repeats: false
                )
                let request = UNNotificationRequest(
                    identifier: "water-\(plant.id.uuidString)",
                    content: content,
                    trigger: trigger
                )
                try await center.add(request)
            }
        } catch {
            print("Notification error: \(error)")
        }
    }

    // MARK: - Reminder Date
    static func reminderDate(for plant: Plant, now: Date = Date()) -> Date {
        let calendar = Calendar.current
        var dueDay = now
        if let lastWateredAt = plant.lastWateredAt {
            dueDay = calendar.date(
                byAdding: .day, value: plant.wateringDays.days, to: lastWateredAt
            ) ?? now
        }
        dueDay = max(calendar.startOfDay(for: dueDay), calendar.startOfDay(for: now))
        let morning = calendar.date(
            bySettingHour: 9, minute: 0, second: 0, of: dueDay
        ) ?? dueDay
        return max(morning, now.addingTimeInterval(60))
    }

    // MARK: - Cancellation
    static func cancel(for id: UUID) {
        let center = UNUserNotificationCenter.current()
        let identifier = "water-\(id.uuidString)"
        center.removePendingNotificationRequests(withIdentifiers: [identifier])
        center.removeDeliveredNotifications(withIdentifiers: [identifier])
    }
}
