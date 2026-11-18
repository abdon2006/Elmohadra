-- Which files a user has finished. The subject card needs it to show progress
-- ("3 من 7 ملفات"), and the boss unlock rule needs it ("the boss opens when
-- every file in the chapter is done").
--
-- One row per user and file, written the first time the file is completed.
-- Playing the same file again does not add a row: progress is a set of
-- finished files, not a log of attempts. Attempts live in battles and
-- battle_answers.
--
-- Nothing writes this table yet. The writer arrives with saving a battle
-- result (Phase 3), and like xp_history it will write from the server only -
-- the client is never the one deciding that a file is done.

create table public.user_file_progress (
  user_id      uuid not null references public.users (id) on delete cascade,
  file_id      uuid not null references public.files (id) on delete cascade,
  completed_at timestamptz not null default now(),
  primary key (user_id, file_id)
);

alter table public.user_file_progress enable row level security;

-- Read your own progress only.
create policy "Users read own file progress" on public.user_file_progress
  for select to authenticated
  using (auth.uid() = user_id);

-- Read your own rows, and only through RLS. There is deliberately no insert,
-- update or delete grant: the rows are written by the server.
grant select on public.user_file_progress to authenticated;

-- The primary key already indexes user_id; the other side of the foreign key
-- needs its own index (see 0007).
create index user_file_progress_file_id_idx
  on public.user_file_progress (file_id);
