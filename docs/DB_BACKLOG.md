# DB backlog

Decisions that are made but not built yet.

## Account deletion — waiting on the profile screen

- An Edge Function `delete-account` runs with `service_role` and does two
  things in one call: `public.users.status = 'deleted'` and a ban (`auth.users.banned_until`).
- The client never writes `status`: it has no grant on that column, and it
  cannot ban an account at all.
- Dart side: one usecase + one datasource method that invokes the function.
  Nothing else.

## Still open in the schema

- `characters.key` is not unique, and `users.avatar_key` is not a FK to it.
- `characters` carries two identical read policies.
- `battles.status` defaults to 'active' while the design uses
  in_progress / completed / expired.
- No indexes on any foreign key column.