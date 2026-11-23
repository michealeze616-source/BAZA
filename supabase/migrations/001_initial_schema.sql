-- BAZA initial Supabase schema (apply in Supabase SQL Editor)
create extension if not exists pgcrypto;

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text not null default '',
  phone text,
  city text,
  state text,
  avatar_url text,
  created_at timestamptz not null default now()
);
alter table public.profiles enable row level security;
create policy "Profiles are visible to public" on public.profiles for select using (true);
create policy "Users insert own profile" on public.profiles for insert with check (auth.uid() = id);
create policy "Users update own profile" on public.profiles for update using (auth.uid() = id) with check (auth.uid() = id);

create or replace function public.handle_new_user()
returns trigger language plpgsql security definer set search_path = public
as $$
begin
  insert into public.profiles(id, full_name)
  values (new.id, coalesce(new.raw_user_meta_data->>'full_name',''));
  return new;
end;
$$;
drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created after insert on auth.users
for each row execute procedure public.handle_new_user();

create table if not exists public.listings (
  id uuid primary key default gen_random_uuid(),
  seller_id uuid not null references public.profiles(id) on delete cascade,
  title text not null,
  description text not null default '',
  price numeric(14,2) not null check (price >= 0),
  category text not null,
  condition text not null default 'new' check (condition in ('new','used','refurbished','service')),
  city text,
  state text,
  images text[] not null default '{}',
  status text not null default 'active' check (status in ('active','sold','paused','removed')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create index if not exists listings_category_idx on public.listings(category);
create index if not exists listings_created_idx on public.listings(created_at desc);
create index if not exists listings_seller_idx on public.listings(seller_id);
alter table public.listings enable row level security;
create policy "Active listings visible publicly" on public.listings for select using (status='active' or auth.uid()=seller_id);
create policy "Authenticated users create own listings" on public.listings for insert with check (auth.uid()=seller_id);
create policy "Sellers manage own listings" on public.listings for update using (auth.uid()=seller_id) with check (auth.uid()=seller_id);
create policy "Sellers delete own listings" on public.listings for delete using (auth.uid()=seller_id);

create table if not exists public.favorites (
  user_id uuid not null references public.profiles(id) on delete cascade,
  listing_id uuid not null references public.listings(id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key(user_id, listing_id)
);
alter table public.favorites enable row level security;
create policy "Users see own favorites" on public.favorites for select using (auth.uid()=user_id);
create policy "Users add own favorites" on public.favorites for insert with check (auth.uid()=user_id);
create policy "Users remove own favorites" on public.favorites for delete using (auth.uid()=user_id);

create table if not exists public.conversations (
  id uuid primary key default gen_random_uuid(),
  listing_id uuid references public.listings(id) on delete set null,
  buyer_id uuid not null references public.profiles(id) on delete cascade,
  seller_id uuid not null references public.profiles(id) on delete cascade,
  created_at timestamptz not null default now(),
  check (buyer_id <> seller_id)
);
alter table public.conversations enable row level security;
create policy "Conversation participants read" on public.conversations for select using (auth.uid() in (buyer_id,seller_id));
create policy "Buyer starts conversation" on public.conversations for insert with check (auth.uid()=buyer_id);
create policy "Participants update conversation" on public.conversations for update using (auth.uid() in (buyer_id,seller_id)) with check (auth.uid() in (buyer_id,seller_id));

create table if not exists public.messages (
  id uuid primary key default gen_random_uuid(),
  conversation_id uuid not null references public.conversations(id) on delete cascade,
  sender_id uuid not null references public.profiles(id) on delete cascade,
  body text not null check (length(body) between 1 and 5000),
  created_at timestamptz not null default now()
);
create index if not exists messages_conversation_created_idx on public.messages(conversation_id,created_at);
alter table public.messages enable row level security;
create policy "Participants read messages" on public.messages for select using (
  exists(select 1 from public.conversations c where c.id=conversation_id and auth.uid() in (c.buyer_id,c.seller_id))
);
create policy "Participants send messages" on public.messages for insert with check (
  auth.uid()=sender_id and exists(select 1 from public.conversations c where c.id=conversation_id and auth.uid() in (c.buyer_id,c.seller_id))
);
