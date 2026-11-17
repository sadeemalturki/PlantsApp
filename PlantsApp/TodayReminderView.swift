import SwiftUI

struct TodayReminderView: View {
    let viewModel: PlantsViewModel
    let onEdit: (Plant) -> Void

    var body: some View {
        VStack(spacing: 24) {
            if !viewModel.todayPlants.isEmpty {
                VStack(spacing: 12) {
                    Text(viewModel.completedCount == 0
                         ? "Your plants are waiting for a sip 💦"
                         : "\(viewModel.completedCount) of your plants feel loved today✨")
                        .font(.subheadline)
                    ProgressView(value: viewModel.progress)
                        .tint(.accentColor)
                        .animation(.easeInOut, value: viewModel.progress)
                }
                .padding(.horizontal, 24)
                .padding(.top, 32)
            }

            List {
                ForEach(viewModel.plants) { plant in
                    HStack(spacing: 12) {
                        Button {
                            viewModel.toggleWateredToday(plant)
                            Task { await viewModel.refreshNotifications() }
                        } label: {
                            Image(systemName: viewModel.isWateredToday(plant) ? "checkmark.circle.fill" : "circle")
                                .font(.title3)
                                .foregroundStyle(viewModel.isWateredToday(plant) ? Color.accentColor : .gray)
                                .frame(width: 32, height: 44)
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel(viewModel.isWateredToday(plant) ? "Mark \(plant.name) not watered" : "Water \(plant.name)")

                        Button {
                            onEdit(plant)
                        } label: {
                            VStack(alignment: .leading, spacing: 6) {
                                Label("in \(plant.room.rawValue)", systemImage: "location")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                Text(plant.name)
                                    .font(.title2)
                                    .foregroundStyle(viewModel.isWateredToday(plant) ? .secondary : .primary)
                                HStack(spacing: 8) {
                                    Label(plant.light.rawValue, systemImage: plant.light.symbol)
                                        .foregroundStyle(Color(red: 0.72, green: 0.69, blue: 0.42))
                                        .padding(.horizontal, 6)
                                        .background(Color(white: 0.12), in: RoundedRectangle(cornerRadius: 5))
                                    Label(plant.waterAmount.rawValue, systemImage: "drop")
                                        .foregroundStyle(Color(red: 0.55, green: 0.73, blue: 0.82))
                                        .padding(.horizontal, 6)
                                        .background(Color(white: 0.12), in: RoundedRectangle(cornerRadius: 5))
                                }
                                .font(.caption2)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel("Edit \(plant.name)")
                    }
                    .padding(.vertical, 4)
                    .listRowInsets(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 16))
                    .listRowBackground(Color.black)
                    .swipeActions {
                        Button("Delete", systemImage: "trash", role: .destructive) {
                            viewModel.deletePlant(plant)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
    }
}

#Preview {
    TodayReminderView(viewModel: PlantsViewModel(), onEdit: { _ in })
        .background(.black)
        .preferredColorScheme(.dark)
}
