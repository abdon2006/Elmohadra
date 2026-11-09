# DB backlog

Decisions that are made but not built yet.

## Account deletion — waiting on the profile screen

- An Edge Function `delete-account` runs with `service_role` and does two
  things in one call: `public.users.status = 'deleted'` and a ban (`auth.users.banned_until`).
- The client never writes `status`: it has no grant on that column, and it
  cannot ban an account at all.
- Dart side: one usecase + one datasource method that invokes the function.
  Nothing else.

## battles.status — decide in Phase 6

Three vocabularies exist for the same idea: `battles` uses 'active',
`battle_rooms` uses waiting/active/finished, and the design doc says
in_progress/completed/expired. Nothing in the app touches these tables yet,
and the state machine depends on how disconnect, grace period and timeout
are built. Adding a CHECK now would be guessing.