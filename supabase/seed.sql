-- ============================================================================
-- seed.sql  —  TEST DATA ONLY
--
-- There is no real curriculum yet. This exists so the subject/chapter screens
-- have something to render while the code is built. Delete it before any real
-- content goes in; the ids are fixed and prefixed so it is easy to find.
--
-- Run in the SQL editor (it runs as the table owner, so RLS does not apply).
-- ============================================================================

insert into public.colleges (id, name) values
  ('c0000000-0000-4000-8000-000000000001', 'كلية الحاسبات')
on conflict (id) do nothing;

insert into public.subjects (id, title, academic_year, college_id) values
  ('50000000-0000-4000-8000-000000000001', 'هياكل البيانات', 2,
   'c0000000-0000-4000-8000-000000000001'),
  ('50000000-0000-4000-8000-000000000002', 'البرمجة الكائنية', 2,
   'c0000000-0000-4000-8000-000000000001')
on conflict (id) do nothing;

insert into public.bosses
  (id, subject_id, title, stages_count, win_condition_percentage) values
  ('b0000000-0000-4000-8000-000000000001',
   '50000000-0000-4000-8000-000000000001',
   'The Structure Keeper', 4, 80),
  ('b0000000-0000-4000-8000-000000000002',
   '50000000-0000-4000-8000-000000000002',
   'Object Warden', 4, 80)
on conflict (id) do nothing;

insert into public.files
  (id, boss_id, file_title, file_source, battle_count) values
  ('f0000000-0000-4000-8000-000000000001',
   'b0000000-0000-4000-8000-000000000001', 'Stacks & Queues', 'test-data', 2),
  ('f0000000-0000-4000-8000-000000000002',
   'b0000000-0000-4000-8000-000000000001', 'Complexity', 'test-data', 2),
  ('f0000000-0000-4000-8000-000000000003',
   'b0000000-0000-4000-8000-000000000002', 'Classes & Objects', 'test-data', 2)
on conflict (id) do nothing;

-- choices: [{key, text}], answer = key.
insert into public.questions
  (id, content, choices, answer, type, subject_id, "time", source, status) values
  ('a0000000-0000-4000-8000-000000000001',
   'أي بنية بيانات تعمل بمبدأ LIFO؟',
   '[{"key":"a","text":"Stack"},{"key":"b","text":"Queue"},{"key":"c","text":"Linked List"},{"key":"d","text":"Tree"}]',
   'a', 'mcq', '50000000-0000-4000-8000-000000000001', 30, 'test-data', 'active'),

  ('a0000000-0000-4000-8000-000000000002',
   'أي بنية بيانات تعمل بمبدأ FIFO؟',
   '[{"key":"a","text":"Stack"},{"key":"b","text":"Queue"},{"key":"c","text":"Heap"},{"key":"d","text":"Graph"}]',
   'b', 'mcq', '50000000-0000-4000-8000-000000000001', 30, 'test-data', 'active'),

  ('a0000000-0000-4000-8000-000000000003',
   'ما تعقيد إضافة عنصر أعلى الـ Stack؟',
   '[{"key":"a","text":"O(1)"},{"key":"b","text":"O(n)"},{"key":"c","text":"O(log n)"},{"key":"d","text":"O(n log n)"}]',
   'a', 'mcq', '50000000-0000-4000-8000-000000000001', 30, 'test-data', 'active'),

  ('a0000000-0000-4000-8000-000000000004',
   'ما تعقيد البحث الثنائي في مصفوفة مرتبة؟',
   '[{"key":"a","text":"O(n)"},{"key":"b","text":"O(log n)"},{"key":"c","text":"O(1)"},{"key":"d","text":"O(n^2)"}]',
   'b', 'mcq', '50000000-0000-4000-8000-000000000001', 30, 'test-data', 'active'),

  ('a0000000-0000-4000-8000-000000000005',
   'أي مما يلي ليس من مبادئ الـ OOP؟',
   '[{"key":"a","text":"Encapsulation"},{"key":"b","text":"Inheritance"},{"key":"c","text":"Polymorphism"},{"key":"d","text":"Compilation"}]',
   'd', 'mcq', '50000000-0000-4000-8000-000000000002', 30, 'test-data', 'active'),

  ('a0000000-0000-4000-8000-000000000006',
   'الـ Inheritance معناها؟',
   '[{"key":"a","text":"إعادة استخدام سلوك كلاس أب"},{"key":"b","text":"إخفاء البيانات"},{"key":"c","text":"تحويل النوع"},{"key":"d","text":"تعدد الملفات"}]',
   'a', 'mcq', '50000000-0000-4000-8000-000000000002', 30, 'test-data', 'active')
on conflict (id) do nothing;

insert into public.file_questions (id, file_id, question_id, "order") values
  ('e0000000-0000-4000-8000-000000000001',
   'f0000000-0000-4000-8000-000000000001',
   'a0000000-0000-4000-8000-000000000001', 1),
  ('e0000000-0000-4000-8000-000000000002',
   'f0000000-0000-4000-8000-000000000001',
   'a0000000-0000-4000-8000-000000000002', 2),
  ('e0000000-0000-4000-8000-000000000003',
   'f0000000-0000-4000-8000-000000000002',
   'a0000000-0000-4000-8000-000000000003', 1),
  ('e0000000-0000-4000-8000-000000000004',
   'f0000000-0000-4000-8000-000000000002',
   'a0000000-0000-4000-8000-000000000004', 2),
  ('e0000000-0000-4000-8000-000000000005',
   'f0000000-0000-4000-8000-000000000003',
   'a0000000-0000-4000-8000-000000000005', 1),
  ('e0000000-0000-4000-8000-000000000006',
   'f0000000-0000-4000-8000-000000000003',
   'a0000000-0000-4000-8000-000000000006', 2)
on conflict (id) do nothing;

-- ---------------------------------------------------------------------------
-- Cleanup, in this order (no cascades by design), when real content arrives:
--   delete from public.file_questions where file_id::text like 'f0000000%';
--   delete from public.questions     where source = 'test-data';
--   delete from public.files         where file_source = 'test-data';
--   delete from public.bosses        where id::text like 'b0000000%';
--   delete from public.subjects      where id::text like '50000000%';
--   delete from public.colleges      where id::text like 'c0000000%';
-- ---------------------------------------------------------------------------