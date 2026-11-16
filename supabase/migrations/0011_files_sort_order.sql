-- The files of a chapter are read in order: a student studies file 1, then
-- file 2, and the boss fight opens when all of them are done. Without a stored
-- order, the list would come back in whatever order Postgres happened to
-- return, which is not stable between requests.

alter table public.files
  add column if not exists sort_order integer not null default 0;

-- Number the rows that already exist, oldest first, restarting inside every
-- chapter.
update public.files f
set sort_order = numbered.position
from (
  select id,
         row_number() over (
           partition by boss_id
           order by created_at, file_title
         ) as position
  from public.files
) numbered
where f.id = numbered.id;

-- Files are always read per chapter, in order.
create index if not exists files_boss_id_sort_order_idx
  on public.files (boss_id, sort_order);
