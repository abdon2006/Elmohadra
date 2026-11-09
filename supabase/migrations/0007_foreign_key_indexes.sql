-- Postgres indexes primary keys automatically, never foreign key columns.
-- Every FK is a column something looks up: the app filters by it,
-- a join walks it, and the FK check itself scans it whenever a parent row is deleted.
-- Without these, every one of those is a sequential scan.
--
-- Written with IF NOT EXISTS because migrations are pasted into the SQL editor
-- by hand here, and a half-applied run should be safe to repeat.
-- No CONCURRENTLY: these tables are empty, and CONCURRENTLY cannot run inside
-- a transaction block.

create index if not exists battle_answers_battle_id_idx   on public.battle_answers (battle_id);
create index if not exists battle_answers_user_id_idx     on public.battle_answers (user_id);
create index if not exists battle_answers_question_id_idx on public.battle_answers (question_id);

create index if not exists battles_player1_id_idx on public.battles (player1_id);
create index if not exists battles_player2_id_idx on public.battles (player2_id);
create index if not exists battles_file_id_idx    on public.battles (file_id);
create index if not exists battles_created_by_idx on public.battles (created_by);

create index if not exists battle_rooms_file_id_idx    on public.battle_rooms (file_id);
create index if not exists battle_rooms_created_by_idx on public.battle_rooms (created_by);

create index if not exists boss_attempts_user_id_idx on public.boss_attempts (user_id);
create index if not exists boss_attempts_boss_id_idx on public.boss_attempts (boss_id);

create index if not exists file_questions_file_id_idx     on public.file_questions (file_id);
create index if not exists file_questions_question_id_idx on public.file_questions (question_id);

create index if not exists friendships_sender_id_idx   on public.friendships (sender_id);
create index if not exists friendships_receiver_id_idx on public.friendships (receiver_id);

create index if not exists user_purchases_user_id_idx on public.user_purchases (user_id);
create index if not exists user_purchases_item_id_idx on public.user_purchases (item_id);

create index if not exists xp_history_user_id_idx    on public.xp_history (user_id);
create index if not exists coins_history_user_id_idx on public.coins_history (user_id);

create index if not exists questions_subject_id_idx     on public.questions (subject_id);
create index if not exists subjects_college_id_idx      on public.subjects (college_id);
create index if not exists bosses_subject_id_idx        on public.bosses (subject_id);
create index if not exists files_boss_id_idx            on public.files (boss_id);
create index if not exists store_items_category_id_idx  on public.store_items (category_id);

create index if not exists users_avatar_key_idx on public.users (avatar_key);