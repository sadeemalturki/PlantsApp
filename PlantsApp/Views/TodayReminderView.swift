
// أدوات عرض قائمة النباتات والتقدم.
import SwiftUI

// عرض تذكيرات اليوم وإجراءات الري والتعديل والحذف.
struct TodayReminderView: View {

    // مصدر بيانات النباتات وإجراء فتح التعديل.
    let viewModel: PlantsViewModel
    let onEdit: (Plant) -> Void

    // ترتيب ملخص الإنجاز وقائمة النباتات.
    var body: some View {

        VStack(spacing: 48) {

            // إظهار ملخص الإنجاز عند وجود نباتات ضمن تذكيرات اليوم.
            if !viewModel.todayPlants.isEmpty {

                VStack(spacing: 12) {

                    // تغيير الرسالة حسب عدد النباتات التي تم ريها.
                    Text(
                        viewModel.completedCount == 0
                        ? "Your plants are waiting for a sip 💦"
                        : "\(viewModel.completedCount) of your plants feel loved today✨"
                    )
                    .font(.subheadline)

                    // شريط يوضح نسبة الإنجاز مع حركة عند تغيّرها.
                    ProgressView(value: viewModel.progress)
                        .tint(
                            Color(
                                red: 0.35,
                                green: 0.65,
                                blue: 0.56
                            )
                        )
                        .scaleEffect(x: 1, y: 2)
                        .frame(height: 8)
                        .animation(
                            .easeInOut,
                            value: viewModel.progress
                        )
                }
                .padding(.horizontal, 24)
                .padding(.top, 32)
            }

            // قائمة قابلة للتمرير تعرض صفًا لكل نبات ضمن تذكيرات اليوم.
            List {

                ForEach(viewModel.todayPlants) { plant in

                    HStack(spacing: 16) {

                        // تبديل حالة الري ثم تحديث مواعيد الإشعارات.
                        Button {

                            viewModel.toggleWateredToday(plant)

                            Task {
                                await viewModel.refreshNotifications()
                            }

                        } label: {

                            // تغيير شكل علامة الري ولونها حسب حالة النبات.
                            Image(
                                systemName:
                                    viewModel.isWateredToday(plant)
                                    ? "checkmark.circle.fill"
                                    : "circle"
                            )
                            .font(.system(size: 22))
                            .foregroundStyle(
                                viewModel.isWateredToday(plant)
                                ? Color(
                                    red: 0.12,
                                    green: 0.84,
                                    blue: 0.67
                                )
                                : Color.gray
                            )
                            .frame(width: 32, height: 44)
                        }
                        .buttonStyle(.plain)
                        // وصف إجراء زر الري لقارئ الشاشة.
                        .accessibilityLabel(
                            viewModel.isWateredToday(plant)
                            ? "Mark \(plant.name) not watered"
                            : "Water \(plant.name)"
                        )

                        // فتح تعديل النبات عند الضغط على تفاصيله.
                        Button {

                            onEdit(plant)

                        } label: {

                            VStack(
                                alignment: .leading,
                                spacing: 6
                            ) {

                                // عرض الغرفة التي يوجد فيها النبات.
                                HStack(spacing: 4) {

                                    Image(systemName: "location")

                                    Text("in \(plant.room.rawValue)")
                                }
                                .font(.system(size: 14))
                                .foregroundStyle(.secondary)

                                // عرض الاسم بلون أخف عند اكتمال الري.
                                Text(plant.name)
                                    .font(.system(size: 24))
                                    .foregroundStyle(
                                        viewModel.isWateredToday(plant)
                                        ? .secondary
                                        : .primary
                                    )

                                HStack(spacing: 8) {

                                    // شارة توضح مستوى الإضاءة ورمزه.
                                    HStack(spacing: 4) {

                                        Image(
                                            systemName: plant.light.symbol
                                        )

                                        Text(plant.light.rawValue)
                                    }
                                    .foregroundStyle(
                                        Color(
                                            red: 0.72,
                                            green: 0.69,
                                            blue: 0.42
                                        )
                                    )
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 3)
                                    .background(
                                        Color(white: 0.12),
                                        in: RoundedRectangle(
                                            cornerRadius: 5
                                        )
                                    )

                                    // شارة توضح كمية الماء المطلوبة.
                                    HStack(spacing: 4) {

                                        Image(systemName: "drop")

                                        Text(plant.waterAmount.rawValue)
                                    }
                                    .foregroundStyle(
                                        Color(
                                            red: 0.55,
                                            green: 0.73,
                                            blue: 0.82
                                        )
                                    )
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 3)
                                    .background(
                                        Color(white: 0.12),
                                        in: RoundedRectangle(
                                            cornerRadius: 5
                                        )
                                    )
                                }
                                .font(.system(size: 12))
                            }
                            // توسيع مساحة الضغط لتشمل منطقة التفاصيل.
                            .frame(
                                maxWidth: .infinity,
                                alignment: .leading
                            )
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel("Edit \(plant.name)")
                    }
                    // تنسيق مسافات الصف وخلفيته والفاصل السفلي.
                    .padding(.vertical, 8)
                    .listRowInsets(
                        EdgeInsets(
                            top: 4,
                            leading: 8,
                            bottom: 4,
                            trailing: 16
                        )
                    )
                    .listRowBackground(Color.black)
                    .listRowSeparator(.hidden)
                    .overlay(alignment: .bottom) {

                        Rectangle()
                            .fill(Color(white: 0.15))
                            .frame(height: 0.5)
                    }
                    // إظهار خيار حذف النبات عند السحب على الصف.
                    .swipeActions {

                        Button(
                            "Delete",
                            systemImage: "trash",
                            role: .destructive
                        ) {

                            viewModel.deletePlant(plant)
                        }
                    }
                }
            }
            // استخدام قائمة بسيطة بخلفية متوافقة مع الشاشة.
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
    }
}

// معاينة القائمة ببيانات تجريبية لحالات ري مختلفة.
#Preview("Today's Reminders") {

    let model = PlantsViewModel()

    model.plants = [
        Plant(name: "Monstera", room: .kitchen),
        Plant(name: "Pothos", lastWateringDate: Date()),
        Plant(
            name: "Orchid",
            room: .livingRoom,
            lastWateringDate: Date()
        ),
        Plant(
            name: "Spider",
            room: .kitchen,
            lastWateringDate: Date()
        )
    ]

    return VStack(spacing: 0) {

        HStack {

            Text("My Plants 🌱")
                .font(.system(size: 32, weight: .bold))

            Spacer()
        }
        .padding()

        Divider()

        TodayReminderView(
            viewModel: model,
            onEdit: { _ in }
        )
    }
    .background(.black)
    .preferredColorScheme(.dark)
}

