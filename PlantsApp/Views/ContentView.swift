// أدوات بناء الواجهة.
import SwiftUI

// الشاشة الرئيسية التي تختار المحتوى حسب حالة النباتات.
struct ContentView: View {
    // حفظ نموذج البيانات وحالات فتح الإضافة والتعديل وعرض القائمة.
    @State private var viewModel = PlantsViewModel()
    @State private var showingAddReminder = false
    @State private var editingPlant: Plant?
    @State private var showingCompletedList = false
    // مراقبة انتقال التطبيق بين النشاط والخلفية.
    @Environment(\.scenePhase) private var scenePhase

    // ترتيب عنوان الشاشة والمحتوى عموديًا.
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("My Plants 🌱")
                    .font(.system(size: 32, weight: .bold))
                Spacer()
            }
            .padding()
            Divider()

            // عرض الترحيب للمستخدم الجديد، أو الحالة الفارغة، أو اكتمال الري.
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
                    // الضغط على صورة الإنجاز يعيد عرض قائمة النباتات.
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
                // عرض تذكيرات اليوم وتحديد النبات المطلوب تعديله.
                TodayReminderView(viewModel: viewModel) { plant in
                    editingPlant = plant
                }
            }
        }
        // توسيع الواجهة وتطبيق الخلفية والألوان الداكنة.
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.ignoresSafeArea())
        .foregroundStyle(.white)
        .preferredColorScheme(.dark)
        // زر إضافة نبات في أسفل الشاشة بعد بدء الاستخدام.
        .safeAreaInset(edge: .bottom, alignment: .trailing) {
            if viewModel.hasStarted {
                Button {
                    showingAddReminder = true
                } label: {
                    Image(systemName: "plus")
                        .font(.title2)
                        .frame(width: 44, height: 44)
                        .glassEffect(.regular.tint(Color("AccentColor")).interactive(), in: .circle)
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Add Plant")
                .padding(24)
            }
        }
        // فتح نموذج إضافة تذكير جديد.
        .sheet(isPresented: $showingAddReminder) {
            SetReminderView(viewModel: viewModel, plant: nil)
        }
        // فتح نموذج تعديل النبات المحدد.
        .sheet(item: $editingPlant) { plant in
            SetReminderView(viewModel: viewModel, plant: plant)
        }
        // إعادة ضبط عرض قائمة الإنجاز عند تغير حالة الاكتمال.
        .onChange(of: viewModel.allDone) {
            showingCompletedList = false
        }
        // تحديث الإشعارات عند ظهور الشاشة.
        .task { await viewModel.refreshNotifications() }
        // تحديث التاريخ والإشعارات عند عودة التطبيق للنشاط.
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                Task { await viewModel.refreshNotifications() }
            }
        }
        // عرض رسالة الخطأ ومسحها عند إغلاق التنبيه.
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

// معاينة الشاشة داخل Xcode.
#Preview {
    ContentView()
}
