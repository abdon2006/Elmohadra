-- ============================================================================
-- 0005_characters_keys.sql
--
-- characters.key is the name a profile points at, but nothing made it unique
-- and nothing made users.avatar_key point at a real character. A typo
-- ('ramy2', 'RAMY') was stored happily and the profile rendered an avatar
-- that does not exist.
--
-- key becomes the identity of a character: NOT NULL and unique. avatar_key
-- becomes a reference to it. Deleting a character that a profile uses is
-- blocked - the alternative is profiles pointing at nothing.
--
-- Data was checked before writing this: 20 characters, no null and no
-- duplicate keys, and every existing avatar_key already matches a character.
-- ============================================================================

alter table public.characters
  alter column key set not null;

alter table public.characters
  add constraint characters_key_key unique (key);

alter table public.users
  add constraint users_avatar_key_fkey
  foreign key (avatar_key) references public.characters (key);