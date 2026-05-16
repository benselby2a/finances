begin;

-- Row 121: 2019-12-29 Council Tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council Tax', 132.00, 'GBP', 1, '2019-12-29', 132.00, '2019-12-29', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 132.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 66.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 66.00 from ins_payment, other_member;


-- Row 122: 2020-01-01 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 58.00, 'GBP', 1, '2020-01-01', 58.00, '2020-01-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 58.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 29.00 from ins_payment, other_member;


-- Row 123: 2020-01-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2020-01-01', 24.00, '2020-01-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 124: 2020-01-01 Florence flights and hotel
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Florence flights and hotel', 130.00, 'GBP', 1, '2020-01-01', 130.00, '2020-01-01', 'travel', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 130.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 65.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 65.00 from ins_payment, other_member;


-- Row 125: 2020-01-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 29.00, 'GBP', 1, '2020-01-04', 29.00, '2020-01-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 14.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 14.50 from ins_payment, other_member;


-- Row 126: 2020-01-19 Contents insurance
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Contents insurance', 57.00, 'GBP', 1, '2020-01-19', 57.00, '2020-01-19', 'insurance', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 57.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 28.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 28.50 from ins_payment, other_member;


-- Row 127: 2020-01-19 Oban flights
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Oban flights', 228.00, 'GBP', 1, '2020-01-19', 228.00, '2020-01-19', 'travel', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 228.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 114.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 114.00 from ins_payment, other_member;


-- Row 128: 2020-01-19 Service Charge
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Service Charge', 2073.84, 'GBP', 1, '2020-01-19', 2073.84, '2020-01-19', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 2073.84 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 1036.92 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 1036.92 from ins_payment, other_member;


-- Row 129: 2020-01-29 Council Tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council Tax', 132.00, 'GBP', 1, '2020-01-29', 132.00, '2020-01-29', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 132.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 66.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 66.00 from ins_payment, other_member;


-- Row 130: 2020-02-01 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 58.00, 'GBP', 1, '2020-02-01', 58.00, '2020-02-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 58.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 29.00 from ins_payment, other_member;


-- Row 131: 2020-02-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2020-02-01', 24.00, '2020-02-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 132: 2020-02-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 35.00, 'GBP', 1, '2020-02-04', 35.00, '2020-02-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 35.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 17.50 from ins_payment, other_member;


-- Row 133: 2020-02-08 Didcot hotel
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Didcot hotel', 80.00, 'GBP', 1, '2020-02-08', 80.00, '2020-02-08', 'travel', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 80.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 40.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 40.00 from ins_payment, other_member;


-- Row 134: 2020-02-29 Louise B. paid Ben S.
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Louise B. paid Ben S.', 500.00, 'GBP', 1, '2020-02-29', 500.00, '2020-02-29', 'settlements', null, 'settlement', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 500.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, other_member.user_id, 500.00 from ins_payment, other_member;


-- Row 135: 2020-03-01 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 58.00, 'GBP', 1, '2020-03-01', 58.00, '2020-03-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 58.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 29.00 from ins_payment, other_member;


-- Row 136: 2020-03-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2020-03-01', 24.00, '2020-03-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 137: 2020-03-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 35.00, 'GBP', 1, '2020-03-04', 35.00, '2020-03-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 35.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 17.50 from ins_payment, other_member;


-- Row 138: 2020-03-08 America flights
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'America flights', 3200.00, 'GBP', 1, '2020-03-08', 3200.00, '2020-03-08', 'travel', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 3200.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 1600.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 1600.00 from ins_payment, other_member;


-- Row 139: 2020-03-17 Manatee computer
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Manatee computer', 300.00, 'GBP', 1, '2020-03-17', 300.00, '2020-03-17', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 300.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 150.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 150.00 from ins_payment, other_member;


-- Row 140: 2020-04-01 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 58.00, 'GBP', 1, '2020-04-01', 58.00, '2020-04-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 58.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 29.00 from ins_payment, other_member;


-- Row 141: 2020-04-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2020-04-01', 24.00, '2020-04-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 142: 2020-04-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 35.00, 'GBP', 1, '2020-04-04', 35.00, '2020-04-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 35.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 17.50 from ins_payment, other_member;


-- Row 143: 2020-04-10 Horse racing
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Horse racing', 40.00, 'GBP', 1, '2020-04-10', 40.00, '2020-04-10', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 40.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 20.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 20.00 from ins_payment, other_member;


-- Row 144: 2020-04-13 Horse race winnings
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Horse race winnings', 22.00, 'GBP', 1, '2020-04-13', 22.00, '2020-04-13', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 22.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 11.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 11.00 from ins_payment, other_member;


-- Row 145: 2020-04-23 Ben Shoes
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Ben Shoes', 45.00, 'GBP', 1, '2020-04-23', 45.00, '2020-04-23', 'shopping', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 45.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 22.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 22.50 from ins_payment, other_member;


-- Row 146: 2020-04-26 Louise B. paid Ben S.
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Louise B. paid Ben S.', 500.00, 'GBP', 1, '2020-04-26', 500.00, '2020-04-26', 'settlements', null, 'settlement', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 500.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, other_member.user_id, 500.00 from ins_payment, other_member;


-- Row 147: 2020-04-26 Horse racing
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Horse racing', 10.00, 'GBP', 1, '2020-04-26', 10.00, '2020-04-26', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 10.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 5.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 5.00 from ins_payment, other_member;


-- Row 148: 2020-04-29 Council Tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council Tax', 132.00, 'GBP', 1, '2020-04-29', 132.00, '2020-04-29', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 132.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 66.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 66.00 from ins_payment, other_member;


-- Row 149: 2020-05-01 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 58.00, 'GBP', 1, '2020-05-01', 58.00, '2020-05-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 58.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 29.00 from ins_payment, other_member;


-- Row 150: 2020-05-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2020-05-01', 24.00, '2020-05-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 151: 2020-05-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 35.00, 'GBP', 1, '2020-05-04', 35.00, '2020-05-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 35.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 17.50 from ins_payment, other_member;


-- Row 152: 2020-05-29 Council Tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council Tax', 132.00, 'GBP', 1, '2020-05-29', 132.00, '2020-05-29', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 132.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 66.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 66.00 from ins_payment, other_member;


-- Row 153: 2020-05-30 Louise B. paid Ben S.
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Louise B. paid Ben S.', 500.00, 'GBP', 1, '2020-05-30', 500.00, '2020-05-30', 'settlements', null, 'settlement', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 500.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, other_member.user_id, 500.00 from ins_payment, other_member;


-- Row 154: 2020-06-01 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 58.00, 'GBP', 1, '2020-06-01', 58.00, '2020-06-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 58.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 29.00 from ins_payment, other_member;


-- Row 155: 2020-06-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2020-06-01', 24.00, '2020-06-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 156: 2020-06-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 35.00, 'GBP', 1, '2020-06-04', 35.00, '2020-06-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 35.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 17.50 from ins_payment, other_member;


-- Row 157: 2020-06-29 Council Tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council Tax', 132.00, 'GBP', 1, '2020-06-29', 132.00, '2020-06-29', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 132.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 66.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 66.00 from ins_payment, other_member;


-- Row 158: 2020-07-01 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 58.00, 'GBP', 1, '2020-07-01', 58.00, '2020-07-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 58.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 29.00 from ins_payment, other_member;


-- Row 159: 2020-07-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2020-07-01', 24.00, '2020-07-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 160: 2020-07-03 Louise B. paid Ben S.
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Louise B. paid Ben S.', 400.00, 'GBP', 1, '2020-07-03', 400.00, '2020-07-03', 'settlements', null, 'settlement', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 400.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, other_member.user_id, 400.00 from ins_payment, other_member;


-- Row 161: 2020-07-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 35.00, 'GBP', 1, '2020-07-04', 35.00, '2020-07-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 35.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 17.50 from ins_payment, other_member;


-- Row 162: 2020-07-11 Service charge
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Service charge', 2423.28, 'GBP', 1, '2020-07-11', 2423.28, '2020-07-11', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 2423.28 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 1211.64 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 1211.64 from ins_payment, other_member;


-- Row 163: 2020-07-14 National Trust Subscription
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'National Trust Subscription', 120.00, 'GBP', 1, '2020-07-14', 120.00, '2020-07-14', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 120.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 60.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 60.00 from ins_payment, other_member;


-- Row 164: 2020-07-14 Louise B. paid Ben S.
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Louise B. paid Ben S.', 700.00, 'GBP', 1, '2020-07-14', 700.00, '2020-07-14', 'settlements', null, 'settlement', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 700.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, other_member.user_id, 700.00 from ins_payment, other_member;


-- Row 165: 2020-07-29 Council Tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council Tax', 132.00, 'GBP', 1, '2020-07-29', 132.00, '2020-07-29', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 132.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 66.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 66.00 from ins_payment, other_member;


-- Row 166: 2020-08-01 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 58.00, 'GBP', 1, '2020-08-01', 58.00, '2020-08-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 58.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 29.00 from ins_payment, other_member;


-- Row 167: 2020-08-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2020-08-01', 24.00, '2020-08-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 168: 2020-08-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 17.50, 'GBP', 1, '2020-08-01', 17.50, '2020-08-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 8.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 8.75 from ins_payment, other_member;


-- Row 169: 2020-08-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 35.00, 'GBP', 1, '2020-08-04', 35.00, '2020-08-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 35.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 17.50 from ins_payment, other_member;


-- Row 170: 2020-08-29 Council Tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council Tax', 132.00, 'GBP', 1, '2020-08-29', 132.00, '2020-08-29', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 132.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 66.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 66.00 from ins_payment, other_member;


-- Row 171: 2020-09-01 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 58.00, 'GBP', 1, '2020-09-01', 58.00, '2020-09-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 58.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 29.00 from ins_payment, other_member;


-- Row 172: 2020-09-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2020-09-01', 24.00, '2020-09-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 173: 2020-09-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 17.50, 'GBP', 1, '2020-09-01', 17.50, '2020-09-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 8.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 8.75 from ins_payment, other_member;


-- Row 174: 2020-09-03 Louise B. paid Ben S.
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Louise B. paid Ben S.', 200.00, 'GBP', 1, '2020-09-03', 200.00, '2020-09-03', 'settlements', null, 'settlement', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 200.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, other_member.user_id, 200.00 from ins_payment, other_member;


-- Row 175: 2020-09-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 35.00, 'GBP', 1, '2020-09-04', 35.00, '2020-09-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 35.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 17.50 from ins_payment, other_member;


-- Row 176: 2020-09-28 Car
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Car', 3765.00, 'GBP', 1, '2020-09-28', 3765.00, '2020-09-28', 'transport', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 3765.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 1882.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 1882.50 from ins_payment, other_member;


-- Row 177: 2020-09-29 Council Tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council Tax', 132.00, 'GBP', 1, '2020-09-29', 132.00, '2020-09-29', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 132.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 66.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 66.00 from ins_payment, other_member;


-- Row 178: 2020-09-30 Car tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Car tax', 150.00, 'GBP', 1, '2020-09-30', 150.00, '2020-09-30', 'transport', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 150.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 75.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 75.00 from ins_payment, other_member;


-- Row 179: 2020-09-30 Car insurance
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Car insurance', 324.00, 'GBP', 1, '2020-09-30', 324.00, '2020-09-30', 'insurance', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 324.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 162.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 162.00 from ins_payment, other_member;


-- Row 180: 2020-10-01 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 58.00, 'GBP', 1, '2020-10-01', 58.00, '2020-10-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 58.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 29.00 from ins_payment, other_member;


-- Row 181: 2020-10-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2020-10-01', 24.00, '2020-10-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 182: 2020-10-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 17.50, 'GBP', 1, '2020-10-01', 17.50, '2020-10-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 8.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 8.75 from ins_payment, other_member;


-- Row 183: 2020-10-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 35.00, 'GBP', 1, '2020-10-04', 35.00, '2020-10-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 35.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 17.50 from ins_payment, other_member;


-- Row 184: 2020-10-29 Council Tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council Tax', 132.00, 'GBP', 1, '2020-10-29', 132.00, '2020-10-29', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 132.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 66.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 66.00 from ins_payment, other_member;


-- Row 185: 2020-11-01 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 58.00, 'GBP', 1, '2020-11-01', 58.00, '2020-11-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 58.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 29.00 from ins_payment, other_member;


-- Row 186: 2020-11-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2020-11-01', 24.00, '2020-11-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 187: 2020-11-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 17.50, 'GBP', 1, '2020-11-01', 17.50, '2020-11-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 8.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 8.75 from ins_payment, other_member;


-- Row 188: 2020-11-01 Louise B. paid Ben S.
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Louise B. paid Ben S.', 2000.00, 'GBP', 1, '2020-11-01', 2000.00, '2020-11-01', 'settlements', null, 'settlement', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 2000.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, other_member.user_id, 2000.00 from ins_payment, other_member;


-- Row 189: 2020-11-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 35.00, 'GBP', 1, '2020-11-04', 35.00, '2020-11-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 35.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 17.50 from ins_payment, other_member;


-- Row 190: 2020-11-29 Council Tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council Tax', 132.00, 'GBP', 1, '2020-11-29', 132.00, '2020-11-29', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 132.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 66.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 66.00 from ins_payment, other_member;


-- Row 191: 2020-11-30 Ground Rent 2021
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Ground Rent 2021', 400.00, 'GBP', 1, '2020-11-30', 400.00, '2020-11-30', 'mortgage_rent', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 400.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 200.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 200.00 from ins_payment, other_member;


-- Row 192: 2020-12-01 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 58.00, 'GBP', 1, '2020-12-01', 58.00, '2020-12-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 58.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 29.00 from ins_payment, other_member;


-- Row 193: 2020-12-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2020-12-01', 24.00, '2020-12-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 194: 2020-12-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 17.50, 'GBP', 1, '2020-12-01', 17.50, '2020-12-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 8.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 8.75 from ins_payment, other_member;


-- Row 195: 2020-12-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 35.00, 'GBP', 1, '2020-12-04', 35.00, '2020-12-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 35.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 17.50 from ins_payment, other_member;


-- Row 196: 2020-12-17 TV Licence
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'TV Licence', 157.50, 'GBP', 1, '2020-12-17', 157.50, '2020-12-17', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 157.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 78.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 78.75 from ins_payment, other_member;


-- Row 197: 2020-12-29 Council Tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council Tax', 132.00, 'GBP', 1, '2020-12-29', 132.00, '2020-12-29', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 132.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 66.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 66.00 from ins_payment, other_member;


-- Row 198: 2021-01-01 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 58.00, 'GBP', 1, '2021-01-01', 58.00, '2021-01-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 58.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 29.00 from ins_payment, other_member;


-- Row 199: 2021-01-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2021-01-01', 24.00, '2021-01-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 200: 2021-01-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 17.50, 'GBP', 1, '2021-01-01', 17.50, '2021-01-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 8.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 8.75 from ins_payment, other_member;


-- Row 201: 2021-01-02 Louise B. paid Ben S.
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Louise B. paid Ben S.', 500.00, 'GBP', 1, '2021-01-02', 500.00, '2021-01-02', 'settlements', null, 'settlement', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 500.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, other_member.user_id, 500.00 from ins_payment, other_member;


-- Row 202: 2021-01-04 Ink cartridges
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Ink cartridges', 36.99, 'GBP', 1, '2021-01-04', 36.99, '2021-01-04', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 36.99 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 18.49 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 18.50 from ins_payment, other_member;


-- Row 203: 2021-01-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 29.00, 'GBP', 1, '2021-01-04', 29.00, '2021-01-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 14.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 14.50 from ins_payment, other_member;


-- Row 204: 2021-01-08 Tracing paper
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Tracing paper', 7.99, 'GBP', 1, '2021-01-08', 7.99, '2021-01-08', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 7.99 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 3.99 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 4.00 from ins_payment, other_member;


-- Row 205: 2021-01-16 Contents insurance
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Contents insurance', 57.55, 'GBP', 1, '2021-01-16', 57.55, '2021-01-16', 'insurance', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 57.55 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 28.77 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 28.78 from ins_payment, other_member;


-- Row 206: 2021-01-20 Hot Water Bill
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot Water Bill', 327.39, 'GBP', 1, '2021-01-20', 327.39, '2021-01-20', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 327.39 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 163.69 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 163.70 from ins_payment, other_member;


-- Row 207: 2021-01-21 Manatee Debt Amnesty
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Manatee Debt Amnesty', 1000.00, 'GBP', 1, '2021-01-21', 1000.00, '2021-01-21', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 1000.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 500.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 500.00 from ins_payment, other_member;


-- Row 208: 2021-01-23 Six nations guesser
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Six nations guesser', 15.00, 'GBP', 1, '2021-01-23', 15.00, '2021-01-23', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 15.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 7.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 7.50 from ins_payment, other_member;


-- Row 209: 2021-01-29 Council Tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council Tax', 132.00, 'GBP', 1, '2021-01-29', 132.00, '2021-01-29', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 132.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 66.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 66.00 from ins_payment, other_member;


-- Row 210: 2021-01-31 Service charge
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Service charge', 702.00, 'GBP', 1, '2021-01-31', 702.00, '2021-01-31', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 702.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 351.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 351.00 from ins_payment, other_member;


-- Row 211: 2021-01-31 Louise B. paid Ben S.
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Louise B. paid Ben S.', 850.00, 'GBP', 1, '2021-01-31', 850.00, '2021-01-31', 'settlements', null, 'settlement', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 850.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, other_member.user_id, 850.00 from ins_payment, other_member;


-- Row 212: 2021-02-01 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 58.00, 'GBP', 1, '2021-02-01', 58.00, '2021-02-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 58.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 29.00 from ins_payment, other_member;


-- Row 213: 2021-02-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2021-02-01', 24.00, '2021-02-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 214: 2021-02-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 17.50, 'GBP', 1, '2021-02-01', 17.50, '2021-02-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 8.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 8.75 from ins_payment, other_member;


-- Row 215: 2021-02-01 Hot Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot Water', 30.00, 'GBP', 1, '2021-02-01', 30.00, '2021-02-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 30.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 15.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 15.00 from ins_payment, other_member;


-- Row 216: 2021-02-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 29.00, 'GBP', 1, '2021-02-04', 29.00, '2021-02-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 14.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 14.50 from ins_payment, other_member;


-- Row 217: 2021-03-01 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 58.00, 'GBP', 1, '2021-03-01', 58.00, '2021-03-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 58.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 29.00 from ins_payment, other_member;


-- Row 218: 2021-03-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2021-03-01', 24.00, '2021-03-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 219: 2021-03-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 17.50, 'GBP', 1, '2021-03-01', 17.50, '2021-03-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 8.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 8.75 from ins_payment, other_member;


-- Row 220: 2021-03-01 Hot Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot Water', 30.00, 'GBP', 1, '2021-03-01', 30.00, '2021-03-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 30.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 15.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 15.00 from ins_payment, other_member;


-- Row 221: 2021-03-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 29.00, 'GBP', 1, '2021-03-04', 29.00, '2021-03-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 14.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 14.50 from ins_payment, other_member;


-- Row 222: 2021-03-14 Cotswold holiday
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Cotswold holiday', 528.60, 'GBP', 1, '2021-03-14', 528.60, '2021-03-14', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 528.60 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 264.30 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 264.30 from ins_payment, other_member;


-- Row 223: 2021-04-01 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 58.00, 'GBP', 1, '2021-04-01', 58.00, '2021-04-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 58.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 29.00 from ins_payment, other_member;


-- Row 224: 2021-04-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2021-04-01', 24.00, '2021-04-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 225: 2021-04-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 17.50, 'GBP', 1, '2021-04-01', 17.50, '2021-04-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 8.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 8.75 from ins_payment, other_member;


-- Row 226: 2021-04-01 Hot Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot Water', 30.00, 'GBP', 1, '2021-04-01', 30.00, '2021-04-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 30.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 15.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 15.00 from ins_payment, other_member;


-- Row 227: 2021-04-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 29.00, 'GBP', 1, '2021-04-04', 29.00, '2021-04-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 14.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 14.50 from ins_payment, other_member;


-- Row 228: 2021-04-14 Louise B. paid Ben S.
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Louise B. paid Ben S.', 100.00, 'GBP', 1, '2021-04-14', 100.00, '2021-04-14', 'settlements', null, 'settlement', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 100.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, other_member.user_id, 100.00 from ins_payment, other_member;


-- Row 229: 2021-04-14 Sissinghurst B&B
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Sissinghurst B&B', 410.00, 'GBP', 1, '2021-04-14', 410.00, '2021-04-14', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 410.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 205.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 205.00 from ins_payment, other_member;


-- Row 230: 2021-04-14 White company
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'White company', 54.00, 'GBP', 1, '2021-04-14', 54.00, '2021-04-14', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 54.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 27.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 27.00 from ins_payment, other_member;


-- Row 231: 2021-04-17 Peat Spade Inn
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Peat Spade Inn', 149.00, 'GBP', 1, '2021-04-17', 149.00, '2021-04-17', 'travel', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 149.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 74.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 74.50 from ins_payment, other_member;


-- Row 232: 2021-04-18 Travelodge
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Travelodge', 53.00, 'GBP', 1, '2021-04-18', 53.00, '2021-04-18', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 53.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 26.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 26.50 from ins_payment, other_member;


-- Row 233: 2021-04-27 Council Tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council Tax', 121.00, 'GBP', 1, '2021-04-27', 121.00, '2021-04-27', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 121.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 60.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 60.50 from ins_payment, other_member;


-- Row 234: 2021-05-01 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 58.00, 'GBP', 1, '2021-05-01', 58.00, '2021-05-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 58.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 29.00 from ins_payment, other_member;


-- Row 235: 2021-05-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2021-05-01', 24.00, '2021-05-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 236: 2021-05-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 17.50, 'GBP', 1, '2021-05-01', 17.50, '2021-05-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 8.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 8.75 from ins_payment, other_member;


-- Row 237: 2021-05-01 Hot Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot Water', 30.00, 'GBP', 1, '2021-05-01', 30.00, '2021-05-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 30.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 15.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 15.00 from ins_payment, other_member;


-- Row 238: 2021-05-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 29.00, 'GBP', 1, '2021-05-04', 29.00, '2021-05-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 14.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 14.50 from ins_payment, other_member;


-- Row 239: 2021-05-08 Premier Inn
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Premier Inn', 30.00, 'GBP', 1, '2021-05-08', 30.00, '2021-05-08', 'travel', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 30.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 15.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 15.00 from ins_payment, other_member;


-- Row 240: 2021-05-08 East wall hotel
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'East wall hotel', 338.00, 'GBP', 1, '2021-05-08', 338.00, '2021-05-08', 'travel', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 338.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 169.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 169.00 from ins_payment, other_member;



commit;
