import SwiftUI

struct StartJourneyView: View {
    let onSetReminder: () -> Void

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Image("PlantIllustration")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 190)
                    .padding(.top, 64)
                    .accessibilityHidden(true)

                Text("Start your plant journey!")
                    .font(.title3.bold())
                    .padding(.top, 32)

                Text("Now all your plants will be in one place and\nwe will help you take care of them :)🪴")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.top, 16)

                Button(action: onSetReminder) {
                    Text("Set Plant Reminder")
                        .font(.subheadline.weight(.medium))
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .glassEffect(.regular.tint(Color.accentColor).interactive())
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 52)
                .padding(.top, 92)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    StartJourneyView(onSetReminder: {})
        .background(.black)
        .preferredColorScheme(.dark)
}
