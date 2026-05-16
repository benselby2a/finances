-- Permanent display-name enforcement for known members
-- Ben Selby:    5cbedf5b-9c84-4926-b125-e4a958bee5f9
-- Louise Billingham: fbbffb5f-f39b-4938-ab8d-c455a7799409

begin;

-- 1) One-time correction
update finance_app.household_members
set display_name = 'Ben Selby', is_active = true
where user_id = '5cbedf5b-9c84-4926-b125-e4a958bee5f9';

update finance_app.household_members
set display_name = 'Louise Billingham', is_active = true
where user_id = 'fbbffb5f-f39b-4938-ab8d-c455a7799409';

-- 2) Enforce on all future inserts/updates
create or replace function finance_app.enforce_known_member_display_names()
returns trigger
language plpgsql
as $$
begin
  if new.user_id = '5cbedf5b-9c84-4926-b125-e4a958bee5f9'::uuid then
    new.display_name := 'Ben Selby';
  elsif new.user_id = 'fbbffb5f-f39b-4938-ab8d-c455a7799409'::uuid then
    new.display_name := 'Louise Billingham';
  end if;

  return new;
end;
$$;

drop trigger if exists trg_enforce_known_member_display_names on finance_app.household_members;

create trigger trg_enforce_known_member_display_names
before insert or update on finance_app.household_members
for each row
execute function finance_app.enforce_known_member_display_names();

commit;
