# Home screen — agreed layout

Status: agreed visually. Not built yet: it is a dashboard, so it is built last,
once XP, battles and the boss flow produce real numbers.

┌──────────────────────────────────────┐
│ 📖 الساحة 🔔 │
│ أنت في تجربة │
├──────────────────────────────────────┤
│    [شعار]        أهلاً عبدالله!        │
│ كلية الحاسبات · سنة 2 │
├──────────────────────────────────────┤
│ المستوى 7 🪙1,240│
│ ████████████░░░░░░ 3,200 / 5,000 │
│ 1,800 نقطة للمستوى القادم │
├──────────────────────────────────────┤
│ ┌────────┬────────┬────────┐ │
│ │ 7 │ 18 │ #8 │ │
│ │ أيام │ معارك │ ترتيب │ │
│ │ متتابعة│ │ الدفعة │ │
│ └────────┴────────┴────────┘ │
├──────────────────────────────────────┤
│ ┌────────────────────────────────┐ │
│ │ 🔴 LIVE │ │
│ │ كمّل من حيث وقفت │ │
│ │ هياكل البيانات · الشابتر 2 │ │
│ │ 10 أسئلة · 5 دقائق │ │
│ │ +120 XP │ │
│ │ ┌────────────────────────────┐ │ │
│ │ │ ابدأ التحدي │ │ │
│ │ └────────────────────────────┘ │ │
│ └────────────────────────────────┘ │
├──────────────────────────────────────┤
│ كمّل مراجعتك │
│ ┌────────────────────────────────┐ │
│ │ هياكل البيانات › │ │
│ │ 2 من 4 شابترز │ │
│ └────────────────────────────────┘ │
│ ┌────────────────────────────────┐ │
│ │ البرمجة الكائنية › │ │
│ │ 0 من 3 شابترز │ │
│ └────────────────────────────────┘ │
├──────────────────────────────────────┤
│ 🏠 📚 (＋)    🎒 👤 │
│ الرئيسية المواد المستودع │
└──────────────────────────────────────┘

## Why this shape

- Taken from the earlier mockup: the three stat tiles (streak / battles / rank)
  and the "كمّل مراجعتك" list, which leads straight into the subject screens.
- Taken from the first proposal: one hero card instead of two cards, and a
  single clear XP bar.
- Dropped: "تحدي اليوم". It needs server-side scheduling and is not in the MVP.

## What each block needs

| Block                   | Source                                           | Available                        |
|-------------------------|--------------------------------------------------|----------------------------------|
| Avatar, level, coins    | `users.avatar_key`, `users.level`, `users.coins` | yes                              |
| XP bar                  | `users.xp`                                       | yes                              |
| Battles count           | `users.total_battles`                            | yes                              |
| Streak (7 أيام)         | nothing exists                                   | **no** — needs a schema decision |
| Rank (#8)               | ordering by `users.xp`                           | **no** — "الدفعة" is undefined   |
| Hero: current chapter   | last opened file                                 | **no** — needs tracking          |
| Hero: "5 دقائق"         | `files` has no duration                          | **no** — needs a schema decision |
| Hero: "+120 XP"         | boss reward rule                                 | **no** — Phase 4                 |
| "كمّل مراجعتك": "2 من 4" | `boss_attempts` per subject                      | **no** — Phase 4                 |

## Decided

- **Streak — dropped.** Not in the MVP feature list, and a number that has to be
  kept correct forever is not worth it before there are real users. If it comes
  back, it comes from a trigger on `xp_history`, never from the client.
- **"تحدي اليوم" — replaced by "أعلى 3 في الدفعة".** A daily pick can be
  derived from the date with no server, but the reserved slot is better spent on
  something social. Both wait for the rank decision.
- **Hero duration — dropped.** Questions per file are effectively fixed, so a
  duration adds a column that would carry no information. The hero shows the
  subject, the college and the question count.
- **"كمّل من حيث وقفت" — kept**, with `users.last_file_id`, written by the app
  when it opens a file. "Where you stopped" means the last thing you *saw*, not
  the last thing you *played*.
- **"آخر نشاط" — kept**, with `users.last_seen_at`, written once per app start.

## Wanted on screen, waiting on the rank and level decisions

These all read columns that already exist; only the rules are missing.

| Element               | Formula                                            |
|-----------------------|----------------------------------------------------|
| Win rate              | `won_battles / total_battles`                      |
| Full record           | won / lost / drawn, straight from `users`          |
| Membership age        | `now() - created_at`                               |
| Average XP per battle | `xp / total_battles`                               |
| Rank                  | ordering by `users.xp` — **scope not decided yet** |
| XP to next level      | needs the level curve and the rank badges          |

## Open decisions

1. "الدفعة" for the rank: which set of users does a rank compare against.
2. The level curve, and whether ranks are derived from it or separate.
