-- Public portfolio data: everyone may read; only the verified owner email may write.
create table if not exists public.portfolio_content (
  id text primary key default 'main' check (id = 'main'),
  content jsonb not null default '{"de": {}, "en": {}, "profileImage": null}'::jsonb
    check (jsonb_typeof(content) = 'object'),
  updated_at timestamptz not null default now()
);

alter table public.portfolio_content enable row level security;

revoke all on table public.portfolio_content from anon, authenticated;
grant select on table public.portfolio_content to anon, authenticated;
grant insert, update on table public.portfolio_content to authenticated;

create policy "Portfolio content is publicly readable"
on public.portfolio_content
for select
to anon, authenticated
using (true);

create policy "Only the owner can create portfolio content"
on public.portfolio_content
for insert
to authenticated
with check (lower(coalesce(auth.jwt() ->> 'email', '')) = 'josef.iebed@gmail.com');

create policy "Only the owner can update portfolio content"
on public.portfolio_content
for update
to authenticated
using (lower(coalesce(auth.jwt() ->> 'email', '')) = 'josef.iebed@gmail.com')
with check (lower(coalesce(auth.jwt() ->> 'email', '')) = 'josef.iebed@gmail.com');
