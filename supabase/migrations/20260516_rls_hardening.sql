-- RLS hardening: household-scoped policies for finance_app
-- Replaces broad authenticated access with membership-based access.

begin;

-- Helper function: true when auth user is active member of household
create or replace function finance_app.is_household_member(p_household_id uuid)
returns boolean
language sql
stable
security definer
set search_path = finance_app, public
as $$
  select exists (
    select 1
    from finance_app.household_members hm
    where hm.household_id = p_household_id
      and hm.user_id = auth.uid()
      and hm.is_active = true
  );
$$;

grant execute on function finance_app.is_household_member(uuid) to authenticated;

-- Drop permissive policies created in bootstrap migration
-- Households
 drop policy if exists households_read_auth on finance_app.households;
 drop policy if exists households_insert_auth on finance_app.households;
 drop policy if exists households_update_auth on finance_app.households;

-- Household members
 drop policy if exists household_members_read_auth on finance_app.household_members;
 drop policy if exists household_members_insert_auth on finance_app.household_members;
 drop policy if exists household_members_update_auth on finance_app.household_members;

-- Categories
 drop policy if exists categories_read_auth on finance_app.categories;

-- Recurring templates
 drop policy if exists recurring_templates_rw_auth on finance_app.recurring_templates;
 drop policy if exists recurring_template_contributions_rw_auth on finance_app.recurring_template_contributions;
 drop policy if exists recurring_template_splits_rw_auth on finance_app.recurring_template_splits;

-- Payments and child rows
 drop policy if exists payments_rw_auth on finance_app.payments;
 drop policy if exists payment_contributions_rw_auth on finance_app.payment_contributions;
 drop policy if exists payment_splits_rw_auth on finance_app.payment_splits;
 drop policy if exists recurring_generation_log_rw_auth on finance_app.recurring_generation_log;

-- Categories: readable by authenticated users, no writes from app clients
create policy categories_select_auth
on finance_app.categories
for select
to authenticated
using (true);

-- Households: users can only see households they belong to
create policy households_select_member
on finance_app.households
for select
to authenticated
using (finance_app.is_household_member(id));

-- Households: insert only by self as creator
create policy households_insert_self
on finance_app.households
for insert
to authenticated
with check (created_by = auth.uid());

-- Households: update only if member
create policy households_update_member
on finance_app.households
for update
to authenticated
using (finance_app.is_household_member(id))
with check (finance_app.is_household_member(id));

-- Household members: select only within own household membership
create policy household_members_select_member
on finance_app.household_members
for select
to authenticated
using (finance_app.is_household_member(household_id));

-- Household members: insert only into households the caller belongs to
create policy household_members_insert_member
on finance_app.household_members
for insert
to authenticated
with check (finance_app.is_household_member(household_id));

-- Household members: update only within caller households
create policy household_members_update_member
on finance_app.household_members
for update
to authenticated
using (finance_app.is_household_member(household_id))
with check (finance_app.is_household_member(household_id));

-- Payments: household-scoped read/write
create policy payments_select_member
on finance_app.payments
for select
to authenticated
using (finance_app.is_household_member(household_id));

create policy payments_insert_member
on finance_app.payments
for insert
to authenticated
with check (finance_app.is_household_member(household_id) and created_by = auth.uid());

create policy payments_update_member
on finance_app.payments
for update
to authenticated
using (finance_app.is_household_member(household_id))
with check (finance_app.is_household_member(household_id));

create policy payments_delete_member
on finance_app.payments
for delete
to authenticated
using (finance_app.is_household_member(household_id));

-- payment_contributions: scope via parent payment household
create policy payment_contrib_select_member
on finance_app.payment_contributions
for select
to authenticated
using (
  exists (
    select 1
    from finance_app.payments p
    where p.id = payment_contributions.payment_id
      and finance_app.is_household_member(p.household_id)
  )
);

create policy payment_contrib_insert_member
on finance_app.payment_contributions
for insert
to authenticated
with check (
  exists (
    select 1
    from finance_app.payments p
    where p.id = payment_contributions.payment_id
      and finance_app.is_household_member(p.household_id)
  )
);

create policy payment_contrib_update_member
on finance_app.payment_contributions
for update
to authenticated
using (
  exists (
    select 1
    from finance_app.payments p
    where p.id = payment_contributions.payment_id
      and finance_app.is_household_member(p.household_id)
  )
)
with check (
  exists (
    select 1
    from finance_app.payments p
    where p.id = payment_contributions.payment_id
      and finance_app.is_household_member(p.household_id)
  )
);

create policy payment_contrib_delete_member
on finance_app.payment_contributions
for delete
to authenticated
using (
  exists (
    select 1
    from finance_app.payments p
    where p.id = payment_contributions.payment_id
      and finance_app.is_household_member(p.household_id)
  )
);

-- payment_splits: scope via parent payment household
create policy payment_splits_select_member
on finance_app.payment_splits
for select
to authenticated
using (
  exists (
    select 1
    from finance_app.payments p
    where p.id = payment_splits.payment_id
      and finance_app.is_household_member(p.household_id)
  )
);

create policy payment_splits_insert_member
on finance_app.payment_splits
for insert
to authenticated
with check (
  exists (
    select 1
    from finance_app.payments p
    where p.id = payment_splits.payment_id
      and finance_app.is_household_member(p.household_id)
  )
);

create policy payment_splits_update_member
on finance_app.payment_splits
for update
to authenticated
using (
  exists (
    select 1
    from finance_app.payments p
    where p.id = payment_splits.payment_id
      and finance_app.is_household_member(p.household_id)
  )
)
with check (
  exists (
    select 1
    from finance_app.payments p
    where p.id = payment_splits.payment_id
      and finance_app.is_household_member(p.household_id)
  )
);

create policy payment_splits_delete_member
on finance_app.payment_splits
for delete
to authenticated
using (
  exists (
    select 1
    from finance_app.payments p
    where p.id = payment_splits.payment_id
      and finance_app.is_household_member(p.household_id)
  )
);

-- Recurring templates: household-scoped
create policy recurring_templates_select_member
on finance_app.recurring_templates
for select
to authenticated
using (finance_app.is_household_member(household_id));

create policy recurring_templates_insert_member
on finance_app.recurring_templates
for insert
to authenticated
with check (finance_app.is_household_member(household_id) and created_by = auth.uid());

create policy recurring_templates_update_member
on finance_app.recurring_templates
for update
to authenticated
using (finance_app.is_household_member(household_id))
with check (finance_app.is_household_member(household_id));

create policy recurring_templates_delete_member
on finance_app.recurring_templates
for delete
to authenticated
using (finance_app.is_household_member(household_id));

-- recurring_template_contributions: scope via parent template
create policy recurring_t_contrib_select_member
on finance_app.recurring_template_contributions
for select
to authenticated
using (
  exists (
    select 1
    from finance_app.recurring_templates rt
    where rt.id = recurring_template_contributions.recurring_template_id
      and finance_app.is_household_member(rt.household_id)
  )
);

create policy recurring_t_contrib_insert_member
on finance_app.recurring_template_contributions
for insert
to authenticated
with check (
  exists (
    select 1
    from finance_app.recurring_templates rt
    where rt.id = recurring_template_contributions.recurring_template_id
      and finance_app.is_household_member(rt.household_id)
  )
);

create policy recurring_t_contrib_update_member
on finance_app.recurring_template_contributions
for update
to authenticated
using (
  exists (
    select 1
    from finance_app.recurring_templates rt
    where rt.id = recurring_template_contributions.recurring_template_id
      and finance_app.is_household_member(rt.household_id)
  )
)
with check (
  exists (
    select 1
    from finance_app.recurring_templates rt
    where rt.id = recurring_template_contributions.recurring_template_id
      and finance_app.is_household_member(rt.household_id)
  )
);

create policy recurring_t_contrib_delete_member
on finance_app.recurring_template_contributions
for delete
to authenticated
using (
  exists (
    select 1
    from finance_app.recurring_templates rt
    where rt.id = recurring_template_contributions.recurring_template_id
      and finance_app.is_household_member(rt.household_id)
  )
);

-- recurring_template_splits: scope via parent template
create policy recurring_t_splits_select_member
on finance_app.recurring_template_splits
for select
to authenticated
using (
  exists (
    select 1
    from finance_app.recurring_templates rt
    where rt.id = recurring_template_splits.recurring_template_id
      and finance_app.is_household_member(rt.household_id)
  )
);

create policy recurring_t_splits_insert_member
on finance_app.recurring_template_splits
for insert
to authenticated
with check (
  exists (
    select 1
    from finance_app.recurring_templates rt
    where rt.id = recurring_template_splits.recurring_template_id
      and finance_app.is_household_member(rt.household_id)
  )
);

create policy recurring_t_splits_update_member
on finance_app.recurring_template_splits
for update
to authenticated
using (
  exists (
    select 1
    from finance_app.recurring_templates rt
    where rt.id = recurring_template_splits.recurring_template_id
      and finance_app.is_household_member(rt.household_id)
  )
)
with check (
  exists (
    select 1
    from finance_app.recurring_templates rt
    where rt.id = recurring_template_splits.recurring_template_id
      and finance_app.is_household_member(rt.household_id)
  )
);

create policy recurring_t_splits_delete_member
on finance_app.recurring_template_splits
for delete
to authenticated
using (
  exists (
    select 1
    from finance_app.recurring_templates rt
    where rt.id = recurring_template_splits.recurring_template_id
      and finance_app.is_household_member(rt.household_id)
  )
);

-- recurring_generation_log: scope via parent template
create policy recurring_log_select_member
on finance_app.recurring_generation_log
for select
to authenticated
using (
  exists (
    select 1
    from finance_app.recurring_templates rt
    where rt.id = recurring_generation_log.recurring_template_id
      and finance_app.is_household_member(rt.household_id)
  )
);

create policy recurring_log_insert_member
on finance_app.recurring_generation_log
for insert
to authenticated
with check (
  exists (
    select 1
    from finance_app.recurring_templates rt
    where rt.id = recurring_generation_log.recurring_template_id
      and finance_app.is_household_member(rt.household_id)
  )
);

create policy recurring_log_update_member
on finance_app.recurring_generation_log
for update
to authenticated
using (
  exists (
    select 1
    from finance_app.recurring_templates rt
    where rt.id = recurring_generation_log.recurring_template_id
      and finance_app.is_household_member(rt.household_id)
  )
)
with check (
  exists (
    select 1
    from finance_app.recurring_templates rt
    where rt.id = recurring_generation_log.recurring_template_id
      and finance_app.is_household_member(rt.household_id)
  )
);

create policy recurring_log_delete_member
on finance_app.recurring_generation_log
for delete
to authenticated
using (
  exists (
    select 1
    from finance_app.recurring_templates rt
    where rt.id = recurring_generation_log.recurring_template_id
      and finance_app.is_household_member(rt.household_id)
  )
);

commit;
