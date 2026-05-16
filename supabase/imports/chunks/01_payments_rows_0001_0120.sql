begin;

-- Row 1: 2018-11-08 Mortgage fee
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Mortgage fee', 1495.00, 'GBP', 1, '2018-11-08', 1495.00, '2018-11-08', 'mortgage_rent', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 1495.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 747.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 747.50 from ins_payment, other_member;


-- Row 2: 2018-11-08 Mortgage survey
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Mortgage survey', 200.00, 'GBP', 1, '2018-11-08', 200.00, '2018-11-08', 'mortgage_rent', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 200.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 100.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 100.00 from ins_payment, other_member;


-- Row 3: 2018-11-08 Solicitor fee
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Solicitor fee', 350.00, 'GBP', 1, '2018-11-08', 350.00, '2018-11-08', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 350.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 175.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 175.00 from ins_payment, other_member;


-- Row 4: 2018-11-08 Moving boxes
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Moving boxes', 55.00, 'GBP', 1, '2018-11-08', 55.00, '2018-11-08', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 55.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 27.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 27.50 from ins_payment, other_member;


-- Row 5: 2018-11-17 Vacuum bags
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Vacuum bags', 19.00, 'GBP', 1, '2018-11-17', 19.00, '2018-11-17', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 19.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 9.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 9.50 from ins_payment, other_member;


-- Row 6: 2018-11-18 Moving boxes
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Moving boxes', 39.99, 'GBP', 1, '2018-11-18', 39.99, '2018-11-18', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 39.99 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 19.99 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 20.00 from ins_payment, other_member;


-- Row 7: 2018-12-06 Accommodation 10-14th Dec
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Accommodation 10-14th Dec', 582.00, 'GBP', 1, '2018-12-06', 582.00, '2018-12-06', 'mortgage_rent', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 582.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 291.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 291.00 from ins_payment, other_member;


-- Row 8: 2018-12-06 Rent
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Rent', 200.00, 'GBP', 1, '2018-12-06', 200.00, '2018-12-06', 'mortgage_rent', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 200.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 100.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 100.00 from ins_payment, other_member;


-- Row 9: 2018-12-06 Boxes
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Boxes', 42.85, 'GBP', 1, '2018-12-06', 42.85, '2018-12-06', 'shopping', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 42.85 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 21.42 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 21.43 from ins_payment, other_member;


-- Row 10: 2018-12-06 Shurgard Storage
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Shurgard Storage', 36.97, 'GBP', 1, '2018-12-06', 36.97, '2018-12-06', 'shopping', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 36.97 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 18.48 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 18.49 from ins_payment, other_member;


-- Row 11: 2018-12-10 Van Removal
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Van Removal', 323.00, 'GBP', 1, '2018-12-10', 323.00, '2018-12-10', 'shopping', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 323.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 161.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 161.50 from ins_payment, other_member;


-- Row 12: 2018-12-11 Aprtment 17-21 Dec
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Aprtment 17-21 Dec', 472.00, 'GBP', 1, '2018-12-11', 472.00, '2018-12-11', 'mortgage_rent', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 472.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 236.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 236.00 from ins_payment, other_member;


-- Row 13: 2018-12-11 Travelodge 16th December
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Travelodge 16th December', 49.00, 'GBP', 1, '2018-12-11', 49.00, '2018-12-11', 'travel', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 49.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 24.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 24.50 from ins_payment, other_member;


-- Row 14: 2018-12-23 Apartment 1st-4th Jan
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apartment 1st-4th Jan', 276.00, 'GBP', 1, '2018-12-23', 276.00, '2018-12-23', 'mortgage_rent', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 276.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 138.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 138.00 from ins_payment, other_member;


-- Row 15: 2018-12-23 Premier Inn 31st Dec
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Premier Inn 31st Dec', 158.00, 'GBP', 1, '2018-12-23', 158.00, '2018-12-23', 'travel', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 158.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 79.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 79.00 from ins_payment, other_member;


-- Row 16: 2018-12-23 Louise B. paid Ben S.
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Louise B. paid Ben S.', 500.00, 'GBP', 1, '2018-12-23', 500.00, '2018-12-23', 'settlements', null, 'settlement', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 500.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, other_member.user_id, 500.00 from ins_payment, other_member;


-- Row 17: 2019-01-01 Accommodation 6thJan-11thJan
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Accommodation 6thJan-11thJan', 351.00, 'GBP', 1, '2019-01-01', 351.00, '2019-01-01', 'mortgage_rent', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 351.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 175.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 175.50 from ins_payment, other_member;


-- Row 18: 2019-01-09 Apartment 14th- 18th Jan
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apartment 14th- 18th Jan', 405.00, 'GBP', 1, '2019-01-09', 405.00, '2019-01-09', 'mortgage_rent', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 405.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 202.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 202.50 from ins_payment, other_member;


-- Row 19: 2019-01-09 Travelodge
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Travelodge', 27.00, 'GBP', 1, '2019-01-09', 27.00, '2019-01-09', 'travel', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 27.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 13.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 13.50 from ins_payment, other_member;


-- Row 20: 2019-01-09 Shurgard Storage
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Shurgard Storage', 94.77, 'GBP', 1, '2019-01-09', 94.77, '2019-01-09', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 94.77 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 47.38 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 47.39 from ins_payment, other_member;


-- Row 21: 2019-01-18 Carpet deposit
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Carpet deposit', 1097.00, 'GBP', 1, '2019-01-18', 1097.00, '2019-01-18', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 1097.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 548.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 548.50 from ins_payment, other_member;


-- Row 22: 2019-01-26 TV licence
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'TV licence', 150.50, 'GBP', 1, '2019-01-26', 150.50, '2019-01-26', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 150.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 75.25 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 75.25 from ins_payment, other_member;


-- Row 23: 2019-01-26 Kitchenware
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Kitchenware', 112.00, 'GBP', 1, '2019-01-26', 112.00, '2019-01-26', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 112.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 56.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 56.00 from ins_payment, other_member;


-- Row 24: 2019-01-26 Bath Mats
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Bath Mats', 37.50, 'GBP', 1, '2019-01-26', 37.50, '2019-01-26', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 37.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 18.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 18.75 from ins_payment, other_member;


-- Row 25: 2019-02-01 Carpet Completion
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Carpet Completion', 1257.80, 'GBP', 1, '2019-02-01', 1257.80, '2019-02-01', 'shopping', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 1257.80 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 628.90 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 628.90 from ins_payment, other_member;


-- Row 26: 2019-02-02 Mortgage
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Mortgage', 1432.12, 'GBP', 1, '2019-02-02', 1432.12, '2019-02-02', 'mortgage_rent', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 1432.12 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 716.06 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 716.06 from ins_payment, other_member;


-- Row 27: 2019-02-04 Painting
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Painting', 650.00, 'GBP', 1, '2019-02-04', 650.00, '2019-02-04', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 650.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 325.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 325.00 from ins_payment, other_member;


-- Row 28: 2019-02-04 Louise B. paid Ben S.
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Louise B. paid Ben S.', 550.67, 'GBP', 1, '2019-02-04', 550.67, '2019-02-04', 'settlements', null, 'settlement', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 550.67 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, other_member.user_id, 550.67 from ins_payment, other_member;


-- Row 29: 2019-02-18 Sofabed
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Sofabed', 938.00, 'GBP', 1, '2019-02-18', 938.00, '2019-02-18', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 938.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 469.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 469.00 from ins_payment, other_member;


-- Row 30: 2019-02-18 Sofa
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Sofa', 1099.00, 'GBP', 1, '2019-02-18', 1099.00, '2019-02-18', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 1099.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 549.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 549.50 from ins_payment, other_member;


-- Row 31: 2019-02-18 Shelving
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Shelving', 245.00, 'GBP', 1, '2019-02-18', 245.00, '2019-02-18', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 245.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 122.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 122.50 from ins_payment, other_member;


-- Row 32: 2019-02-18 Painting and Decorating from B&Q
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Painting and Decorating from B&Q', 86.00, 'GBP', 1, '2019-02-18', 86.00, '2019-02-18', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 86.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 43.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 43.00 from ins_payment, other_member;


-- Row 33: 2019-02-18 B&Q decorating
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'B&Q decorating', 39.00, 'GBP', 1, '2019-02-18', 39.00, '2019-02-18', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 39.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 19.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 19.50 from ins_payment, other_member;


-- Row 34: 2019-02-21 Electricity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electricity', 50.00, 'GBP', 1, '2019-02-21', 50.00, '2019-02-21', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 50.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 25.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 25.00 from ins_payment, other_member;


-- Row 35: 2019-02-21 Louise B. paid Ben S.
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Louise B. paid Ben S.', 1139.50, 'GBP', 1, '2019-02-21', 1139.50, '2019-02-21', 'settlements', null, 'settlement', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 1139.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, other_member.user_id, 1139.50 from ins_payment, other_member;


-- Row 36: 2019-02-22 Chair
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Chair', 199.00, 'GBP', 1, '2019-02-22', 199.00, '2019-02-22', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 199.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 99.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 99.50 from ins_payment, other_member;


-- Row 37: 2019-02-26 Sideboard
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Sideboard', 988.00, 'GBP', 1, '2019-02-26', 988.00, '2019-02-26', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 988.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 494.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 494.00 from ins_payment, other_member;


-- Row 38: 2019-03-03 Big manatee holiday deposit
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Big manatee holiday deposit', 1286.00, 'GBP', 1, '2019-03-03', 1286.00, '2019-03-03', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 1286.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 643.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 643.00 from ins_payment, other_member;


-- Row 39: 2019-03-04 New york hotel
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'New york hotel', 650.00, 'GBP', 1, '2019-03-04', 650.00, '2019-03-04', 'travel', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 650.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 325.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 325.00 from ins_payment, other_member;


-- Row 40: 2019-03-04 BA upgrade Louise
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'BA upgrade Louise', 88.00, 'GBP', 1, '2019-03-04', 88.00, '2019-03-04', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 88.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 44.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 44.00 from ins_payment, other_member;


-- Row 41: 2019-03-04 Laundry bin
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Laundry bin', 40.00, 'GBP', 1, '2019-03-04', 40.00, '2019-03-04', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 40.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 20.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 20.00 from ins_payment, other_member;


-- Row 42: 2019-03-04 Manatee holiday flights
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Manatee holiday flights', 2306.00, 'GBP', 1, '2019-03-04', 2306.00, '2019-03-04', 'travel', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 2306.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 1153.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 1153.00 from ins_payment, other_member;


-- Row 43: 2019-03-04 Ben S. paid Louise B.
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Ben S. paid Louise B.', 1144.50, 'GBP', 1, '2019-03-04', 1144.50, '2019-03-04', 'settlements', null, 'settlement', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 1144.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, other_member.user_id, 1144.50 from ins_payment, other_member;


-- Row 44: 2019-03-16 Flight seat reservations
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Flight seat reservations', 145.00, 'GBP', 1, '2019-03-16', 145.00, '2019-03-16', 'travel', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 145.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 72.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 72.50 from ins_payment, other_member;


-- Row 45: 2019-03-17 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 74.00, 'GBP', 1, '2019-03-17', 74.00, '2019-03-17', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 74.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 37.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 37.00 from ins_payment, other_member;


-- Row 46: 2019-03-17 Water bill
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water bill', 24.00, 'GBP', 1, '2019-03-17', 24.00, '2019-03-17', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 47: 2019-03-17 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 29.00, 'GBP', 1, '2019-03-17', 29.00, '2019-03-17', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 14.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 14.50 from ins_payment, other_member;


-- Row 48: 2019-03-19 Lego ship
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Lego ship', 60.00, 'GBP', 1, '2019-03-19', 60.00, '2019-03-19', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 60.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 30.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 30.00 from ins_payment, other_member;


-- Row 49: 2019-03-27 Council tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council tax', 233.00, 'GBP', 1, '2019-03-27', 233.00, '2019-03-27', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 233.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 116.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 116.50 from ins_payment, other_member;


-- Row 50: 2019-04-01 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 74.00, 'GBP', 1, '2019-04-01', 74.00, '2019-04-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 74.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 37.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 37.00 from ins_payment, other_member;


-- Row 51: 2019-04-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2019-04-01', 24.00, '2019-04-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 52: 2019-04-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 29.00, 'GBP', 1, '2019-04-04', 29.00, '2019-04-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 14.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 14.50 from ins_payment, other_member;


-- Row 53: 2019-04-14 Spare room bedding
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Spare room bedding', 31.00, 'GBP', 1, '2019-04-14', 31.00, '2019-04-14', 'mortgage_rent', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 31.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 15.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 15.50 from ins_payment, other_member;


-- Row 54: 2019-04-14 Service charge
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Service charge', 2143.13, 'GBP', 1, '2019-04-14', 2143.13, '2019-04-14', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 2143.13 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 1071.56 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 1071.57 from ins_payment, other_member;


-- Row 55: 2019-04-14 Armchair Ikea
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Armchair Ikea', 130.00, 'GBP', 1, '2019-04-14', 130.00, '2019-04-14', 'shopping', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 130.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 65.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 65.00 from ins_payment, other_member;


-- Row 56: 2019-04-14 Balcony furniture
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Balcony furniture', 218.00, 'GBP', 1, '2019-04-14', 218.00, '2019-04-14', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 218.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 109.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 109.00 from ins_payment, other_member;


-- Row 57: 2019-04-14 Louise B. paid Ben S.
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Louise B. paid Ben S.', 633.44, 'GBP', 1, '2019-04-14', 633.44, '2019-04-14', 'settlements', null, 'settlement', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 633.44 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, other_member.user_id, 633.44 from ins_payment, other_member;


-- Row 58: 2019-04-16 Ikea table component
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Ikea table component', 50.00, 'GBP', 1, '2019-04-16', 50.00, '2019-04-16', 'shopping', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 50.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 25.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 25.00 from ins_payment, other_member;


-- Row 59: 2019-04-16 Flight
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Flight', 157.00, 'GBP', 1, '2019-04-16', 157.00, '2019-04-16', 'travel', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 157.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 78.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 78.50 from ins_payment, other_member;


-- Row 60: 2019-04-24 Holiday rental
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Holiday rental', 195.00, 'GBP', 1, '2019-04-24', 195.00, '2019-04-24', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 195.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 97.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 97.50 from ins_payment, other_member;


-- Row 61: 2019-04-28 Holiday Flights
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Holiday Flights', 413.00, 'GBP', 1, '2019-04-28', 413.00, '2019-04-28', 'travel', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 413.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 206.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 206.50 from ins_payment, other_member;


-- Row 62: 2019-04-28 Premier inn Gatwick
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Premier inn Gatwick', 76.00, 'GBP', 1, '2019-04-28', 76.00, '2019-04-28', 'travel', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 76.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 38.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 38.00 from ins_payment, other_member;


-- Row 63: 2019-04-29 Council Tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council Tax', 136.00, 'GBP', 1, '2019-04-29', 136.00, '2019-04-29', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 136.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 68.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 68.00 from ins_payment, other_member;


-- Row 64: 2019-05-01 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 74.00, 'GBP', 1, '2019-05-01', 74.00, '2019-05-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 74.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 37.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 37.00 from ins_payment, other_member;


-- Row 65: 2019-05-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2019-05-01', 24.00, '2019-05-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 66: 2019-05-01 Curtains deposit
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Curtains deposit', 950.00, 'GBP', 1, '2019-05-01', 950.00, '2019-05-01', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 950.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 475.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 475.00 from ins_payment, other_member;


-- Row 67: 2019-05-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 29.00, 'GBP', 1, '2019-05-04', 29.00, '2019-05-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 14.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 14.50 from ins_payment, other_member;


-- Row 68: 2019-05-08 Car hire
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Car hire', 197.00, 'GBP', 1, '2019-05-08', 197.00, '2019-05-08', 'transport', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 197.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 98.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 98.50 from ins_payment, other_member;


-- Row 69: 2019-05-13 Coffee Table
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Coffee Table', 150.00, 'GBP', 1, '2019-05-13', 150.00, '2019-05-13', 'dining', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 150.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 75.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 75.00 from ins_payment, other_member;


-- Row 70: 2019-05-20 Louise B. paid Ben S.
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Louise B. paid Ben S.', 350.00, 'GBP', 1, '2019-05-20', 350.00, '2019-05-20', 'settlements', null, 'settlement', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 350.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, other_member.user_id, 350.00 from ins_payment, other_member;


-- Row 71: 2019-05-22 Curtains - balance
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Curtains - balance', 942.00, 'GBP', 1, '2019-05-22', 942.00, '2019-05-22', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 942.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 471.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 471.00 from ins_payment, other_member;


-- Row 72: 2019-05-29 Council Tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council Tax', 136.00, 'GBP', 1, '2019-05-29', 136.00, '2019-05-29', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 136.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 68.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 68.00 from ins_payment, other_member;


-- Row 73: 2019-06-01 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 74.00, 'GBP', 1, '2019-06-01', 74.00, '2019-06-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 74.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 37.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 37.00 from ins_payment, other_member;


-- Row 74: 2019-06-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2019-06-01', 24.00, '2019-06-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 75: 2019-06-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 29.00, 'GBP', 1, '2019-06-04', 29.00, '2019-06-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 14.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 14.50 from ins_payment, other_member;


-- Row 76: 2019-06-06 Louise B. paid Ben S.
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Louise B. paid Ben S.', 300.00, 'GBP', 1, '2019-06-06', 300.00, '2019-06-06', 'settlements', null, 'settlement', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 300.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, other_member.user_id, 300.00 from ins_payment, other_member;


-- Row 77: 2019-06-23 Shopping
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Shopping', 62.00, 'GBP', 1, '2019-06-23', 62.00, '2019-06-23', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 62.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 31.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 31.00 from ins_payment, other_member;


-- Row 78: 2019-06-23 Service charge
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Service charge', 2143.13, 'GBP', 1, '2019-06-23', 2143.13, '2019-06-23', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 2143.13 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 1071.56 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 1071.57 from ins_payment, other_member;


-- Row 79: 2019-06-28 Louise B. paid Ben S.
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Louise B. paid Ben S.', 1056.44, 'GBP', 1, '2019-06-28', 1056.44, '2019-06-28', 'settlements', null, 'settlement', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 1056.44 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, other_member.user_id, 1056.44 from ins_payment, other_member;


-- Row 80: 2019-06-29 Council Tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council Tax', 136.00, 'GBP', 1, '2019-06-29', 136.00, '2019-06-29', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 136.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 68.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 68.00 from ins_payment, other_member;


-- Row 81: 2019-07-01 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 74.00, 'GBP', 1, '2019-07-01', 74.00, '2019-07-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 74.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 37.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 37.00 from ins_payment, other_member;


-- Row 82: 2019-07-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2019-07-01', 24.00, '2019-07-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 83: 2019-07-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 29.00, 'GBP', 1, '2019-07-04', 29.00, '2019-07-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 14.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 14.50 from ins_payment, other_member;


-- Row 84: 2019-07-08 National Trust
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'National Trust', 120.00, 'GBP', 1, '2019-07-08', 120.00, '2019-07-08', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 120.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 60.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 60.00 from ins_payment, other_member;


-- Row 85: 2019-07-29 Council Tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council Tax', 136.00, 'GBP', 1, '2019-07-29', 136.00, '2019-07-29', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 136.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 68.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 68.00 from ins_payment, other_member;


-- Row 86: 2019-08-01 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 58.00, 'GBP', 1, '2019-08-01', 58.00, '2019-08-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 58.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 29.00 from ins_payment, other_member;


-- Row 87: 2019-08-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2019-08-01', 24.00, '2019-08-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 88: 2019-08-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 29.00, 'GBP', 1, '2019-08-04', 29.00, '2019-08-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 14.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 14.50 from ins_payment, other_member;


-- Row 89: 2019-08-13 Stonefield Castle
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Stonefield Castle', 480.00, 'GBP', 1, '2019-08-13', 480.00, '2019-08-13', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 480.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 240.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 240.00 from ins_payment, other_member;


-- Row 90: 2019-08-18 Cutty sark dinner
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Cutty sark dinner', 132.00, 'GBP', 1, '2019-08-18', 132.00, '2019-08-18', 'dining', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 132.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 66.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 66.00 from ins_payment, other_member;


-- Row 91: 2019-08-18 Tower of london
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Tower of london', 50.00, 'GBP', 1, '2019-08-18', 50.00, '2019-08-18', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 50.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 25.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 25.00 from ins_payment, other_member;


-- Row 92: 2019-08-18 Wedding presents
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Wedding presents', 40.00, 'GBP', 1, '2019-08-18', 40.00, '2019-08-18', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 40.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 20.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 20.00 from ins_payment, other_member;


-- Row 93: 2019-08-18 Ben S. paid Louise B.
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Ben S. paid Louise B.', 102.00, 'GBP', 1, '2019-08-18', 102.00, '2019-08-18', 'settlements', null, 'settlement', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 102.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, other_member.user_id, 102.00 from ins_payment, other_member;


-- Row 94: 2019-08-29 Council Tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council Tax', 136.00, 'GBP', 1, '2019-08-29', 136.00, '2019-08-29', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 136.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 68.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 68.00 from ins_payment, other_member;


-- Row 95: 2019-09-01 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 58.00, 'GBP', 1, '2019-09-01', 58.00, '2019-09-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 58.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 29.00 from ins_payment, other_member;


-- Row 96: 2019-09-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2019-09-01', 24.00, '2019-09-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 97: 2019-09-02 Coach transfer
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Coach transfer', 39.00, 'GBP', 1, '2019-09-02', 39.00, '2019-09-02', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 39.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 19.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 19.50 from ins_payment, other_member;


-- Row 98: 2019-09-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 29.00, 'GBP', 1, '2019-09-04', 29.00, '2019-09-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 14.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 14.50 from ins_payment, other_member;


-- Row 99: 2019-09-09 Saturday shop
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Saturday shop', 50.00, 'GBP', 1, '2019-09-09', 50.00, '2019-09-09', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 50.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 25.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 25.00 from ins_payment, other_member;


-- Row 100: 2019-09-28 Louise B. paid Ben S.
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Louise B. paid Ben S.', 138.50, 'GBP', 1, '2019-09-28', 138.50, '2019-09-28', 'settlements', null, 'settlement', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 138.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, other_member.user_id, 138.50 from ins_payment, other_member;


-- Row 101: 2019-09-29 Council Tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council Tax', 136.00, 'GBP', 1, '2019-09-29', 136.00, '2019-09-29', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 136.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 68.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 68.00 from ins_payment, other_member;


-- Row 102: 2019-10-01 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 58.00, 'GBP', 1, '2019-10-01', 58.00, '2019-10-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 58.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 29.00 from ins_payment, other_member;


-- Row 103: 2019-10-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2019-10-01', 24.00, '2019-10-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 104: 2019-10-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 29.00, 'GBP', 1, '2019-10-04', 29.00, '2019-10-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 14.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 14.50 from ins_payment, other_member;


-- Row 105: 2019-10-29 Council Tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council Tax', 136.00, 'GBP', 1, '2019-10-29', 136.00, '2019-10-29', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 136.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 68.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 68.00 from ins_payment, other_member;


-- Row 106: 2019-11-01 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 58.00, 'GBP', 1, '2019-11-01', 58.00, '2019-11-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 58.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 29.00 from ins_payment, other_member;


-- Row 107: 2019-11-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2019-11-01', 24.00, '2019-11-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 108: 2019-11-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 29.00, 'GBP', 1, '2019-11-04', 29.00, '2019-11-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 14.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 14.50 from ins_payment, other_member;


-- Row 109: 2019-11-04 Pictures
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Pictures', 160.00, 'GBP', 1, '2019-11-04', 160.00, '2019-11-04', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 160.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 80.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 80.00 from ins_payment, other_member;


-- Row 110: 2019-11-23 Baby presents
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Baby presents', 37.00, 'GBP', 1, '2019-11-23', 37.00, '2019-11-23', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 37.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 18.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 18.50 from ins_payment, other_member;


-- Row 111: 2019-11-23 Rose hand cream
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Rose hand cream', 12.00, 'GBP', 1, '2019-11-23', 12.00, '2019-11-23', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 6.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 6.00 from ins_payment, other_member;


-- Row 112: 2019-11-23 Decorations and cushion
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Decorations and cushion', 142.00, 'GBP', 1, '2019-11-23', 142.00, '2019-11-23', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 142.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 71.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 71.00 from ins_payment, other_member;


-- Row 113: 2019-11-29 Council Tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council Tax', 132.00, 'GBP', 1, '2019-11-29', 132.00, '2019-11-29', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 132.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 66.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 66.00 from ins_payment, other_member;


-- Row 114: 2019-12-01 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 58.00, 'GBP', 1, '2019-12-01', 58.00, '2019-12-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 58.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 29.00 from ins_payment, other_member;


-- Row 115: 2019-12-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2019-12-01', 24.00, '2019-12-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 116: 2019-12-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 29.00, 'GBP', 1, '2019-12-04', 29.00, '2019-12-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 14.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 14.50 from ins_payment, other_member;


-- Row 117: 2019-12-08 Council tax refund
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council tax refund', 12.00, 'GBP', 1, '2019-12-08', 12.00, '2019-12-08', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 6.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 6.00 from ins_payment, other_member;


-- Row 118: 2019-12-10 Manatee taxi credit
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Manatee taxi credit', 20.00, 'GBP', 1, '2019-12-10', 20.00, '2019-12-10', 'transport', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 20.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 10.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 10.00 from ins_payment, other_member;


-- Row 119: 2019-12-15 Ground Rent
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Ground Rent', 400.00, 'GBP', 1, '2019-12-15', 400.00, '2019-12-15', 'mortgage_rent', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 400.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 200.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 200.00 from ins_payment, other_member;


-- Row 120: 2019-12-27 TV licence
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'TV licence', 154.50, 'GBP', 1, '2019-12-27', 154.50, '2019-12-27', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 154.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 77.25 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 77.25 from ins_payment, other_member;



commit;
