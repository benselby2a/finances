begin;

insert into finance_app.households (name, created_by)
select 'Shared Household', u.id
from auth.users u
where u.email is not null
order by u.created_at asc
limit 1
on conflict do nothing;

with target_household as (
  select id from finance_app.households order by created_at asc limit 1
),
ben_user as (
  select u.id
  from auth.users u
  where
    lower(coalesce(u.raw_user_meta_data->>'full_name', '')) like '%ben%'
    or lower(coalesce(u.email, '')) like '%ben%'
  order by u.created_at asc
  limit 1
),
lou_user as (
  select u.id
  from auth.users u
  where
    lower(coalesce(u.raw_user_meta_data->>'full_name', '')) like '%lou%'
    or lower(coalesce(u.email, '')) like '%lou%'
  order by u.created_at asc
  limit 1
)
insert into finance_app.household_members (household_id, user_id, display_name, is_active)
select th.id, bu.id, 'Ben Selby', true
from target_household th, ben_user bu
on conflict (user_id) do update
set household_id = excluded.household_id,
    display_name = excluded.display_name,
    is_active = true;

with target_household as (
  select id from finance_app.households order by created_at asc limit 1
),
lou_user as (
  select u.id
  from auth.users u
  where
    lower(coalesce(u.raw_user_meta_data->>'full_name', '')) like '%lou%'
    or lower(coalesce(u.email, '')) like '%lou%'
  order by u.created_at asc
  limit 1
)
insert into finance_app.household_members (household_id, user_id, display_name, is_active)
select th.id, lu.id, 'Louise Billingham', true
from target_household th, lou_user lu
on conflict (user_id) do update
set household_id = excluded.household_id,
    display_name = excluded.display_name,
    is_active = true;

commit;
