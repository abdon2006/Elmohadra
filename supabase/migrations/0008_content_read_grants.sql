-- Every table except characters and users lost its SELECT grant, so the app
-- could not read the curriculum at all ("permission denied for table
-- subjects", and the dashboard reports the table as API DISABLED).
--
-- Read grants are given broadly on purpose: every table already has RLS, and
-- RLS decides which rows a user may see. Writes stay narrow and are added per
-- feature, because they decide which columns a user may change.
--
-- questions is absent on purpose: it is readable only through
-- questions_public, which hides `answer`.
grant select on
  public.colleges,
  public.subjects,
  public.bosses,
  public.files,
  public.file_questions,
  public.store_categories,
  public.store_items,
  public.battles,
  public.battle_answers,
  public.battle_rooms,
  public.boss_attempts,
  public.friendships,
  public.user_purchases,
  public.xp_history,
  public.coins_history
to authenticated;