// أدوات بناء نموذج التذكير.
import SwiftUI

// نموذج مشترك لإضافة نبات أو تعديل بياناته.
struct SetReminderView: View {
    // نموذج البيانات والنبات المراد تعديله؛ القيمة الفارغة تعني الإضافة.
    let viewModel: PlantsViewModel
    let plant: Plant?
    // إغلاق النافذة والاحتفاظ بمسودة التعديلات حتى الحفظ.
    @Environment(\.dismiss) private var dismiss
    @State private var draft = Plant()

    // ترتيب شريط الأزرار وحقول الإدخال.
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                // إغلاق النموذج دون حفظ المسودة.
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 20))
                        .frame(width: 40, height: 40)
                        .glassEffect(in: .circle)
                }
                .accessibilityLabel("Cancel")

                Spacer()
                Text("Set Reminder").font(.system(size: 16, weight: .semibold))
                Spacer()

                // تنظيف الاسم ثم إضافة النبات أو تحديثه.
                Button {
                    draft.name = draft.name.trimmingCharacters(in: .whitespacesAndNewlines)
                    if plant == nil {
                        viewModel.addPlant(draft)
                    } else {
                        viewModel.updatePlant(draft)
                    }
                    // تحديث الإشعارات وطلب الإذن ثم إغلاق النموذج.
                    Task { await viewModel.refreshNotifications(requestPermission: true) }
                    dismiss()
                } label: {
                    Image(systemName: "checkmark")
                        .font(.system(size: 24))
                        .frame(width: 40, height: 40)
                        .glassEffect(.regular.tint(Color("AccentColor")).interactive(), in: .circle)
                }
                .accessibilityLabel("Save Reminder")
                // منع الحفظ إذا كان الاسم فارغًا أو مسافات فقط.
                .disabled(draft.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 24)
            .padding(.vertical, 12)

            // إتاحة تمرير الحقول على الشاشات الصغيرة.
            ScrollView {
                VStack(spacing: 0) {
                    // ربط حقل الاسم بمسودة النبات.
                    HStack(spacing: 6) {
                        Text("Plant Name")
                        TextField("Pothos", text: $draft.name)
                            .tint(Color("AccentColor"))
                            .accessibilityLabel("Plant Name")
                    }
                    .padding(.horizontal, 18)
                    .frame(height: 54)
                    .background(Color(white: 0.17), in: Capsule())

                    VStack(spacing: 0) {
                        // اختيار غرفة النبات من الغرف المتاحة.
                        HStack(spacing: 4) {
                            Image(systemName: "location")
                            Text("Room")
                            Spacer()
                            Picker("Room", selection: $draft.room) {
                                ForEach(Room.allCases, id: \.self) { room in
                                    Text(room.rawValue).tag(room)
                                }
                            }
                            .labelsHidden()
                        }
                        .frame(minHeight: 44)

                        Divider()

                        // اختيار مستوى الإضاءة.
                        HStack(spacing: 4) {
                            Image(systemName: "sun.max")
                            Text("Light")
                            Spacer()
                            Picker("Light", selection: $draft.light) {
                                ForEach(Light.allCases, id: \.self) { light in
                                    Text(light.rawValue).tag(light)
                                }
                            }
                            .labelsHidden()
                        }
                        .frame(minHeight: 44)
                    }
                    .padding(.horizontal, 16)
                    .background(Color(white: 0.17), in: RoundedRectangle(cornerRadius: 24))
                    .padding(.top, 46)

                    VStack(spacing: 0) {
                        // تحديد الفترة بين مرات الري.
                        HStack(spacing: 4) {
                            Image(systemName: "drop")
                            Text("Watering Days")
                            Spacer()
                            Picker("Watering Days", selection: $draft.wateringDays) {
                                ForEach(WateringDays.allCases, id: \.self) { days in
                                    Text(days.rawValue).tag(days)
                                }
                            }
                            .labelsHidden()
                        }
                        .frame(minHeight: 44)

                        Divider()

                        // تحديد كمية الماء لكل مرة ري.
                        HStack(spacing: 4) {
                            Image(systemName: "drop")
                            Text("Water")
                            Spacer()
                            Picker("Water", selection: $draft.waterAmount) {
                                ForEach(WaterAmount.allCases, id: \.self) { amount in
                                    Text(amount.rawValue).tag(amount)
                                }
                            }
                            .labelsHidden()
                        }
                        .frame(minHeight: 44)
                    }
                    .padding(.horizontal, 16)
                    .background(Color(white: 0.17), in: RoundedRectangle(cornerRadius: 24))
                    .padding(.top, plant == nil ? 36 : 48)

                    // إظهار الحذف عند تعديل نبات موجود فقط.
                    if let plant {
                        Button("Delete Reminder", role: .destructive) {
                            viewModel.deletePlant(plant)
                            dismiss()
                        }
                        .buttonStyle(.plain)
                        .foregroundStyle(.red)
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(Color(white: 0.17), in: Capsule())
                        .padding(.horizontal, 6)
                        .padding(.top, 64)
                    }
                }
                // توحيد تنسيق الحقول وعرض الخيارات كقوائم.
                .font(.system(size: 16))
                .pickerStyle(.menu)
                .tint(.gray)
                .padding(.horizontal, 16)
                .padding(.top, 40)
                .padding(.bottom, 24)
            }
        }
        // تطبيق مظهر النموذج الداكن.
        .foregroundStyle(.white)
        .background(Color(white: 0.12).ignoresSafeArea())
        .preferredColorScheme(.dark)
        // تعبئة المسودة ببيانات النبات أو بالقيم الافتراضية عند الظهور.
        .onAppear { draft = plant ?? Plant() }
    }
}

// معاينة وضع إضافة تذكير.
#Preview("Add Reminder") {
    Color.black
        .sheet(isPresented: .constant(true)) {
            SetReminderView(viewModel: PlantsViewModel(), plant: nil)
        }
        .preferredColorScheme(.dark)
}

// معاينة وضع تعديل تذكير.
#Preview("Edit Reminder") {
    Color.black
        .sheet(isPresented: .constant(true)) {
            SetReminderView(viewModel: PlantsViewModel(), plant: Plant(name: "Pothos"))
        }
        .preferredColorScheme(.dark)
}
