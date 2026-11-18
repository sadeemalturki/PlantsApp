
// أدوات حفظ البيانات ومراقبة تغيّراتها.
import Foundation
import Observation

// إدارة بيانات النباتات وتحديث الواجهات على المنفّذ الرئيسي.
@MainActor
@Observable
class PlantsViewModel {

    // قائمة النباتات وحالة البداية والتاريخ المستخدم ورسالة الخطأ.
    var plants: [Plant] = []
    var hasStarted = false
    var currentDate = Date()
    var errorMessage: String?

    // مخزن محلي للاحتفاظ بالبيانات بين مرات تشغيل التطبيق.
    private let defaults: UserDefaults

    // استعادة حالة البداية والنباتات المحفوظة عند إنشاء النموذج.
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults

        hasStarted = defaults.bool(forKey: "hasStarted")

        // فك بيانات النباتات المحفوظة وإظهار خطأ عند تعذّر قراءتها.
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

    // التحقق من تسجيل ري النبات في اليوم الحالي.
    func isWateredToday(_ plant: Plant) -> Bool {
        guard let date = plant.lastWateringDate else {
            return false
        }

        return Calendar.current.isDate(
            date,
            inSameDayAs: currentDate
        )
    }

    // حساب موعد الري القادم.
    func nextWateringDate(_ plant: Plant) -> Date {
        // النبات الذي لم يُسجّل ريه يُعد مستحقًا الآن.
        guard let date = plant.lastWateringDate else {
            return currentDate
        }

        // حساب الموعد من بداية يوم آخر ري.
        let calendar = Calendar.current
        let lastDay = calendar.startOfDay(for: date)

        return calendar.date(
            byAdding: .day,
            value: plant.wateringDays.days,
            to: lastDay
        ) ?? currentDate
    }

    // التحقق من استحقاق الري اليوم أو قبله.
    func needsWaterToday(_ plant: Plant) -> Bool {
        let calendar = Calendar.current

        // يشمل الاستحقاق اليوم والمواعيد المتأخرة.
        return calendar.startOfDay(
            for: nextWateringDate(plant)
        ) <= calendar.startOfDay(for: currentDate)
    }

    // النباتات المستحقة للري أو التي تم ريها اليوم.
    var todayPlants: [Plant] {
        plants.filter {
            needsWaterToday($0) || isWateredToday($0)
        }
    }

    // عدد النباتات التي تم ريها اليوم.
    var completedCount: Int {
        todayPlants.filter {
            isWateredToday($0)
        }.count
    }

    // نسبة إنجاز الري من صفر إلى واحد.
    var progress: Double {
        guard !todayPlants.isEmpty else {
            return 0
        }

        return Double(completedCount) /
               Double(todayPlants.count)
    }

    // التحقق من اكتمال جميع تذكيرات اليوم.
    var allDone: Bool {
        !todayPlants.isEmpty &&
        completedCount == todayPlants.count
    }

    // إضافة نبات وحفظ البيانات وتسجيل بدء الاستخدام.
    func addPlant(_ plant: Plant) {
        plants.append(plant)
        hasStarted = true
        savePlants()
    }

    // تحديث النبات المطابق للمعرّف وحفظ التعديل.
    func updatePlant(_ plant: Plant) {
        guard let index = plants.firstIndex(where: {
            $0.id == plant.id
        }) else {
            return
        }

        plants[index] = plant
        savePlants()
    }

    // حذف النبات وإلغاء إشعاراته وحفظ القائمة.
    func deletePlant(_ plant: Plant) {
        plants.removeAll {
            $0.id == plant.id
        }

        PlantNotifications.cancel(plant)
        savePlants()
    }

    // تبديل حالة ري النبات اليوم.
    func toggleWateredToday(_ plant: Plant) {
        guard let index = plants.firstIndex(where: {
            $0.id == plant.id
        }) else {
            return
        }

        // إلغاء علامة الري يمسح تاريخه، وتفعيلها يسجّل التاريخ الحالي.
        if isWateredToday(plant) {
            plants[index].lastWateringDate = nil
        } else {
            plants[index].lastWateringDate = currentDate
        }

        savePlants()
    }

    // حفظ النباتات وحالة البداية محليًا.
    func savePlants() {
        do {
            // تحويل النباتات إلى بيانات وحفظها مع حالة البداية.
            let data = try JSONEncoder().encode(plants)

            defaults.set(data, forKey: "plants")
            defaults.set(hasStarted, forKey: "hasStarted")

        } catch {
            errorMessage = "Your plants could not be saved."
        }
    }

    // تحديث مواعيد إشعارات الري مع إمكانية طلب الإذن.
    func refreshNotifications(
        requestPermission: Bool = false
    ) async {

        // تحديث التاريخ قبل إعادة حساب مواعيد التذكير.
        currentDate = Date()

        do {
            // طلب الإذن فقط عند الحاجة، والتوقف عند رفضه.
            if requestPermission {
                let allowed = try await
                    PlantNotifications.requestPermission()

                if !allowed {
                    return
                }
            }

            // تحديث الإشعار القادم لكل نبات.
            for plant in plants {
                try await PlantNotifications.schedule(
                    plant,
                    dueDate: nextWateringDate(plant)
                )
            }

        // إظهار خطأ الجدولة مع بقاء بيانات النباتات محفوظة.
        } catch {
            errorMessage =
                "Your plants are saved, but a watering notification could not be scheduled."
        }
    }
}

