-- BAZA automated listing safety screening MVP
alter table public.listings add column if not exists review_status text not null default 'approved' check (review_status in ('approved','flagged','hold'));
alter table public.listings add column if not exists risk_score integer not null default 0;
alter table public.listings add column if not exists risk_flags text[] not null default '{}';
-- Restrict public reads to approved active listings; sellers can still view/manage their own.
drop policy if exists "Active listings visible publicly" on public.listings;
create policy "Approved listings visible publicly and owners see own" on public.listings for select using ((status='active' and review_status='approved') or auth.uid()=seller_id);
create index if not exists listings_review_status_idx on public.listings(review_status,risk_score desc);
