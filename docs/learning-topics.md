# مواضيع اتعلمناها — قايمة للمراجعة التفصيلية

دي قايمة المواضيع اللي اشتغلنا عليها في المشروع، مجموعة عشان نرجع نشرحها واحدة واحدة بعدين.
كل بند فيه: **الفكرة في سطر**، و**فين شفناها في الكود** (لو اتنفذت).

**حالة:**

- ✅ اتنفذت في الكود
- 📝 شرح نظري (مافيش كود ليها في المشروع)
- ⏳ مؤجلة أو لسه مبدأناهاش

---

## 1. Dart

### 1. `Either` — `fold` مقابل `map` ✅
`fold` بتستهلك النتيجة (نجاح أو فشل) وبترجّع قيمة. `map` بتتحوّل جانب واحد بس. والمهم: النتيجة **كسولة** — لو محدش استهلكها، مفيش حاجة بتنفذ.
`lib/features/subjects/presentation/bloc/subject_bloc.dart`

### 2. `guard()` و `Either<Failure, T>` ✅
كل repository بيلف الاستدعاء في `guard`: لو رمى استثناء، بيترجم لـ `Failure` ويرجّع `Left`. فالـ bloc مش بيعمل `try/catch`.
`lib/core/errors/repository_guard.dart`

### 3. `@injectable` مقابل `@lazySingleton` ⏳
`@injectable` = نسخة جديدة كل مرة تطلبها. `@lazySingleton` = نسخة واحدة بتعيش. البلوك عادةً `@injectable` عشان مايحملش حالة قديمة بعد الخروج من الشاشة.
`lib/features/subjects/presentation/bloc/subject_bloc.dart`

### 4. Tear-off ✅
`res.map(ChapterModel.fromJson)` نفس `res.map((b) => ChapterModel.fromJson(b))`. الاسم لوحده = الدالة نفسها، مش نتيجتها.

### 5. `late final` والنوع الصريح ✅
`late final TextEditingController searchController;` — التعريف من غير نوع بيخلي النوع `dynamic`، وده بيلغي مساعدة الـ analyzer.

## 2. الحالة (BLoC)

### 6. `setState` جوه `initState` ⏳
مفيش حاجة اترسمت بعد، فملهاش لازمة — الإسناد العادي كفاية.

### 7. `BlocBuilder` مقابل `BlocConsumer` ✅
`BlocBuilder` بيرسم. الـ `listener` في `BlocConsumer` بيعمل شغل جانبي (توست، تنقّل). اللي بيتبني على الـ `listener` بيتأخر فريم، وده سبب مشاكل في الهيدر.

### 8. `TextEditingController`: `addListener` لازم `setState` ✅
من غير `setState` مفيش إعادة رسم، فالفلترة بتحصل وما بتوصلش للشاشة.

### 9. ترتيب `dispose` ✅
`super.dispose()` آخر سطر، مش الأول.

### 10. الفلترة جوه `build` مش في `listener` ✅
الحالة هي المصدر، والقايمة المفلترة بتتحسب في `build` من نص البحث. أسهل في القراءة وأقل في الأخطاء.

## 3. التنقّل واللغة

### 11. GoRouter: `push` مقابل `go` ✅
`go` بتستبدل المسار (تبويبات)، `push` بتضيف فوق بعض (شاشات داخلية فيها سهم رجوع).

### 12. المسار النسبي مقابل الثابت ✅
الـ `GoRoute.path` جوه راوت أب لازم يبقى نسبي (`chapters`), واللي بتبعته لـ `context.push` لازم يكون كامل (`/subjects/x/chapters`).

### 13. RTL: أول عنصر في `Row` على اليمين ✅
مش محتاج `Directionality` ولا حسابات — الترتيب في الـ `Row` بيتقلب تلقائي مع اتجاه اللغة.

### 14. اتجاه السهم في RTL ✅
رجوع = سهم بيشاور **يمين**. تقدّم = سهم بيشاور **شمال**.

### 15. الأرقام: عربي (١٢٣) ولا لاتيني (123) ✅
اخترنا اللاتيني للاتساق مع `0/3` اللي في `SubjectCard`.

### 16. `easy_localization` وملفات `ar/en` ⏳
كل نص في `.tr()`، والمفاتيح متطابقة في اللغتين. المؤجل: تمريرة واحدة على كل الشاشات بعد ما تخلص.

## 4. الثيم والتصميم

### 17. `MaterialApp.builder` لخلفية عامة ✅
لفّ `child` في `AppBackground` مرة واحدة، فكل الراوتس تاخد الخلفية من غير كود في كل شاشة.

### 18. `scaffoldBackgroundColor: Colors.transparent` ✅
من غيرها الـ `Scaffold` بيرسم لون فوق الخلفية، فالصورة تختفي.

### 19. `elevation` مقابل التصميم المسطّح ⏳
الـ design system مسطّح، بس القرار: الكروت بـ `elevation`. مسجّل إنه اختيار مقصود.

### 20. `LinearProgressIndicator` ✅
`value` من 0.0 لـ 1.0، ولازم `color` و`backgroundColor` صريحين.

### 21. `surfaceVariant` مش معرّف عندنا ✅
الـ `ColorScheme` بتاعنا ناقصه، فالـ Material بيرجع لون افتراضي (لافندر) — وده اللي كان بيخلي الشريط يبان مالي.

## 5. الرسم والودجتس

### 22. `Material` + `InkWell` والـ splash ✅
الحبر بيترسم على الـ `Material`، فلو فيه `Container` بلون فوقه، الـ splash بيختفي تحته.

### 23. `Ink` ووظيفتها ✅
`Ink` بترسم الديكوريشن **جوه** طبقة الـ Material، فالـ splash بيبان فوقها — عكس الكونتينر العادي.

### 24. `Stack` + `Positioned` لصورة متداخلة ⏳
`clipBehavior: Clip.none` على الـ `Stack`، والصورة **بره** الـ `Material` المتقص، و`Positioned` بإحداثيات سالبة تخرجها بره الحدود.

### 25. `IntrinsicHeight` ✅
بيخلي عناصر الـ `Row` تاخد أطول ارتفاع فيهم.

### 26. `ListView.separated` والـ padding السفلي ⏳
الـ `padding` السفلي مطلوب عشان آخر عنصر مايلزقش في الفاب/البوتوم بار.

### 27. `MediaQuery.viewInsetsOf` وإخفاء الفاب ✅
`viewInsets.bottom > 0` = الكيبورد مفتوح.

### 28. استخراج widget ✅
بدل دالة top-level جوه ملف الشاشة: `presentation/widgets/x_card.dart` بشكل `StatelessWidget`. والتسمية: الـ widget مابتاخدش `context` كـ field.

### 29. ScreenUtil: `.w` / `.h` / `.sp` ⏳
`.w` للعرض، `.h` للطول، `.sp` للخطوط. المتساوي في الاتجاهين بيفضل رقم عادي.

### 30. `AppAnimatedEntry` ⏳
دخول العناصر بتأخير — `delay` بتزيد لكل عنصر.

## 6. Supabase / PostgREST

### 31. اتجاه الـ embed ✅
العلاقة many-to-one بترجع **object** (`subjects(title)`)، one-to-many بترجع **array** (`files(...)`).

### 32. مفيش embed من غير FK ✅
PostgREST بيبني الـ embed من علاقة معرّفة في الداتابيز. مفيش FK = استعلامين أو view.

### 33. `count()` على مجموعة فاضية ✅
بترجع `[{"count": 0}]` مش `[]`.

### 34. RLS بتفلتر الـ embed ✅
`user_file_progress(user_id)` بترجع صفوف المستخدم الحالي بس، فمفيش مقارنة `user_id` في Dart.

### 35. `.order()` مرتين ✅
`.order('sort_order')` على الجدول، و`.order('sort_order', referencedTable: 'files')` على الملفات جوه كل شابتر.

### 36. `.eq()` المتكررة = AND ✅
و`.match({...})` نفس الحاجة في شكل Map.

### 37. `.single()` ✅
لما تكون متأكد إن فيه صف واحد بالظبط؛ غيره بيرمي.

## 7. قاعدة البيانات والـ migrations

### 38. migration ثابتة ✅
الملف اللي اتنفذ مبيتعدلش — كل تغيير ملف جديد برقم.

### 39. `default` في الأعمدة الجديدة ✅
`add column ... not null default 'chapter'` بيعبي الصفوف القديمة، فمفيش backfill يدوي.

### 40. partial unique index ✅
`where kind = 'final'` بيمنع تكرار التحدي الكبير جوه المادة، وبيسمح بتكرار `subject_id` للشابترز.

### 41. `check constraint` ✅
`kind in ('chapter','final')` — الداتابيز بترفض أي قيمة تالتة.

### 42. index على الـ FK ✅
Postgres مابيعملش index تلقائي على عمود الـ FK (`0007`).

### 43. `grant` مقابل `RLS` ✅
`grant` = هل تقدر تلمس الجدول. `RLS` = أنهي صفوف. الاتنين مطلوبين.

### 44. عمود `kind` بدل جدول جديد ✅
لما صفين من نفس الشكل (شابتر / تحدي كبير) بيختلفوا في المعنى بس، عمود تفرقة أنضف من جدول موازي.

### 45. `sort_order` متخزن مش مشتق ✅
وفخ الـ backfill: لما `created_at` بيتساوى، الترتيب بيقع على العمود التاني (أبجدي) — وده اللي قلب `Complexity` قبل `Stacks & Queues`.

### 46. الأعمدة المشتقة ✅
`stages_count` اتشالت (`0010`) لأنها `filesCount + 1`.

### 47. `seed.sql` ✅
بيانات تيست بمعرّفات ثابتة، وترتيب تنظيف معروف، ومفيش `cascade` بالتصميم.

### 48. فجوة `college_id` ⏳
`subjects` فيه `college_id` والمستخدم لأ. مسجلة في `DB_BACKLOG.md`.

## 8. المنطق والمنتج

### 49. حلقة المحتوى ✅
`questions → file_questions → files → bosses`. مقفولة، فبوس من غير ملفات = صفر أسئلة.

### 50. الشابتر = صف في `bosses` ✅
والتحدي الكبير صف تاني بـ `kind = 'final'` في نفس الجدول.

### 51. فتح البوس ✅
`completedFiles == filesCount` (و`filesCount > 0`).

### 52. `user_file_progress` set مش log ⏳
صف واحد لكل (مستخدم، ملف). إعادة اللعب مابتضيفش صف.

### 53. النتيجة على السيرفر دايماً ⏳
XP/Coins بتتحسب في الداتابيز، والعميل بيقرأ بس.

## 9. طريقة الشغل

### 54. طبقة واحدة في المرة ✅
مراجعة domain → data → presentation، والتوقف عند كل طبقة.

### 55. المؤجل بيتكتب ✅
`docs/ui_notes.md` للحاجات الشكلية، و`docs/DB_BACKLOG.md` لقرارات الداتابيز.

### 56. `flutter analyze` عند صفر ✅
أي تحذير جديد بيتراجع قبل ما نكمل.
