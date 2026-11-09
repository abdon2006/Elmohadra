-- ============================================================================
-- 0001_initial_schema.sql
--
-- Snapshot of the schema that already exists in the Supabase project,
-- written after the security fixes applied on 2026-11-09:
--   * dropped the `users` policy "allow email check" (anon could read every row)
--   * created the `questions_public` view and revoked direct reads of `answer`
--   * dropped the 16 dead "Admin full access" policies
--
-- No Supabase CLI is used in this project yet: paste this file into the
-- SQL Editor. It is written to build the schema from scratch, so it is not
-- meant to be re-run against the live project as-is.
--
-- No seed data is included. Content (colleges/subjects/bosses/files/questions)
-- is built by hand from the dashboard.
-- ============================================================================


-- ----------------------------------------------------------------------------
-- Content
-- ----------------------------------------------------------------------------

create table public.colleges (
  id         uuid primary key default gen_random_uuid(),
  name       text not null,
  created_at timestamptz default now()
);

create table public.subjects (
  id            uuid primary key default gen_random_uuid(),
  title         text not null,
  academic_year integer not null,
  college_id    uuid references public.colleges (id),
  created_at    timestamptz default now()
);

create table public.bosses (
  id                       uuid primary key default gen_random_uuid(),
  subject_id               uuid references public.subjects (id),
  title                    text not null,
  stages_count             integer not null,
  win_condition_percentage integer not null,
  created_at               timestamptz default now()
);

create table public.files (
  id           uuid primary key default gen_random_uuid(),
  boss_id      uuid references public.bosses (id),
  file_title   text not null,
  file_source  text,
  battle_count integer default 0,
  created_at   timestamptz default now()
);

create table public.questions (
  id         uuid primary key default gen_random_uuid(),
  content    text not null,
  choices    jsonb not null,
  -- The correct answer. Never readable by clients: reads go through
  -- questions_public (see the view at the bottom of this file).
  answer     text not null,
  type       text not null,
  subject_id uuid references public.subjects (id),
  "time"     integer not null,
  source     text,
  status     text default 'active',
  created_at timestamptz default now()
);

create table public.file_questions (
  id          uuid primary key default gen_random_uuid(),
  file_id     uuid references public.files (id),
  question_id uuid references public.questions (id),
  -- "order" is a reserved word: it must be quoted in every statement.
  "order"     integer not null
);


-- ----------------------------------------------------------------------------
-- People
-- ----------------------------------------------------------------------------

-- Profile row for an auth user. There is deliberately no FK to auth.users yet:
-- the id is filled with the auth uid by the client at signup, and deleting an
-- auth account currently leaves this row behind.
create table public.users (
  id             uuid primary key default gen_random_uuid(),
  name           text not null,
  nickname       text,
  email          text not null unique,
  university     text,
  academic_year  integer,
  level          integer default 1,
  xp             integer default 0,
  total_battles  integer default 0,
  won_battles    integer default 0,
  defeat_battles integer default 0,
  draw_battles   integer default 0,
  coins          integer default 0,
  avatar_key     text,
  created_at     timestamptz default now(),
  status         text default 'active'
);

create table public.characters (
  id              uuid primary key default gen_random_uuid(),
  key             text,
  image_url       text default '',
  is_locked       boolean default true,
  coins_to_unlock bigint,
  level           smallint,
  created_at      timestamptz not null default now(),
  name_en         text default '',
  name_ar         text default '',
  title_en        text default '',
  title_ar        text default ''
);


-- ----------------------------------------------------------------------------
-- Play
-- ----------------------------------------------------------------------------

create table public.battles (
  id          uuid primary key default gen_random_uuid(),
  player1_id  uuid references public.users (id),
  player2_id  uuid references public.users (id),
  file_id     uuid references public.files (id),
  status      text default 'active',
  type        text,
  total_xp    integer default 0,
  player1_xp  integer default 0,
  player2_xp  integer default 0,
  created_by  uuid references public.users (id),
  created_at  timestamptz default now()
);

create table public.battle_answers (
  id            uuid primary key default gen_random_uuid(),
  battle_id     uuid references public.battles (id),
  user_id       uuid references public.users (id),
  question_id   uuid references public.questions (id),
  chosen_answer text,
  time_taken    integer,
  is_correct    boolean
);

create table public.battle_rooms (
  id          uuid primary key default gen_random_uuid(),
  file_id     uuid references public.files (id),
  created_by  uuid references public.users (id),
  status      text default 'waiting',
  invite_code text unique,
  created_at  timestamptz default now()
);

create table public.boss_attempts (
  id               uuid primary key default gen_random_uuid(),
  user_id          uuid references public.users (id),
  boss_id          uuid references public.bosses (id),
  score_percentage integer,
  status           text,
  xp_earned        integer default 0,
  created_at       timestamptz default now()
);


-- ----------------------------------------------------------------------------
-- Social and store
-- ----------------------------------------------------------------------------

create table public.friendships (
  id          uuid primary key default gen_random_uuid(),
  sender_id   uuid references public.users (id),
  receiver_id uuid references public.users (id),
  status      text default 'pending',
  created_at  timestamptz default now()
);

create table public.store_categories (
  id         uuid primary key default gen_random_uuid(),
  name       text not null,
  created_at timestamptz default now()
);

create table public.store_items (
  id           uuid primary key default gen_random_uuid(),
  category_id  uuid references public.store_categories (id),
  item_title   text not null,
  type         text,
  price        integer not null,
  is_available boolean default true,
  created_at   timestamptz default now()
);

create table public.user_purchases (
  id             uuid primary key default gen_random_uuid(),
  user_id        uuid references public.users (id),
  item_id        uuid references public.store_items (id),
  purchase_price integer,
  created_at     timestamptz default now()
);


-- ----------------------------------------------------------------------------
-- Ledgers (one row per reward, so a reward cannot be granted twice)
-- ----------------------------------------------------------------------------

create table public.xp_history (
  id          uuid primary key default gen_random_uuid(),
  user_id     uuid references public.users (id),
  source_type text,
  source_id   uuid,
  xp_earned   integer,
  created_at  timestamptz default now()
);

create table public.coins_history (
  id           uuid primary key default gen_random_uuid(),
  user_id      uuid references public.users (id),
  source_type  text,
  source_id    uuid,
  coins_earned integer,
  earned_at    timestamptz default now()
);


-- ============================================================================
-- Row Level Security
--
-- Every table is protected. Table-level grants come from Supabase's default
-- privileges (anon and authenticated get full DML on public tables), so RLS
-- is the only thing that actually restricts access.
-- ============================================================================

alter table public.colleges        enable row level security;
alter table public.subjects        enable row level security;
alter table public.bosses          enable row level security;
alter table public.files           enable row level security;
alter table public.questions       enable row level security;
alter table public.file_questions  enable row level security;
alter table public.users           enable row level security;
alter table public.characters      enable row level security;
alter table public.battles         enable row level security;
alter table public.battle_answers  enable row level security;
alter table public.battle_rooms    enable row level security;
alter table public.boss_attempts   enable row level security;
alter table public.friendships     enable row level security;
alter table public.store_categories enable row level security;
alter table public.store_items     enable row level security;
alter table public.user_purchases  enable row level security;
alter table public.xp_history      enable row level security;
alter table public.coins_history   enable row level security;


-- Content is readable by signed-in users only.

create policy "Users read colleges" on public.colleges
  for select to public
  using (auth.role() = 'authenticated');

create policy "Users read subjects" on public.subjects
  for select to public
  using (auth.role() = 'authenticated');

create policy "Users read bosses" on public.bosses
  for select to public
  using (auth.role() = 'authenticated');

create policy "Users read files" on public.files
  for select to public
  using (auth.role() = 'authenticated');

create policy "Users read file_questions" on public.file_questions
  for select to public
  using (auth.role() = 'authenticated');

create policy "Users read questions" on public.questions
  for select to public
  using (auth.role() = 'authenticated');

create policy "Users read store_categories" on public.store_categories
  for select to public
  using (auth.role() = 'authenticated');

create policy "Users read store_items" on public.store_items
  for select to public
  using (auth.role() = 'authenticated');


-- Owner-scoped rows.

create policy "Users manage own profile" on public.users
  for all to public
  using (auth.uid() = id);

create policy "users_select_own" on public.users
  for select to authenticated
  using (auth.uid() = id);

create policy "Users manage own battles" on public.battles
  for all to public
  using (auth.uid() = player1_id or auth.uid() = player2_id);

create policy "Users manage own battle_answers" on public.battle_answers
  for all to public
  using (auth.uid() = user_id);

create policy "Users manage own battle_rooms" on public.battle_rooms
  for all to public
  using (auth.uid() = created_by);

create policy "Users manage own boss_attempts" on public.boss_attempts
  for all to public
  using (auth.uid() = user_id);

create policy "Users manage own friendships" on public.friendships
  for all to public
  using (auth.uid() = sender_id or auth.uid() = receiver_id);

create policy "Users manage own purchases" on public.user_purchases
  for all to public
  using (auth.uid() = user_id);

create policy "Users read own xp_history" on public.xp_history
  for select to public
  using (auth.uid() = user_id);

create policy "Users read own coins_history" on public.coins_history
  for select to public
  using (auth.uid() = user_id);


-- Characters are cosmetic and public: the signup and profile screens need the
-- full list before the user is signed in. Two overlapping policies exist in
-- the live project and are reproduced here as-is.
create policy "allow read for all" on public.characters
  for select to anon, authenticated
  using (true);

create policy "characters_select" on public.characters
  for select to authenticated
  using (true);


-- ============================================================================
-- questions_public
--
-- `answer` must never reach a client. Signed-in users read this view instead
-- of the table, and direct SELECT on the table is revoked.
--
-- The view runs as its owner (security definer by default), so it reads the
-- base table without the caller's RLS. That is fine while every question is
-- readable by every signed-in user; if questions ever become per-user, this
-- view must be locked down with security_invoker.
-- ============================================================================

create or replace view public.questions_public as
select
  id,
  content,
  choices,
  type,
  subject_id,
  "time",
  source,
  status
from public.questions;

grant select on public.questions_public to authenticated;

revoke select on public.questions from authenticated;
revoke select on public.questions from anon;


-- ============================================================================
-- Known gaps (deliberately not fixed here; each one is its own migration)
--
--   * public.users.id is not tied to auth.users(id) and has no on delete
--     cascade, so deleting an auth account leaves the profile behind.
--   * public.characters.key is not unique, and public.users.avatar_key is free
--     text rather than a FK to characters.key.
--   * INSERT on public.users is open, so a client can set its own xp and coins
--     at signup. Rewards must be written by the server only.
--   * battles.status defaults to 'active' while the design uses
--     in_progress / completed / expired.
--   * No indexes on any foreign key column.
-- ============================================================================
