-- Chapters are shown in curriculum order, not alphabetical order, so the order
-- has to be stored. A chapter is a row in `bosses` (one boss per chapter).
--
-- Without this, the chapter number in the UI would come from whatever order
-- Postgres happened to return, which is not stable between requests.

alter table public.bosses
  add column if not exists sort_order integer not null default 0;

-- Give the rows that already exist a number, oldest first, restarting at 1
-- inside every subject.
update public.bosses b
set sort_order = numbered.position
from (
  select id,
         row_number() over (
           partition by subject_id
           order by created_at, title
         ) as position
  from public.bosses
) numbered
where b.id = numbered.id;

-- The chapters of one subject are always read together, in order, so this is
-- the pair that gets looked up.
create index if not exists bosses_subject_id_sort_order_idx
  on public.bosses (subject_id, sort_order);
