# Josef Iebed — CV Portfolio

This repository hosts the public portfolio as a static GitHub Pages site. The active site does not use Supabase, authentication, password recovery, a database, or remote file storage. Visitors can read the profile, switch between German and English, share the page, and download files committed to this repository.

## Updating the public portfolio

- Edit the German and English text in `portfolio-content.json`.
- Replace the portrait at `assets/profile.jpg` if needed.
- Add public files under `downloads/` and add entries to `portfolio-downloads.json` using `{ "name": "CV.pdf", "path": "downloads/CV.pdf" }` in the `cv` or `other` list.
- Commit and push changes to the GitHub Pages source branch to publish them. There is no in-page editing or upload interface on the public site.

The former Supabase-enabled source, including its login and password-recovery implementation, is preserved on the GitHub branch `backup/supabase-enabled-2026-11-26`. The full exported database row and extracted source portrait are also saved locally at `/home/ubuntu/portfolio-migration-backup/` during this migration. Do not put passwords, service-role keys, or other secrets in this public repository.
