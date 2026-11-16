-- A chapter's stages are its files, followed by one final boss battle, so the
-- number is always `files + 1`. Storing it next to the files lets the two
-- disagree: the seed data has chapters with two files and stages_count = 4.
--
-- The number is now derived, so the column goes.

alter table public.bosses
  drop column if exists stages_count;

-- Still undecided, recorded so it is not lost: the product notes describe the
-- Boss Raid as four stages of its own (Knowledge, Application, Bug Hunt,
-- Final Mastery). That is the fight, not the chapter. When the boss screen is
-- built, those four stages either live inside the single boss battle or the
-- chapter model changes again. The chapter screen does not depend on it.
