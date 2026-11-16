import SwiftUI

struct StartJourneyView: View {
    let viewModel: PlantsViewModel
    @State private var showSetReminder = false

    var body: some View {
        VStack(spacing: 0) {
            PlantsHeader()

            ScrollView {
                VStack(spacing: 20) {
                    Image("PlantIllustration")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 170, height: 190)
                        .accessibilityHidden(true)

                    Text("Start your plant journey!")
                        .font(.title3.bold())

                    Text("Now all your plants will be in one place and\nwe will help you take care of them :) 🪴")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.center)

                    Button {
                        showSetReminder = true
                    } label: {
                        Text("Set Plant Reminder")
                            .font(.subheadline.weight(.medium))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 4)
                    }
                    .buttonStyle(.glassProminent)
                    .tint(Color(red: 0.2, green: 0.5, blue: 0.41))
                    .buttonBorderShape(.capsule)
                    .padding(.horizontal, 48)
                    .padding(.top, 64)
                }
                .padding(.top, 60)
                .padding(.bottom, 24)
            }
        }
        .background(Color.black.ignoresSafeArea())
        .foregroundStyle(.white)
        .preferredColorScheme(.dark)
        .sheet(isPresented: $showSetReminder) {
            SetReminderView(viewModel: viewModel)
                .presentationDetents([.large])
                .presentationDragIndicator(.hidden)
                .presentationCornerRadius(28)
        }
    }
}

// MARK: - Preview
#Preview {
    StartJourneyView(viewModel: PlantsViewModel(defaults: nil))
}
