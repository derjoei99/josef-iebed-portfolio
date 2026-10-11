# Secure portfolio login setup

The portfolio remains publicly viewable on GitHub Pages. Editing is gated by Supabase email-and-password authentication and enforced again by PostgreSQL row-level security (RLS). The browser client uses only the Supabase publishable key; it must never use a `service_role` or secret key.

## Project

- Supabase project: `josef-iebed-portfolio-auth`
- Region: EU Central (`eu-central-1`)
- Billing tier approved for creation: Free ($0/month)
- Public site: <https://derjoei99.github.io/josef-iebed-portfolio/>

The frontend settings live in `supabase-config.js`. The owner email is allowlisted in the migration as well as in the UI. Public visitors can read the portfolio row; authenticated writes are restricted by RLS to that email.

## Owner password account

The site signs in with `signInWithPassword`. Submitting the login form does **not** send a sign-in email or link. Public registration is not exposed in the portfolio.

Before the first login, create the owner account in Supabase Dashboard under **Authentication → Users**. Use the portfolio owner email, set a password directly in the dashboard, and confirm the email for that account. Never put the password in this repository, a source file, or a chat message. Password reset is not currently implemented in the portfolio UI.

The dashboard’s **Site URL** and redirect allowlist are already set to `https://derjoei99.github.io/josef-iebed-portfolio/`. Those settings are not used by normal password sign-in; they remain useful for future confirmation or recovery flows.

## Data and image handling

The site stores German and English editable content plus the profile image in the single `public.portfolio_content` row. The image is resized in the browser and stored as a compressed JPEG data URL. No image is sent until the owner saves; public visitors can then read the published profile and image.

The SQL migration is in `supabase/migrations/20261011184000_portfolio_content.sql`.

## References

- [Supabase password-based authentication](https://supabase.com/docs/guides/auth/passwords)
- [Supabase Auth redirect URLs](https://supabase.com/docs/guides/auth/redirect-urls)
- [Supabase row-level security](https://supabase.com/docs/guides/database/postgres/row-level-security)
- [Supabase pricing](https://supabase.com/pricing)
