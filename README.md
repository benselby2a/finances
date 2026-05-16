# Shared Finance App

Single-screen finance tracker designed for GitHub Pages + Supabase.

## Current Status
- Initial product plan: `docs/app-plan.md`
- Supabase schema migration: `supabase/migrations/20260516_finance_app_init.sql`
- Static app scaffold: `index.html`, `src/app.js`, `src/styles.css`
- GitHub Pages deploy workflow: `.github/workflows/deploy-pages.yml`

## Next Steps
1. Apply SQL migration in Supabase.
2. Replace auth/session stubs in `src/app.js` with real Supabase client usage.
3. Implement payment CRUD + recurring sync logic.
4. Implement balances, reminders, and settlement flow.

## Supabase Env Variables
For local/dev wiring, add these values in your runtime config strategy:
- `SUPABASE_URL`
- `SUPABASE_ANON_KEY`

Do not commit service role keys.
