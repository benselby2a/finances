begin;

-- Row 361: 2022-08-01 Goring drinks
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Goring drinks', 140.00, 'GBP', 1, '2022-08-01', 140.00, '2022-08-01', 'shopping', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 140.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 70.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 70.00 from ins_payment, other_member;


-- Row 362: 2022-08-01 Hot Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot Water', 30.00, 'GBP', 1, '2022-08-01', 30.00, '2022-08-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 30.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 15.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 15.00 from ins_payment, other_member;


-- Row 363: 2022-08-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 25.00, 'GBP', 1, '2022-08-04', 25.00, '2022-08-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 25.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.50 from ins_payment, other_member;


-- Row 364: 2022-08-22 Car tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Car tax', 165.00, 'GBP', 1, '2022-08-22', 165.00, '2022-08-22', 'transport', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 165.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 82.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 82.50 from ins_payment, other_member;


-- Row 365: 2022-08-27 Council tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council tax', 152.00, 'GBP', 1, '2022-08-27', 152.00, '2022-08-27', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 152.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 76.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 76.00 from ins_payment, other_member;


-- Row 366: 2022-08-29 Races champagne
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Races champagne', 65.00, 'GBP', 1, '2022-08-29', 65.00, '2022-08-29', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 65.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 32.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 32.50 from ins_payment, other_member;


-- Row 367: 2022-08-29 Ben S. paid Louise B.
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Ben S. paid Louise B.', 181.75, 'GBP', 1, '2022-08-29', 181.75, '2022-08-29', 'settlements', null, 'settlement', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 181.75 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, other_member.user_id, 181.75 from ins_payment, other_member;


-- Row 368: 2022-09-01 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 81.00, 'GBP', 1, '2022-09-01', 81.00, '2022-09-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 81.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 40.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 40.50 from ins_payment, other_member;


-- Row 369: 2022-09-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2022-09-01', 24.00, '2022-09-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 370: 2022-09-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 17.50, 'GBP', 1, '2022-09-01', 17.50, '2022-09-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 8.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 8.75 from ins_payment, other_member;


-- Row 371: 2022-09-01 Hot Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot Water', 30.00, 'GBP', 1, '2022-09-01', 30.00, '2022-09-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 30.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 15.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 15.00 from ins_payment, other_member;


-- Row 372: 2022-09-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 25.00, 'GBP', 1, '2022-09-04', 25.00, '2022-09-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 25.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.50 from ins_payment, other_member;


-- Row 373: 2022-09-05 Art course
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Art course', 350.00, 'GBP', 1, '2022-09-05', 350.00, '2022-09-05', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 350.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 175.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 175.00 from ins_payment, other_member;


-- Row 374: 2022-09-05 Ben S. paid Louise B.
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Ben S. paid Louise B.', 396.25, 'GBP', 1, '2022-09-05', 396.25, '2022-09-05', 'settlements', null, 'settlement', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 396.25 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, other_member.user_id, 396.25 from ins_payment, other_member;


-- Row 375: 2022-09-09 Car MOT & Service
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Car MOT & Service', 150.00, 'GBP', 1, '2022-09-09', 150.00, '2022-09-09', 'transport', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 150.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 75.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 75.00 from ins_payment, other_member;


-- Row 376: 2022-09-14 Concert ticket - Show of Hands
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Concert ticket - Show of Hands', 65.00, 'GBP', 1, '2022-09-14', 65.00, '2022-09-14', 'subscriptions', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 65.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 32.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 32.50 from ins_payment, other_member;


-- Row 377: 2022-09-19 Norton Park Hotle
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Norton Park Hotle', 155.00, 'GBP', 1, '2022-09-19', 155.00, '2022-09-19', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 155.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 77.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 77.50 from ins_payment, other_member;


-- Row 378: 2022-09-24 Car insurance
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Car insurance', 360.00, 'GBP', 1, '2022-09-24', 360.00, '2022-09-24', 'insurance', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 360.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 180.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 180.00 from ins_payment, other_member;


-- Row 379: 2022-09-27 Council tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council tax', 152.00, 'GBP', 1, '2022-09-27', 152.00, '2022-09-27', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 152.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 76.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 76.00 from ins_payment, other_member;


-- Row 380: 2022-10-01 Electricity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electricity', 50.00, 'GBP', 1, '2022-10-01', 50.00, '2022-10-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 50.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 25.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 25.00 from ins_payment, other_member;


-- Row 381: 2022-10-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2022-10-01', 24.00, '2022-10-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 382: 2022-10-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 17.50, 'GBP', 1, '2022-10-01', 17.50, '2022-10-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 8.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 8.75 from ins_payment, other_member;


-- Row 383: 2022-10-01 Hot Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot Water', 50.00, 'GBP', 1, '2022-10-01', 50.00, '2022-10-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 50.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 25.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 25.00 from ins_payment, other_member;


-- Row 384: 2022-10-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 25.00, 'GBP', 1, '2022-10-04', 25.00, '2022-10-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 25.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.50 from ins_payment, other_member;


-- Row 385: 2022-10-10 Civil cermony invited
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Civil cermony invited', 30.00, 'GBP', 1, '2022-10-10', 30.00, '2022-10-10', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 30.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 15.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 15.00 from ins_payment, other_member;


-- Row 386: 2022-10-20 Holiday spending
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Holiday spending', 500.00, 'GBP', 1, '2022-10-20', 500.00, '2022-10-20', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 500.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 250.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 250.00 from ins_payment, other_member;


-- Row 387: 2022-10-22 Christmas lunch
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Christmas lunch', 48.30, 'GBP', 1, '2022-10-22', 48.30, '2022-10-22', 'dining', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 48.30 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 24.15 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 24.15 from ins_payment, other_member;


-- Row 388: 2022-10-27 Council tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council tax', 152.00, 'GBP', 1, '2022-10-27', 152.00, '2022-10-27', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 152.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 76.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 76.00 from ins_payment, other_member;


-- Row 389: 2022-11-01 Electricity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electricity', 50.00, 'GBP', 1, '2022-11-01', 50.00, '2022-11-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 50.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 25.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 25.00 from ins_payment, other_member;


-- Row 390: 2022-11-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2022-11-01', 24.00, '2022-11-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 391: 2022-11-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 17.50, 'GBP', 1, '2022-11-01', 17.50, '2022-11-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 8.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 8.75 from ins_payment, other_member;


-- Row 392: 2022-11-01 Hot Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot Water', 50.00, 'GBP', 1, '2022-11-01', 50.00, '2022-11-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 50.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 25.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 25.00 from ins_payment, other_member;


-- Row 393: 2022-11-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 25.00, 'GBP', 1, '2022-11-04', 25.00, '2022-11-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 25.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.50 from ins_payment, other_member;


-- Row 394: 2022-11-12 Ground rent
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Ground rent', 400.00, 'GBP', 1, '2022-11-12', 400.00, '2022-11-12', 'mortgage_rent', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 400.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 200.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 200.00 from ins_payment, other_member;


-- Row 395: 2022-11-22 Food shop
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Food shop', 95.00, 'GBP', 1, '2022-11-22', 95.00, '2022-11-22', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 95.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 47.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 47.50 from ins_payment, other_member;


-- Row 396: 2022-11-27 Council tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council tax', 152.00, 'GBP', 1, '2022-11-27', 152.00, '2022-11-27', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 152.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 76.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 76.00 from ins_payment, other_member;


-- Row 397: 2022-12-01 Electricity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electricity', 50.00, 'GBP', 1, '2022-12-01', 50.00, '2022-12-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 50.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 25.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 25.00 from ins_payment, other_member;


-- Row 398: 2022-12-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2022-12-01', 24.00, '2022-12-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 399: 2022-12-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 17.50, 'GBP', 1, '2022-12-01', 17.50, '2022-12-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 8.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 8.75 from ins_payment, other_member;


-- Row 400: 2022-12-01 Hot Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot Water', 50.00, 'GBP', 1, '2022-12-01', 50.00, '2022-12-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 50.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 25.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 25.00 from ins_payment, other_member;


-- Row 401: 2022-12-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 25.00, 'GBP', 1, '2022-12-04', 25.00, '2022-12-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 25.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.50 from ins_payment, other_member;


-- Row 402: 2022-12-05 Charlie present contribution
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Charlie present contribution', 10.00, 'GBP', 1, '2022-12-05', 10.00, '2022-12-05', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 10.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 5.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 5.00 from ins_payment, other_member;


-- Row 403: 2022-12-17 Trev present
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Trev present', 40.00, 'GBP', 1, '2022-12-17', 40.00, '2022-12-17', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 40.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 20.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 20.00 from ins_payment, other_member;


-- Row 404: 2022-12-18 TV licence
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'TV licence', 159.00, 'GBP', 1, '2022-12-18', 159.00, '2022-12-18', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 159.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 79.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 79.50 from ins_payment, other_member;


-- Row 405: 2022-12-18 Flowers civil ceremony deposit
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Flowers civil ceremony deposit', 300.00, 'GBP', 1, '2022-12-18', 300.00, '2022-12-18', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 300.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 150.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 150.00 from ins_payment, other_member;


-- Row 406: 2022-12-27 Council tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council tax', 152.00, 'GBP', 1, '2022-12-27', 152.00, '2022-12-27', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 152.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 76.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 76.00 from ins_payment, other_member;


-- Row 407: 2023-01-01 Electricity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electricity', 50.00, 'GBP', 1, '2023-01-01', 50.00, '2023-01-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 50.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 25.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 25.00 from ins_payment, other_member;


-- Row 408: 2023-01-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2023-01-01', 24.00, '2023-01-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 409: 2023-01-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 17.50, 'GBP', 1, '2023-01-01', 17.50, '2023-01-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 8.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 8.75 from ins_payment, other_member;


-- Row 410: 2023-01-01 Hot Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot Water', 50.00, 'GBP', 1, '2023-01-01', 50.00, '2023-01-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 50.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 25.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 25.00 from ins_payment, other_member;


-- Row 411: 2023-01-02 Turin
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Turin', 100.00, 'GBP', 1, '2023-01-02', 100.00, '2023-01-02', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 100.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 50.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 50.00 from ins_payment, other_member;


-- Row 412: 2023-01-02 Travel insurnace
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Travel insurnace', 149.00, 'GBP', 1, '2023-01-02', 149.00, '2023-01-02', 'travel', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 149.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 74.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 74.50 from ins_payment, other_member;


-- Row 413: 2023-01-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 25.00, 'GBP', 1, '2023-01-04', 25.00, '2023-01-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 25.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.50 from ins_payment, other_member;


-- Row 414: 2023-01-07 Contents insurance
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Contents insurance', 51.00, 'GBP', 1, '2023-01-07', 51.00, '2023-01-07', 'insurance', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 51.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 25.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 25.50 from ins_payment, other_member;


-- Row 415: 2023-01-07 Amsterdam
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Amsterdam', 200.00, 'GBP', 1, '2023-01-07', 200.00, '2023-01-07', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 200.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 100.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 100.00 from ins_payment, other_member;


-- Row 416: 2023-01-10 Photographer deposit
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Photographer deposit', 100.00, 'GBP', 1, '2023-01-10', 100.00, '2023-01-10', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 100.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 50.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 50.00 from ins_payment, other_member;


-- Row 417: 2023-01-20 Plane seats
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Plane seats', 200.00, 'GBP', 1, '2023-01-20', 200.00, '2023-01-20', 'travel', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 200.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 100.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 100.00 from ins_payment, other_member;


-- Row 418: 2023-01-22 Service charge
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Service charge', 736.00, 'GBP', 1, '2023-01-22', 736.00, '2023-01-22', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 736.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 368.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 368.00 from ins_payment, other_member;


-- Row 419: 2023-01-22 Louise B. paid Ben S.
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Louise B. paid Ben S.', 922.70, 'GBP', 1, '2023-01-22', 922.70, '2023-01-22', 'settlements', null, 'settlement', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 922.70 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, other_member.user_id, 922.70 from ins_payment, other_member;


-- Row 420: 2023-01-27 Council tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council tax', 152.00, 'GBP', 1, '2023-01-27', 152.00, '2023-01-27', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 152.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 76.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 76.00 from ins_payment, other_member;


-- Row 421: 2023-02-01 Electricity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electricity', 50.00, 'GBP', 1, '2023-02-01', 50.00, '2023-02-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 50.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 25.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 25.00 from ins_payment, other_member;


-- Row 422: 2023-02-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2023-02-01', 24.00, '2023-02-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 423: 2023-02-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 17.50, 'GBP', 1, '2023-02-01', 17.50, '2023-02-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 8.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 8.75 from ins_payment, other_member;


-- Row 424: 2023-02-01 Hot Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot Water', 50.00, 'GBP', 1, '2023-02-01', 50.00, '2023-02-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 50.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 25.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 25.00 from ins_payment, other_member;


-- Row 425: 2023-02-03 Greenwich park photo licence
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Greenwich park photo licence', 120.00, 'GBP', 1, '2023-02-03', 120.00, '2023-02-03', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 120.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 60.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 60.00 from ins_payment, other_member;


-- Row 426: 2023-02-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 25.00, 'GBP', 1, '2023-02-04', 25.00, '2023-02-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 25.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.50 from ins_payment, other_member;


-- Row 427: 2023-02-12 Drinks Bentleys
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Drinks Bentleys', 90.00, 'GBP', 1, '2023-02-12', 90.00, '2023-02-12', 'shopping', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 90.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 45.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 45.00 from ins_payment, other_member;


-- Row 428: 2023-02-12 Times subscripton
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Times subscripton', 6.50, 'GBP', 1, '2023-02-12', 6.50, '2023-02-12', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 6.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 3.25 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 3.25 from ins_payment, other_member;


-- Row 429: 2023-02-27 Council tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council tax', 152.00, 'GBP', 1, '2023-02-27', 152.00, '2023-02-27', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 152.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 76.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 76.00 from ins_payment, other_member;


-- Row 430: 2023-03-01 Electricity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electricity', 50.00, 'GBP', 1, '2023-03-01', 50.00, '2023-03-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 50.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 25.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 25.00 from ins_payment, other_member;


-- Row 431: 2023-03-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2023-03-01', 24.00, '2023-03-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 432: 2023-03-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 17.50, 'GBP', 1, '2023-03-01', 17.50, '2023-03-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 8.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 8.75 from ins_payment, other_member;


-- Row 433: 2023-03-01 Hot Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot Water', 50.00, 'GBP', 1, '2023-03-01', 50.00, '2023-03-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 50.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 25.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 25.00 from ins_payment, other_member;


-- Row 434: 2023-03-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 25.00, 'GBP', 1, '2023-03-04', 25.00, '2023-03-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 25.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.50 from ins_payment, other_member;


-- Row 435: 2023-03-12 Times subscripton
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Times subscripton', 6.50, 'GBP', 1, '2023-03-12', 6.50, '2023-03-12', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 6.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 3.25 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 3.25 from ins_payment, other_member;


-- Row 436: 2023-03-27 Council tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council tax', 152.00, 'GBP', 1, '2023-03-27', 152.00, '2023-03-27', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 152.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 76.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 76.00 from ins_payment, other_member;


-- Row 437: 2023-04-01 Electricity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electricity', 50.00, 'GBP', 1, '2023-04-01', 50.00, '2023-04-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 50.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 25.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 25.00 from ins_payment, other_member;


-- Row 438: 2023-04-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2023-04-01', 24.00, '2023-04-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 439: 2023-04-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 17.50, 'GBP', 1, '2023-04-01', 17.50, '2023-04-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 8.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 8.75 from ins_payment, other_member;


-- Row 440: 2023-04-01 Hot Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot Water', 50.00, 'GBP', 1, '2023-04-01', 50.00, '2023-04-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 50.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 25.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 25.00 from ins_payment, other_member;


-- Row 441: 2023-04-02 Give notice civil ceremony
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Give notice civil ceremony', 70.00, 'GBP', 1, '2023-04-02', 70.00, '2023-04-02', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 70.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 35.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 35.00 from ins_payment, other_member;


-- Row 442: 2023-04-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 25.00, 'GBP', 1, '2023-04-04', 25.00, '2023-04-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 25.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.50 from ins_payment, other_member;


-- Row 443: 2023-04-12 Times subscripton
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Times subscripton', 6.50, 'GBP', 1, '2023-04-12', 6.50, '2023-04-12', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 6.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 3.25 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 3.25 from ins_payment, other_member;


-- Row 444: 2023-04-13 Car insurance excess
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Car insurance excess', 400.00, 'GBP', 1, '2023-04-13', 400.00, '2023-04-13', 'insurance', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 400.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 200.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 200.00 from ins_payment, other_member;


-- Row 445: 2023-04-16 Italy september hotels
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Italy september hotels', 250.00, 'GBP', 1, '2023-04-16', 250.00, '2023-04-16', 'travel', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 250.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 125.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 125.00 from ins_payment, other_member;


-- Row 446: 2023-04-27 Council tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council tax', 152.00, 'GBP', 1, '2023-04-27', 152.00, '2023-04-27', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 152.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 76.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 76.00 from ins_payment, other_member;


-- Row 447: 2023-05-01 Electricity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electricity', 50.00, 'GBP', 1, '2023-05-01', 50.00, '2023-05-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 50.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 25.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 25.00 from ins_payment, other_member;


-- Row 448: 2023-05-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2023-05-01', 24.00, '2023-05-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 449: 2023-05-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 17.50, 'GBP', 1, '2023-05-01', 17.50, '2023-05-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 8.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 8.75 from ins_payment, other_member;


-- Row 450: 2023-05-01 Hot Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot Water', 50.00, 'GBP', 1, '2023-05-01', 50.00, '2023-05-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 50.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 25.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 25.00 from ins_payment, other_member;


-- Row 451: 2023-05-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 25.00, 'GBP', 1, '2023-05-04', 25.00, '2023-05-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 25.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.50 from ins_payment, other_member;


-- Row 452: 2023-05-07 RHS memebership
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'RHS memebership', 78.00, 'GBP', 1, '2023-05-07', 78.00, '2023-05-07', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 78.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 39.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 39.00 from ins_payment, other_member;


-- Row 453: 2023-05-08 Rangers house fee
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Rangers house fee', 1770.00, 'GBP', 1, '2023-05-08', 1770.00, '2023-05-08', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 1770.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 885.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 885.00 from ins_payment, other_member;


-- Row 454: 2023-05-12 Times subscripton
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Times subscripton', 6.50, 'GBP', 1, '2023-05-12', 6.50, '2023-05-12', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 6.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 3.25 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 3.25 from ins_payment, other_member;


-- Row 455: 2023-05-27 Council tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council tax', 161.00, 'GBP', 1, '2023-05-27', 161.00, '2023-05-27', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 161.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 80.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 80.50 from ins_payment, other_member;


-- Row 456: 2023-06-01 Electricity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electricity', 50.00, 'GBP', 1, '2023-06-01', 50.00, '2023-06-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 50.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 25.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 25.00 from ins_payment, other_member;


-- Row 457: 2023-06-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2023-06-01', 24.00, '2023-06-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 458: 2023-06-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 17.50, 'GBP', 1, '2023-06-01', 17.50, '2023-06-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 8.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 8.75 from ins_payment, other_member;


-- Row 459: 2023-06-01 Hot Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot Water', 50.00, 'GBP', 1, '2023-06-01', 50.00, '2023-06-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 50.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 25.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 25.00 from ins_payment, other_member;


-- Row 460: 2023-06-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 29.00, 'GBP', 1, '2023-06-04', 29.00, '2023-06-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 14.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 14.50 from ins_payment, other_member;


-- Row 461: 2023-06-05 Handmade food
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Handmade food', 1100.84, 'GBP', 1, '2023-06-05', 1100.84, '2023-06-05', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 1100.84 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 550.42 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 550.42 from ins_payment, other_member;


-- Row 462: 2023-06-17 Flowers
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Flowers', 2916.00, 'GBP', 1, '2023-06-17', 2916.00, '2023-06-17', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 2916.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 1458.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 1458.00 from ins_payment, other_member;


-- Row 463: 2023-06-17 Photographer
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Photographer', 350.00, 'GBP', 1, '2023-06-17', 350.00, '2023-06-17', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 350.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 175.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 175.00 from ins_payment, other_member;


-- Row 464: 2023-06-18 Ben S. paid Louise B.
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Ben S. paid Louise B.', 201.83, 'GBP', 1, '2023-06-18', 201.83, '2023-06-18', 'settlements', null, 'settlement', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 201.83 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, other_member.user_id, 201.83 from ins_payment, other_member;


-- Row 465: 2023-06-27 Council tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council tax', 161.00, 'GBP', 1, '2023-06-27', 161.00, '2023-06-27', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 161.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 80.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 80.50 from ins_payment, other_member;


-- Row 466: 2023-07-01 Electricity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electricity', 50.00, 'GBP', 1, '2023-07-01', 50.00, '2023-07-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 50.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 25.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 25.00 from ins_payment, other_member;


-- Row 467: 2023-07-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2023-07-01', 24.00, '2023-07-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 468: 2023-07-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 17.50, 'GBP', 1, '2023-07-01', 17.50, '2023-07-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 8.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 8.75 from ins_payment, other_member;


-- Row 469: 2023-07-01 Hot Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot Water', 50.00, 'GBP', 1, '2023-07-01', 50.00, '2023-07-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 50.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 25.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 25.00 from ins_payment, other_member;


-- Row 470: 2023-07-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 29.00, 'GBP', 1, '2023-07-04', 29.00, '2023-07-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 14.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 14.50 from ins_payment, other_member;


-- Row 471: 2023-07-16 Service charge
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Service charge', 830.00, 'GBP', 1, '2023-07-16', 830.00, '2023-07-16', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 830.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 415.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 415.00 from ins_payment, other_member;


-- Row 472: 2023-07-27 Council tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council tax', 161.00, 'GBP', 1, '2023-07-27', 161.00, '2023-07-27', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 161.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 80.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 80.50 from ins_payment, other_member;


-- Row 473: 2023-08-01 Electricity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electricity', 50.00, 'GBP', 1, '2023-08-01', 50.00, '2023-08-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 50.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 25.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 25.00 from ins_payment, other_member;


-- Row 474: 2023-08-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2023-08-01', 24.00, '2023-08-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 475: 2023-08-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 17.50, 'GBP', 1, '2023-08-01', 17.50, '2023-08-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 8.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 8.75 from ins_payment, other_member;


-- Row 476: 2023-08-01 English heritage
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'English heritage', 120.00, 'GBP', 1, '2023-08-01', 120.00, '2023-08-01', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 120.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 60.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 60.00 from ins_payment, other_member;


-- Row 477: 2023-08-01 Hot Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot Water', 50.00, 'GBP', 1, '2023-08-01', 50.00, '2023-08-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 50.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 25.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 25.00 from ins_payment, other_member;


-- Row 478: 2023-08-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 29.00, 'GBP', 1, '2023-08-04', 29.00, '2023-08-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 14.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 14.50 from ins_payment, other_member;


-- Row 479: 2023-08-13 Car tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Car tax', 180.00, 'GBP', 1, '2023-08-13', 180.00, '2023-08-13', 'transport', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 180.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 90.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 90.00 from ins_payment, other_member;


-- Row 480: 2023-08-27 Council tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council tax', 161.00, 'GBP', 1, '2023-08-27', 161.00, '2023-08-27', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 161.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 80.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 80.50 from ins_payment, other_member;



commit;
