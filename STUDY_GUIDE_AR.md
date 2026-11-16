دليل فهم مشروع Planto — للمذاكرة قبل لقاء المينتور

هذا شرح للنسخة الموجودة عند إعداد الدليل ليلة 17 نوفمبر 2026. لا يغيّر كود التطبيق. أرقام الأسطر تخص هذه النسخة؛ إذا عدّلتي الملفات لاحقًا قد تتغيّر. تجدين أدناه الكود الكامل لكل ملف مع أرقام الأسطر، ثم شرح عباراته بالترتيب. الأقواس والأسطر الفارغة لها شرح مشترك حتى لا تتكرر نفس المعلومة مئات المرات.

**فكرة المشروع بصوتك**

«تطبيقي يساعد المستخدم ينظّم العناية بنباتاته. يضيف اسم النبات ومكانه واحتياجه للضوء والماء وفترة السقي. التطبيق يعرض النباتات المستحقة اليوم، ويسمح بتحديدها كمكتملة والتراجع والتعديل والحذف. يحفظ المعلومات محليًا ويجدول إشعارًا لموعد السقي القادم».

النبات الجديد لم يُسجّل له سقي سابق، لذلك نعتبره مستحقًا اليوم. لو سقيتِ نباتًا أسبوعيًا يوم الاثنين، نعرضه مكتملًا يوم الاثنين، ثم لا يكون مستحقًا حتى الاثنين القادم. يبقى موجودًا في «My Plants» خلال الأيام بينهما.

**خريطة الملفات**

| الملف | مسؤوليته |
|---|---|
| MyApp.swift | نقطة تشغيل التطبيق وعرض أول واجهة. |
| Plant.swift | أنواع بيانات النبات والخيارات وقواعد تاريخ السقي. |
| PlantsViewModel.swift | امتلاك القائمة والإضافة والتعديل والحذف والتقدّم والحفظ. |
| ContentView.swift | اختيار البداية أو الشاشة الرئيسية، ومتابعة اليوم والأخطاء. |
| StartJourneyView.swift | شاشة الترحيب وفتح نموذج إضافة أول نبات. |
| SetReminderView.swift | نموذج الإضافة والتعديل، اختيار القيم، وتأكيد الحذف. |
| TodayReminderView.swift | قائمة اليوم، الصفوف، التقدّم، الإنجاز، والحالات الفارغة. |
| PlantoNotifications.swift | التعامل مع إشعارات iOS وحساب موعد الإشعار. |
| Assets.xcassets | الصور والألوان والأصول؛ ليس ملف كود Swift. |
| Planto.icon | أصل أيقونة التطبيق، وليس منطق تذكيرات. |
| مشروع Xcode | إعدادات البناء والملفات والهدف؛ ليس شاشة في التطبيق. |

**MVVM في مشروعك**

M = Model، بيانات النبات وقواعده الأساسية في Plant.
V = View، الشكل والأزرار والحقول في ملفات الواجهات.
VM = ViewModel، الحالة المشتركة والعمليات في PlantsViewModel.

مسار الضغط على حفظ:
SetReminderView → savePlant → addPlant أو updatePlant → saveChanges → حفظ البيانات وجدولة الإشعارات.
تراقب SwiftUI البيانات التي تقرؤها من الكائن @Observable، فتعيد تقييم الواجهات المتأثرة.

MVVM مو مجرد تسمية مجلدات. الفكرة أن الواجهة تطلب عملية، والـ ViewModel يدير البيانات. مو كل if لازم يطلع من الواجهة: شرط «اعرض هذه الشاشة» جزء من العرض؛ شرط «متى يستحق النبات السقي» قاعدة بيانات وضعناها في Model.

**قاموس لازم تفهمينه أولًا**

| الرمز أو الكلمة | معناها في مشروعك |
|---|---|
| import | يجعل أسماء مكتبة معيّنة متاحة للملف. |
| Foundation | أدوات مثل Date وUUID وCalendar وUserDefaults وJSON. |
| SwiftUI | بناء الواجهات بطريقة تصف الشكل حسب الحالة. |
| Observation | يوفّر @Observable لمراقبة تغيّر الخصائص المستخدمة. |
| UserNotifications | واجهات النظام الخاصة بالإشعارات المحلية. |
| let | قيمة لا تعيدين إسنادها بعد التهيئة. مع class يمنع تبديل المرجع، وليس تعديل كل محتوى الكائن. |
| var | قيمة يمكن تغييرها؛ وقد تكون خاصية محسوبة بدل قيمة مخزنة. |
| String | نص، مثل اسم النبات. |
| Int | عدد صحيح، مثل عدد النباتات. |
| Double | عدد عشري، مثل 0.75 للتقدّم. |
| Bool | true أو false. |
| Date | لحظة زمنية؛ ليست نصًا مكتوبًا مثل «الاثنين». |
| [Plant] | Array، مصفوفة من عناصر نوعها Plant. |
| [] | مصفوفة فارغة في هذا السياق. |
| struct | نوع قيمة؛ إسناده لمتغير آخر يعطي قيمة مستقلة من ناحية السلوك. استخدمناه للنبات والواجهات. |
| class | نوع مرجع؛ عدة واجهات يمكن أن تشترك في نفس الكائن. استخدمناه للـ ViewModel. |
| enum | نوع ذو خيارات محددة، مثل الغرف. يمنع قيمًا عشوائية غير معرّفة. |
| case | أحد الخيارات داخل enum، أو أحد فروع switch. |
| protocol | متطلبات يلتزم بها النوع، مثل View أو Identifiable. |
| : | يحدد النوع، أو الالتزام ببروتوكول، بحسب المكان. |
| = | إسناد قيمة. |
| == | مقارنة تساوي قيمتين. |
| != | عدم تساوي. |
| !value | عكس Bool؛ !true تصبح false. ليس force unwrap في هذا الاستخدام. |
| && | الشرطان لازم يكونان صحيحين. |
| \|\| | يكفي أحد الشرطين يكون صحيحًا. |
| >= | أكبر من أو يساوي. |
| . | الوصول إلى خاصية أو دالة: plant.name. |
| .bedroom | اختصار PlantRoom.bedroom عندما النوع معروف. |
| func | تعريف دالة تنفذ مهمة. |
| -> Bool | الدالة ترجع قيمة Bool. |
| return | يرجع النتيجة وينهي تنفيذ الدالة الحالية. |
| private | لا يستخدمه الكود من خارج نطاق الوصول المحدد؛ وفي الأنواع يقيّد الوصول لتفاصيلها. |
| private(set) | يسمح بالقراءة من الخارج، لكن تغيير الخاصية من داخل النوع. |
| self | القيمة أو الكائن الحالي داخل النوع. |
| init | مهيئ يضع القيم الابتدائية عند إنشاء قيمة أو كائن. |
| if / else | اختيار مسار حسب شرط. |
| switch | التعامل مع الحالات المختلفة لقيمة، مناسب جدًا لـ enum. |
| Optional مثل Plant? | إما قيمة Plant موجودة، أو nil. |
| nil | لا توجد قيمة. ليست نصًا فارغًا وليست صفرًا. |
| if let | يفك Optional بأمان داخل الفرع إذا كانت له قيمة. |
| if var | مثل if let، لكن القيمة الناتجة يمكن تعديلها. |
| guard let ... else | يجب وجود القيمة للاستمرار؛ إذا غابت نخرج مبكرًا. |
| ?. | Optional chaining؛ نفّذ الوصول إذا كانت القيمة موجودة. |
| ?? | أعطِ قيمة بديلة عند nil. |
| condition ? a : b | اختيار مختصر: a إذا الشرط صحيح، وإلا b. |
| $plantName | Binding لحالة SwiftUI، يسمح للمكوّن يقرأ ويكتب القيمة. |
| $0 | أول معامل لدالة مختصرة داخل closure، وليس Binding. |
| _ في معامل دالة | يلغي اسم المعامل عند الاستدعاء، أو يتجاهل قيمة غير مستخدمة. |
| _plantName | التخزين الذي يمثّل @State؛ يستخدم هنا لتحديد القيمة الابتدائية. ليس نفس معنى _ المستقل. |
| \\.self | Key path إلى القيمة نفسها؛ يُستخدم كهوية لخيارات enum الثابتة هنا. |
| [Plant].self | نوع Array of Plant نفسه، نعطيه للـ decoder لنعلمه ماذا ينشئ. |
| () -> Void | دالة لا تستقبل معاملات ولا ترجع قيمة مفيدة؛ مثل فعل زر. |
| closure | قطعة كود يمكن تمريرها كقيمة، مثل { dismiss() }. |
| \(expression) داخل نص | String interpolation: إدخال قيمة داخل النص. |
| // | تعليق للمبرمج، لا ينفذ كأمر. |
| { } | بداية ونهاية كتلة: نوع، دالة، شرط، محتوى View أو closure. |
| ( ) | معاملات دالة أو تجميع تعبير؛ وقد تكون جزءًا من tuple. |
| , | فصل معاملات أو عناصر. |
| الأسطر الفارغة والمسافات البادئة | ترتيب للقراءة؛ لا تضيف ميزة للتطبيق. |

**SwiftUI وإدارة الحالة**

@State: الواجهة تملك حالة محلية. مثال showAddPlant يقرر هل النموذج مفتوح. SwiftUI يحتفظ بهذه الحالة طوال بقاء هوية الواجهة، وليس مجرد كل إعادة رسم.

@Binding: واجهة فرعية تستعير قراءة وتعديل حالة يملكها الأب. RoomAndLightSection يعدّل selectedRoom في SetReminderView بدل إنشاء نسخة منفصلة لا تعود للأب.

@Observable: الـ ViewModel يجعل تغيّر الخصائص التي تقرؤها الواجهة قابلًا للتتبع. لا يعني حفظ البيانات على الجهاز؛ الحفظ وظيفة أخرى.

@Environment: قراءة قيمة من بيئة SwiftUI، مثل dismiss لإغلاق العرض الحالي وscenePhase لمعرفة نشاط المشهد.

@MainActor: يعزل الوصول لهذا النوع على الـ Main Actor الذي ترتبط به تحديثات الواجهة. لا يعني أن كل await يحجز الشاشة أو أن Task بالضرورة يعمل على thread خلفي.

var body: some View: خاصية محسوبة تصف واجهة. some View يعني أن الناتج نوع محدد يلتزم بـ View، والمترجم يستنتج تفاصيله المعقدة. ليس AnyView.

Modifier: أمر مثل .padding أو .font يرجع واجهة معدّلة. ترتيبها مهم؛ padding قبل background يجعل الخلفية تشمل المساحة المضافة.

**مكونات الواجهة المشتركة**

| المكوّن | وظيفته |
|---|---|
| VStack | ترتيب عمودي. |
| HStack | ترتيب أفقي. |
| Group | تجميع منطقي لتطبيق معدّلات مشتركة، لا يرتب العناصر مثل stack. |
| ScrollView | يسمح بالتمرير؛ مفيد مع لوحة المفاتيح والشاشات الصغيرة. |
| List | قائمة صفوف قابلة للتمرير مع دعم مثل السحب للحذف. |
| ForEach | يبني واجهات من عناصر لها هوية؛ ليس نفس for العادي الذي ينفذ أوامر. |
| Spacer | مساحة مرنة تدفع العناصر. |
| Divider | خط فاصل. |
| Text | يعرض نصًا. |
| TextField | حقل إدخال مربوط بقيمة. |
| Image("اسم") | صورة من Assets. |
| Image(systemName:) | رمز من SF Symbols. |
| Label | نص مع أيقونة. |
| Button | فعل ينفذ عند الضغط + محتوى مرئي. |
| Picker | اختيار قيمة من مجموعة. |
| ProgressView(value:) | شريط نسبة؛ هنا النطاق الافتراضي من 0 إلى 1. |
| .sheet | عرض واجهة فوق الحالية. |
| .alert | رسالة تنبيه، هنا لأخطاء الحفظ أو التحميل. |
| .confirmationDialog | خيارات تأكيد، هنا للحذف. |
| .frame | قيود للحجم والمحاذاة؛ infinity تعني ملء المساحة المتاحة، لا حجمًا لا نهائيًا فعليًا. |
| .padding | مساحة حول المحتوى، القيم بالنقاط points لا بالبكسلات. |
| .foregroundStyle | لون أو نمط للنصوص والرموز. |
| .background | خلفية. |
| .tint | لون التأكيد للمكوّنات الداعمة مثل الأزرار وPicker. |
| .opacity | الشفافية: 1 ظاهر بالكامل، 0 مخفي بصريًا. |
| .font | نمط الخط والحجم والوزن. |
| .preferredColorScheme(.dark) | طلب المظهر الداكن. |
| .ignoresSafeArea | يسمح للخلفية بالامتداد إلى حواف الشاشة؛ لا نطبقه على النصوص هنا. |
| .accessibilityLabel | اسم مفهوم لقارئ الشاشة، خاصة للأزرار التي فيها رمز فقط. |
| .accessibilityHidden(true) | تجاهل صورة زخرفية عند قراءة الشاشة. |
| .glassProminent / .glassEffect | تطبيق Liquid Glass الحقيقي على الأزرار أو المكوّن المخصص. |

في الشرح التالي: أي سطر قوس إغلاق فقط ينهي الكتلة المفتوحة، وأي سطر فارغ للفصل. العبارات الممتدة على عدة أسطر مشروحة معًا لأنها أمر واحد؛ باقي الأسطر موضّحة بأرقامها.


---

**1. MyApp.swift — الكود كاملًا**

```text
  1 | import SwiftUI
  2 | 
  3 | @main struct MyApp: App {
  4 |     var body: some Scene {
  5 |         WindowGroup {
  6 |             ContentView()
  7 |         }
  8 |     }
  9 | }
```

**شرح الأسطر بالترتيب**

| الأسطر | المعنى ولماذا كتبناه |
|---|---|
| 1 | نستورد SwiftUI حتى نستخدم App وScene وWindowGroup. |
| 3 | @main تحدد نقطة بدء التطبيق. MyApp اسم نوع struct يلتزم ببروتوكول App؛ التطبيق له نقطة دخول واحدة. |
| 4 | body هنا ترجع some Scene، لأننا نصف مشهد التطبيق، وليس عنصر واجهة عاديًا. |
| 5 | WindowGroup ينشئ مجموعة النوافذ التي يعرضها النظام للتطبيق. لا نحتاج بناء نافذة UIKit يدويًا. |
| 6 | أول واجهة داخل النافذة هي ContentView. الأقواس () تعني إنشاء قيمة من هذا النوع. |


---

**2. Plant.swift — الكود كاملًا**

```text
  1 | import Foundation
  2 | 
  3 | enum PlantRoom: String, CaseIterable, Codable {
  4 |     case bedroom = "Bedroom"
  5 |     case livingRoom = "Living Room"
  6 |     case kitchen = "Kitchen"
  7 |     case balcony = "Balcony"
  8 |     case bathroom = "Bathroom"
  9 | }
 10 | 
 11 | enum LightLevel: String, CaseIterable, Codable {
 12 |     case fullSun = "Full Sun"
 13 |     case partialSun = "Partial Sun"
 14 |     case lowLight = "Low Light"
 15 | 
 16 |     var symbolName: String {
 17 |         switch self {
 18 |         case .fullSun: return "sun.max"
 19 |         case .partialSun: return "sun.haze"
 20 |         case .lowLight: return "moon"
 21 |         }
 22 |     }
 23 | }
 24 | 
 25 | enum WateringSchedule: String, CaseIterable, Codable {
 26 |     case everyDay = "Every day"
 27 |     case everyTwoDays = "Every 2 days"
 28 |     case everyThreeDays = "Every 3 days"
 29 |     case onceAWeek = "Once a week"
 30 |     case everyTenDays = "Every 10 days"
 31 |     case everyTwoWeeks = "Every 2 weeks"
 32 | 
 33 |     var days: Int {
 34 |         switch self {
 35 |         case .everyDay: return 1
 36 |         case .everyTwoDays: return 2
 37 |         case .everyThreeDays: return 3
 38 |         case .onceAWeek: return 7
 39 |         case .everyTenDays: return 10
 40 |         case .everyTwoWeeks: return 14
 41 |         }
 42 |     }
 43 | }
 44 | 
 45 | struct Plant: Identifiable, Codable {
 46 |     var id = UUID()
 47 |     var name: String
 48 |     var room: PlantRoom
 49 |     var light: LightLevel
 50 |     var wateringDays: WateringSchedule
 51 |     var waterAmount: WaterAmount
 52 |     var lastWateredAt: Date?
 53 |     // Keep the previous date so undoing today's check restores the schedule.
 54 |     var previousWateredAt: Date?
 55 | 
 56 |     func isWatered(on date: Date) -> Bool {
 57 |         guard let lastWateredAt else { return false }
 58 |         return Calendar.current.isDate(lastWateredAt, inSameDayAs: date)
 59 |     }
 60 | 
 61 |     func isDue(on date: Date) -> Bool {
 62 |         guard let lastWateredAt else { return true }
 63 |         let calendar = Calendar.current
 64 |         let daysSinceWatering = calendar.dateComponents(
 65 |             [.day],
 66 |             from: calendar.startOfDay(for: lastWateredAt),
 67 |             to: calendar.startOfDay(for: date)
 68 |         ).day ?? 0
 69 |         return daysSinceWatering >= wateringDays.days
 70 |     }
 71 | }
 72 | 
 73 | enum WaterAmount: String, CaseIterable, Codable {
 74 |     case small = "20-50 ml"
 75 |     case medium = "50-100 ml"
 76 |     case large = "100-200 ml"
 77 |     case extraLarge = "200-300 ml"
 78 | }
```

**شرح الأسطر بالترتيب**

| الأسطر | المعنى ولماذا كتبناه |
|---|---|
| 1 | Foundation توفر UUID وDate وCalendar. |
| 3 | نعرّف نوع الغرفة enum. String تعطي كل حالة قيمة نصية خام، CaseIterable توفر allCases، وCodable تسمح بتحويل القيمة للحفظ وقراءتها. |
| 4–8 | كل سطر يعرّف غرفة مسموحة وقيمتها النصية: Bedroom، Living Room، Kitchen، Balcony، Bathroom. نختار enum بدل String حر حتى لا ندخل اسم غرفة غير مدعوم. |
| 11 | نفس الفكرة لمستويات الضوء: نص للعرض، قائمة حالات للـ Picker، وقابلية للحفظ. |
| 12–14 | الحالات الثلاث: شمس كاملة، شمس جزئية، وإضاءة منخفضة. |
| 16 | symbolName خاصية محسوبة ترجع String. لا نخزن اسم الأيقونة منفصلًا لأننا نقدر نستنتجه من مستوى الضوء. |
| 17 | switch self يسأل: ما حالة LightLevel الحالية؟ |
| 18 | إذا كانت fullSun نرجع اسم رمز SF Symbols: sun.max. |
| 19 | إذا كانت partialSun نرجع sun.haze. |
| 20 | إذا كانت lowLight نرجع moon. معالجة كل حالات enum تجعل switch كاملًا بدون default. |
| 25 | نوع مستقل لفترة السقي، بنفس بروتوكولات خيارات الغرفة. |
| 26–31 | خيارات العرض الستة: يوم، يومان، 3 أيام، أسبوع، 10 أيام، أسبوعان. rawValue نص للمستخدم؛ ليس عددًا نحسب به. |
| 33 | days خاصية محسوبة تحوّل الخيار إلى عدد صحيح نستخدمه في حساب الموعد. |
| 34–40 | switch يحول كل حالة بالتتابع إلى 1 أو 2 أو 3 أو 7 أو 10 أو 14. فصل الرقم عن النص يمنع محاولة تحليل النصوص للحصول على العدد. |
| 45 | Plant نموذج نبات. Identifiable يطلب هوية id تستخدمها List وsheet(item:). Codable تجمع Encodable وDecodable للحفظ والاسترجاع. struct مناسبة لأن النبات سجل قيم. |
| 46 | UUID يولد معرفًا فريدًا لكل نبات جديد. استخدمنا var هنا حتى يفك Codable المعرف المحفوظ عند التحميل؛ let مع قيمة ابتدائية ثابتة قد يمنع استبدال تلك القيمة أثناء فك الترميز التلقائي. الاسم ليس هوية لأن نباتين قد يكون لهما نفس الاسم. |
| 47 | اسم النبات نص ويمكن تعديله. |
| 48 | الغرفة نوعها PlantRoom، فلا نقبل إلا الخيارات المعرفة. |
| 49 | الإضاءة نوعها LightLevel. |
| 50 | فترة السقي نوعها WateringSchedule. |
| 51 | كمية الماء نوعها WaterAmount. يصح تعريف هذا النوع لاحقًا في نفس الملف. |
| 52 | آخر وقت سقي اختياري. Date? تكون nil للنبات الجديد لأننا لا نعرف له تاريخ سقي. لا نحط Date() هنا وإلا سيبدو النبات الجديد مسقيًا. |
| 53–54 | نحتفظ بتاريخ السقي السابق قبل علامة اليوم. إذا تراجعتِ عن العلامة نسترجعه بدل فقدان الجدول القديم. التعليق يشرح سبب الخاصية. |
| 56 | دالة ترجع هل سُقي النبات في نفس اليوم الذي مررناه. الاستدعاء isWatered(on: today)، وdate الاسم داخل الدالة. |
| 57 | إذا lastWateredAt غير موجود، نرجع false مباشرة. guard let المختصر يقرأ الخاصية الاختيارية ويكوّن قيمة غير اختيارية داخل بقية الدالة. |
| 58 | نقارن اليوم بالتقويم الحالي، لا نستخدم == بين Date لأن ساعتين مختلفتين من نفس اليوم ليستا نفس اللحظة. |
| 61 | isDue ترجع هل موعد السقي قد حان في تاريخ معيّن. |
| 62 | إذا النبات لم يُسقَ سابقًا، نعتبره مستحقًا. هذا قرار سلوكي في التطبيق، وليس قاعدة مفروضة من Swift. |
| 63 | نحفظ التقويم الحالي في ثابت محلي لتسهيل القراءة. |
| 64–68 | نطلب فرق الأيام [.day] بين بداية يوم آخر سقي وبداية اليوم المطلوب. startOfDay يجعل الحساب مبنيًا على أيام التقويم، بدل عدد الساعات منذ السقي. .day قد تكون nil لذلك نضع ?? 0 كقيمة بديلة. |
| 69 | إذا مضى عدد أيام يساوي الفترة المحددة أو أكثر، النبات مستحق. مثال: 8 >= 7 يعطي true لنبات أسبوعي متأخر. |
| 73 | نوع كمية الماء: خيارات واضحة وقابلة للعرض والحفظ. |
| 74–77 | أربع حالات بنصوص 20–50 و50–100 و100–200 و200–300 ml. التطبيق يعرض الكمية، ولا يقيس الماء بحساس ولا يحسبها علميًا. |


---

**3. PlantsViewModel.swift — الكود كاملًا**

```text
  1 | import Foundation
  2 | import Observation
  3 | 
  4 | @MainActor
  5 | @Observable
  6 | final class PlantsViewModel {
  7 |     private(set) var plants: [Plant] = []
  8 |     private(set) var hasStartedJourney = false
  9 |     private(set) var today = Date()
 10 |     var errorMessage: String?
 11 | 
 12 |     private let defaults: UserDefaults?
 13 |     private let storageKey = "savedPlants"
 14 |     private let journeyKey = "hasStartedPlantJourney"
 15 |     private var notificationTask: Task<Void, Never>?
 16 | 
 17 |     // Pass nil for previews and tests to avoid changing real data or notifications.
 18 |     init(defaults: UserDefaults? = .standard) {
 19 |         self.defaults = defaults
 20 |         hasStartedJourney = defaults?.bool(forKey: journeyKey) ?? false
 21 |         guard let data = defaults?.data(forKey: storageKey) else { return }
 22 |         do {
 23 |             plants = try JSONDecoder().decode([Plant].self, from: data)
 24 |             hasStartedJourney = hasStartedJourney || !plants.isEmpty
 25 |         } catch {
 26 |             errorMessage = "Your saved plants could not be loaded."
 27 |         }
 28 |     }
 29 | 
 30 |     var todayPlants: [Plant] {
 31 |         plants.filter { $0.isDue(on: today) || $0.isWatered(on: today) }
 32 |     }
 33 | 
 34 |     var completedCount: Int {
 35 |         todayPlants.filter { $0.isWatered(on: today) }.count
 36 |     }
 37 | 
 38 |     var progress: Double {
 39 |         guard !todayPlants.isEmpty else { return 0 }
 40 |         return Double(completedCount) / Double(todayPlants.count)
 41 |     }
 42 | 
 43 |     var allCompleted: Bool {
 44 |         !todayPlants.isEmpty && completedCount == todayPlants.count
 45 |     }
 46 | 
 47 |     func refreshDay() {
 48 |         today = Date()
 49 |     }
 50 | 
 51 |     func addPlant(_ plant: Plant) {
 52 |         plants.append(plant)
 53 |         hasStartedJourney = true
 54 |         saveChanges()
 55 |     }
 56 | 
 57 |     func updatePlant(_ plant: Plant) {
 58 |         guard let index = plants.firstIndex(where: { $0.id == plant.id }) else { return }
 59 |         plants[index] = plant
 60 |         saveChanges()
 61 |     }
 62 | 
 63 |     func deletePlant(id: UUID) {
 64 |         plants.removeAll { $0.id == id }
 65 |         if defaults != nil {
 66 |             PlantoNotifications.cancel(for: id)
 67 |         }
 68 |         saveChanges()
 69 |     }
 70 | 
 71 |     func isWateredToday(_ plant: Plant) -> Bool {
 72 |         plant.isWatered(on: today)
 73 |     }
 74 | 
 75 |     func toggleWateredToday(_ plant: Plant) {
 76 |         refreshDay()
 77 |         guard let index = plants.firstIndex(where: { $0.id == plant.id }) else { return }
 78 |         if plants[index].isWatered(on: today) {
 79 |             plants[index].lastWateredAt = plants[index].previousWateredAt
 80 |             plants[index].previousWateredAt = nil
 81 |         } else {
 82 |             plants[index].previousWateredAt = plants[index].lastWateredAt
 83 |             plants[index].lastWateredAt = today
 84 |         }
 85 |         saveChanges()
 86 |     }
 87 | 
 88 |     private func saveChanges() {
 89 |         guard let defaults else { return }
 90 |         do {
 91 |             let data = try JSONEncoder().encode(plants)
 92 |             defaults.set(data, forKey: storageKey)
 93 |             defaults.set(hasStartedJourney, forKey: journeyKey)
 94 |         } catch {
 95 |             errorMessage = "Your changes could not be saved."
 96 |         }
 97 | 
 98 |         // Finish an older update before scheduling the latest snapshot.
 99 |         // This prevents a quick edit or delete from leaving an outdated reminder.
100 |         let previousTask = notificationTask
101 |         let currentPlants = plants
102 |         notificationTask = Task {
103 |             await previousTask?.value
104 |             await PlantoNotifications.synchronize(plants: currentPlants)
105 |         }
106 |     }
107 | }
```

**شرح الأسطر بالترتيب**

| الأسطر | المعنى ولماذا كتبناه |
|---|---|
| 1–2 | Foundation للتواريخ والحفظ، وObservation لاستخدام @Observable. |
| 4 | @MainActor يعزل عمليات الـ ViewModel على الـ Main Actor. هذا مناسب لحالة مشتركة تقرؤها الواجهات. |
| 5 | @Observable يجعل قراءة الخصائص داخل SwiftUI قابلة لتتبع التغيّر. عند تغيير plants تتحدث الواجهات التي تعتمد عليها. |
| 6 | final class تعني كائنًا مرجعيًا لا نسمح بالوراثة منه. class تجعل الشاشات تشترك في نفس قائمة النباتات بدل نسخ منفصلة. |
| 7 | plants مصفوفة نباتات تبدأ فارغة. private(set) يسمح للواجهة بقراءتها، لكن يلزم استخدام add/update/delete لتعديلها؛ حتى لا ننسى الحفظ والإشعارات. |
| 8 | نتذكر هل المستخدم أضاف نباتًا من قبل. لا نعيدها false عند حذف آخر نبات، حتى نعرض No reminders بدل شاشة الترحيب. |
| 9 | today لحظة زمنية مخزنة في حالة قابلة للمراقبة. تحديثها يساعد الواجهة تعيد حساب تذكيرات اليوم. |
| 10 | نص خطأ اختياري: nil تعني لا يوجد خطأ، والنص الموجود يعرضه ContentView في alert. |
| 12 | defaults هو مخزن UserDefaults اختياري. نستطيع تمرير nil للمعاينات حتى لا نحفظ أو نرسل إشعارات. هذه طريقة بسيطة لتشغيل النموذج في الذاكرة فقط. |
| 13 | مفتاح التخزين للنباتات. المفتاح مثل اسم خانة نقرأ ونكتب بها نفس البيانات. |
| 14 | مفتاح مستقل لحفظ حالة بدء الرحلة. |
| 15 | نحتفظ بآخر Task خاصة بالإشعارات. Void يعني لا ترجع نتيجة مفيدة، Never يعني لا يخرج منها خطأ مرمي؛ synchronize تمسك أخطاءها داخليًا. ? لأن البداية لا توجد فيها مهمة. |
| 17–19 | init يستقبل مخزنًا اختياريًا، والافتراضي .standard أي مخزن التطبيق المعتاد. self.defaults تميّز الخاصية عن معامل الدالة بنفس الاسم. |
| 20 | نقرأ Bool من مفتاح الرحلة إن كان المخزن موجودًا، وإلا false. ?. هنا optional chaining و?? قيمة بديلة. |
| 21 | نقرأ Data المحفوظة. إذا لا توجد بيانات أو المخزن nil، نخرج من init ونبقى بالقيم الافتراضية. لا يعني إغلاق التطبيق. |
| 22–23 | داخل do نحاول فك JSON. try لأن البيانات قد تكون تالفة أو لا تطابق النوع. [Plant].self تخبر JSONDecoder أن النتيجة المطلوبة مصفوفة Plant. |
| 24 | لو كانت الرحلة محفوظة true أو وجدنا نباتات، نعتبر المستخدم قد بدأ. !plants.isEmpty تعني القائمة ليست فارغة. |
| 25–26 | إذا فشل فك البيانات نضع رسالة واضحة بدل انهيار التطبيق. لا يوجد force unwrap هنا. |
| 30–31 | todayPlants خاصية محسوبة ترشح المصفوفة: النبات المستحق اليوم أو الذي سُقي اليوم. إبقاء المكتمل ضمن قائمة اليوم يحافظ على الصف والعلامة وحساب التقدّم. $0 هو النبات الحالي في filter. |
| 34–35 | نرشح نباتات اليوم إلى المسقية ثم نأخذ count. هذه النتيجة عدد صحيح. |
| 38–39 | progress قيمة عشرية محسوبة. نمنع القسمة على صفر إذا لم يوجد أي نبات في قائمة اليوم. |
| 40 | عدد المكتمل ÷ عدد نباتات اليوم. نحولهما إلى Double حتى لا نحصل على قسمة أعداد صحيحة. 3 ÷ 4 = 0.75 أي 75%. |
| 43–44 | allCompleted صحيح فقط إذا القائمة غير فارغة وعدد المكتمل يساوي العدد الكلي. بدون الشرط الأول، 0 == 0 ستعتبر القائمة الفارغة مكتملة. |
| 47–48 | refreshDay تستبدل today بالوقت الحالي، لأن Date المخزنة لا تتقدم تلقائيًا كساعة. |
| 51 | addPlant تستقبل Plant. الشرطة _ تعني الاستدعاء addPlant(plant) بدل addPlant(plant: plant). |
| 52–54 | append يضيف النبات، ثم نثبت بدء الرحلة، ثم نحفظ ونزامن الإشعارات. نترك lastWateredAt كما هو؛ الإضافة لا تضع علامة إنجاز. |
| 57–58 | نبحث عن أول موقع في المصفوفة له نفس id. firstIndex يرجع Int? لأنه قد لا يجد النبات، فنخرج بـ guard إذا غاب. |
| 59–60 | نستبدل النبات في هذا الموقع بالقيمة المعدلة، ثم نحفظ. لا ننشئ هوية جديدة عند التعديل. |
| 63–64 | deletePlant يستقبل id ويحذف كل عنصر يطابقه. عمليًا كل نبات له UUID مختلف، لذلك يحذف النبات المطلوب. |
| 65–67 | نلغي إشعاره إذا كان هذا نموذجًا يستخدم التخزين الحقيقي، وليس preview بــ defaults: nil. |
| 68 | نحفظ القائمة بعد الحذف، ونعيد مزامنة المواعيد. |
| 71–72 | دالة تسهيل للواجهة: تسأل Plant هل سُقي في today الخاص بالنموذج. Swift يسمح بحذف return للدالة ذات التعبير الواحد. |
| 75–77 | toggleWateredToday تعني تبديل حالة اليوم. نحدث التاريخ ثم نبحث عن النسخة الحالية داخل المصفوفة؛ لا نعتمد على نسخة قديمة مررتها الواجهة. |
| 78–80 | إذا كان مسقيًا اليوم، نسترجع previousWateredAt ونفرغ نسخة التراجع. مثال: التاريخ كان قبل أسبوع ثم سجلنا اليوم؛ التراجع يرجع تاريخ قبل أسبوع. |
| 81–83 | إذا لم يكن مسقيًا اليوم، نحفظ التاريخ القديم أولًا ثم نضع today كآخر سقي. ترتيب السطرين مهم حتى لا نفقد القيمة القديمة. |
| 85 | نحفظ بعد كلا المسارين؛ الإنجاز والتراجع يستمران بعد إعادة التشغيل. |
| 88–89 | saveChanges خاصة لأن الواجهات لا تحتاج استدعاءها مباشرة. لو defaults nil نخرج؛ تبقى التغييرات في الذاكرة فقط للمعاينة. |
| 90–93 | نحوّل plants إلى Data باستخدام JSONEncoder ثم نخزنها في UserDefaults تحت storageKey، ونخزن Bool الرحلة تحت journeyKey. UserDefaults لا يعرف حفظ Plant مباشرة لهذا استخدمنا Codable. |
| 94–95 | لو فشل الترميز، نعطي errorMessage. هذا يلتقط خطأ JSONEncoder، ولا يضمن كشف كل فشل محتمل في كتابة القرص؛ UserDefaults.set لا يرمي خطأ. |
| 98–101 | نأخذ مرجع المهمة السابقة ونسخة القائمة الحالية. الهدف ترتيب عمليات الإشعارات عند التعديل بسرعة. |
| 102–105 | ننشئ Task جديدة؛ await previousTask?.value ينتظر انتهاء السابقة إن وُجدت، ثم await synchronize يحدّث الإشعارات بالقائمة الحالية. await يسمح بالتوقف المؤقت بدون حجز تنفيذ الواجهة أثناء الانتظار. هذه أكثر جزئية تقدمًا في الملف؛ فائدتها منع مهمة قديمة من إعادة إشعار نبات حذفناه. |


---

**4. ContentView.swift — الكود كاملًا**

```text
  1 | import SwiftUI
  2 | 
  3 | struct ContentView: View {
  4 |     @State private var viewModel = PlantsViewModel()
  5 |     @Environment(\.scenePhase) private var scenePhase
  6 | 
  7 |     var body: some View {
  8 |         Group {
  9 |             if viewModel.hasStartedJourney {
 10 |                 TodayReminderView(viewModel: viewModel)
 11 |             } else {
 12 |                 StartJourneyView(viewModel: viewModel)
 13 |             }
 14 |         }
 15 |         .preferredColorScheme(.dark)
 16 |         .onChange(of: scenePhase) { _, phase in
 17 |             if phase == .active {
 18 |                 viewModel.refreshDay()
 19 |             }
 20 |         }
 21 |         .task {
 22 |             // Refresh the date even when the app stays open across midnight.
 23 |             while !Task.isCancelled {
 24 |                 viewModel.refreshDay()
 25 |                 do {
 26 |                     try await Task.sleep(for: .seconds(60))
 27 |                 } catch {
 28 |                     return
 29 |                 }
 30 |             }
 31 |         }
 32 |         .alert("Unable to Save or Load", isPresented: Binding(
 33 |             get: { viewModel.errorMessage != nil },
 34 |             set: { if !$0 { viewModel.errorMessage = nil } }
 35 |         )) {
 36 |             Button("OK") { viewModel.errorMessage = nil }
 37 |         } message: {
 38 |             Text(viewModel.errorMessage ?? "")
 39 |         }
 40 |     }
 41 | }
 42 | 
 43 | struct PlantsHeader: View {
 44 |     var body: some View {
 45 |         VStack(spacing: 0) {
 46 |             Text("My Plants🌱")
 47 |                 .font(.title.bold())
 48 |                 .frame(maxWidth: .infinity, alignment: .leading)
 49 |                 .padding(.horizontal, 16)
 50 |                 .padding(.vertical, 18)
 51 |             Divider()
 52 |         }
 53 |     }
 54 | }
 55 | 
 56 | #Preview {
 57 |     ContentView()
 58 | }
```

**شرح الأسطر بالترتيب**

| الأسطر | المعنى ولماذا كتبناه |
|---|---|
| 1 | نستورد SwiftUI. |
| 3 | ContentView واجهة struct تلتزم بـ View. |
| 4 | الواجهة الجذرية تملك نسخة واحدة من PlantsViewModel داخل @State. تمرر نفس الكائن للشاشات الفرعية. لا تنشئين ViewModel جديدًا لكل شاشة وإلا ستصبح القوائم منفصلة. |
| 5 | نقرأ scenePhase من Environment. \.scenePhase مسار إلى قيمة بيئية، وقد تكون active أو inactive أو background. |
| 7–8 | body تبني محتوى View، وGroup يجمع الشرط حتى نطبق معدلات واحدة على الحالتين. |
| 9–10 | إذا hasStartedJourney صحيح، نعرض TodayReminderView ونمرر نفس viewModel. |
| 11–12 | غير ذلك نعرض StartJourneyView. الاختيار مبني على تاريخ بدء الرحلة، وليس مجرد فراغ القائمة. |
| 15 | نطلب المظهر الداكن للمحتوى. |
| 16 | onChange يستجيب لتغيّر scenePhase. _ يتجاهل القيمة القديمة، وphase اسم القيمة الجديدة. |
| 17–18 | عند رجوع التطبيق للحالة active نحدث التاريخ، لأن اليوم ربما تغيّر أثناء غيابه. |
| 21–24 | .task تشغّل عملًا مرتبطًا بعمر الواجهة. نستمر ما دامت المهمة غير ملغاة ونحدث today. هذا ليس خدمة تعمل للأبد في خلفية iOS؛ النظام قد يعلّق التطبيق. |
| 25–29 | ننتظر 60 ثانية باستخدام Task.sleep غير الحاجز. try لأن الإلغاء قد يرمي خطأ، وعندها catch يخرج من المهمة. بذلك نراجع اليوم كل دقيقة أثناء تشغيل المهمة، وليس عند منتصف الليل بالمللي ثانية. |
| 32 | alert لرسالة فشل الحفظ أو القراءة. isPresented تحتاج Binding<Bool> بينما حالتنا الأصلية String?، لذلك نبني Binding محسوبة. |
| 33 | get يقرر هل التنبيه ظاهر: وجود errorMessage يعني true. |
| 34 | set يستقبل القيمة الجديدة في $0؛ إذا النظام أغلق التنبيه وأصبحت false نمسح رسالة الخطأ حتى لا يعود التنبيه. |
| 35–38 | زر OK يفرغ الخطأ. message تعرض نص الخطأ، أو نصًا فارغًا إذا كان nil؛ Text تحتاج String غير اختياري. |
| 43–44 | PlantsHeader واجهة مشتركة صغيرة للعناوين. عرّفناها في نفس الملف لكن ليست private حتى تستخدمها الملفات الأخرى. |
| 45–47 | عمود بلا مسافات بين العنوان والفاصل. النص My Plants مع الرمز، بخط title عريض. |
| 48–50 | يمتد العنوان بعرض المساحة المتاحة ويتحاذى مع leading، ثم حشوة أفقية 16 وعمودية 18 نقطة. leading بداية اتجاه القراءة وليست دائمًا اليسار. |
| 51 | خط يفصل العنوان عن المحتوى. |
| 56–58 | #Preview تعرض ContentView في Canvas داخل Xcode. هذه المعاينة تحديدًا تنشئ ContentView الذي يستخدم التخزين الافتراضي؛ ليست واحدة من المعاينات المعزولة بـ defaults: nil. |


---

**5. StartJourneyView.swift — الكود كاملًا**

```text
  1 | import SwiftUI
  2 | 
  3 | struct StartJourneyView: View {
  4 |     let viewModel: PlantsViewModel
  5 |     @State private var showSetReminder = false
  6 | 
  7 |     var body: some View {
  8 |         VStack(spacing: 0) {
  9 |             PlantsHeader()
 10 | 
 11 |             ScrollView {
 12 |                 VStack(spacing: 20) {
 13 |                     Image("PlantIllustration")
 14 |                         .resizable()
 15 |                         .scaledToFit()
 16 |                         .frame(width: 170, height: 190)
 17 |                         .accessibilityHidden(true)
 18 | 
 19 |                     Text("Start your plant journey!")
 20 |                         .font(.title3.bold())
 21 | 
 22 |                     Text("Now all your plants will be in one place and\nwe will help you take care of them :) 🪴")
 23 |                         .font(.caption)
 24 |                         .foregroundStyle(.gray)
 25 |                         .multilineTextAlignment(.center)
 26 | 
 27 |                     Button {
 28 |                         showSetReminder = true
 29 |                     } label: {
 30 |                         Text("Set Plant Reminder")
 31 |                             .font(.subheadline.weight(.medium))
 32 |                             .frame(maxWidth: .infinity)
 33 |                             .padding(.vertical, 4)
 34 |                     }
 35 |                     .buttonStyle(.glassProminent)
 36 |                     .tint(Color(red: 0.2, green: 0.5, blue: 0.41))
 37 |                     .buttonBorderShape(.capsule)
 38 |                     .padding(.horizontal, 48)
 39 |                     .padding(.top, 64)
 40 |                 }
 41 |                 .padding(.top, 60)
 42 |                 .padding(.bottom, 24)
 43 |             }
 44 |         }
 45 |         .background(Color.black.ignoresSafeArea())
 46 |         .foregroundStyle(.white)
 47 |         .preferredColorScheme(.dark)
 48 |         .sheet(isPresented: $showSetReminder) {
 49 |             SetReminderView(viewModel: viewModel)
 50 |                 .presentationDetents([.large])
 51 |                 .presentationDragIndicator(.hidden)
 52 |                 .presentationCornerRadius(28)
 53 |         }
 54 |     }
 55 | }
 56 | 
 57 | #Preview {
 58 |     StartJourneyView(viewModel: PlantsViewModel(defaults: nil))
 59 | }
```

**شرح الأسطر بالترتيب**

| الأسطر | المعنى ولماذا كتبناه |
|---|---|
| 1 | مكتبة الواجهات. |
| 3–4 | واجهة الترحيب تستقبل نفس ViewModel من الأب. let يمنع تبديل المرجع داخل هذه الواجهة، لكن كائن الـ class نفسه يظل قابلًا للتعديل عبر دواله. |
| 5 | حالة محلية: هل ورقة الإضافة مفتوحة؟ تبدأ false. |
| 7–9 | نبني عمودًا، ونضع PlantsHeader المشترك في أعلاه. |
| 11–12 | ScrollView تسمح بتمرير المحتوى لو ضاقت المساحة. داخلها عمود بفواصل 20 نقطة. |
| 13 | نقرأ الصورة المسماة PlantIllustration من Assets؛ ليست SF Symbol ولا صورة من الإنترنت. |
| 14 | resizable تسمح للصورة بتغيير حجمها. |
| 15 | scaledToFit تحافظ على تناسب الصورة وتظهرها كاملة داخل المساحة. |
| 16 | مساحة الصورة بعرض 170 وارتفاع 190 نقطة. |
| 17 | نخفي الصورة الزخرفية عن قارئ الشاشة لأن النص يشرح الحالة بالفعل. |
| 19–20 | عنوان الترحيب بخط title3 عريض. |
| 22 | نص الوصف. \n داخل String يضيف سطرًا جديدًا في العرض. |
| 23–25 | خط caption صغير، لون رمادي، ومحاذاة أسطر النص في الوسط. |
| 27–29 | قسم فعل الزر: نغير showSetReminder إلى true. هذا التغيير يجعل .sheet تظهر، وليس استدعاء شاشة بأسلوب imperative. |
| 30–33 | قسم label يحدد شكل الزر: نص، خط متوسط، عرض يتمدد، وحشوة عمودية 4. |
| 35 | glassProminent نمط زر يستخدم Liquid Glass. هذا تطبيق فعلي لهدف التصميم، وليس مجرد شفافية لخلفية. |
| 36 | tint بلون أخضر. قيم RGB هنا بين 0 و1. |
| 37 | شكل حواف الزر كبسولة. |
| 38–39 | مسافة خارجية أفقية 48 ومسافة علوية 64 تفصل الزر عن الوصف. |
| 41–42 | مسافات حول مجموعة محتوى الترحيب: 60 من الأعلى و24 من الأسفل. |
| 45–47 | الخلفية سوداء إلى الأطراف، النص الافتراضي أبيض، والمظهر داكن. |
| 48–49 | sheet مربوطة بـ $showSetReminder. نمرر Binding حتى يستطيع النظام إعادة false عند الإغلاق. المحتوى SetReminderView بنفس الـ ViewModel، وبدون editingPlant لذلك وضع إضافة. |
| 50 | detents تحدد ارتفاعات الورقة المسموحة؛ اخترنا large فقط. |
| 51 | نخفي علامة السحب الصغيرة أعلى الورقة. هذا لا يعني منع السحب لإغلاقها. |
| 52 | زوايا الورقة بنصف قطر 28 نقطة. |
| 57–59 | معاينة ترحيب بنموذج defaults: nil، لذلك تغييراتها لا تحفظ ولا تجدول إشعارات. |


---

**6. SetReminderView.swift — الكود كاملًا**

```text
  1 | import SwiftUI
  2 | 
  3 | struct SetReminderView: View {
  4 |     let viewModel: PlantsViewModel
  5 |     let editingPlant: Plant?
  6 | 
  7 |     @Environment(\.dismiss) private var dismiss
  8 |     @State private var plantName: String
  9 |     @State private var selectedRoom: PlantRoom
 10 |     @State private var selectedLight: LightLevel
 11 |     @State private var selectedDays: WateringSchedule
 12 |     @State private var selectedWater: WaterAmount
 13 |     @State private var showDeleteConfirmation = false
 14 | 
 15 |     private let green = Color(red: 0.2, green: 0.5, blue: 0.41)
 16 |     private let rowColor = Color(red: 44 / 255, green: 44 / 255, blue: 46 / 255)
 17 |     private let background = Color(red: 28 / 255, green: 28 / 255, blue: 30 / 255)
 18 | 
 19 |     init(viewModel: PlantsViewModel, editingPlant: Plant? = nil) {
 20 |         self.viewModel = viewModel
 21 |         self.editingPlant = editingPlant
 22 |         // Editing starts with the saved values; adding starts with defaults.
 23 |         _plantName = State(initialValue: editingPlant?.name ?? "")
 24 |         _selectedRoom = State(initialValue: editingPlant?.room ?? .bedroom)
 25 |         _selectedLight = State(initialValue: editingPlant?.light ?? .fullSun)
 26 |         _selectedDays = State(initialValue: editingPlant?.wateringDays ?? .everyDay)
 27 |         _selectedWater = State(initialValue: editingPlant?.waterAmount ?? .small)
 28 |     }
 29 | 
 30 |     var body: some View {
 31 |         VStack(spacing: 0) {
 32 |             ReminderHeader(
 33 |                 canSave: !plantName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
 34 |                 onCancel: { dismiss() },
 35 |                 onSave: savePlant
 36 |             )
 37 | 
 38 |             ScrollView {
 39 |                 VStack(spacing: 36) {
 40 |                     HStack(spacing: 8) {
 41 |                         Text("Plant Name")
 42 |                         TextField("Pothos", text: $plantName)
 43 |                             .tint(green)
 44 |                             .accessibilityLabel("Plant Name")
 45 |                     }
 46 |                     .padding(.horizontal, 16)
 47 |                     .frame(minHeight: 54)
 48 |                     .background(rowColor, in: RoundedRectangle(cornerRadius: 26))
 49 | 
 50 |                     RoomAndLightSection(room: $selectedRoom, light: $selectedLight)
 51 |                         .padding(.horizontal, 16)
 52 |                         .background(rowColor, in: RoundedRectangle(cornerRadius: 24))
 53 | 
 54 |                     WateringSection(days: $selectedDays, water: $selectedWater)
 55 |                         .padding(.horizontal, 16)
 56 |                         .background(rowColor, in: RoundedRectangle(cornerRadius: 24))
 57 | 
 58 |                     if editingPlant != nil {
 59 |                         Button {
 60 |                             showDeleteConfirmation = true
 61 |                         } label: {
 62 |                             Text("Delete Reminder")
 63 |                                 .font(.subheadline)
 64 |                                 .foregroundStyle(.red)
 65 |                                 .frame(maxWidth: .infinity, minHeight: 48)
 66 |                                 .background(rowColor, in: Capsule())
 67 |                         }
 68 |                         .buttonStyle(.plain)
 69 |                         .padding(.top, 24)
 70 |                     }
 71 |                 }
 72 |                 .font(.subheadline)
 73 |                 .padding(.horizontal, 16)
 74 |                 .padding(.top, 48)
 75 |                 .padding(.bottom, 24)
 76 |             }
 77 |             .scrollDismissesKeyboard(.interactively)
 78 |         }
 79 |         .background(background.ignoresSafeArea())
 80 |         .foregroundStyle(.white)
 81 |         .preferredColorScheme(.dark)
 82 |         .confirmationDialog("Delete this reminder?", isPresented: $showDeleteConfirmation,
 83 |                             titleVisibility: .visible) {
 84 |             Button("Delete Reminder", role: .destructive) {
 85 |                 if let editingPlant {
 86 |                     viewModel.deletePlant(id: editingPlant.id)
 87 |                     dismiss()
 88 |                 }
 89 |             }
 90 |             Button("Cancel", role: .cancel) {}
 91 |         } message: {
 92 |             Text("This plant will be removed from your list.")
 93 |         }
 94 |     }
 95 | 
 96 |     private func savePlant() {
 97 |         let name = plantName.trimmingCharacters(in: .whitespacesAndNewlines)
 98 |         guard !name.isEmpty else { return }
 99 | 
100 |         if var plant = editingPlant {
101 |             plant.name = name
102 |             plant.room = selectedRoom
103 |             plant.light = selectedLight
104 |             plant.wateringDays = selectedDays
105 |             plant.waterAmount = selectedWater
106 |             viewModel.updatePlant(plant)
107 |         } else {
108 |             let plant = Plant(name: name, room: selectedRoom, light: selectedLight,
109 |                               wateringDays: selectedDays, waterAmount: selectedWater)
110 |             viewModel.addPlant(plant)
111 |         }
112 |         dismiss()
113 |     }
114 | }
115 | 
116 | private struct ReminderHeader: View {
117 |     let canSave: Bool
118 |     let onCancel: () -> Void
119 |     let onSave: () -> Void
120 | 
121 |     var body: some View {
122 |         HStack {
123 |             Button(action: onCancel) {
124 |                 Image(systemName: "xmark")
125 |                     .frame(width: 40, height: 40)
126 |                     .glassEffect(.regular.interactive(), in: Circle())
127 |             }
128 |             .accessibilityLabel("Cancel")
129 | 
130 |             Spacer()
131 |             Text("Set Reminder")
132 |                 .font(.subheadline.weight(.semibold))
133 |             Spacer()
134 | 
135 |             Button(action: onSave) {
136 |                 Image(systemName: "checkmark")
137 |                     .frame(width: 40, height: 40)
138 |                     .glassEffect(
139 |                         .regular.tint(Color(red: 0.2, green: 0.5, blue: 0.41)).interactive(),
140 |                         in: Circle()
141 |                     )
142 |             }
143 |             .disabled(!canSave)
144 |             .opacity(canSave ? 1 : 0.5)
145 |             .accessibilityLabel("Save reminder")
146 |         }
147 |         .buttonStyle(.plain)
148 |         .padding(.horizontal, 16)
149 |         .padding(.top, 16)
150 |     }
151 | }
152 | 
153 | private struct RoomAndLightSection: View {
154 |     @Binding var room: PlantRoom
155 |     @Binding var light: LightLevel
156 | 
157 |     var body: some View {
158 |         VStack(spacing: 0) {
159 |             HStack {
160 |                 Label("Room", systemImage: "location")
161 |                 Spacer()
162 |                 Picker("Room", selection: $room) {
163 |                     ForEach(PlantRoom.allCases, id: \.self) { room in
164 |                         Text(room.rawValue).tag(room)
165 |                     }
166 |                 }
167 |                 .labelsHidden()
168 |             }
169 |             .frame(minHeight: 44)
170 | 
171 |             Divider()
172 | 
173 |             HStack {
174 |                 Label("Light", systemImage: light.symbolName)
175 |                 Spacer()
176 |                 Picker("Light", selection: $light) {
177 |                     ForEach(LightLevel.allCases, id: \.self) { light in
178 |                         Text(light.rawValue).tag(light)
179 |                     }
180 |                 }
181 |                 .labelsHidden()
182 |             }
183 |             .frame(minHeight: 44)
184 |         }
185 |         .pickerStyle(.menu)
186 |         .tint(.gray)
187 |     }
188 | }
189 | 
190 | private struct WateringSection: View {
191 |     @Binding var days: WateringSchedule
192 |     @Binding var water: WaterAmount
193 | 
194 |     var body: some View {
195 |         VStack(spacing: 0) {
196 |             HStack {
197 |                 Label("Watering Days", systemImage: "drop")
198 |                 Spacer()
199 |                 Picker("Watering Days", selection: $days) {
200 |                     ForEach(WateringSchedule.allCases, id: \.self) { day in
201 |                         Text(day.rawValue).tag(day)
202 |                     }
203 |                 }
204 |                 .labelsHidden()
205 |             }
206 |             .frame(minHeight: 44)
207 | 
208 |             Divider()
209 | 
210 |             HStack {
211 |                 Label("Water", systemImage: "drop")
212 |                 Spacer()
213 |                 Picker("Water", selection: $water) {
214 |                     ForEach(WaterAmount.allCases, id: \.self) { amount in
215 |                         Text(amount.rawValue).tag(amount)
216 |                     }
217 |                 }
218 |                 .labelsHidden()
219 |             }
220 |             .frame(minHeight: 44)
221 |         }
222 |         .pickerStyle(.menu)
223 |         .tint(.gray)
224 |     }
225 | }
226 | 
227 | #Preview("Add Plant") {
228 |     SetReminderView(viewModel: PlantsViewModel(defaults: nil))
229 | }
230 | 
231 | #Preview("Edit / Delete Plant") {
232 |     SetReminderView(
233 |         viewModel: PlantsViewModel(defaults: nil),
234 |         editingPlant: Plant(name: "Pothos", room: .bedroom, light: .fullSun,
235 |                             wateringDays: .everyDay, waterAmount: .small)
236 |     )
237 | }
```

**شرح الأسطر بالترتيب**

| الأسطر | المعنى ولماذا كتبناه |
|---|---|
| 1 | مكتبة SwiftUI. |
| 3–4 | واجهة النموذج تستقبل الكائن المشترك لإرسال الإضافة والتعديل والحذف. |
| 5 | editingPlant اختياري: nil تعني إضافة، وقيمة موجودة تعني تعديل هذا النبات. لذلك نستخدم نفس النموذج للحالتين. |
| 7 | dismiss إجراء من Environment يغلق الورقة الحالية عند استدعائه. لا يغلق التطبيق. |
| 8–12 | خمس حالات @State تمثل مسودة النموذج: الاسم، الغرفة، الضوء، فترة السقي، وكمية الماء. تتغير أثناء الاختيار، لكن القائمة الأصلية لا تتغير إلا عند الحفظ. |
| 13 | Bool مستقل لإظهار حوار تأكيد الحذف. |
| 15–17 | ألوان خاصة بالنموذج: الأخضر، خلفية صفوف رمادية، وخلفية الشاشة الأغمق. القسمة على 255 تحول RGB من مقياس 0–255 إلى 0–1؛ السياق هنا Double. |
| 19–21 | مهيئ يستقبل ViewModel ونباتًا اختياريًا افتراضيه nil، ثم يخزنهما في خصائص الواجهة. self تميز خصائص الواجهة عن المعاملات. |
| 22–23 | نهيئ تخزين @State للاسم. editingPlant?.name يعني اسم النبات إن وجد، و?? "" يعني اسمًا فارغًا في الإضافة. _plantName يشير إلى تخزين State، وليس النص نفسه. |
| 24 | الغرفة تبدأ بقيمة النبات أو Bedroom عند الإضافة. |
| 25 | الضوء يبدأ بقيمة النبات أو Full Sun. |
| 26 | الفترة تبدأ بقيمة النبات أو Every day. |
| 27 | الماء يبدأ بقيمة النبات أو small. هذه قيم ابتدائية للعرض، وليست توصيات نباتية علمية. |
| 30–32 | نبني عمود الشاشة ونضع ReminderHeader، وهو View صغيرة للأزرار والعنوان. |
| 33 | canSave: نحذف المسافات والأسطر من طرفي الاسم، ونتأكد أنه ليس فارغًا. الاسم "   " لا يكفي لتفعيل الحفظ. trimmingCharacters لا يمسح المسافات بين كلمات الاسم. |
| 34 | نمرر closure للإلغاء تستدعي dismiss(). لم ننفذها هنا؛ ستنفذ عندما يضغط المستخدم زر الإلغاء. |
| 35 | نمرر الدالة savePlant كفعل للزر بدون ()؛ كتابة savePlant() كانت ستنفذها الآن بدل تمريرها. |
| 38–40 | النموذج قابل للتمرير. الأقسام عمودية بمسافة 36، واسم النبات داخل صف أفقي بمسافة 8. |
| 41–42 | عنوان ثابت Plant Name وحقل إدخال. Pothos هو placeholder يظهر عند الفراغ، وليس اسمًا محفوظًا تلقائيًا. $plantName يربط الكتابة بالمسودة. |
| 43–44 | لون المؤشر/التأكيد أخضر، واسم واضح للحقل لدى VoiceOver. |
| 46–48 | حشوة 16، حد أدنى للارتفاع 54، وخلفية مستطيل بزوايا مدورة 26. |
| 50–52 | قسم الغرفة والضوء يستقبل Binding للحالتين، لذلك تعديله يغيّر مسودة الأب. نضيف له حشوة وخلفية رمادية بزوايا 24. |
| 54–56 | نفس الفكرة لقسم السقي والماء؛ نمرر رابطين للحالات بدل نسخة منفصلة من قيمها. |
| 58–60 | زر الحذف يظهر فقط في التعديل. الضغط الأول يفتح التأكيد ولا يحذف مباشرة. |
| 61–66 | تصميم الزر: نص Delete Reminder بخط subheadline أحمر، عرض كامل، ارتفاع أدنى 48، وخلفية كبسولة. |
| 68–69 | plain يمنع نمط زر إضافيًا فوق تصميمنا. مسافة علوية 24. |
| 72–75 | تنسيق الأقسام مجتمعة: خط subheadline وحشوة أفقية 16 وعلوية 48 وسفلية 24. |
| 77 | السحب داخل النموذج يمكنه إغلاق لوحة المفاتيح بشكل تفاعلي. |
| 79–81 | خلفية داكنة ممتدة للحواف، نص أبيض، ومظهر داكن. |
| 82–83 | حوار التأكيد مربوط بـ showDeleteConfirmation، وعنوانه ظاهر. |
| 84–87 | زر destructive يعبّر للنظام عن فعل حذف. نفك editingPlant بأمان، نطلب من ViewModel الحذف بالهوية، ثم نغلق النموذج. إلغاء الإشعار صار مسؤولية ViewModel. |
| 90 | زر Cancel بدور cancel يغلق الحوار دون حذف. closure الفارغة تعني لا نحتاج عملًا إضافيًا. |
| 91–92 | رسالة توضح نتيجة الحذف للمستخدم. |
| 96–98 | savePlant دالة خاصة. ننظف الاسم ونعيد فحصه بـ guard؛ تعطيل الزر لتحسين التجربة، وguard يحمي الدالة نفسها أيضًا. |
| 100 | if var يفك النبات الاختياري إلى نسخة قابلة للتعديل. لأن Plant struct، تعديلات هذه النسخة لا تغيّر المصفوفة الأصلية حتى updatePlant. |
| 101–105 | ننقل القيم الخمس من المسودة إلى نسخة النبات. لا نغيّر id ولا تواريخ السقي. |
| 106 | نرسل النسخة المعدلة إلى ViewModel لاستبدال النبات بنفس id وحفظه. |
| 107–110 | عند الإضافة ننشئ Plant بالقيم الخمس. UUID يُنشأ تلقائيًا والتواريخ nil، ثم نستدعي addPlant. |
| 112 | نغلق الورقة بعد إرسال الحفظ. |
| 116–117 | ReminderHeader واجهة خاصة بهذا الملف، تستقبل هل الحفظ مسموحًا. |
| 118–119 | onCancel وonSave قيمتا دالتين من النوع () -> Void: بدون مدخلات وبدون قيمة راجعة. تجعل Header مسؤولة عن العرض والضغط، لا عن معرفة كيف نحفظ نباتًا. |
| 121–124 | صف أفقي، زر الإلغاء يشغّل الفعل الممرر ويعرض رمز xmark. |
| 125–126 | مساحة 40×40، وتأثير Liquid Glass عادي يتفاعل مع الضغط داخل شكل دائري. |
| 128 | اسم زر الإلغاء لقارئ الشاشة. |
| 130–133 | Spacer على جانبي العنوان يوسّطه بين زرين متساويين بالحجم. الخط شبه عريض. |
| 135–141 | زر الحفظ يشغّل onSave. رمز checkmark في مساحة 40×40 وخلفية زجاجية خضراء تفاعلية ودائرية. |
| 143 | نعطل الزر إذا canSave غير صحيح. !canSave عكس القيمة. |
| 144 | تعبير شرطي مختصر للشفافية: 1 إذا الحفظ متاح، 0.5 إذا غير متاح. |
| 145 | اسم مفهوم لزر الحفظ بدل قراءة checkmark فقط. |
| 147–149 | نمط plain للأزرار لأن تأثيرها محدد داخل label، وحشوة أفقية 16 وعلوية 16. |
| 153–155 | RoomAndLightSection واجهة فرعية تستعير room وlight بـ @Binding. لا تملك القيم الأصلية. |
| 157–160 | عمود يحتوي صفًا للغرفة. Label يعرض Room مع رمز location. |
| 161–162 | Spacer يدفع Picker للطرف الآخر. selection: $room يجعل الاختيار يقرأ ويعدل binding المرتبط بالأب. |
| 163 | allCases من CaseIterable تعطي كل الغرف. ForEach يبني خيارًا لكل غرفة. id: \.self صالح هنا لأن كل حالة enum قيمة ثابتة ومميزة. |
| 164 | rawValue النص الذي يراه المستخدم، وtag(room) القيمة الفعلية المرتبطة بالخيار. نوع tag يجب أن يطابق نوع selection، هنا PlantRoom. |
| 167 | نخفي عنوان Picker المرئي لأننا كتبنا Label مستقلًا. لا نحذف وظيفة الاختيار. |
| 169–171 | حد أدنى للصف 44 نقطة وخط بين الغرفة والضوء. |
| 173–178 | صف الضوء بنفس التركيب: Label بأيقونة تعتمد على الاختيار، Spacer، Picker مرتبط بـ light، ForEach لكل حالات LightLevel، Text للنص وtag للقيمة. |
| 181–186 | إخفاء عنوان Picker، ارتفاع أدنى 44، عرض الاختيارات كقائمة menu، ولون تأكيد رمادي. |
| 190–192 | WateringSection تستعير اختيار الأيام وكمية الماء من الأب. |
| 194–201 | صف Watering Days مع قطرة، Spacer، Picker مربوط بالأيام. ForEach يعرض كل فترات السقي، وtag يربط النص بحالة enum. |
| 204–208 | إخفاء عنوان Picker المكرر، ارتفاع أدنى 44، وفاصل. |
| 210–215 | صف Water مع قطرة وPicker مربوط بكمية الماء؛ يعرض خيارات WaterAmount مع tags المطابقة. |
| 218–223 | إخفاء عنوان Picker وارتفاع 44، ونمط menu ولون رمادي للقسم. |
| 227–229 | معاينة إضافة بنموذج لا يخزن البيانات. |
| 231–237 | معاينة تعديل بنبات Pothos مؤقت. نمرره مباشرة للنموذج؛ هذه معاينة شكل، ولم نضفه إلى مصفوفة الـ ViewModel، لذلك ليست تجربة كاملة للحفظ والحذف. |


---

**7. TodayReminderView.swift — الكود كاملًا**

```text
  1 | import SwiftUI
  2 | 
  3 | struct TodayReminderView: View {
  4 |     let viewModel: PlantsViewModel
  5 |     @State private var showAddPlant = false
  6 |     @State private var editingPlant: Plant?
  7 |     @State private var showAllPlants = false
  8 | 
  9 |     private let green = Color(red: 0.2, green: 0.5, blue: 0.41)
 10 | 
 11 |     var body: some View {
 12 |         VStack(spacing: 0) {
 13 |             PlantsHeader()
 14 | 
 15 |             if viewModel.plants.isEmpty {
 16 |                 Spacer()
 17 |                 Text("No reminders set yet..")
 18 |                     .font(.subheadline)
 19 |                     .foregroundStyle(.gray)
 20 |                 Spacer()
 21 |             } else if viewModel.allCompleted && !showAllPlants {
 22 |                 CompletedPlantsView()
 23 |             } else if viewModel.todayPlants.isEmpty && !showAllPlants {
 24 |                 Spacer()
 25 |                 Text("No reminders for today")
 26 |                     .font(.subheadline)
 27 |                     .foregroundStyle(.gray)
 28 |                 Spacer()
 29 |             } else {
 30 |                 if !viewModel.todayPlants.isEmpty {
 31 |                     PlantProgressView(
 32 |                         completedCount: viewModel.completedCount,
 33 |                         progress: viewModel.progress
 34 |                     )
 35 |                 }
 36 | 
 37 |                 List {
 38 |                     ForEach(showAllPlants ? viewModel.plants : viewModel.todayPlants) { plant in
 39 |                         PlantRowView(
 40 |                             plant: plant,
 41 |                             isCompleted: viewModel.isWateredToday(plant),
 42 |                             onToggle: { viewModel.toggleWateredToday(plant) },
 43 |                             onEdit: { editingPlant = plant }
 44 |                         )
 45 |                         .listRowInsets(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
 46 |                         .listRowBackground(Color.black)
 47 |                         .listRowSeparator(.hidden)
 48 |                         .swipeActions(edge: .trailing, allowsFullSwipe: false) {
 49 |                             Button(role: .destructive) {
 50 |                                 viewModel.deletePlant(id: plant.id)
 51 |                             } label: {
 52 |                                 Label("Delete", systemImage: "trash")
 53 |                             }
 54 |                         }
 55 |                     }
 56 |                 }
 57 |                 .listStyle(.plain)
 58 |                 .scrollContentBackground(.hidden)
 59 |             }
 60 | 
 61 |             HStack {
 62 |                 // Keep editing and undo available when the daily list is hidden.
 63 |                 if !viewModel.plants.isEmpty &&
 64 |                     (showAllPlants || viewModel.allCompleted ||
 65 |                      viewModel.todayPlants.count < viewModel.plants.count) {
 66 |                     Button(showAllPlants ? "Today" : "My Plants") {
 67 |                         showAllPlants.toggle()
 68 |                     }
 69 |                     .font(.subheadline)
 70 |                     .foregroundStyle(.gray)
 71 |                 }
 72 | 
 73 |                 Spacer()
 74 | 
 75 |                 Button {
 76 |                     showAddPlant = true
 77 |                 } label: {
 78 |                     Image(systemName: "plus")
 79 |                         .font(.title2)
 80 |                         .frame(width: 28, height: 28)
 81 |                 }
 82 |                 .buttonStyle(.glassProminent)
 83 |                 .buttonBorderShape(.circle)
 84 |                 .tint(green)
 85 |                 .accessibilityLabel("Add plant reminder")
 86 |             }
 87 |             .padding(.horizontal, 20)
 88 |             .padding(.bottom, 16)
 89 |         }
 90 |         .background(Color.black.ignoresSafeArea())
 91 |         .foregroundStyle(.white)
 92 |         .preferredColorScheme(.dark)
 93 |         .sheet(isPresented: $showAddPlant) {
 94 |             SetReminderView(viewModel: viewModel)
 95 |                 .presentationDetents([.large])
 96 |                 .presentationDragIndicator(.hidden)
 97 |                 .presentationCornerRadius(28)
 98 |         }
 99 |         .sheet(item: $editingPlant) { plant in
100 |             SetReminderView(viewModel: viewModel, editingPlant: plant)
101 |                 .presentationDetents([.large])
102 |                 .presentationDragIndicator(.hidden)
103 |                 .presentationCornerRadius(28)
104 |         }
105 |     }
106 | }
107 | 
108 | private struct PlantProgressView: View {
109 |     let completedCount: Int
110 |     let progress: Double
111 | 
112 |     var body: some View {
113 |         VStack(spacing: 12) {
114 |             if completedCount == 0 {
115 |                 Text("Your plants are waiting for a sip 💦")
116 |             } else {
117 |                 Text("\(completedCount) of your plants feel loved today✨")
118 |             }
119 |             ProgressView(value: progress)
120 |                 .tint(Color(red: 0.4, green: 0.68, blue: 0.61))
121 |                 .animation(.easeInOut(duration: 0.3), value: progress)
122 |         }
123 |         .font(.subheadline)
124 |         .padding(.horizontal, 24)
125 |         .padding(.top, 28)
126 |         .padding(.bottom, 32)
127 |     }
128 | }
129 | 
130 | private struct PlantRowView: View {
131 |     let plant: Plant
132 |     let isCompleted: Bool
133 |     let onToggle: () -> Void
134 |     let onEdit: () -> Void
135 | 
136 |     var body: some View {
137 |         VStack(spacing: 0) {
138 |             HStack(spacing: 12) {
139 |                 Button(action: onToggle) {
140 |                     Image(systemName: isCompleted ? "checkmark.circle.fill" : "circle")
141 |                         .font(.system(size: 22))
142 |                         .foregroundStyle(isCompleted
143 |                             ? Color(red: 0.16, green: 0.88, blue: 0.66) : .gray)
144 |                         .frame(width: 32, height: 44)
145 |                 }
146 |                 .buttonStyle(.plain)
147 |                 .accessibilityLabel(isCompleted
148 |                     ? "Undo watering \(plant.name)" : "Mark \(plant.name) as watered")
149 | 
150 |                 Button(action: onEdit) {
151 |                     VStack(alignment: .leading, spacing: 5) {
152 |                         Label("in \(plant.room.rawValue)", systemImage: "location")
153 |                             .font(.caption2)
154 |                             .foregroundStyle(.gray)
155 | 
156 |                         Text(plant.name)
157 |                             .font(.title2)
158 |                             .foregroundStyle(.white)
159 | 
160 |                         HStack(spacing: 8) {
161 |                             Label(plant.light.rawValue, systemImage: plant.light.symbolName)
162 |                                 .foregroundStyle(Color(red: 0.8, green: 0.78, blue: 0.52))
163 |                                 .padding(.horizontal, 6)
164 |                                 .padding(.vertical, 2)
165 |                                 .background(Color(white: 0.1), in: RoundedRectangle(cornerRadius: 5))
166 | 
167 |                             Label(plant.waterAmount.rawValue, systemImage: "drop")
168 |                                 .foregroundStyle(Color(red: 0.79, green: 0.95, blue: 0.98))
169 |                                 .padding(.horizontal, 6)
170 |                                 .padding(.vertical, 2)
171 |                                 .background(Color(white: 0.1), in: RoundedRectangle(cornerRadius: 5))
172 |                         }
173 |                         .font(.caption2)
174 |                     }
175 |                     .opacity(isCompleted ? 0.5 : 1)
176 |                     .frame(maxWidth: .infinity, alignment: .leading)
177 |                     .contentShape(Rectangle())
178 |                 }
179 |                 .buttonStyle(.plain)
180 |             }
181 |             .padding(.vertical, 10)
182 |             Divider()
183 |         }
184 |     }
185 | }
186 | 
187 | private struct CompletedPlantsView: View {
188 |     var body: some View {
189 |         VStack(spacing: 0) {
190 |             Image("CompletedPlantIllustration")
191 |                 .resizable()
192 |                 .scaledToFit()
193 |                 .frame(width: 190, height: 200)
194 |                 .accessibilityHidden(true)
195 | 
196 |             Text("All Done! 🎉")
197 |                 .font(.title3.weight(.semibold))
198 |                 .padding(.top, 24)
199 | 
200 |             Text("All Reminders Completed")
201 |                 .font(.caption)
202 |                 .foregroundStyle(.gray)
203 |                 .padding(.top, 10)
204 |         }
205 |         .padding(.top, 100)
206 |         .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
207 |     }
208 | }
209 | 
210 | private func createPreviewModel(allCompleted: Bool) -> PlantsViewModel {
211 |     let model = PlantsViewModel(defaults: nil)
212 |     for (name, room) in [("Monstera", PlantRoom.kitchen), ("Pothos", .bedroom),
213 |                          ("Orchid", .livingRoom), ("Spider", .kitchen)] {
214 |         let plant = Plant(name: name, room: room, light: .fullSun,
215 |                           wateringDays: .everyDay, waterAmount: .small)
216 |         model.addPlant(plant)
217 |         if allCompleted || name != "Monstera" {
218 |             model.toggleWateredToday(plant)
219 |         }
220 |     }
221 |     return model
222 | }
223 | 
224 | #Preview("Today Reminder") {
225 |     TodayReminderView(viewModel: createPreviewModel(allCompleted: false))
226 | }
227 | 
228 | #Preview("All Reminders Completed") {
229 |     TodayReminderView(viewModel: createPreviewModel(allCompleted: true))
230 | }
231 | 
232 | #Preview("No Reminders") {
233 |     TodayReminderView(viewModel: PlantsViewModel(defaults: nil))
234 | }
```

**شرح الأسطر بالترتيب**

| الأسطر | المعنى ولماذا كتبناه |
|---|---|
| 1 | مكتبة SwiftUI. |
| 3–4 | الشاشة الرئيسية تستقبل نفس ViewModel المشترك. |
| 5 | Bool محلي لفتح نموذج إضافة نبات. |
| 6 | نبات اختياري يحدد أي نبات نعدّل. nil تعني لا توجد ورقة تعديل؛ وجود نبات يفتحها. |
| 7 | هل نعرض كل النباتات أو قائمة اليوم فقط؟ تبدأ قائمة اليوم. |
| 9 | لون الزر الأخضر. |
| 11–13 | نبدأ محتوى الشاشة بعمود وعنوان مشترك. |
| 15–20 | أول حالة: قائمة كل النباتات فارغة. Spacer ثم رسالة No reminders ثم Spacer لتوسيطها عموديًا في المساحة. |
| 21–22 | إذا اكتملت تذكيرات اليوم ولم نطلب كل النباتات، نعرض CompletedPlantsView. |
| 23–28 | إذا لا توجد تذكيرات اليوم ولم نطلب كل النباتات، نعرض No reminders for today. هذا يختلف عن عدم امتلاك أي نبات؛ قد تكون النباتات أسبوعية ولم يحن موعدها. |
| 29–35 | وإلا نعرض القائمة. إذا توجد نباتات لليوم نعرض PlantProgressView ونمرر لها العدد والنسبة المحسوبين. حتى في عرض كل النباتات، التقدّم يظل خاصًا باليوم. |
| 37–38 | List قائمة الصفوف. التعبير showAllPlants ? plants : todayPlants يختار المصدر. ForEach يستخدم id من Identifiable لتمييز النبات بين التحديثات. |
| 39–41 | نبني PlantRowView لكل نبات، ونرسل قيمة النبات وهل سُقي اليوم. |
| 42 | نرسل فعل تغيير الإنجاز كـ closure تستدعي دالة الـ ViewModel للنبات المحدد. |
| 43 | نرسل فعل التعديل: وضع النبات في editingPlant يفعّل sheet(item:) تلقائيًا. |
| 45–47 | هوامش الصف 12 من الجانبين، خلفية سوداء، إخفاء فاصل List الافتراضي لأن PlantRowView يرسم Divider خاصًا به. |
| 48 | السحب من trailing يكشف إجراء الحذف. allowsFullSwipe: false يمنع تنفيذ الحذف بمجرد سحب كامل؛ يلزم الضغط على زر الحذف الظاهر. |
| 49–53 | زر destructive يطلب الحذف من ViewModel ويعرض Label Delete مع سلة. هذا المسار لا يعرض نفس حوار تأكيد زر الحذف داخل النموذج. |
| 57–58 | قائمة plain، وإخفاء خلفيتها الافتراضية حتى تظهر الخلفية السوداء. |
| 61–65 | صف أسفل الشاشة. زر تبديل القوائم يظهر عندما يوجد نبات، ومعه إما أننا في عرض الكل، أو مكتملون، أو هناك نباتات غير موجودة في قائمة اليوم. الهدف بقاء التعديل والتراجع ممكنين. |
| 66–67 | عنوان الزر Today إذا نعرض الكل، وإلا My Plants. toggle() تعكس Bool بين true وfalse. |
| 69–70 | خط subheadline ولون رمادي للزر. |
| 73 | Spacer يدفع زر الإضافة إلى الطرف الآخر. |
| 75–80 | زر + يجعل showAddPlant true. علامة plus بخط title2 ومساحة محتوى 28×28؛ نمط الزر قد يضيف مساحة أخرى حولها. |
| 82–85 | Liquid Glass بارز، شكل دائري، لون أخضر، واسم صوتي Add plant reminder. |
| 87–88 | هوامش الصف السفلي: 20 أفقيًا و16 من الأسفل. |
| 90–92 | خلفية سوداء ممتدة، نص أبيض، ومظهر داكن. |
| 93–98 | ورقة إضافة مرتبطة بـ Bool. نمرر ViewModel فقط، فيكون editingPlant الافتراضي nil. ارتفاع كبير، مؤشر سحب مخفي، وزوايا 28. |
| 99–104 | ورقة تعديل مرتبطة بعنصر Optional Identifiable. عند وجود editingPlant تأخذ closure النبات غير الاختياري ونمرره مع ViewModel. إغلاق الورقة يعيد binding إلى nil. لا نحتاج Bool ثانية لتحديد النبات. |
| 108–110 | PlantProgressView واجهة صغيرة خاصة بالملف تستقبل عدد الإنجاز ونسبته؛ لا تعرف الحفظ ولا الإشعارات. |
| 112–115 | عمود بمسافة 12. إذا العدد صفر تظهر رسالة النباتات تنتظر الماء. |
| 116–118 | وإلا ندخل completedCount في النص باستخدام String interpolation. |
| 119–121 | شريط قيمة progress من 0 إلى 1، لون أخضر هادئ، وحركة easeInOut مدتها 0.3 ثانية عند تغير progress تحديدًا. |
| 123–126 | خط subheadline وهوامش: 24 أفقيًا، 28 أعلى، 32 أسفل. |
| 130–134 | PlantRowView تستقبل بيانات العرض وفعلين. فصلها يجعل الشاشة الرئيسية أقصر، ويمنع الصف من تحمل مسؤولية حفظ القائمة. |
| 136–139 | عمود يحتوي صفًا أفقيًا؛ زر أول لتبديل الإنجاز عبر onToggle. |
| 140 | نختار صورة checkmark.circle.fill للمكتمل، أو circle لغير المكتمل. |
| 141–144 | حجم الرمز 22 نقطة، لونه أخضر عند الإنجاز وإلا رمادي، ومساحة الزر 32×44. |
| 146–148 | نمط plain، ووصف VoiceOver يتغير بين التراجع عن سقي الاسم أو وضعه كمسقي. الاسم يدخل بالنص عبر interpolation. |
| 150–151 | المعلومات نفسها داخل زر تعديل، ومحتواها عمود محاذٍ للبداية بمسافة 5. |
| 152–154 | نعرض in ثم اسم الغرفة الخام مع رمز موقع، بخط caption2 رمادي. |
| 156–158 | اسم النبات بخط title2 أبيض. |
| 160–165 | صف للمعلومات الصغيرة؛ Label الضوء يستخدم النص الخام والرمز المناسب. لون أصفر هادئ وحشوة 6 أفقية و2 عمودية وخلفية رمادية صغيرة بزوايا 5. |
| 167–171 | Label الماء مع رمز drop، لون أزرق فاتح ونفس الحشوات والخلفية. هاتان الخلفيتان أضيفتا لتقريب التصميم من Sketch. |
| 173 | خط caption2 لكلا الملصقين. |
| 175 | المعلومات تصبح بنصف الشفافية إذا اكتمل النبات؛ الزر الدائري خارج هذه المجموعة فلا تخفت علامته معها. |
| 176–177 | نمد معلومات النبات لعرض الصف ونحاذيها للبداية. contentShape(Rectangle()) يجعل مساحة المحتوى المستطيلة ضمن منطقة اللمس، وليس النص وحده. |
| 179–182 | نمط زر plain، هوامش عمودية 10، ثم Divider مخصص تحت الصف. |
| 187–189 | واجهة منفصلة لحالة الإنجاز، داخل عمود بدون مسافات افتراضية. |
| 190–194 | صورة CompletedPlantIllustration من الأصول، قابلة لتغيير الحجم مع حفظ النسبة، مساحة 190×200، وزخرفية لقارئ الشاشة. |
| 196–198 | All Done بخط title3 شبه عريض ومسافة علوية 24. |
| 200–203 | وصف الإنجاز بخط caption رمادي ومسافة علوية 10. |
| 205–206 | نبدأ المحتوى بعد 100 نقطة من الأعلى، ونجعل الحاوية تتمدد للمساحة المتاحة مع محاذاة المحتوى للأعلى. هذه أرقام لضبط الشكل وليست قواعد بيانات. |
| 210–211 | دالة خاصة لإنشاء بيانات المعاينة فقط. تستقبل هل كل النباتات مكتملة، وتنشئ ViewModel بدون تخزين. |
| 212–213 | for عادية تمر على Array من tuples، كل tuple فيها اسم وغرفة. (name, room) يفك الاثنين إلى متغيرين أثناء كل دورة. النوع معروف من أول عنصر. |
| 214–216 | ننشيء نباتًا بالقيم التجريبية ونضيفه للنموذج المؤقت. |
| 217–219 | إذا allCompleted صحيح نكمل كل نبات. وإلا نكمل الجميع ما عدا Monstera، فتظهر معاينة 3 من 4. هذا هو سبب علامات الإنجاز في Preview، وليس سلوك الإضافة في التطبيق الحقيقي. |
| 221 | نرجع النموذج المؤقت الجاهز للمعاينة. |
| 224–226 | Preview قائمة فيها 3 نباتات مكتملة من 4. |
| 228–230 | Preview جميع النباتات مكتملة. |
| 232–234 | Preview قائمة فارغة. تمريرها مباشرة إلى TodayReminderView يعرض حالة عدم وجود تذكيرات، دون المرور باختيار ContentView. |


---

**8. PlantoNotifications.swift — الكود كاملًا**

```text
  1 | import Foundation
  2 | import UserNotifications
  3 | 
  4 | @MainActor
  5 | enum PlantoNotifications {
  6 |     static func synchronize(plants: [Plant]) async {
  7 |         let center = UNUserNotificationCenter.current()
  8 |         let pending = await center.pendingNotificationRequests()
  9 |         let oldIDs = pending.map(\.identifier).filter { $0.hasPrefix("water-") }
 10 |         center.removePendingNotificationRequests(withIdentifiers: oldIDs)
 11 |         guard !plants.isEmpty else { return }
 12 | 
 13 |         do {
 14 |             let allowed = try await center.requestAuthorization(options: [.alert, .sound])
 15 |             guard allowed else { return }
 16 | 
 17 |             // One upcoming reminder per plant, at 9 AM on its next watering day.
 18 |             for plant in plants {
 19 |                 let content = UNMutableNotificationContent()
 20 |                 content.title = "Planto"
 21 |                 content.body = "Hey! Let's water your \(plant.name) 🌱"
 22 |                 content.sound = .default
 23 | 
 24 |                 let date = reminderDate(for: plant)
 25 |                 let components = Calendar.current.dateComponents(
 26 |                     [.year, .month, .day, .hour, .minute], from: date
 27 |                 )
 28 |                 let trigger = UNCalendarNotificationTrigger(
 29 |                     dateMatching: components, repeats: false
 30 |                 )
 31 |                 let request = UNNotificationRequest(
 32 |                     identifier: "water-\(plant.id.uuidString)",
 33 |                     content: content,
 34 |                     trigger: trigger
 35 |                 )
 36 |                 try await center.add(request)
 37 |             }
 38 |         } catch {
 39 |             print("Notification error: \(error)")
 40 |         }
 41 |     }
 42 | 
 43 |     static func reminderDate(for plant: Plant, now: Date = Date()) -> Date {
 44 |         let calendar = Calendar.current
 45 |         var dueDay = now
 46 |         if let lastWateredAt = plant.lastWateredAt {
 47 |             dueDay = calendar.date(
 48 |                 byAdding: .day, value: plant.wateringDays.days, to: lastWateredAt
 49 |             ) ?? now
 50 |         }
 51 |         dueDay = max(calendar.startOfDay(for: dueDay), calendar.startOfDay(for: now))
 52 |         let morning = calendar.date(
 53 |             bySettingHour: 9, minute: 0, second: 0, of: dueDay
 54 |         ) ?? dueDay
 55 |         // A reminder already due today is delivered shortly after saving.
 56 |         return max(morning, now.addingTimeInterval(60))
 57 |     }
 58 | 
 59 |     static func cancel(for id: UUID) {
 60 |         let center = UNUserNotificationCenter.current()
 61 |         let identifier = "water-\(id.uuidString)"
 62 |         center.removePendingNotificationRequests(withIdentifiers: [identifier])
 63 |         center.removeDeliveredNotifications(withIdentifiers: [identifier])
 64 |     }
 65 | }
```

**شرح الأسطر بالترتيب**

| الأسطر | المعنى ولماذا كتبناه |
|---|---|
| 1–2 | Foundation للتواريخ، وUserNotifications لطلب الإذن وجدولة إشعارات النظام. |
| 4–5 | نوع خدمات على Main Actor. استخدمنا enum بدون حالات لتجميع دوال static؛ لا نمثل هنا قائمة خيارات مثل PlantRoom، ولا نحتاج إنشاء كائن خدمة. |
| 6 | static تعني الاستدعاء باسم النوع: PlantoNotifications.synchronize. الدالة async لأن قراءة الإشعارات وطلب الإذن وإضافتها فيها انتظار غير متزامن. |
| 7 | نحصل على مركز إشعارات التطبيق من النظام. |
| 8 | ننتظر قائمة الإشعارات التي لم تُسلّم بعد. await لا تعني انتظار المستخدم بحلقة توقف الشاشة. |
| 9 | map(\.identifier) يحول طلبات الإشعار إلى قائمة معرّفات نصية، ثم filter يبقي التي تبدأ بـ water-. هذا prefix يميز إشعارات النباتات حتى لا نحذف أي نوع آخر قد يضاف لاحقًا. |
| 10–11 | نزيل المواعيد القديمة الخاصة بالنباتات. إذا لا نباتات نخرج؛ لذلك حذف آخر نبات يفرغ قائمة مواعيده أيضًا. |
| 13–15 | نحاول طلب إذن التنبيهات والصوت. العملية قد ترمي خطأ لذلك try، وقد تنتظر لذلك await. إذا رفض المستخدم، نخرج ويظل التطبيق قابلًا للاستخدام بدون إشعارات. النظام لا يعيد نافذة الإذن كل مرة بعد حسم الاختيار. |
| 17–18 | ننشئ موعدًا قادمًا واحدًا لكل نبات في القائمة. for هنا لتنفيذ أوامر، وليست ForEach لبناء Views. |
| 19–22 | ننشئ محتوى قابلًا للتعديل: العنوان Planto، رسالة فيها اسم النبات، والصوت الافتراضي. |
| 24–27 | نحسب الموعد ثم نأخذ مكوناته: السنة والشهر واليوم والساعة والدقيقة. لم نضمّن الثواني؛ لذلك التوقيت هنا بدقة الدقيقة. |
| 28–30 | Calendar trigger يحدد متى يرسل النظام الإشعار. repeats: false يعني موعدًا واحدًا، وليس إشعارًا يتكرر تلقائيًا للأبد. |
| 31–35 | نبني request تجمع الهوية والمحتوى والموعد. الهوية water- ثم UUID كنص، حتى نستطيع تحديد إشعار النبات عند إلغائه. |
| 36 | نطلب من النظام حفظ الإشعار وجدولته. try await لأن العملية غير متزامنة وقد تفشل. |
| 38–39 | عند الفشل نطبع رسالة للمطور في Console. حاليًا هذا الخطأ لا يظهر للمستخدم في alert؛ لا تدّعين أنه يظهر. |
| 43 | دالة تحسب Date فقط، بدون إرسال إشعار. now افتراضيه الوقت الحالي، لكن يمكن تمرير تاريخ ثابت لفحص الحساب. هذا يجعل المنطق أسهل للتحقق. |
| 44–45 | نستخدم التقويم الحالي ونبدأ بافتراض الاستحقاق اليوم. |
| 46–49 | إذا يوجد آخر سقي، نضيف له عدد أيام فترة السقي. calendar.date قد ترجع nil فنستخدم now بديلًا. |
| 51 | نأخذ الأحدث بين بداية يوم الاستحقاق وبداية اليوم الحالي؛ لا نعيد موعدًا يقع في يوم قديم لنبات متأخر. |
| 52–54 | نحدد التاسعة صباحًا في اليوم المحسوب. إذا فشل التقويم نستخدم dueDay بديلًا. |
| 55–56 | نرجع الأحدث من التاسعة وnow + 60 ثانية، حتى لا نطلب وقتًا مضى. لكن عند بناء trigger نأخذ الدقائق فقط، فيكون الإرسال المقصود خلال الدقيقة القادمة تقريبًا، وليس ضمان 60 ثانية كاملة. النظام يحدد التسليم الفعلي. |
| 59–61 | دالة إلغاء static تستقبل UUID وتبني نفس معرّف الإشعار. for اسم المعامل الخارجي، وid اسمه داخل الدالة. |
| 62 | نزيل الإشعار المعلق الذي لم يُسلّم. |
| 63 | ونزيل الإشعار الذي سبق تسليمه من مركز الإشعارات، إذا كان موجودًا. |


---


**ملفات الصور وإعدادات المشروع**

Assets.xcassets يحتوي مجلدات أصول. PlantIllustration صورة البداية، وCompletedPlantIllustration صورة الإنجاز. Image("PlantIllustration") يبحث بالاسم داخل الأصول. Contents.json داخل imageset وصف للصورة واسم الملف ونسخ المقاسات؛ ليس منطق شاشة. AccentColor أصل لون؛ الألوان المستخدمة في الكود الحالي أغلبها معرفة مباشرة بـ Color وليست كلها مأخوذة منه.

Planto.icon أصل أيقونة التطبيق. Products/PlantsApp.app ناتج البناء؛ Xcode ينشئه، ولا نكتب فيه قواعد السقي. ملفات المشروع تحدد الهدف والملفات والإعدادات. xcuserdata إعدادات خاصة بالمستخدم داخل Xcode. ملف Git يسجل تاريخ العمل؛ لا يدير بيانات نباتات المستخدم.

**ما الذي كان موجودًا وما الذي أضفناه؟**

| الجانب | قبل التعديل الذي عملناه معًا | النسخة الحالية |
|---|---|---|
| Models | Plant وEnums والـ Optional موجودة | أضفنا Codable وأرقام الفترات ورموز الضوء وقواعد التاريخ والتراجع. |
| MVVM | فصل أساسي موجود | العمليات موحدة داخل ViewModel، والصفوف والأقسام أصغر. |
| التخزين | قائمة في الذاكرة تبدأ فارغة | حفظ محلي UserDefaults بعد تحويل البيانات بـ JSONEncoder وتحميلها بـ JSONDecoder. |
| الحذف | إلغاء الإشعار في مسار السحب فقط | كل حذف عبر ViewModel يلغي الإشعار. |
| قائمة اليوم | تعرض كل النباتات | تعرض المستحق والمسقي اليوم مع وصول منفصل لكل النباتات. |
| الحالة الفارغة | تعود شاشة البداية عند فراغ القائمة | hasStartedJourney يميز البداية عن حذف آخر نبات. |
| إكمال الجميع | الشاشة تخفي الوصول للقائمة | زر My Plants يسمح بالعودة والتراجع أو التعديل. |
| المظهر | أجزاء قريبة من المرجع | عنوان موحد، ملصقات للضوء والماء، رموز حسب الضوء، وأزرار Liquid Glass. |
| تقدم الإنجاز | ProgressView موجود | حركة مرتبطة بتغيّر النسبة. |
| الإشعارات | تكرار كل عدد أيام من وقت الجدولة | موعد قادم واحد حسب تاريخ السقي، يعاد حسابه عند تغيّر البيانات. |

**أهداف التحدي والأدلة التي تقدرين تعرضينها**

Swift وSwiftUI: ملفات الشاشات، TextField وPicker وList وsheet وButton وإدارة الحالة.
Data Modeling: Plant struct، PlantsViewModel class، أربع enums، وOptional لتاريخ السقي ونبات التعديل.
MVVM: أشيري إلى Model وViewModel وView، ثم اشرحي مسار عملية إضافة فعلية.
Liquid Glass: أشيري إلى .buttonStyle(.glassProminent) في زر البداية والإضافة، و.glassEffect في أزرار رأس النموذج.
Git/GitHub: يوجد مستودع مربوط بـ GitHub وسجل commits سابق. لا تعني التعديلات المحلية أو staging أنها رُفعت؛ يلزم commit ثم push لتظهر على GitHub. لم ننفذ commit أو push في عمل التعديلات السابق.

المشروع يستخدم VStack وHStack؛ لا نقول إننا استخدمنا ZStack لمجرد أنه موجود في قائمة التعلم. النموذج مبني بـ ScrollView وStacks وليس SwiftUI Form. شريط التقدم مكوّن SwiftUI عادي مع tint وanimation، وليس رسم ProgressView مخصصًا من الصفر. توضيح هذه الفروق أفضل من الادعاء بأننا طبقنا أشياء غير موجودة.

**رحلة كاملة كمثال**

1. التطبيق يبدأ من MyApp ويعرض ContentView.
2. ينشئ ContentView كائن PlantsViewModel، الذي يحاول قراءة البيانات المحلية.
3. إذا المستخدم جديد تظهر StartJourneyView.
4. زر Set Plant Reminder يغيّر Bool، فتفتح sheet.
5. المستخدم يكتب Pothos ويختار Bedroom وLow Light وOnce a week و20-50 ml.
6. كل اختيار يغيّر @State للمسودة، وبعضها من واجهات فرعية عبر @Binding.
7. عند الضغط على الحفظ، savePlant ينظف الاسم وينشئ Plant ويطلب addPlant.
8. الـ ViewModel يضيف النبات ويغيّر hasStartedJourney ويحفظ البيانات ويطلب مزامنة الإشعارات.
9. SwiftUI تتابع التغيّر فتظهر الشاشة الرئيسية. النبات جديد، وتاريخ سقيه nil، لذلك مستحق اليوم.
10. عند الضغط على الدائرة، نحفظ التاريخ السابق ونضع اليوم آخر سقي.
11. completedCount يزيد، والتقدم يتغير، وإذا اكتمل الجميع تظهر All Done.
12. زر My Plants يعيد الوصول للقائمة. التراجع يسترجع التاريخ السابق.
13. التعديل ينشئ مسودة من نفس النبات، والحفظ يحدّثه بنفس id.
14. الحذف يزيل العنصر ومعرّف إشعاره ويحفظ القائمة. إذا كانت هذه آخر نبتة تظهر No reminders.
15. عند إعادة التشغيل، نقرأ البيانات والرحلة من UserDefaults بدل بدء قائمة جديدة كل مرة.

**أشياء لازم تكون إجابتك عنها دقيقة**

- لا يوجد تسجيل حساب أو خادم أو مزامنة سحابية؛ التخزين محلي.
- UserDefaults حل بسيط لحجم تعليمي صغير، وليس قاعدة بيانات كبيرة. SwiftData أو تخزين ملف يمكن أن يناسب توسعًا لاحقًا، ولم نستخدمهما هنا.
- كمية الماء والضوء مدخلات المستخدم؛ التطبيق لا يعرف تلقائيًا احتياج نوع النبات.
- «اليوم» محسوب بتقويم الجهاز، ويُحدّث عند نشاط التطبيق وبمراجعة كل دقيقة أثناء عمل المهمة.
- الإشعارات تحتاج إذن النظام. عدم ظهور نافذة الإذن لا يثبت نجاح التسليم؛ قد يكون الإذن محسومًا سابقًا.
- هناك إشعار قادم واحد لكل نبات، repeats: false. لا تقولي «يتكرر للأبد كل أسبوع». نعيد الجدولة بعد الإضافة والتعديل والسقي والتراجع والحذف. تجاهل إشعار ثم عدم فتح التطبيق أو تغيير البيانات لا يولّد سلسلة جديدة تلقائيًا.
- إذا تعدلت نبتة، المزامنة الحالية تعيد بناء مواعيد كل النباتات، وهي بساطة مناسبة للقائمة الصغيرة، وليست تحديثًا جزئيًا متقدمًا.
- await لا يعني دائمًا thread خلفي، وTask لا تعني أن التطبيق سيظل يعمل وهو مغلق.
- @Observable لا تحفظ، و@State لا تعوض UserDefaults.
- Preview بيانات عرض، ولا تثبت وحدها أن رحلة المستخدم الفعلية نجحت.
- مطابقة الشكل أقرب للمرجع، ولم نثبت تطابق بكسل ببكسل.
- نجح Build، وفُحصت قواعد الأيام والتراجع والترميز في snippets مؤقتة. هذه ليست ملفات Unit Tests محفوظة في Target اختبارات.
- تجربة المحاكي أكدت عدة عمليات والحفظ بعد إعادة التشغيل، لكن لوحظت مدخلات غير متوقعة وظهور نبات جديد مكتملًا أثناء التجربة؛ لم يُثبت سببها، فلا نخفيها أو نصف التطبيق بأنه خالٍ من الأخطاء. قواعد النموذج عند إنشاء نبات جديد تعطي تاريخًا nil ولا تضع علامة إنجاز تلقائيًا.
- لم نتحقق من تسليم إشعار فعلي على الجهاز في تلك التجربة.

**أسئلة محتملة من المينتور وإجابات للفهم**

| السؤال | جواب تقدرين تقولينه بكلماتك |
|---|---|
| اشرحي مشروعك في نصف دقيقة | تطبيق ينظم نباتاتي وتفاصيل العناية، يعرض مستحقات اليوم، ويتابع الإنجاز ويحفظ محليًا ويجدول إشعارًا قادمًا. |
| لماذا اخترتِ MVVM؟ | لفصل شكل الشاشة عن إدارة البيانات، فلا أكرر الحفظ والحذف في كل واجهة. |
| لماذا Plant struct؟ | لأنه سجل بيانات يمثل قيمة، وأقدر أعمل نسخة للتعديل ثم أحفظها. |
| لماذا ViewModel class؟ | عشان كل الشاشات تشترك في نفس الكائن والقائمة. |
| هل let viewModel يمنع تعديل النباتات؟ | يمنع تبديل مرجع الكائن داخل الواجهة، لكن دوال class تستطيع تغيير خصائصه. |
| لماذا enum للغرف؟ | الخيارات محددة؛ يمنع قيمًا غير مدعومة ويسهل عرض جميع الخيارات. |
| ما CaseIterable؟ | يوفر allCases لبناء خيارات Picker من enum. |
| ما rawValue؟ | القيمة النصية المرتبطة بحالة enum، مثل Bedroom. |
| ما Codable؟ | يجمع القدرة على الترميز وفك الترميز؛ استخدمناه لتحويل النموذج إلى Data بصيغة JSON واستعادته. |
| لماذا Identifiable؟ | حتى تعرف SwiftUI هوية الصف أو العنصر عند التحديث وsheet(item:). |
| لماذا UUID وليس الاسم؟ | ممكن يتكرر الاسم أو يتغير، بينما نحتاج هوية مستقرة لكل نبات. |
| ما Optional عندك؟ | lastWateredAt قد لا يحتوي تاريخًا، وeditingPlant قد لا يحتوي نباتًا وقت الإضافة. |
| لماذا guard let؟ | نتأكد من وجود القيمة ونخرج مبكرًا إن غابت بدل استخدام قيمة غير موجودة. |
| ما الفرق بين nil و""؟ | nil لا توجد قيمة أصلًا؛ النص الفارغ قيمة String موجودة لكن طولها صفر. |
| ما الفرق بين @State و@Binding؟ | State تملك الحالة؛ Binding رابط لتعديل حالة يملكها غيرها. |
| ما الفرق بين $selectedRoom و$0؟ | الأول Binding لحالة؛ الثاني أول معامل في closure مختصرة. |
| لماذا _plantName في init؟ | لتهيئة تخزين State بقيمة البداية، من النبات الموجود أو من قيمة افتراضية. |
| هل onSave: savePlant تحفظ فورًا؟ | لا؛ تمرر الدالة، والزر ينفذها لاحقًا عند الضغط. |
| لماذا private(set)؟ | أسمح بالقراءة من الواجهة وأجبر التعديل على المرور بالدوال التي تحفظ وتزامن. |
| ما الخاصية المحسوبة؟ | نتيجة تُحسب عند القراءة مثل progress، بدل تخزين نسخة قد تصبح قديمة. |
| كيف حسبتِ progress؟ | المكتمل اليوم مقسوم على إجمالي قائمة اليوم، كـ Double مع حماية من القسمة على صفر. |
| لماذا اليوم يشمل المكتمل؟ | حتى يظهر ما أنجزناه ويبقى المقام ثابتًا أثناء الإنجاز. |
| لماذا previousWateredAt؟ | عشان التراجع عن علامة اليوم يرجع التاريخ الأصلي ولا يضيع موعد النبات السابق. |
| كيف نفرق إضافة وتعديل؟ | editingPlant nil تعني إضافة، وقيمة موجودة تعني تعديل بنفس id. |
| لماذا مسودة في النموذج؟ | المستخدم يقدر يغير ثم يلغي بدون تعديل البيانات الأصلية قبل Save. |
| لماذا UserDefaults؟ | حفظ محلي بسيط لكمية بيانات صغيرة في هذا المشروع التعليمي، بعد ترميزها. |
| ما async وawait؟ | async تعني دالة يمكن أن تتوقف مؤقتًا للانتظار، وawait نقطة انتظار نتيجتها بدون حجز التنفيذ بطريقة تزامنية. |
| ما try وcatch؟ | try لاستدعاء شيء قد يرمي خطأ، وcatch لمعالجة ذلك الخطأ. |
| لماذا Task الإشعارات تنتظر السابقة؟ | لمنع تحديث قديم يصل متأخرًا ويعيد موعدًا لم يعد صحيحًا. |
| كيف يرسل إشعار والتطبيق مغلق؟ | نسجل طلبًا عند نظام iOS؛ النظام مسؤول عن تسليمه وفق الإذن والإعدادات. لا نعتمد على loop داخل التطبيق. |
| أين Liquid Glass؟ | في أنماط أزرار البداية والإضافة، وفي glassEffect لأزرار الحفظ والإغلاق. |
| ماذا فعلتِ لتقليل تكرار الكود؟ | عنوان مشترك، صف نبات مستقل، أقسام نموذج مستقلة، وحذف موحد في ViewModel. |
| الفرق بين Git وGitHub؟ | Git يتتبع نسخ العمل محليًا، وGitHub يستضيف المستودع عن بعد ويساعد المشاركة. |
| الفرق بين stage وcommit وpush؟ | stage اختيار التغييرات للنسخة، commit تسجيل نسخة محلية، push رفع الـ commits للمستودع البعيد. |
| ما الذي ستطورينه لاحقًا؟ | أختبر التسليم الفعلي للإشعارات، وأحسم حالة الإضافة التي ظهرت في المحاكي، وأوسع الاختبارات ومراجعة المقاسات. |

**تمارين قصيرة بدل الحفظ**

1. احسبي progress لو عندك 4 نباتات اليوم وواحد مكتمل. الجواب 0.25.
2. نبات أسبوعي آخر سقي له قبل 3 أيام: isDue false؛ قبل 7 أيام true؛ قبل 9 أيام true.
3. اسم النبات في النموذج كله مسافات: زر الحفظ معطل وguard يمنع الحفظ.
4. المستخدم فتح تعديلًا وغير الاسم ثم ضغط X: القائمة تبقى باسمها السابق لأننا عدلنا المسودة فقط.
5. نباتان اسمهما Pothos: يمكن تمييزهما بـ UUID.
6. حذف آخر نبات: plants فارغة لكن hasStartedJourney true، لذلك No reminders وليس البداية.
7. lastWateredAt nil: isWatered false وisDue true.
8. حفظ غرفة في Picker: الواجهة تعرض rawValue، لكن selection يخزن PlantRoom، وليس النص.
9. تغيير اسم نبات مكتمل: نحتفظ بـ id وتاريخ السقي؛ تعديل الاسم لا ينشئ نباتًا جديدًا.
10. لماذا !todayPlants.isEmpty في allCompleted؟ لأن 0 == 0 صحيح حسابيًا لكن لا يعني أننا أنجزنا تذكيرات فعلية.

**طريقة مذاكرة الليلة**

ابدئي بالفكرة وخريطة الملفات، ثم Plant، ثم ViewModel. بعد ذلك افهمي مسار إضافة واحدة كاملًا قبل تفاصيل الألوان والمسافات. اقرئي ContentView وSetReminderView، ثم TodayReminderView، واتركي تفاصيل الإشعارات للنهاية. أثناء القراءة افتحي الملف في Xcode وابحثي عن السطر المذكور.

لا تحتاجين تبرير الرقم 24 كأنه قاعدة في Swift؛ هو اختيار تصميم. لكن لازم تعرفين لماذا استخدمنا Optional وBinding وUUID ولماذا فصلنا الحفظ عن الواجهة.

أجزاء الحفظ وCodable وTask وMainActor والـ Binding المحسوبة أعمق من أساسيات Text وVStack. خذي الوقت لتفهمي السبب من كل جزء. إذا سُئلتِ عن شيء ما زلتِ تتعلمينه، اشرحي الوظيفة التي فهمتيها بصدق بدل ادعاء إتقان تفاصيل التزامن.

**مراجع Apple للتوسع عند الحاجة**

- [State](https://developer.apple.com/documentation/swiftui/state)
- [Binding](https://developer.apple.com/documentation/swiftui/binding)
- [Observation](https://developer.apple.com/documentation/observation)
- [UserDefaults](https://developer.apple.com/documentation/foundation/userdefaults)
- [Liquid Glass للمكونات المخصصة](https://developer.apple.com/documentation/swiftui/applying-liquid-glass-to-custom-views)
- [UNCalendarNotificationTrigger](https://developer.apple.com/documentation/usernotifications/uncalendarnotificationtrigger)

