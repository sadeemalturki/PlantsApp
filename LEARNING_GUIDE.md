# Understanding Planto

The active Swift files are in `PlantsApp/`. The app follows this flow:

`MyApp → ContentView → screen → ViewModel function → Plant data → updated screen`

## Plant.swift — Model

`Plant` is a struct: one value containing a plant's name and care details. Its UUID gives each plant a stable identity, even when two plants have the same name.

The enums list the allowed rooms, light levels, watering intervals, and water amounts. `CaseIterable` gives pickers all the choices. `Codable` lets Swift turn these values into saved data and back again.

`lastWateringDate` is an optional date. `nil` means the plant has not been marked watered. `guard let` safely reads the date when it exists.

Tell your mentor: “My model describes a plant and limits care choices to valid values.”

## PlantsViewModel.swift — ViewModel

This class owns the array of plants. Unlike a struct copy, the same class instance can be shared by several views. `@Observable` tells SwiftUI when its data changes. `@MainActor` keeps changes on the same actor used by the interface.

- `addPlant` appends a plant.
- `updatePlant` finds its ID and replaces its saved value.
- `deletePlant` removes it and cancels its notification.
- `toggleWateredToday` sets today's date, or clears it when undoing.

Each action saves the array. `JSONEncoder` converts plants into data; `UserDefaults` stores that data. Initialization uses `JSONDecoder` to restore it. This is enough for a small learning project.

Computed properties calculate today's plants, completed count, progress, and All Done. For example, one completed reminder out of two gives `1 / 2 = 0.5`.

Tell your mentor: “The views call my ViewModel's functions. The ViewModel changes and saves the model, so it is actually connected MVVM.”

## ContentView.swift — Main screen

`@State` owns the ViewModel and sheet presentation state. `if` statements choose the welcome, list, empty, or completed screen. The optional `editingPlant` is `nil` when no edit sheet is open.

The plus button opens the add sheet. Tapping the completed illustration returns to the plant list so watering can be undone or details edited. The plus button stays available after deleting the last plant.

Tell your mentor: “ContentView decides which screen to show using the ViewModel's data.”

## StartJourneyView.swift — Welcome

`VStack`, `Text`, `Image`, and `Button` reproduce the welcome screen. The illustration is the existing project asset. `onSetReminder` is a closure: an action passed in by ContentView.

Tell your mentor: “The button asks the parent view to open the form.”

## SetReminderView.swift — Add and edit

`@State` holds a temporary `draft` plant. `$draft.name` and picker bindings allow controls to update that draft. Saving calls `addPlant` or `updatePlant`; cancelling closes the sheet without saving the draft. An empty or whitespace-only name disables Save.

The delete button calls `deletePlant`. `@Environment(\.dismiss)` supplies SwiftUI's action for closing the sheet.

Tell your mentor: “I edit a draft first, so cancelling does not accidentally change the saved plant.”

## TodayReminderView.swift — Plants and progress

`List` and `ForEach` display saved plants using their IDs. Each circle calls `toggleWateredToday`. Plant details open the edit sheet. Standard `swipeActions` provides deletion. `ProgressView` displays the fraction calculated by the ViewModel.

All saved plants remain accessible for editing. The progress calculation includes plants due today and plants watered today. A weekly plant watered today is not due again tomorrow.

Tell your mentor: “My view displays data and forwards actions; the ViewModel calculates the progress.”

## PlantNotifications.swift — Notification helper

This small helper uses Apple's UserNotifications framework. It requests permission when saving a reminder and schedules one upcoming notification per plant at 9 AM. The plant ID is also the notification ID, so edits replace the same request. Deleting cancels it.

An overdue reminder is scheduled for the next 9 AM. Watering schedules the next due date according to the selected interval. These are upcoming reminders, not an unlimited repeating notification series. Opening the app refreshes scheduling. Notification delivery also depends on the user's system permission and notification settings.

`async` and `await` let the function wait for the system without blocking the screen. `do`, `try`, and `catch` handle operations that can fail.

Tell your mentor: “The ViewModel asks the helper to schedule reminders; the operating system delivers them.”

## MyApp.swift and appearance

The existing app entry point opens ContentView. The original plant illustrations and icon are retained. The AccentColor asset supplies the green tint. Liquid Glass is applied to the existing action buttons; the content remains black and the form dark gray.

## Useful walkthrough for your mentor

1. Add two plants and show the enum pickers.
2. Tap one watering circle and explain why progress becomes 50%.
3. Water the second plant to show All Done.
4. Tap the completed illustration and undo one watering action.
5. Edit a name, then demonstrate Cancel versus Save.
6. Relaunch to show that saved plants remain.
7. Swipe to delete, then delete the last plant from its edit form.

Every screen includes a `#Preview`. Previews show layout; they do not prove saving or notifications work.
