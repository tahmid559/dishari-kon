-- Supabase SQL Editor-এ পুরো কোডটি চালান।
create table if not exists public.books (
 id uuid primary key default gen_random_uuid(),
 title text not null,
 author text,
 description text,
 file_url text not null,
 storage_path text not null,
 created_at timestamptz not null default now()
);
create table if not exists public.videos (
 id uuid primary key default gen_random_uuid(),
 title text not null,
 url text not null,
 description text,
 created_at timestamptz not null default now()
);
create table if not exists public.news (
 id uuid primary key default gen_random_uuid(),
 title text not null,
 body text not null,
 image_url text,
 created_at timestamptz not null default now()
);
alter table public.books enable row level security;
alter table public.videos enable row level security;
alter table public.news enable row level security;

-- সবাই পড়তে পারবে
create policy "Public can read books" on public.books for select using (true);
create policy "Public can read videos" on public.videos for select using (true);
create policy "Public can read news" on public.news for select using (true);

-- কেবল app_metadata-তে role=admin থাকা লগইন করা অ্যাডমিন পরিবর্তন করতে পারবেন
create policy "Admins manage books" on public.books for all
 using ((auth.jwt()->'app_metadata'->>'role') = 'admin')
 with check ((auth.jwt()->'app_metadata'->>'role') = 'admin');
create policy "Admins manage videos" on public.videos for all
 using ((auth.jwt()->'app_metadata'->>'role') = 'admin')
 with check ((auth.jwt()->'app_metadata'->>'role') = 'admin');
create policy "Admins manage news" on public.news for all
 using ((auth.jwt()->'app_metadata'->>'role') = 'admin')
 with check ((auth.jwt()->'app_metadata'->>'role') = 'admin');

-- Public PDF bucket (পড়ার জন্য public, আপলোড কেবল admin)
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('library','library',true,52428800,array['application/pdf'])
on conflict (id) do update set public=true, file_size_limit=52428800, allowed_mime_types=array['application/pdf'];

create policy "Public can read library files" on storage.objects for select
 using (bucket_id = 'library');
create policy "Admins upload library files" on storage.objects for insert
 with check (bucket_id = 'library' and (auth.jwt()->'app_metadata'->>'role') = 'admin');
create policy "Admins update library files" on storage.objects for update
 using (bucket_id = 'library' and (auth.jwt()->'app_metadata'->>'role') = 'admin')
 with check (bucket_id = 'library' and (auth.jwt()->'app_metadata'->>'role') = 'admin');
create policy "Admins delete library files" on storage.objects for delete
 using (bucket_id = 'library' and (auth.jwt()->'app_metadata'->>'role') = 'admin');

-- অ্যাডমিন ইউজার তৈরি করার পর নিচের লাইনটি নিজের ইমেইল দিয়ে চালান:
-- update auth.users set raw_app_meta_data = coalesce(raw_app_meta_data, '{}'::jsonb) || '{"role":"admin"}'::jsonb where email = 'YOUR_ADMIN_EMAIL';
