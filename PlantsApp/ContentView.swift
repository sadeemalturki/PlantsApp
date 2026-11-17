import SwiftUI

struct ContentView: View {
    @State private var viewModel = PlantsViewModel()
    @State private var showingAddReminder = false
    @State private var editingPlant: Plant?
    @State private var showingCompletedList = false
    @Environment(\.scenePhase) private var scenePhase

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("My Plants🌱")
                    .font(.title.bold())
                Spacer()
            }
            .padding()
            Divider()

            if !viewModel.hasStarted && viewModel.plants.isEmpty {
                StartJourneyView {
                    showingAddReminder = true
                }
            } else if viewModel.plants.isEmpty {
                Spacer()
                Text("No reminders set yet...")
                    .foregroundStyle(.secondary)
                Spacer()
            } else if viewModel.allDone && !showingCompletedList {
                VStack(spacing: 20) {
                    Button {
                        showingCompletedList = true
                    } label: {
                        Image("CompletedPlantIllustration")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 160, height: 190)
                            .padding(20)
                            .background(Color(white: 0.045), in: Circle())
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("All reminders completed. Show plants")
                    Text("All Done! 🎉").font(.title3.bold())
                    Text("All Reminders Completed")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 100)
                Spacer()
            } else {
                TodayReminderView(viewModel: viewModel) { plant in
                    editingPlant = plant
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.ignoresSafeArea())
        .foregroundStyle(.white)
        .preferredColorScheme(.dark)
        .safeAreaInset(edge: .bottom, alignment: .trailing) {
            if viewModel.hasStarted {
                Button {
                    showingAddReminder = true
                } label: {
                    Image(systemName: "plus")
                        .font(.title2)
                        .frame(width: 44, height: 44)
                        .glassEffect(.regular.tint(Color.accentColor).interactive(), in: .circle)
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Add Plant")
                .padding(24)
            }
        }
        .sheet(isPresented: $showingAddReminder) {
            SetReminderView(viewModel: viewModel, plant: nil)
        }
        .sheet(item: $editingPlant) { plant in
            SetReminderView(viewModel: viewModel, plant: plant)
        }
        .onChange(of: viewModel.allDone) {
            showingCompletedList = false
        }
        .task { await viewModel.refreshNotifications() }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                Task { await viewModel.refreshNotifications() }
            }
        }
        .alert("Planto", isPresented: Binding(
            get: { viewModel.errorMessage != nil },
            set: { if !$0 { viewModel.errorMessage = nil } }
        )) {
            Button("OK") { viewModel.errorMessage = nil }
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
    }
}

#Preview {
    ContentView()
}
