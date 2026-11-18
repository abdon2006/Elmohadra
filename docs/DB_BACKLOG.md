# DB backlog

Decisions that are made but not built yet.

## subjects.college_id — HIGH PRIORITY, blocks multi-college

`subjects` already carries `college_id`, but `users` does not carry the same
value in Dart: `UserEntity` only has `university` (a free-text name). So the
subjects query filters on `academic_year` alone, and a subject from another
college with the same year would show up.

The moment a second college enters the data this is wrong, not just imprecise.
It is deferred only because the MVP is single-college.

What it needs, in order:

1. `users.college_id` (uuid, FK → `colleges.id`) — schema change, new
   migration, backfill for existing rows.
2. `college_id` on the user entity, mapped from that column.
3. `GetSubjectsParams.collegeId` — the params object is already in place, so
   this is one field.
4. `.match({'academic_year': ..., 'college_id': ...})` in the subjects
   datasource — one key added to the map.

Deliberately NOT added as `String?` today: a parameter that is always null is
dead code, and the next reader has to guess who was supposed to fill it.

## Account deletion — waiting on the profile screen

- An Edge Function `delete-account` runs with `service_role` and does two
  things in one call: `public.users.status = 'deleted'` and a ban (`auth.users.banned_until`).
- The client never writes `status`: it has no grant on that column, and it
  cannot ban an account at all.
- Dart side: one usecase + one datasource method that invokes the function.
  Nothing else.

## Explain later — embedded queries and RLS on both sides

Why it matters: `subjects?select=*,bosses(count)` returns a count that is
already filtered by the policy on `bosses`, not by the policy on `subjects`.
When an app shows a number that came from an embed, that number is whatever
the *child* table allowed, which is easy to misread as "the real total".

Points to cover when we return to it:

- How PostgREST turns a declared FK into an embed, in both directions.
- Which RLS policy applies to each side of the embed, and what service_role
  sees instead.
- `count` on an empty child collection: `[]` vs `[{count: 0}]`.
- Why an embed cannot exist without a declared FK, and what to do when there
  is none (two queries, or a view).

## Boss Raid stages — decide when the boss screen is built

`bosses.stages_count` was dropped in `0010`: a chapter's stages are its files
plus one boss battle, so the number is derived, not stored.

Still open: the product notes describe the Boss Raid as four stages of its own
(Knowledge, Application, Bug Hunt, Final Mastery). Those four stages have to
live somewhere — either inside the single boss battle, or the chapter model
changes. Nothing on the chapter screen depends on the answer.

## battles.status — decide in Phase 6

Three vocabularies exist for the same idea: `battles` uses 'active',
`battle_rooms` uses waiting/active/finished, and the design doc says
in_progress/completed/expired. Nothing in the app touches these tables yet,
and the state machine depends on how disconnect, grace period and timeout
are built. Adding a CHECK now would be guessing.