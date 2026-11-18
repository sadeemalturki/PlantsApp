// أدوات التواريخ وجدولة الإشعارات المحلية.
import Foundation
import UserNotifications

// تذكير قادم واحد لكل نبات، يُستبدل عند الري أو التعديل.
struct PlantNotifications {
    // طلب السماح بعرض التنبيهات وتشغيل صوتها.
    static func requestPermission() async throws -> Bool {
        try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound])
    }

    // إزالة إشعارات النبات المنتظرة والظاهرة.
    static func cancel(_ plant: Plant) {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [plant.id.uuidString])
        center.removeDeliveredNotifications(withIdentifiers: [plant.id.uuidString])
    }

    // جدولة التذكير القادم بعد التأكد من وجود إذن.
    static func schedule(_ plant: Plant, dueDate: Date) async throws {
        let center = UNUserNotificationCenter.current()
        let settings = await center.notificationSettings()
        guard settings.authorizationStatus == .authorized else { return }

        // ضبط وقت التذكير على التاسعة صباحًا في يوم الاستحقاق.
        let calendar = Calendar.current
        let now = Date()
        var delivery = calendar.date(bySettingHour: 9, minute: 0, second: 0, of: dueDate) ?? dueDate
        // نقل التذكير المتأخر إلى أقرب تاسعة صباحًا قادمة.
        if delivery <= now {
            delivery = calendar.nextDate(after: now, matching: DateComponents(hour: 9), matchingPolicy: .nextTime) ?? now
        }

        // تجهيز عنوان الإشعار ورسالته وصوته.
        let content = UNMutableNotificationContent()
        content.title = "Planto"
        content.body = "Hey! Let's water your \(plant.name)"
        content.sound = .default
        // إنشاء إشعار لمرة واحدة؛ استخدام معرّف النبات يستبدل تذكيره السابق.
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: delivery)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: plant.id.uuidString, content: content, trigger: trigger)
        try await center.add(request)
    }
}
