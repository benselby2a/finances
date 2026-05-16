-- DB-side balance aggregation for a household

create or replace function finance_app.get_household_balances(p_household_id uuid)
returns table (
  user_id uuid,
  display_name text,
  paid numeric,
  owes numeric,
  net numeric
)
language sql
security definer
set search_path = finance_app, public
as $$
  with contrib as (
    select
      pc.user_id,
      sum(pc.amount)::numeric as paid
    from finance_app.payment_contributions pc
    join finance_app.payments p on p.id = pc.payment_id
    where p.household_id = p_household_id
      and p.deleted_at is null
    group by pc.user_id
  ),
  owed as (
    select
      ps.user_id,
      sum(ps.amount)::numeric as owes
    from finance_app.payment_splits ps
    join finance_app.payments p on p.id = ps.payment_id
    where p.household_id = p_household_id
      and p.deleted_at is null
    group by ps.user_id
  )
  select
    hm.user_id,
    hm.display_name,
    coalesce(c.paid, 0)::numeric as paid,
    coalesce(o.owes, 0)::numeric as owes,
    (coalesce(c.paid, 0) - coalesce(o.owes, 0))::numeric as net
  from finance_app.household_members hm
  left join contrib c on c.user_id = hm.user_id
  left join owed o on o.user_id = hm.user_id
  where hm.household_id = p_household_id
    and hm.is_active = true
  order by hm.display_name;
$$;

grant execute on function finance_app.get_household_balances(uuid) to authenticated;
