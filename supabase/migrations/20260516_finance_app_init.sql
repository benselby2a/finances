create schema if not exists finance_app;

create extension if not exists pgcrypto;

create type finance_app.payment_source_type as enum ('one_off', 'recurring_generated', 'settlement');
create type finance_app.recurring_status as enum ('active', 'paused', 'expired');
create type finance_app.split_mode as enum ('equal', 'fixed', 'percentage', 'ratio');
create type finance_app.recurring_frequency as enum ('monthly', 'annual');

create table finance_app.households (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  created_by uuid not null references auth.users(id),
  created_at timestamptz not null default now()
);

create table finance_app.household_members (
  household_id uuid not null references finance_app.households(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  display_name text not null,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  primary key (household_id, user_id),
  unique (user_id)
);

create table finance_app.categories (
  key text primary key,
  label text not null,
  icon_key text not null,
  sort_order int not null default 100,
  is_active boolean not null default true,
  created_at timestamptz not null default now()
);

insert into finance_app.categories (key, label, icon_key, sort_order) values
  ('household_bills', 'Household Bills', 'home', 10),
  ('mortgage_rent', 'Mortgage / Rent', 'house', 20),
  ('insurance', 'Insurance', 'shield', 30),
  ('travel', 'Travel', 'plane', 40),
  ('groceries', 'Groceries', 'basket', 50),
  ('utilities', 'Utilities', 'zap', 60),
  ('internet_phone', 'Internet / Phone', 'wifi', 70),
  ('subscriptions', 'Subscriptions', 'repeat', 80),
  ('transport', 'Transport', 'car', 90),
  ('healthcare', 'Healthcare', 'heart', 100),
  ('education', 'Education', 'book', 110),
  ('entertainment', 'Entertainment', 'film', 120),
  ('dining', 'Dining', 'utensils', 130),
  ('shopping', 'Shopping', 'bag', 140),
  ('other', 'Other', 'circle', 999)
on conflict (key) do nothing;

create table finance_app.recurring_templates (
  id uuid primary key default gen_random_uuid(),
  household_id uuid not null references finance_app.households(id) on delete cascade,
  title text not null,
  amount numeric(12,2) not null check (amount > 0),
  currency_code text not null default 'GBP',
  category_key text null references finance_app.categories(key),
  notes text,
  frequency finance_app.recurring_frequency not null,
  day_of_month int null check (day_of_month between 1 and 31),
  start_date date not null,
  end_date date null,
  review_days_before int not null default 30 check (review_days_before >= 0),
  status finance_app.recurring_status not null default 'active',
  last_processed_at timestamptz null,
  created_by uuid not null references auth.users(id),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  check (end_date is null or end_date >= start_date)
);

create table finance_app.recurring_template_contributions (
  id uuid primary key default gen_random_uuid(),
  recurring_template_id uuid not null references finance_app.recurring_templates(id) on delete cascade,
  user_id uuid not null references auth.users(id),
  mode finance_app.split_mode not null,
  value numeric(12,6) not null check (value >= 0),
  created_at timestamptz not null default now()
);

create table finance_app.recurring_template_splits (
  id uuid primary key default gen_random_uuid(),
  recurring_template_id uuid not null references finance_app.recurring_templates(id) on delete cascade,
  user_id uuid not null references auth.users(id),
  mode finance_app.split_mode not null,
  value numeric(12,6) not null check (value >= 0),
  created_at timestamptz not null default now()
);

create table finance_app.payments (
  id uuid primary key default gen_random_uuid(),
  household_id uuid not null references finance_app.households(id) on delete cascade,
  title text not null,
  amount numeric(12,2) not null check (amount > 0),
  currency_code text not null default 'GBP',
  fx_rate_to_gbp numeric(18,8) not null default 1,
  fx_rate_date date not null default current_date,
  amount_gbp numeric(12,2) not null,
  payment_date date not null,
  category_key text null references finance_app.categories(key),
  notes text,
  source_type finance_app.payment_source_type not null,
  generated_by_recurring_template_id uuid null references finance_app.recurring_templates(id) on delete set null,
  due_date_for_generation date null,
  created_by uuid not null references auth.users(id),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  deleted_at timestamptz null,
  check (fx_rate_to_gbp > 0)
);

create unique index finance_app_payments_recurring_occurrence_uniq
  on finance_app.payments (generated_by_recurring_template_id, due_date_for_generation)
  where source_type = 'recurring_generated' and deleted_at is null;

create index finance_app_payments_household_date_idx
  on finance_app.payments (household_id, payment_date desc)
  where deleted_at is null;

create table finance_app.payment_contributions (
  id uuid primary key default gen_random_uuid(),
  payment_id uuid not null references finance_app.payments(id) on delete cascade,
  user_id uuid not null references auth.users(id),
  amount numeric(12,2) not null check (amount >= 0),
  created_at timestamptz not null default now()
);

create table finance_app.payment_splits (
  id uuid primary key default gen_random_uuid(),
  payment_id uuid not null references finance_app.payments(id) on delete cascade,
  user_id uuid not null references auth.users(id),
  amount numeric(12,2) not null check (amount >= 0),
  created_at timestamptz not null default now()
);

create table finance_app.recurring_generation_log (
  id uuid primary key default gen_random_uuid(),
  recurring_template_id uuid not null references finance_app.recurring_templates(id) on delete cascade,
  due_date date not null,
  payment_id uuid null references finance_app.payments(id) on delete set null,
  status text not null check (status in ('created', 'skipped_exists', 'failed')),
  error_text text null,
  created_at timestamptz not null default now(),
  unique (recurring_template_id, due_date)
);

alter table finance_app.households enable row level security;
alter table finance_app.household_members enable row level security;
alter table finance_app.categories enable row level security;
alter table finance_app.recurring_templates enable row level security;
alter table finance_app.recurring_template_contributions enable row level security;
alter table finance_app.recurring_template_splits enable row level security;
alter table finance_app.payments enable row level security;
alter table finance_app.payment_contributions enable row level security;
alter table finance_app.payment_splits enable row level security;
alter table finance_app.recurring_generation_log enable row level security;

create policy categories_read_auth
on finance_app.categories
for select
to authenticated
using (true);

create policy households_read_auth
on finance_app.households
for select
to authenticated
using (true);

create policy households_insert_auth
on finance_app.households
for insert
to authenticated
with check (created_by = auth.uid());

create policy households_update_auth
on finance_app.households
for update
to authenticated
using (true)
with check (true);

create policy household_members_read_auth
on finance_app.household_members
for select
to authenticated
using (true);

create policy household_members_insert_auth
on finance_app.household_members
for insert
to authenticated
with check (true);

create policy household_members_update_auth
on finance_app.household_members
for update
to authenticated
using (true)
with check (true);

create policy recurring_templates_rw_auth
on finance_app.recurring_templates
for all
to authenticated
using (true)
with check (created_by = auth.uid());

create policy recurring_template_contributions_rw_auth
on finance_app.recurring_template_contributions
for all
to authenticated
using (true)
with check (true);

create policy recurring_template_splits_rw_auth
on finance_app.recurring_template_splits
for all
to authenticated
using (true)
with check (true);

create policy payments_rw_auth
on finance_app.payments
for all
to authenticated
using (true)
with check (created_by = auth.uid());

create policy payment_contributions_rw_auth
on finance_app.payment_contributions
for all
to authenticated
using (true)
with check (true);

create policy payment_splits_rw_auth
on finance_app.payment_splits
for all
to authenticated
using (true)
with check (true);

create policy recurring_generation_log_rw_auth
on finance_app.recurring_generation_log
for all
to authenticated
using (true)
with check (true);
