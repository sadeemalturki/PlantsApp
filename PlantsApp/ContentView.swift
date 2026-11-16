import SwiftUI

struct ContentView: View {
    @State private var viewModel = PlantsViewModel()
    @Environment(\.scenePhase) private var scenePhase

    var body: some View {
        Group {
            if viewModel.hasStartedJourney {
                TodayReminderView(viewModel: viewModel)
            } else {
                StartJourneyView(viewModel: viewModel)
            }
        }
        .preferredColorScheme(.dark)
        .onChange(of: scenePhase) { _, phase in
            if phase == .active {
                viewModel.refreshDay()
            }
        }
        .task {
            while !Task.isCancelled {
                viewModel.refreshDay()
                do {
                    try await Task.sleep(for: .seconds(60))
                } catch {
                    return
                }
            }
        }
        .alert("Unable to Save or Load", isPresented: Binding(
            get: { viewModel.errorMessage != nil },
            set: { if !$0 { viewModel.errorMessage = nil } }
        )) {
            Button("OK") { viewModel.errorMessage = nil }
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
    }
}

// MARK: - Shared Header
struct PlantsHeader: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("My Plants🌱")
                .font(.title.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .padding(.vertical, 18)
            Divider()
        }
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
