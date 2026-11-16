import SwiftUI

struct SetReminderView: View {
    let viewModel: PlantsViewModel
    let editingPlant: Plant?

    @Environment(\.dismiss) private var dismiss
    @State private var plantName: String
    @State private var selectedRoom: PlantRoom
    @State private var selectedLight: LightLevel
    @State private var selectedDays: WateringSchedule
    @State private var selectedWater: WaterAmount
    @State private var showDeleteConfirmation = false

    private let green = Color(red: 0.2, green: 0.5, blue: 0.41)
    private let rowColor = Color(red: 44 / 255, green: 44 / 255, blue: 46 / 255)
    private let background = Color(red: 28 / 255, green: 28 / 255, blue: 30 / 255)

    init(viewModel: PlantsViewModel, editingPlant: Plant? = nil) {
        self.viewModel = viewModel
        self.editingPlant = editingPlant
        _plantName = State(initialValue: editingPlant?.name ?? "")
        _selectedRoom = State(initialValue: editingPlant?.room ?? .bedroom)
        _selectedLight = State(initialValue: editingPlant?.light ?? .fullSun)
        _selectedDays = State(initialValue: editingPlant?.wateringDays ?? .everyDay)
        _selectedWater = State(initialValue: editingPlant?.waterAmount ?? .small)
    }

    var body: some View {
        VStack(spacing: 0) {
            ReminderHeader(
                canSave: !plantName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
                onCancel: { dismiss() },
                onSave: savePlant
            )

            ScrollView {
                VStack(spacing: 36) {
                    HStack(spacing: 8) {
                        Text("Plant Name")
                        TextField("Pothos", text: $plantName)
                            .tint(green)
                            .accessibilityLabel("Plant Name")
                    }
                    .padding(.horizontal, 16)
                    .frame(minHeight: 54)
                    .background(rowColor, in: RoundedRectangle(cornerRadius: 26))

                    RoomAndLightSection(room: $selectedRoom, light: $selectedLight)
                        .padding(.horizontal, 16)
                        .background(rowColor, in: RoundedRectangle(cornerRadius: 24))

                    WateringSection(days: $selectedDays, water: $selectedWater)
                        .padding(.horizontal, 16)
                        .background(rowColor, in: RoundedRectangle(cornerRadius: 24))

                    if editingPlant != nil {
                        Button {
                            showDeleteConfirmation = true
                        } label: {
                            Text("Delete Reminder")
                                .font(.subheadline)
                                .foregroundStyle(.red)
                                .frame(maxWidth: .infinity, minHeight: 48)
                                .background(rowColor, in: Capsule())
                        }
                        .buttonStyle(.plain)
                        .padding(.top, 24)
                    }
                }
                .font(.subheadline)
                .padding(.horizontal, 16)
                .padding(.top, 48)
                .padding(.bottom, 24)
            }
            .scrollDismissesKeyboard(.interactively)
        }
        .background(background.ignoresSafeArea())
        .foregroundStyle(.white)
        .preferredColorScheme(.dark)
        .confirmationDialog("Delete this reminder?", isPresented: $showDeleteConfirmation,
                            titleVisibility: .visible) {
            Button("Delete Reminder", role: .destructive) {
                if let editingPlant {
                    viewModel.deletePlant(id: editingPlant.id)
                    dismiss()
                }
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This plant will be removed from your list.")
        }
    }

    // MARK: - Save Plant
    private func savePlant() {
        let name = plantName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !name.isEmpty else { return }

        if var plant = editingPlant {
            plant.name = name
            plant.room = selectedRoom
            plant.light = selectedLight
            plant.wateringDays = selectedDays
            plant.waterAmount = selectedWater
            viewModel.updatePlant(plant)
        } else {
            let plant = Plant(name: name, room: selectedRoom, light: selectedLight,
                              wateringDays: selectedDays, waterAmount: selectedWater)
            viewModel.addPlant(plant)
        }
        dismiss()
    }
}

// MARK: - Header
private struct ReminderHeader: View {
    let canSave: Bool
    let onCancel: () -> Void
    let onSave: () -> Void

    var body: some View {
        HStack {
            Button(action: onCancel) {
                Image(systemName: "xmark")
                    .frame(width: 40, height: 40)
                    .glassEffect(.regular.interactive(), in: Circle())
            }
            .accessibilityLabel("Cancel")

            Spacer()
            Text("Set Reminder")
                .font(.subheadline.weight(.semibold))
            Spacer()

            Button(action: onSave) {
                Image(systemName: "checkmark")
                    .frame(width: 40, height: 40)
                    .glassEffect(
                        .regular.tint(Color(red: 0.2, green: 0.5, blue: 0.41)).interactive(),
                        in: Circle()
                    )
            }
            .disabled(!canSave)
            .opacity(canSave ? 1 : 0.5)
            .accessibilityLabel("Save reminder")
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }
}

// MARK: - Room and Light
private struct RoomAndLightSection: View {
    @Binding var room: PlantRoom
    @Binding var light: LightLevel

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Label("Room", systemImage: "location")
                Spacer()
                Picker("Room", selection: $room) {
                    ForEach(PlantRoom.allCases, id: \.self) { room in
                        Text(room.rawValue).tag(room)
                    }
                }
                .labelsHidden()
            }
            .frame(minHeight: 44)

            Divider()

            HStack {
                Label("Light", systemImage: light.symbolName)
                Spacer()
                Picker("Light", selection: $light) {
                    ForEach(LightLevel.allCases, id: \.self) { light in
                        Text(light.rawValue).tag(light)
                    }
                }
                .labelsHidden()
            }
            .frame(minHeight: 44)
        }
        .pickerStyle(.menu)
        .tint(.gray)
    }
}

// MARK: - Watering
private struct WateringSection: View {
    @Binding var days: WateringSchedule
    @Binding var water: WaterAmount

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Label("Watering Days", systemImage: "drop")
                Spacer()
                Picker("Watering Days", selection: $days) {
                    ForEach(WateringSchedule.allCases, id: \.self) { day in
                        Text(day.rawValue).tag(day)
                    }
                }
                .labelsHidden()
            }
            .frame(minHeight: 44)

            Divider()

            HStack {
                Label("Water", systemImage: "drop")
                Spacer()
                Picker("Water", selection: $water) {
                    ForEach(WaterAmount.allCases, id: \.self) { amount in
                        Text(amount.rawValue).tag(amount)
                    }
                }
                .labelsHidden()
            }
            .frame(minHeight: 44)
        }
        .pickerStyle(.menu)
        .tint(.gray)
    }
}

// MARK: - Previews
#Preview("Add Plant") {
    SetReminderView(viewModel: PlantsViewModel(defaults: nil))
}

#Preview("Edit / Delete Plant") {
    SetReminderView(
        viewModel: PlantsViewModel(defaults: nil),
        editingPlant: Plant(name: "Pothos", room: .bedroom, light: .fullSun,
                            wateringDays: .everyDay, waterAmount: .small)
    )
}
