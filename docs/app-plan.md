# Single-Screen Finance App (GitHub Pages + Supabase) Implementation Plan

## Summary
Build a single-screen web app hosted on GitHub Pages that tracks shared costs, bills, settlements, and recurring payments, with Supabase as the system of record. The UI uses collapsible sections plus modals for data entry/editing. Recurring payments are created only through `Add Payment` and processed client-side on startup (no backend scheduler). The app is auth-required, uses a single shared household context, supports multi-currency inputs with GBP display totals, and shows a startup popup summary only when there are updates.

## Key Changes
- **UI architecture**
  - Single route/page with collapsible sections: `Who Owes What`, `Payments`, `Recurring`, `Reminders`.
  - Remove Activity/Processing section from main UI; expose sync diagnostics in `Settings`.
  - Use modals for `Add/Edit Payment`, `Payment Details`, and `Record Settlement`.
  - `Add Payment` is the only creation entry for recurring items via `Make recurring` toggle + frequency controls.
  - Category picker uses predefined categories with icon keys.

- **Auth and household model**
  - Supabase authentication is required for all reads/writes.
  - App uses one global household in v1 (no invite or join flow).
  - RLS only allows authenticated users; app data stays in dedicated `finance_app` schema.

- **Startup behavior**
  - On app load, run recurring sync:
    - fetch active recurring templates,
    - compute due/missed occurrences up to “now,”
    - insert missing generated payments idempotently,
    - record sync result metadata.
  - Partial failures commit successful inserts and log failures.
  - Show startup popup summary for updates only.
  - First-ever open initializes local storage markers silently (no popup).

- **Notification deduplication**
  - Count and display:
    - `one-off payments added`,
    - `recurring payments processed`.
  - Do **not** double-notify recurring items as both “processed” and “new payment record.”
  - If both counts are zero, show nothing.

- **Data and business rules**
  - `payments.source_type` enum: `one_off | recurring_generated | settlement`.
  - Recurring frequencies allowed: `monthly | annual`.
  - Soft delete payments via `deleted_at`.
  - Add full payment lifecycle actions: edit existing payment details and soft-delete payments from UI.
  - Editing a payment must update parent `payments` row and its linked `payment_contributions` / `payment_splits` atomically.
  - Deleting a payment must hide it from all default views and trigger balance/stat recomputation immediately.
  - Recurring-generated payments can be edited directly.
  - On edit of recurring-generated payment amount/splits, prompt whether to apply to template defaults.
  - Settlement suggestions minimize number of transfers.
  - Marking a settlement as complete auto-creates a `settlement` payment.

- **FX policy**
  - Multi-currency supported per payment with default `GBP`.
  - Default rate date is entry date.
  - Auto-fetch FX rate by default with manual override.
  - Converted GBP amount uses standard half-up rounding to 2dp.

## Public Interfaces / Types
- **Payment form contract**
  - Core fields: title, amount, currency, payment date, category, notes.
  - Contribution fields: who paid + allocation mode (`fixed | percentage | ratio`).
  - Owes/split fields: allocation mode (`equal | fixed | percentage | ratio`).
  - Recurring extension fields (visible only when toggled): frequency (`monthly | annual`), start date, optional end date, review window days before (default `30`).
- **Payment classification**
  - `source_type` required for all payment rows.
- **Local storage keys**
  - `lastOpenedAt` (ISO timestamp),
  - `lastSummaryShownForWindow` (dedupe guard),
  - optional sync metadata keys for diagnostics.

## Test Plan
- **Startup sync**
  - Generates pending recurring payments exactly once per due occurrence.
  - Re-opening/refreshing without new due items creates zero duplicates.
  - No backfill cap in v1; all missed occurrences are processed.
  - Partial failure preserves successful inserts and logs failed occurrences.
- **Summary notifications**
  - Since-last-open popup shows accurate counts for one-off vs recurring.
  - Recurring-generated rows are counted only in recurring bucket, never duplicated.
  - First open shows no summary popup.
  - Zero-update startup shows no popup.
- **Add Payment flow**
  - One-off save works without recurring fields.
  - Recurring toggle save creates payment + recurring template as intended.
  - Validation enforces contribution/split totals equal payment amount.
- **Edit/Delete flow**
  - Edit payment updates display and recalculated balances without page reload.
  - Soft-deleted payment is excluded from payments list, balances, who-owes summary, and insights.
  - Settlement payment edit/delete updates net balances correctly and immediately.
- **Balances and settlements**
  - Net balances reflect one-off, recurring-generated, and settlement records correctly.
  - Settlement complete action auto-creates settlement record.
- **Reminders**
  - Expiring/review reminders appear in reminders section and update correctly after edits.
  - Default reminder window is 30 days.
- **Permissions/security**
  - Unauthenticated users cannot read/write app tables.
  - Authenticated users can access app data according to v1 single-household policy.

## Assumptions and Defaults
- Hosting is static GitHub Pages; all business logic runs client-side.
- Recurring processing runs on startup and optional manual trigger in Settings; no server cron/job.
- Recurring creation is only from `Add Payment`; recurring section is management-only.
- App uses one consolidated startup popup rather than multiple notifications.
- Time calculations use app-configured timezone consistently (timestamps stored UTC).
- Existing non-finance tables in `public` remain untouched; finance tables live in `finance_app` schema.

## UX Revamp Workstream
- Visual direction: modern editorial / Apple-like clarity with neutral surfaces, high-contrast typography, soft gradients, subtle motion, and strict spacing/radius tokens.
- Payments UI: more visible table on desktop (sticky header, zebra rows, clearer numeric alignment, explicit action column) with responsive card-list fallback on mobile.
- Iconography: add category icons and payment-type icons (`one_off`, `settlement`, `recurring_generated`) across payments, recurring, reminders, and insights.
- Tooltips: add concise hover/focus tooltips for category/type chips, balance summaries, and recurring/reminder status explanations.
- Mobile UX: optimize tap targets, compact chips, stacked row actions, and zero horizontal-scroll default behavior.
- Acceptance criteria:
  - Table readability is improved on desktop.
  - Category/type icons are consistently visible.
  - Tooltips provide metadata explanations without clutter.
  - Mobile experience remains fully functional and legible.
