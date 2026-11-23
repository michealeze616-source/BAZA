-- BAZA phase 1 + 2: user roles, profiles, seller listing photos
alter table public.profiles add column if not exists role text not null default 'buyer' check (role in ('buyer','seller','both'));
alter table public.profiles add column if not exists phone text;
alter table public.profiles add column if not exists city text;
alter table public.profiles add column if not exists state text;

create or replace function public.handle_new_user()
returns trigger language plpgsql security definer set search_path = public
as $$
begin
  insert into public.profiles(id, full_name, role)
  values (
    new.id,
    coalesce(new.raw_user_meta_data->>'full_name',''),
    case when new.raw_user_meta_data->>'role' in ('buyer','seller','both') then new.raw_user_meta_data->>'role' else 'buyer' end
  )
  on conflict (id) do update set full_name=excluded.full_name, role=excluded.role;
  return new;
end;
$$;

-- Public listing images; ownership enforced by first folder segment = auth.uid().
insert into storage.buckets(id,name,public,file_size_limit,allowed_mime_types)
values ('listing-photos','listing-photos',true,8388608,array['image/jpeg','image/png','image/webp'])
on conflict (id) do update set public=true,file_size_limit=8388608,allowed_mime_types=array['image/jpeg','image/png','image/webp'];

drop policy if exists "BAZA listing images public read" on storage.objects;
create policy "BAZA listing images public read" on storage.objects for select using (bucket_id='listing-photos');
drop policy if exists "BAZA users upload own listing photos" on storage.objects;
create policy "BAZA users upload own listing photos" on storage.objects for insert to authenticated with check (bucket_id='listing-photos' and (storage.foldername(name))[1]=auth.uid()::text);
drop policy if exists "BAZA users update own listing photos" on storage.objects;
create policy "BAZA users update own listing photos" on storage.objects for update to authenticated using (bucket_id='listing-photos' and (storage.foldername(name))[1]=auth.uid()::text) with check (bucket_id='listing-photos' and (storage.foldername(name))[1]=auth.uid()::text);
drop policy if exists "BAZA users delete own listing photos" on storage.objects;
create policy "BAZA users delete own listing photos" on storage.objects for delete to authenticated using (bucket_id='listing-photos' and (storage.foldername(name))[1]=auth.uid()::text);
