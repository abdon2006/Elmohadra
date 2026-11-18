-- A subject is a list of chapters, and every chapter ends with its own boss.
-- On top of that a subject ends with one big challenge that is not a chapter:
-- it has no battles of its own, it is a container that draws its questions
-- from the files underneath it.
--
-- The two are the same shape - a title, a set of questions, an attempt, a score
-- - so they share this table and differ only by kind. Without the column every
-- reader would keep treating "a row in bosses" as "a chapter", and the subject
-- card would count the final challenge as one more chapter.

alter table public.bosses
  add column if not exists kind text not null default 'chapter';

alter table public.bosses
  drop constraint if exists bosses_kind_check;

alter table public.bosses
  add constraint bosses_kind_check check (kind in ('chapter', 'final'));

comment on column public.bosses.kind is
  'chapter = a chapter of a subject (the boss at its end). '
  'final = the subject-wide challenge; it is not a chapter and must never be '
  'counted as one.';

-- At most one final challenge per subject. A partial unique index rather than a
-- plain one: chapters repeat a subject_id freely, only the final is unique.
create unique index if not exists bosses_one_final_per_subject_idx
  on public.bosses (subject_id)
  where kind = 'final';

-- The final challenge is read separately from the chapter list, so it needs a
-- cheap lookup on (subject_id, kind).
create index if not exists bosses_subject_id_kind_idx
  on public.bosses (subject_id, kind);
