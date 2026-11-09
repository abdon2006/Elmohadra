-- Profile edits were rejected outright: `authenticated` had no UPDATE
-- privilege on public.users, so even changing `name` failed with
-- "permission denied" - the RLS policy allowed the row, but the grant was
-- missing.
--
-- Granting UPDATE on the whole table fixed that, and also let a client write
-- its own xp, coins and level. Those are rewards: the server awards them, the
-- client must never set them.
--
-- So the grant is narrowed to the columns a user actually owns. Column
-- privileges are a separate level from the table grant, and they are the only
-- mechanism that separates one column from another - RLS works on rows, so it
-- cannot express "this row, but not that column".
revoke update on public.users from authenticated;

grant update (name, nickname, university, academic_year, avatar_key)
  on public.users to authenticated;
