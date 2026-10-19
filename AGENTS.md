# AGENTS.md — الـ Default Context للمشروع (ElMohadra / المحاضرة)

> مصدر المحتوى: ملفات Specs في `/home/abdallah/Downloads/المحاضرة/` (نص مستخرج في `docs/memory/*.txt`).
> اقرأ هذا الملف كمرجع افتراضي لكل شغل على المشروع.

---

## 1. المنتج — Product Foundation (v1.0 · MVP Scope)

**الجملة التلخيصية:** المحاضرة هو منصة تنافسية لطلبة الحاسبات بتحول مراجعة المواد الدراسية إلى معارك حقيقية بين الطالب، مبنية على محتوى موثوق ونظام تقدم عادل. — *Learn. Compete. Dominate.*

- مش تطبيق كويزات عادي — هو arena تنافسية مرتبطة بمنهج الكلية الفعلي.
- **الجمهور:** طلبة الحاسبات — **Android-first**، iPhone لاحقاً (تحت التكامل).
- **الحل (الدورة الأساسية):** الطالب يختار مادة → يدخل تحدي أو Boss → يحل أسئلة/يكتشف أخطاء → يشوف النتيجة وتفسير نقاط القوة/الضعف → يكسب XP ويرفع ترتيبه → يتحدى زميل.
- **MVP Out of Scope:** شخصيات دكاترة حقيقيين، لوحة تحليلات أساتذة، تشغيل كود غير موثوق، دعم جامعات متعددة.

**فلسفة المنتج:**
- AI مساعد مش بطل — يساعد في تجهيز المحتوى بس.
- العدل: النتيجة بتتحسب على السيرفر دايماً.
- المحتوى قبل Features — التطبيق لازم يشتغل ويفيد حتى لو AI/PvP مش موجود.

---

## 2. Features — MVP

**داخل الـ MVP (بالترتيب):**
1. تسجيل الدخول وإنشاء الحساب (اسم، دفعة، تخصص)
2. الملف الشخصي (اسم، دفعة، مستوى، XP، Avatar)
3. مكتبة المواد والتحديات (مادة → موضوع → تحديات)
4. Quiz Engine — أسئلة مع تفسير كل إجابة
5. **Boss Raid** — التحدي الرئيسي / Signature Feature
6. نظام XP والمستويات
7. نظام Coins والمتجر (Cosmetics فقط)
8. Leaderboard (مستوى الدفعة أو المادة — بقواعد معلنة)
9. **Real-time Battle** — Crown Feature (آخر حاجة في الـ MVP)

**المؤجل لما بعد MVP:** Async PvP، توليد أسئلة AI (بمراجعة بشرية)، Bug Hunt متقدم، Achievements، جامعات متعددة.

**ترتيب التنفيذ داخل الـ MVP:**
`01 Core Loop` → `02 Boss Raid` → `03 Store + Coins` → `04 Real-time Battle`

---

## 3. Game Design

### أرقام التقدم (ما تتخلطش — 4 حاجات مختلفة):
| الرمز | المعنى |
|---|---|
| **Score** | نتيجة الطالب في تحدي معين |
| **XP** | الخبرة المتراكمة (إجمالي كل التحديات) |
| **Level** | المستوى المستند لحد معيّن، بيبيّنها Badge |
| **Rank** | الترتيب مقارنة بزمايله |

> الطالب ممكن يكون Level عالي ويخسر تحدي — ده طبيعي وصح.

### نظام XP
- بيتحسب **على السيرفر بس**.
- Boss Raid أعلى من Quiz عادي في الـ XP؛ الإجابات الصح بتضيف.
- كل مكافأة بتتسجل في `xp_ledg` (xp_history) عشان منع التكرار.

### نظام Coins
- **منفصلة تماماً عن الـ XP** — مصدرها الوحيد الأداء في التحديات:
  - Perfect Battle (كل الإجابات صح) → كتير
  - Boss Raid فوز → متوسط
  - Boss Raid خسارة → قليل
- ما فيش طريقة تانية تكسب Coins في الـ MVP — وبتنفعش غير المتجر.

### المتجر
- **Cosmetics فقط** — Avatar Frames، Username Frames. مش بتشتري قوة أو ميزة gameplay.

### Boss Raid (Signature Feature)
- مش مجرد Quiz — معركة ليها بداية ونهاية وشروط فوز:
  - اسم + موضوع دراسي واضح، عدد مراحل محدد من الأول، شروط الفوز معلنة قبل البدء.
- **المراحل:** `1 Knowledge` → `2 Application` → `3 Bug Hunt` → `Final Mastery Check`
- مثال: The Structure Keeper (Stacks, Queues & Complexity).
- الـ Bug Hunt في الـ MVP بيعتمد على **كود ثابت وإجابة مرجعية**.
- السؤال الواحد ممكن يدخل في أكتر من Boss.
- نفس المحتوى للاتنين — لو خصمين في نفس الوقت.

### Real-time Battle (Crown Feature)
- WebSockets + Room management + State sync — **أصعب feature تقنياً**، بيتبنى **آخر حاجة في الـ MVP**.

### أمان نظام اللعبة
- النتيجة **بتتحسب على السيرفر دايماً** — مش بتيجي من العميل.
- حالات المحاولة: `in_progress` / `completed` / `expired`.
- معاملة واحدة (Transaction) بتغيّر حالة المحاولة + تعتمد النتيجة + تسجل XP/Coins.
- الـ API بيرجع الإجابة الصحيحة بس — إجابات الخصم مش بتتساب، والإجابات الغلط مش بتساعد.

---

## 4. Battle Design

- الـ Battle بتبقى **بس على Official Files** (المحتوى الموثوق المعتمد كـ admin).
- **إيجاد الخصم (طريقتين، الاتنين في MVP كـ fallback لبعض):**
  1. Friend Request جوه التطبيق
  2. كود أو لينك بره التطبيق (Invite Code)
- **الشكل:** 10 أسئلة لكل Battle، كل سؤال **30 ثانية**.
- **حالات السؤال:** `answered_correct` | `answered_wrong` | `timeout` (الوقت خلص → بيتحسب غلط وبيعدي أوتوماتيك).
- **حساب XP = مجموع الثواني الفاضلة في كل سؤال** (بيتحسب على أدائك إنت بغض النظر عن الخصم).
- **الفايز:**
  1. مين عنده XP أعلى (الوقت الفاضي)
  2. لوتعادل → مين عنده أخطاء أقل
  - (اللي بيزحلق على الإجابات بسرعة عشان يخلص مش هيكسب)
- **الـ Battle بتنتهي لما الاتنين يخلصوا** — مش لما واحد يخلص.
- **Disconnect:** Grace period 10 ثواني → لو رجع كمل من نفس السؤال → لو مرجعش خسر والتاني كسب أوتوماتيك.
- **Backend:** النتيجة على السيرفر بس؛ إجابات الخصم أثناء الـ Battle API بيرجعها؛ الإجابات الغلط مش بتساعد.

---

## 5. Boss Fight Design

- المادة بتتقسم **Chapters** — كل chapter ملفات:
  ```
  chapter 1
  ├── File 1 → Battle
  ├── File 2 → Battle
  ├── File 3 → Battle
  └── Boss Fight
  ```
- **نوعين ملفات:**
  - **Official Files** — admin يحطها في مسار الشابتر كـ `.admin` — المحتوى الموثوق.
  - **User Files** — الطالب بيرفعها بنفسه للمذاكرة الشخصية.
- الطالب بيفتح Official File يلاقي اختيارين: **Solo** أو **Real-time Battle**.
- **الـ Boss Fight بتفتح أوتوماتيك** لما الطالب يخلص كل Official Files في الشابتر.
- اللي بيخليها تحس Boss: UI مختلف خالص، أنيميشنز استثنائية، أسئلة أشمل بتغطي كل الملفات، وقت ضغط أكبر، النتيجة فيها تفسير لنقاط القوة والضعف في الشابتر كله.
- **ال admin هو اللي بيبني كل حاجة يدوياً** (Official Files + Boss Fights) — الطالب ما عندوش تحكم في المسار الرسمي.
- **قاعدة:** جودة الـ Battle بتتحدد بجودة المحتوى — لازم يتراجع قبل ما يتنزّل.

---

## 6. Database — Tables & Relationships (Supabase)

**الجداول:**
| الجدول | أهم الأعمدة |
|---|---|
| `colleges` | id, name, created_at |
| `users` | id, name, nickname, email, password_hash, university, academic_year, level, xp, total_battles, won_battles, defeat_battles, draw_battles, coins, avatar_key, created_at, status |
| `subjects` | id, title, academic_year, college_id, created_at |
| `bosses` | id, subject_id, title, stages_count, win_condition_percentage, created_at |
| `Files` | id, boss_id, file_title, file_source, battle_count, created_at |
| `file_questions` | id, file_id, question_id, order |
| `questions` | id, content, choices, answer, type, subject_id, time, source, status |
| `Battle` | id, player1_id, player2_id, file_id, status, type, total_xp, player1_xp, player2_xp, created_by, created_at |
| `Battle_answers` | id, battle_id, user_id, question_id, chosen_answer, time_taken, is_correct |
| `Battle Rooms` | id, file_id, created_by, status (waiting/active/finished), invite_code, created_at |
| `friendships` | id, sender_id, receiver_id, status, created_at |
| `store_categories` | id, name, created_at |
| `store_items` | id, category_id, item_title, type, price, is_available, created_at |
| `user_purchases` | id, user_id, item_id, purchase_price, created_at |
| `xp_history` | id, user_id, source_type (battle/boss), source_id, xp_earned, created_at |
| `coins_history` | id, user_id, source_type (battle/boss), source_id, coins_earned, earned_at |
| `boss_attempts` | id, user_id, boss_id, score_percentage, status (won/lost), xp_earned, created_at |

**علاقات أساسية:** colleges 1→N subjects → N bosses → N Files → N file_questions N→1 questions؛ users 1→N battles/battle_answers/purchases/xp_history/coins_history/boss_attempts/friendships؛ battle_rooms 1→N Battle؛ store_categories 1→N store_items.

---

## 7. Architecture (Flutter)

**الستاك:** Flutter (Android & iOS) · Supabase (BaaS) · BLoC + Cubit · Clean Architecture (Feature-first) · injectable + get_it · dartz Either · easy_localization · Dark & Light Mode

```
lib/
├── core/           → di/ constants/ theme/ storage/ routing/ supabase/ localization/ widgets/ errors/ usecase/
└── features/
    ├── auth/  ├── user/  ├── battle/  ├── friendship/
    ├── subjects/  ├── files/  ├── questions/  └── store/
```

- كل feature بتتقسم لـ 3 layers: `domain/` (entities, repositories, usecases) · `data/` (datasources, models, repositories) · `presentation/` (bloc/, screens/, widgets/)
- **Error Handling:** كل repositories بترجع `Either<Failure, T>` — اليسار Failure واليمين البيانات؛ كل نوع error subclass ليه message مخصص يتعمل override.
- **State Management:** Bloc للكبيرة (auth, user, battle)؛ Cubit للبسيطة (language, theme).
- **Localization:** easy_localization من أول يوم — `assets/translations` JSON؛ العربي أول لغة والإنجليزي بيجي بعدين.
- **Theme:** Design System في `core/theme` (colors, typography, radius, spacing) — Dark/Light بيتحكم فيهم ThemeCubit.

### Brand / Design System (من Brand Identity)
- **Color Tokens:** `#0B1F44` (background خلفية) · `#1B3A6B` (primary) · `#243447` (surface) · `#F8F6F2` (text) · `#2ECC71` (success) · `#FF3B3B` (error) — **6 ألوان فقط، Flat/No FX**.
- **Typography:** Cairo (14·12·10) للنص الأساسي · Lalezar (48·32·24) للعناوين · Russo One لـ Game Labels · Cairo Bold للعربي — تباعد الأسطر 125%/160%.
- **Spacing:** 4 · 8 · 12 · 16 · 24 · 32 · 48 · Radius: 6px.
- **RTL First** — كل الشاشات RTL من الأول.
- Interaction states: DEFAULT / PRESSED / DISABLED / LOADING — ومفيش Interaction أثناء الـ Battle.
- Bottom nav: الرئيسية · المعارك · الأصدقاء · الفلم — وشريطة سفلية بتظهر أثناء الـ Battle.

---

## 8. Roadmap — الـ Phases

> **قاعدة مهمة:** كل Phase لازم تنتهي بحاجة **قابلة للاختبار** — مش مجرد ملفات وكلاسات.
> **قاعدة التقدم:** ما ننتقلش لـ Phase جديدة غير لما المخرج بتاع اللي قبلها شغال فعلاً.

| Phase | الهدف | المخرج |
|---|---|---|
| **0 — Planning** | تثبيت Backend Stack، رسم تدفقات الشاشات، تحديد أول مادة/شابتر/مجموعة أسئلة، مراجعة ملفات التخطيط | كل الملفات التخطيطية مراجعة |
| **1 — Backend Foundation** | مشروع Supabase، Auth والصلاحيات، جداول (users/subjects/chapters/files)، أول Endpoint للمواد المتاحة، توثيق API | Postman Collection |
| **2 — Flutter Foundation** | Clean Architecture + BLoC + GetIt، Auth والـ Navigation، شاشة المواد والشابترز، ربط API مع Loading/Success/Failure | App شغالة على Backend |
| **3 — Core Loop** | المحاولات والإجابات والنتائج، احتساب XP على السيرفر، شاشة النتيجة والتفسير، حفظ تاريخ المحاولات | Quiz كامل End-to-End |
| **4 — Boss Raid** | ربط الملفات بالشابتر، تتبع إنهاء كل الملفات، فتح Boss Fight أوتوماتيك، أسئلة Boss وقواعد الفوز، UI والأنيميشنز الاستثنائية | Boss Raid كامل |
| **5 — Store + Coins** | حساب Coins وتسجيلها، شاشة المتجر، Frames للـ Avatar/Username، تطبيق Cosmetics على Profile | Store شغالة |
| **6 — Real-time Battle** | Room System وWebSockets، Friend System والInvite بكود، Battle Flow كامل (10 أسئلة / 30 ثانية / تقدم الخصم)، النتيجة والفايز على السيرفر، Disconnect وGrace Period | PvP شغال |
| **7 — QA & Pilot** | اختبارات تكامل وأمان، التعامل مع انقطاع الإنترنت وفشل API، إصلاح الأخطاء، Build تجريبي | Pilot Build |

**ترتيب الأولويات لو الوقت ضغط:** Core Loop (من غيره مفيش تطبيق) → Boss Raid (Signature) → Real-time Battle (سبب وجود التطبيق). الـ Store والـ Coins ممكن يتأجروا لما بعد الـ Pilot.

---

## 9. الحالة الحالية — Progress (حدّثها مع كل مرحلة)

> آخر تحديث: أول بداية شغل.

- [x] **Phase 0** — إعداد مشروع Flutter كامل (Router + DI + Supabase client + easy_localization + ScreenUtil + Theme + LocaleCubit + Bottom Nav/FAB + Failures base)
- [x] **Phase 2 (جزئي)** — Auth Domain Layer خلص (entities, repository interface, usecases: signin/signup email+google, signout)
- [ ] **Phase 1** — Backend (Supabase tables/SQL، endpoints، Postman) — **لسه ما اتعملش**
- [ ] **Phase 2 (متبقي)** — Auth Data/Repository Impl + Presentation (BLoC + شاشات Login/Signup) + شاشة المواد والشابترز
- [ ] Phase 3 → 7 — ما بدأوش

**⚠️ نقطة التوقف الحالية:** في نص Phase 2 — الـ Auth domain خلص، محتاج: repository implementation + auth presentation layer + subjects/chapters screens، وبعدها تراجع Phase 1 (Database على Supabase) حسب ترتيب الـ Roadmap.

---

## 10. قواعد عامة للاشتغل على المشروع

1. النتيجة والـ XP/Coins **دايماً** بتتحسب على السيرفر (Supabase Functions/RLS) — لا تنقل الحساب للـ Client.
2. كل repository بيرجع `Either<Failure, T>`.
3. RTL-first + Arabic-first localization.
4. مفيش features جديدة قبل ما الـ Phase الحالية تخلص اختبارها.
5. المحتوى الرسمي (Official Files/Boss Fights) يتبني يدوياً كـ admin — الطالب ما عندوش صلاحية فيه.
6. المتجر Cosmetics فقط — لا تبيع قوة أو ميزة gameplay.
