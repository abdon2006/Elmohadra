-- "allow read for all" and "characters_select" both granted SELECT on
-- characters with the same expression, so every signed-in read was filtered
-- twice and it was unclear which policy was doing the work. Keep one.
--
-- anon must keep reading: the character picker runs during signup, before an
-- email account exists.
drop policy if exists "allow read for all" on public.characters;
drop policy if exists characters_select on public.characters;

create policy characters_select on public.characters
  for select to anon, authenticated
  using (true);