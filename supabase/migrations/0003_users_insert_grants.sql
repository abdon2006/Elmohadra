-- Problem: the INSERT grant covered the whole users table, so signing up
-- let a client write its own level, xp and coins. RLS still limited the row
-- to id = auth.uid(), but RLS filters rows, not columns - nothing stopped a
-- hand-made request from registering an account at level 50.
--
-- Fix (SQL): same shape as 0002_users_column_grants - drop the table-wide
-- INSERT and grant it on the seven columns signup actually owns. Rewards are
-- then filled by the column defaults.
--
-- Fix (Dart): remove the reward columns from the signup insert in
-- auth_remote_data_source_impl.dart. The list here and that map must match
-- exactly: a column in one and not the other fails the whole insert.
revoke insert on public.users from authenticated;

grant insert (id, name, nickname, email, university, academic_year, avatar_key)
  on public.users to authenticated;