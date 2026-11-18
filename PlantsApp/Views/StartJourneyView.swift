// أدوات بناء واجهة الترحيب.
import SwiftUI

// شاشة البداية قبل إضافة أول نبات.
struct StartJourneyView: View {
    // إجراء يطلب من الشاشة الرئيسية فتح نموذج التذكير.
    let onSetReminder: () -> Void

    // محتوى قابل للتمرير يضم صورة الترحيب والنص والزر.
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // صورة توضيحية للزينة، مخفية عن قارئ الشاشة.
                Image("PlantIllustration")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 184)
                    .padding(.top, 70)
                    .accessibilityHidden(true)

                // عنوان الترحيب ووصف فكرة التطبيق.
                Text("Start your plant journey!")
                    .font(.system(size: 22, weight: .bold))
                    .padding(.top, 36)

                Text("Now all your plants will be in one place and\nwe will help you take care of them :)🪴")
                    .font(.system(size: 14))
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.top, 22)

                // زر بدء إضافة أول تذكير.
                Button(action: onSetReminder) {
                    Text("Set Plant Reminder")
                        .font(.subheadline.weight(.medium))
                        .frame(maxWidth: 258)
                        .frame(height: 38)
                        .glassEffect(.regular.tint(Color("AccentColor")).interactive())
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 24)
                .padding(.top, 96)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

// معاينة شاشة البداية بالمظهر الداكن.
#Preview {
    StartJourneyView(onSetReminder: {})
        .background(.black)
        .preferredColorScheme(.dark)
}
