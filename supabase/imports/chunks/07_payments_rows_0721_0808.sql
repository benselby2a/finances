begin;

-- Row 721: 2025-09-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 17.50, 'GBP', 1, '2025-09-01', 17.50, '2025-09-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 8.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 8.75 from ins_payment, other_member;


-- Row 722: 2025-09-01 Hot Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot Water', 31.00, 'GBP', 1, '2025-09-01', 31.00, '2025-09-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 31.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 15.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 15.50 from ins_payment, other_member;


-- Row 723: 2025-09-01 Car break down  & travel insuranve
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Car break down  & travel insuranve', 13.00, 'GBP', 1, '2025-09-01', 13.00, '2025-09-01', 'transport', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 13.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 6.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 6.50 from ins_payment, other_member;


-- Row 724: 2025-09-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 33.00, 'GBP', 1, '2025-09-04', 33.00, '2025-09-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 33.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 16.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 16.50 from ins_payment, other_member;


-- Row 725: 2025-09-08 Car insurance
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Car insurance', 345.00, 'GBP', 1, '2025-09-08', 345.00, '2025-09-08', 'insurance', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 345.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 172.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 172.50 from ins_payment, other_member;


-- Row 726: 2025-09-09 Service charge
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Service charge', 1247.00, 'GBP', 1, '2025-09-09', 1247.00, '2025-09-09', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 1247.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 623.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 623.50 from ins_payment, other_member;


-- Row 727: 2025-09-27 Council tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council tax', 179.00, 'GBP', 1, '2025-09-27', 179.00, '2025-09-27', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 179.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 89.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 89.50 from ins_payment, other_member;


-- Row 728: 2025-09-28 France contribution
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'France contribution', 300.00, 'GBP', 1, '2025-09-28', 300.00, '2025-09-28', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 300.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 150.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 150.00 from ins_payment, other_member;


-- Row 729: 2025-09-28 Barbados contribution hotels
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Barbados contribution hotels', 500.00, 'GBP', 1, '2025-09-28', 500.00, '2025-09-28', 'travel', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 500.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 250.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 250.00 from ins_payment, other_member;


-- Row 730: 2025-09-28 Kenya return flights
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Kenya return flights', 600.00, 'GBP', 1, '2025-09-28', 600.00, '2025-09-28', 'travel', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 600.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 300.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 300.00 from ins_payment, other_member;


-- Row 731: 2025-09-28 Kenya holiday deposit
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Kenya holiday deposit', 2280.00, 'GBP', 1, '2025-09-28', 2280.00, '2025-09-28', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 2280.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 1140.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 1140.00 from ins_payment, other_member;


-- Row 732: 2025-09-28 Louise B. paid Ben S.
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Louise B. paid Ben S.', 629.26, 'GBP', 1, '2025-09-28', 629.26, '2025-09-28', 'settlements', null, 'settlement', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 629.26 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, other_member.user_id, 629.26 from ins_payment, other_member;


-- Row 733: 2025-10-01 Electricity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electricity', 80.00, 'GBP', 1, '2025-10-01', 80.00, '2025-10-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 80.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 40.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 40.00 from ins_payment, other_member;


-- Row 734: 2025-10-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2025-10-01', 24.00, '2025-10-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 735: 2025-10-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 17.50, 'GBP', 1, '2025-10-01', 17.50, '2025-10-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 8.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 8.75 from ins_payment, other_member;


-- Row 736: 2025-10-01 Hot Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot Water', 31.00, 'GBP', 1, '2025-10-01', 31.00, '2025-10-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 31.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 15.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 15.50 from ins_payment, other_member;


-- Row 737: 2025-10-01 Car break down  & travel insuranve
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Car break down  & travel insuranve', 13.00, 'GBP', 1, '2025-10-01', 13.00, '2025-10-01', 'transport', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 13.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 6.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 6.50 from ins_payment, other_member;


-- Row 738: 2025-10-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 33.00, 'GBP', 1, '2025-10-04', 33.00, '2025-10-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 33.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 16.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 16.50 from ins_payment, other_member;


-- Row 739: 2025-10-27 Council tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council tax', 179.00, 'GBP', 1, '2025-10-27', 179.00, '2025-10-27', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 179.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 89.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 89.50 from ins_payment, other_member;


-- Row 740: 2025-11-01 Electricity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electricity', 80.00, 'GBP', 1, '2025-11-01', 80.00, '2025-11-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 80.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 40.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 40.00 from ins_payment, other_member;


-- Row 741: 2025-11-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2025-11-01', 24.00, '2025-11-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 742: 2025-11-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 17.50, 'GBP', 1, '2025-11-01', 17.50, '2025-11-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 8.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 8.75 from ins_payment, other_member;


-- Row 743: 2025-11-01 Hot Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot Water', 31.00, 'GBP', 1, '2025-11-01', 31.00, '2025-11-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 31.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 15.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 15.50 from ins_payment, other_member;


-- Row 744: 2025-11-01 Car break down  & travel insuranve
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Car break down  & travel insuranve', 13.00, 'GBP', 1, '2025-11-01', 13.00, '2025-11-01', 'transport', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 13.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 6.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 6.50 from ins_payment, other_member;


-- Row 745: 2025-11-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 33.00, 'GBP', 1, '2025-11-04', 33.00, '2025-11-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 33.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 16.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 16.50 from ins_payment, other_member;


-- Row 746: 2025-11-19 Chair cover deposit
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Chair cover deposit', 369.00, 'GBP', 1, '2025-11-19', 369.00, '2025-11-19', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 369.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 184.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 184.50 from ins_payment, other_member;


-- Row 747: 2025-11-27 Council tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council tax', 179.00, 'GBP', 1, '2025-11-27', 179.00, '2025-11-27', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 179.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 89.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 89.50 from ins_payment, other_member;


-- Row 748: 2025-11-29 Manatee Switzerland
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Manatee Switzerland', 300.00, 'GBP', 1, '2025-11-29', 300.00, '2025-11-29', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 300.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 150.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 150.00 from ins_payment, other_member;


-- Row 749: 2025-12-01 Electricity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electricity', 80.00, 'GBP', 1, '2025-12-01', 80.00, '2025-12-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 80.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 40.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 40.00 from ins_payment, other_member;


-- Row 750: 2025-12-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2025-12-01', 24.00, '2025-12-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 751: 2025-12-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 17.50, 'GBP', 1, '2025-12-01', 17.50, '2025-12-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 8.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 8.75 from ins_payment, other_member;


-- Row 752: 2025-12-01 Hot Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot Water', 31.00, 'GBP', 1, '2025-12-01', 31.00, '2025-12-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 31.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 15.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 15.50 from ins_payment, other_member;


-- Row 753: 2025-12-01 Car break down  & travel insuranve
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Car break down  & travel insuranve', 13.00, 'GBP', 1, '2025-12-01', 13.00, '2025-12-01', 'transport', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 13.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 6.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 6.50 from ins_payment, other_member;


-- Row 754: 2025-12-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 33.00, 'GBP', 1, '2025-12-04', 33.00, '2025-12-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 33.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 16.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 16.50 from ins_payment, other_member;


-- Row 755: 2025-12-21 Christmas presents
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Christmas presents', 100.00, 'GBP', 1, '2025-12-21', 100.00, '2025-12-21', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 100.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 50.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 50.00 from ins_payment, other_member;


-- Row 756: 2025-12-21 Lunch with neil and winnie
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Lunch with neil and winnie', 60.00, 'GBP', 1, '2025-12-21', 60.00, '2025-12-21', 'dining', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 60.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 30.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 30.00 from ins_payment, other_member;


-- Row 757: 2025-12-22 Service charge
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Service charge', 1414.00, 'GBP', 1, '2025-12-22', 1414.00, '2025-12-22', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 1414.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 707.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 707.00 from ins_payment, other_member;


-- Row 758: 2025-12-23 Settle all balances
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Settle all balances', 660.53, 'GBP', 1, '2025-12-23', 660.53, '2025-12-23', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 660.53 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 330.26 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 330.27 from ins_payment, other_member;


-- Row 759: 2025-12-27 Council tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council tax', 179.00, 'GBP', 1, '2025-12-27', 179.00, '2025-12-27', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 179.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 89.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 89.50 from ins_payment, other_member;


-- Row 760: 2026-01-01 Electricity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electricity', 80.00, 'GBP', 1, '2026-01-01', 80.00, '2026-01-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 80.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 40.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 40.00 from ins_payment, other_member;


-- Row 761: 2026-01-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2026-01-01', 24.00, '2026-01-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 762: 2026-01-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 26.00, 'GBP', 1, '2026-01-01', 26.00, '2026-01-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 26.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 13.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 13.00 from ins_payment, other_member;


-- Row 763: 2026-01-01 Hot Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot Water', 31.00, 'GBP', 1, '2026-01-01', 31.00, '2026-01-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 31.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 15.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 15.50 from ins_payment, other_member;


-- Row 764: 2026-01-01 Car break down  & travel insuranve
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Car break down  & travel insuranve', 13.00, 'GBP', 1, '2026-01-01', 13.00, '2026-01-01', 'transport', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 13.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 6.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 6.50 from ins_payment, other_member;


-- Row 765: 2026-01-04 Gap year hotel
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Gap year hotel', 100.00, 'GBP', 1, '2026-01-04', 100.00, '2026-01-04', 'shopping', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 100.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 50.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 50.00 from ins_payment, other_member;


-- Row 766: 2026-01-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 33.00, 'GBP', 1, '2026-01-04', 33.00, '2026-01-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 33.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 16.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 16.50 from ins_payment, other_member;


-- Row 767: 2026-01-05 Chair cover
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Chair cover', 369.00, 'GBP', 1, '2026-01-05', 369.00, '2026-01-05', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 369.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 184.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 184.50 from ins_payment, other_member;


-- Row 768: 2026-01-18 Switzerland extras
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Switzerland extras', 100.00, 'GBP', 1, '2026-01-18', 100.00, '2026-01-18', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 100.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 50.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 50.00 from ins_payment, other_member;


-- Row 769: 2026-01-18 Lampshade
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Lampshade', 79.00, 'GBP', 1, '2026-01-18', 79.00, '2026-01-18', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 79.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 39.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 39.50 from ins_payment, other_member;


-- Row 770: 2026-01-27 Council tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council tax', 179.00, 'GBP', 1, '2026-01-27', 179.00, '2026-01-27', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 179.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 89.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 89.50 from ins_payment, other_member;


-- Row 771: 2026-01-31 Losing bet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Losing bet', 10.00, 'GBP', 1, '2026-01-31', 10.00, '2026-01-31', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 10.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 5.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 5.00 from ins_payment, other_member;


-- Row 772: 2026-02-01 Electricity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electricity', 80.00, 'GBP', 1, '2026-02-01', 80.00, '2026-02-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 80.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 40.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 40.00 from ins_payment, other_member;


-- Row 773: 2026-02-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2026-02-01', 24.00, '2026-02-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 774: 2026-02-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 26.00, 'GBP', 1, '2026-02-01', 26.00, '2026-02-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 26.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 13.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 13.00 from ins_payment, other_member;


-- Row 775: 2026-02-01 Hot Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot Water', 31.00, 'GBP', 1, '2026-02-01', 31.00, '2026-02-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 31.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 15.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 15.50 from ins_payment, other_member;


-- Row 776: 2026-02-01 Car break down  & travel insuranve
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Car break down  & travel insuranve', 13.00, 'GBP', 1, '2026-02-01', 13.00, '2026-02-01', 'transport', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 13.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 6.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 6.50 from ins_payment, other_member;


-- Row 777: 2026-02-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 33.00, 'GBP', 1, '2026-02-04', 33.00, '2026-02-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 33.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 16.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 16.50 from ins_payment, other_member;


-- Row 778: 2026-02-27 Council tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council tax', 179.00, 'GBP', 1, '2026-02-27', 179.00, '2026-02-27', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 179.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 89.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 89.50 from ins_payment, other_member;


-- Row 779: 2026-03-01 Electricity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electricity', 80.00, 'GBP', 1, '2026-03-01', 80.00, '2026-03-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 80.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 40.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 40.00 from ins_payment, other_member;


-- Row 780: 2026-03-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2026-03-01', 24.00, '2026-03-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 781: 2026-03-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 26.00, 'GBP', 1, '2026-03-01', 26.00, '2026-03-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 26.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 13.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 13.00 from ins_payment, other_member;


-- Row 782: 2026-03-01 Hot Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot Water', 31.00, 'GBP', 1, '2026-03-01', 31.00, '2026-03-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 31.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 15.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 15.50 from ins_payment, other_member;


-- Row 783: 2026-03-01 Car break down  & travel insuranve
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Car break down  & travel insuranve', 13.00, 'GBP', 1, '2026-03-01', 13.00, '2026-03-01', 'transport', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 13.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 6.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 6.50 from ins_payment, other_member;


-- Row 784: 2026-03-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 33.00, 'GBP', 1, '2026-03-04', 33.00, '2026-03-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 33.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 16.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 16.50 from ins_payment, other_member;


-- Row 785: 2026-03-08 Service chrge and ground rent
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Service chrge and ground rent', 598.81, 'GBP', 1, '2026-03-08', 598.81, '2026-03-08', 'mortgage_rent', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 598.81 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 299.40 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 299.41 from ins_payment, other_member;


-- Row 786: 2026-03-08 Wash box
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Wash box', 80.00, 'GBP', 1, '2026-03-08', 80.00, '2026-03-08', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 80.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 40.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 40.00 from ins_payment, other_member;


-- Row 787: 2026-03-08 Louise B. paid Ben S.
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Louise B. paid Ben S.', 529.81, 'GBP', 1, '2026-03-08', 529.81, '2026-03-08', 'settlements', null, 'settlement', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 529.81 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, other_member.user_id, 529.81 from ins_payment, other_member;


-- Row 788: 2026-03-27 Council tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council tax', 179.00, 'GBP', 1, '2026-03-27', 179.00, '2026-03-27', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 179.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 89.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 89.50 from ins_payment, other_member;


-- Row 789: 2026-03-29 Barbados!
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Barbados!', 2000.00, 'GBP', 1, '2026-03-29', 2000.00, '2026-03-29', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 2000.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 1000.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 1000.00 from ins_payment, other_member;


-- Row 790: 2026-03-29 BMW car insurance
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'BMW car insurance', 200.00, 'GBP', 1, '2026-03-29', 200.00, '2026-03-29', 'insurance', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 200.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 100.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 100.00 from ins_payment, other_member;


-- Row 791: 2026-03-29 Louise B. paid Ben S.
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Louise B. paid Ben S.', 1989.50, 'GBP', 1, '2026-03-29', 1989.50, '2026-03-29', 'settlements', null, 'settlement', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 1989.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, other_member.user_id, 1989.50 from ins_payment, other_member;


-- Row 792: 2026-04-01 Electricity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electricity', 80.00, 'GBP', 1, '2026-04-01', 80.00, '2026-04-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 80.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 40.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 40.00 from ins_payment, other_member;


-- Row 793: 2026-04-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2026-04-01', 24.00, '2026-04-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 794: 2026-04-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 26.00, 'GBP', 1, '2026-04-01', 26.00, '2026-04-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 26.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 13.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 13.00 from ins_payment, other_member;


-- Row 795: 2026-04-01 Hot Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot Water', 31.00, 'GBP', 1, '2026-04-01', 31.00, '2026-04-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 31.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 15.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 15.50 from ins_payment, other_member;


-- Row 796: 2026-04-01 Car break down  & travel insuranve
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Car break down  & travel insuranve', 13.00, 'GBP', 1, '2026-04-01', 13.00, '2026-04-01', 'transport', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 13.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 6.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 6.50 from ins_payment, other_member;


-- Row 797: 2026-04-02 BMW car tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'BMW car tax', 620.00, 'GBP', 1, '2026-04-02', 620.00, '2026-04-02', 'transport', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 620.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 310.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 310.00 from ins_payment, other_member;


-- Row 798: 2026-04-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 33.00, 'GBP', 1, '2026-04-04', 33.00, '2026-04-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 33.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 16.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 16.50 from ins_payment, other_member;


-- Row 799: 2026-04-18 Mortgage lump sum
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Mortgage lump sum', 2000.00, 'GBP', 1, '2026-04-18', 2000.00, '2026-04-18', 'mortgage_rent', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 2000.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 1000.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 1000.00 from ins_payment, other_member;


-- Row 800: 2026-04-27 Council tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council tax', 179.00, 'GBP', 1, '2026-04-27', 179.00, '2026-04-27', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 179.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 89.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 89.50 from ins_payment, other_member;


-- Row 801: 2026-05-01 Electricity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electricity', 80.00, 'GBP', 1, '2026-05-01', 80.00, '2026-05-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 80.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 40.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 40.00 from ins_payment, other_member;


-- Row 802: 2026-05-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2026-05-01', 24.00, '2026-05-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 803: 2026-05-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 26.00, 'GBP', 1, '2026-05-01', 26.00, '2026-05-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 26.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 13.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 13.00 from ins_payment, other_member;


-- Row 804: 2026-05-01 Hot Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot Water', 31.00, 'GBP', 1, '2026-05-01', 31.00, '2026-05-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 31.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 15.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 15.50 from ins_payment, other_member;


-- Row 805: 2026-05-01 Car break down  & travel insuranve
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Car break down  & travel insuranve', 13.00, 'GBP', 1, '2026-05-01', 13.00, '2026-05-01', 'transport', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 13.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 6.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 6.50 from ins_payment, other_member;


-- Row 806: 2026-05-02 Louise B. paid Ben S.
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Louise B. paid Ben S.', 2000.00, 'GBP', 1, '2026-05-02', 2000.00, '2026-05-02', 'settlements', null, 'settlement', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 2000.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, other_member.user_id, 2000.00 from ins_payment, other_member;


-- Row 807: 2026-05-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 33.00, 'GBP', 1, '2026-05-04', 33.00, '2026-05-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 33.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 16.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 16.50 from ins_payment, other_member;


-- Row 808: 2026-05-11 Car tax refund
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Car tax refund', 65.00, 'GBP', 1, '2026-05-11', 65.00, '2026-05-11', 'transport', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 65.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 32.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 32.50 from ins_payment, other_member;

commit;

commit;
