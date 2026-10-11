# Secure portfolio login setup

The portfolio remains publicly viewable on GitHub Pages. Editing is gated by Supabase email-link authentication and enforced again by PostgreSQL row-level security (RLS). The browser client uses only the Supabase publishable key; it must never use a `service_role` or secret key.

## Project

- Supabase project: `josef-iebed-portfolio-auth`
- Region: EU Central (`eu-central-1`)
- Billing tier approved for creation: Free ($0/month)
- Public site: <https://derjoei99.github.io/josef-iebed-portfolio/>

The frontend settings live in `supabase-config.js`. The owner email is allowlisted in the migration as well as in the UI. Public visitors can read the portfolio row; authenticated writes are restricted by RLS to that verified email.

## One-time dashboard setting

Supabase email-link authentication redirects back to the site. In the Supabase Dashboard, open **Authentication → URL Configuration** and set:

- **Site URL:** `https://derjoei99.github.io/josef-iebed-portfolio/`
- **Redirect URL allowlist:** add `https://derjoei99.github.io/josef-iebed-portfolio/`

Email sign-in is handled with Supabase Magic Links. The site requests links only for the owner email; database RLS remains the actual authorization boundary if someone bypasses the client UI.

## Data and image handling

The site stores German and English editable content plus the profile image in the single `public.portfolio_content` row. The image is resized in the browser and stored as a compressed JPEG data URL. No image is sent until the owner saves; public visitors can then read the published profile and image.

The SQL migration is in `supabase/migrations/20261011184000_portfolio_content.sql`.

## References

- [Supabase passwordless email authentication](https://supabase.com/docs/guides/auth/auth-email-passwordless)
- [Supabase Auth redirect URLs](https://supabase.com/docs/guides/auth/redirect-urls)
- [Supabase row-level security](https://supabase.com/docs/guides/database/postgres/row-level-security)
- [Supabase pricing](https://supabase.com/pricing)
