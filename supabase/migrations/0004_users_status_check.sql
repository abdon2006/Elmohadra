-- ============================================================================
-- 0004_users_status_check.sql
--
-- Decisions recorded here, because the schema alone cannot explain them and
-- a future reader would otherwise "fix" them:
--
--  No FK from public.users.id to auth.users.id, and no cascades.
--    A profile row outlives its account on purpose: battle history, xp and
--    purchases belong to the person and are kept.
--
--  Deleting an account = ban + status = 'deleted'. It is not a row delete.
--    Deleting the auth account would free the email, so the same person could
--    register again with a new id - leaving their history attached to an id
--    that no longer exists. Banning keeps the email claimed and the history
--    attached to one identity. Unbanning restores access with history intact.
--
--  That also means no trigger on auth.users is needed: nothing is deleted.
--
--  status is limited to 'active' | 'deleted'.
-- 5) Account deletion is handled by an Edge Function (`delete-account`) that
--    runs with service_role and does both things in one call: set
--    status = 'deleted' and ban the account. The client never writes status -
--    it has no grant on that column - and it cannot ban at all. One request in,
--    one server-side action out.
-- ============================================================================

alter table public.users
  add constraint users_status_check
  check (status in ('active', 'deleted'));