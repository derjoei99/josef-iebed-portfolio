-- Public download area (CV and other documents): everyone may read; only the verified owner email may upload or delete.
insert into storage.buckets (id, name, public, file_size_limit)
values ('portfolio-files', 'portfolio-files', true, 20971520)
on conflict (id) do update set public = true, file_size_limit = excluded.file_size_limit;

create policy "Portfolio files are publicly readable"
on storage.objects for select
to anon, authenticated
using (bucket_id = 'portfolio-files');

create policy "Only the owner can upload portfolio files"
on storage.objects for insert
to authenticated
with check (bucket_id = 'portfolio-files' and lower(coalesce(auth.jwt() ->> 'email', '')) = 'josef.iebed@gmail.com');

create policy "Only the owner can update portfolio files"
on storage.objects for update
to authenticated
using (bucket_id = 'portfolio-files' and lower(coalesce(auth.jwt() ->> 'email', '')) = 'josef.iebed@gmail.com')
with check (bucket_id = 'portfolio-files' and lower(coalesce(auth.jwt() ->> 'email', '')) = 'josef.iebed@gmail.com');

create policy "Only the owner can delete portfolio files"
on storage.objects for delete
to authenticated
using (bucket_id = 'portfolio-files' and lower(coalesce(auth.jwt() ->> 'email', '')) = 'josef.iebed@gmail.com');
