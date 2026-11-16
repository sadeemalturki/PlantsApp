import SwiftUI

struct TodayReminderView: View {
    let viewModel: PlantsViewModel
    @State private var showAddPlant = false
    @State private var editingPlant: Plant?
    @State private var showAllPlants = false

    private let green = Color(red: 0.2, green: 0.5, blue: 0.41)

    var body: some View {
        VStack(spacing: 0) {
            PlantsHeader()

            if viewModel.plants.isEmpty {
                Spacer()
                Text("No reminders set yet..")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                Spacer()
            } else if viewModel.allCompleted && !showAllPlants {
                CompletedPlantsView()
            } else if viewModel.todayPlants.isEmpty && !showAllPlants {
                Spacer()
                Text("No reminders for today")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                Spacer()
            } else {
                if !viewModel.todayPlants.isEmpty {
                    PlantProgressView(
                        completedCount: viewModel.completedCount,
                        progress: viewModel.progress
                    )
                }

                List {
                    ForEach(showAllPlants ? viewModel.plants : viewModel.todayPlants) { plant in
                        PlantRowView(
                            plant: plant,
                            isCompleted: viewModel.isWateredToday(plant),
                            onToggle: { viewModel.toggleWateredToday(plant) },
                            onEdit: { editingPlant = plant }
                        )
                        .listRowInsets(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
                        .listRowBackground(Color.black)
                        .listRowSeparator(.hidden)
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                viewModel.deletePlant(id: plant.id)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }

            HStack {
                if !viewModel.plants.isEmpty &&
                    (showAllPlants || viewModel.allCompleted ||
                     viewModel.todayPlants.count < viewModel.plants.count) {
                    Button(showAllPlants ? "Today" : "My Plants") {
                        showAllPlants.toggle()
                    }
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                }

                Spacer()

                Button {
                    showAddPlant = true
                } label: {
                    Image(systemName: "plus")
                        .font(.title2)
                        .frame(width: 28, height: 28)
                }
                .buttonStyle(.glassProminent)
                .buttonBorderShape(.circle)
                .tint(green)
                .accessibilityLabel("Add plant reminder")
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
        }
        .background(Color.black.ignoresSafeArea())
        .foregroundStyle(.white)
        .preferredColorScheme(.dark)
        .sheet(isPresented: $showAddPlant) {
            SetReminderView(viewModel: viewModel)
                .presentationDetents([.large])
                .presentationDragIndicator(.hidden)
                .presentationCornerRadius(28)
        }
        .sheet(item: $editingPlant) { plant in
            SetReminderView(viewModel: viewModel, editingPlant: plant)
                .presentationDetents([.large])
                .presentationDragIndicator(.hidden)
                .presentationCornerRadius(28)
        }
    }
}

// MARK: - Progress
private struct PlantProgressView: View {
    let completedCount: Int
    let progress: Double

    var body: some View {
        VStack(spacing: 12) {
            if completedCount == 0 {
                Text("Your plants are waiting for a sip 💦")
            } else {
                Text("\(completedCount) of your plants feel loved today✨")
            }
            ProgressView(value: progress)
                .tint(Color(red: 0.4, green: 0.68, blue: 0.61))
                .animation(.easeInOut(duration: 0.3), value: progress)
        }
        .font(.subheadline)
        .padding(.horizontal, 24)
        .padding(.top, 28)
        .padding(.bottom, 32)
    }
}

// MARK: - Plant Row
private struct PlantRowView: View {
    let plant: Plant
    let isCompleted: Bool
    let onToggle: () -> Void
    let onEdit: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 12) {
                Button(action: onToggle) {
                    Image(systemName: isCompleted ? "checkmark.circle.fill" : "circle")
                        .font(.system(size: 22))
                        .foregroundStyle(isCompleted
                            ? Color(red: 0.16, green: 0.88, blue: 0.66) : .gray)
                        .frame(width: 32, height: 44)
                }
                .buttonStyle(.plain)
                .accessibilityLabel(isCompleted
                    ? "Undo watering \(plant.name)" : "Mark \(plant.name) as watered")

                Button(action: onEdit) {
                    VStack(alignment: .leading, spacing: 5) {
                        Label("in \(plant.room.rawValue)", systemImage: "location")
                            .font(.caption2)
                            .foregroundStyle(.gray)

                        Text(plant.name)
                            .font(.title2)
                            .foregroundStyle(.white)

                        HStack(spacing: 8) {
                            Label(plant.light.rawValue, systemImage: plant.light.symbolName)
                                .foregroundStyle(Color(red: 0.8, green: 0.78, blue: 0.52))
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Color(white: 0.1), in: RoundedRectangle(cornerRadius: 5))

                            Label(plant.waterAmount.rawValue, systemImage: "drop")
                                .foregroundStyle(Color(red: 0.79, green: 0.95, blue: 0.98))
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Color(white: 0.1), in: RoundedRectangle(cornerRadius: 5))
                        }
                        .font(.caption2)
                    }
                    .opacity(isCompleted ? 0.5 : 1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
            }
            .padding(.vertical, 10)
            Divider()
        }
    }
}

// MARK: - Completed State
private struct CompletedPlantsView: View {
    var body: some View {
        VStack(spacing: 0) {
            Image("CompletedPlantIllustration")
                .resizable()
                .scaledToFit()
                .frame(width: 190, height: 200)
                .accessibilityHidden(true)

            Text("All Done! 🎉")
                .font(.title3.weight(.semibold))
                .padding(.top, 24)

            Text("All Reminders Completed")
                .font(.caption)
                .foregroundStyle(.gray)
                .padding(.top, 10)
        }
        .padding(.top, 100)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

// MARK: - Previews
private func createPreviewModel(allCompleted: Bool) -> PlantsViewModel {
    let model = PlantsViewModel(defaults: nil)
    for (name, room) in [("Monstera", PlantRoom.kitchen), ("Pothos", .bedroom),
                         ("Orchid", .livingRoom), ("Spider", .kitchen)] {
        let plant = Plant(name: name, room: room, light: .fullSun,
                          wateringDays: .everyDay, waterAmount: .small)
        model.addPlant(plant)
        if allCompleted || name != "Monstera" {
            model.toggleWateredToday(plant)
        }
    }
    return model
}

#Preview("Today Reminder") {
    TodayReminderView(viewModel: createPreviewModel(allCompleted: false))
}

#Preview("All Reminders Completed") {
    TodayReminderView(viewModel: createPreviewModel(allCompleted: true))
}

#Preview("No Reminders") {
    TodayReminderView(viewModel: PlantsViewModel(defaults: nil))
}
