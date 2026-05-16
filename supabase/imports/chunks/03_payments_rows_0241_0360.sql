begin;

-- Row 241: 2021-05-27 Council Tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council Tax', 121.00, 'GBP', 1, '2021-05-27', 121.00, '2021-05-27', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 121.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 60.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 60.50 from ins_payment, other_member;


-- Row 242: 2021-06-01 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 58.00, 'GBP', 1, '2021-06-01', 58.00, '2021-06-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 58.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 29.00 from ins_payment, other_member;


-- Row 243: 2021-06-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2021-06-01', 24.00, '2021-06-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 244: 2021-06-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 17.50, 'GBP', 1, '2021-06-01', 17.50, '2021-06-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 8.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 8.75 from ins_payment, other_member;


-- Row 245: 2021-06-01 Hot Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot Water', 30.00, 'GBP', 1, '2021-06-01', 30.00, '2021-06-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 30.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 15.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 15.00 from ins_payment, other_member;


-- Row 246: 2021-06-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 29.00, 'GBP', 1, '2021-06-04', 29.00, '2021-06-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 14.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 14.50 from ins_payment, other_member;


-- Row 247: 2021-06-27 Council Tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council Tax', 121.00, 'GBP', 1, '2021-06-27', 121.00, '2021-06-27', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 121.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 60.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 60.50 from ins_payment, other_member;


-- Row 248: 2021-07-01 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 58.00, 'GBP', 1, '2021-07-01', 58.00, '2021-07-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 58.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 29.00 from ins_payment, other_member;


-- Row 249: 2021-07-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2021-07-01', 24.00, '2021-07-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 250: 2021-07-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 17.50, 'GBP', 1, '2021-07-01', 17.50, '2021-07-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 8.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 8.75 from ins_payment, other_member;


-- Row 251: 2021-07-01 Hot Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot Water', 30.00, 'GBP', 1, '2021-07-01', 30.00, '2021-07-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 30.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 15.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 15.00 from ins_payment, other_member;


-- Row 252: 2021-07-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 29.00, 'GBP', 1, '2021-07-04', 29.00, '2021-07-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 14.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 14.50 from ins_payment, other_member;


-- Row 253: 2021-07-17 National trust
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'National trust', 120.00, 'GBP', 1, '2021-07-17', 120.00, '2021-07-17', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 120.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 60.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 60.00 from ins_payment, other_member;


-- Row 254: 2021-07-27 Council Tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council Tax', 121.00, 'GBP', 1, '2021-07-27', 121.00, '2021-07-27', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 121.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 60.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 60.50 from ins_payment, other_member;


-- Row 255: 2021-08-01 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 58.00, 'GBP', 1, '2021-08-01', 58.00, '2021-08-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 58.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 29.00 from ins_payment, other_member;


-- Row 256: 2021-08-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2021-08-01', 24.00, '2021-08-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 257: 2021-08-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 17.50, 'GBP', 1, '2021-08-01', 17.50, '2021-08-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 8.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 8.75 from ins_payment, other_member;


-- Row 258: 2021-08-01 Hot Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot Water', 30.00, 'GBP', 1, '2021-08-01', 30.00, '2021-08-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 30.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 15.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 15.00 from ins_payment, other_member;


-- Row 259: 2021-08-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 29.00, 'GBP', 1, '2021-08-04', 29.00, '2021-08-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 14.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 14.50 from ins_payment, other_member;


-- Row 260: 2021-08-20 Car tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Car tax', 155.00, 'GBP', 1, '2021-08-20', 155.00, '2021-08-20', 'transport', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 155.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 77.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 77.50 from ins_payment, other_member;


-- Row 261: 2021-08-27 Council Tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council Tax', 121.00, 'GBP', 1, '2021-08-27', 121.00, '2021-08-27', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 121.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 60.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 60.50 from ins_payment, other_member;


-- Row 262: 2021-09-01 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 81.00, 'GBP', 1, '2021-09-01', 81.00, '2021-09-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 81.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 40.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 40.50 from ins_payment, other_member;


-- Row 263: 2021-09-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2021-09-01', 24.00, '2021-09-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 264: 2021-09-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 17.50, 'GBP', 1, '2021-09-01', 17.50, '2021-09-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 8.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 8.75 from ins_payment, other_member;


-- Row 265: 2021-09-01 Hot Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot Water', 30.00, 'GBP', 1, '2021-09-01', 30.00, '2021-09-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 30.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 15.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 15.00 from ins_payment, other_member;


-- Row 266: 2021-09-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 29.00, 'GBP', 1, '2021-09-04', 29.00, '2021-09-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 14.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 14.50 from ins_payment, other_member;


-- Row 267: 2021-09-08 Covid tests
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Covid tests', 87.00, 'GBP', 1, '2021-09-08', 87.00, '2021-09-08', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 87.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 43.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 43.50 from ins_payment, other_member;


-- Row 268: 2021-09-12 Car insurance
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Car insurance', 305.00, 'GBP', 1, '2021-09-12', 305.00, '2021-09-12', 'insurance', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 305.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 152.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 152.50 from ins_payment, other_member;


-- Row 269: 2021-09-12 Ink catridges
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Ink catridges', 35.00, 'GBP', 1, '2021-09-12', 35.00, '2021-09-12', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 35.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 17.50 from ins_payment, other_member;


-- Row 270: 2021-09-27 Council Tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council Tax', 121.00, 'GBP', 1, '2021-09-27', 121.00, '2021-09-27', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 121.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 60.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 60.50 from ins_payment, other_member;


-- Row 271: 2021-10-01 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 81.00, 'GBP', 1, '2021-10-01', 81.00, '2021-10-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 81.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 40.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 40.50 from ins_payment, other_member;


-- Row 272: 2021-10-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2021-10-01', 24.00, '2021-10-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 273: 2021-10-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 17.50, 'GBP', 1, '2021-10-01', 17.50, '2021-10-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 8.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 8.75 from ins_payment, other_member;


-- Row 274: 2021-10-01 Hot Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot Water', 30.00, 'GBP', 1, '2021-10-01', 30.00, '2021-10-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 30.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 15.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 15.00 from ins_payment, other_member;


-- Row 275: 2021-10-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 29.00, 'GBP', 1, '2021-10-04', 29.00, '2021-10-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 14.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 14.50 from ins_payment, other_member;


-- Row 276: 2021-10-15 Holiday
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Holiday', 100.00, 'GBP', 1, '2021-10-15', 100.00, '2021-10-15', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 100.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 50.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 50.00 from ins_payment, other_member;


-- Row 277: 2021-10-16 Car service
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Car service', 267.00, 'GBP', 1, '2021-10-16', 267.00, '2021-10-16', 'transport', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 267.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 133.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 133.50 from ins_payment, other_member;


-- Row 278: 2021-10-27 Council Tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council Tax', 121.00, 'GBP', 1, '2021-10-27', 121.00, '2021-10-27', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 121.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 60.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 60.50 from ins_payment, other_member;


-- Row 279: 2021-11-01 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 81.00, 'GBP', 1, '2021-11-01', 81.00, '2021-11-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 81.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 40.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 40.50 from ins_payment, other_member;


-- Row 280: 2021-11-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2021-11-01', 24.00, '2021-11-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 281: 2021-11-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 17.50, 'GBP', 1, '2021-11-01', 17.50, '2021-11-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 8.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 8.75 from ins_payment, other_member;


-- Row 282: 2021-11-01 Hot Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot Water', 30.00, 'GBP', 1, '2021-11-01', 30.00, '2021-11-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 30.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 15.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 15.00 from ins_payment, other_member;


-- Row 283: 2021-11-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 29.00, 'GBP', 1, '2021-11-04', 29.00, '2021-11-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 14.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 14.50 from ins_payment, other_member;


-- Row 284: 2021-11-20 Taxi
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Taxi', 14.00, 'GBP', 1, '2021-11-20', 14.00, '2021-11-20', 'transport', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 14.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 7.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 7.00 from ins_payment, other_member;


-- Row 285: 2021-11-20 Ground rent
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Ground rent', 400.00, 'GBP', 1, '2021-11-20', 400.00, '2021-11-20', 'mortgage_rent', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 400.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 200.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 200.00 from ins_payment, other_member;


-- Row 286: 2021-11-27 Council Tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council Tax', 121.00, 'GBP', 1, '2021-11-27', 121.00, '2021-11-27', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 121.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 60.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 60.50 from ins_payment, other_member;


-- Row 287: 2021-12-01 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 81.00, 'GBP', 1, '2021-12-01', 81.00, '2021-12-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 81.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 40.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 40.50 from ins_payment, other_member;


-- Row 288: 2021-12-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2021-12-01', 24.00, '2021-12-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 289: 2021-12-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 17.50, 'GBP', 1, '2021-12-01', 17.50, '2021-12-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 8.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 8.75 from ins_payment, other_member;


-- Row 290: 2021-12-01 Hot Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot Water', 100.00, 'GBP', 1, '2021-12-01', 100.00, '2021-12-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 100.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 50.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 50.00 from ins_payment, other_member;


-- Row 291: 2021-12-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 29.00, 'GBP', 1, '2021-12-04', 29.00, '2021-12-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 14.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 14.50 from ins_payment, other_member;


-- Row 292: 2021-12-20 TV licence
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'TV licence', 159.00, 'GBP', 1, '2021-12-20', 159.00, '2021-12-20', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 159.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 79.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 79.50 from ins_payment, other_member;


-- Row 293: 2021-12-27 Council Tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council Tax', 146.00, 'GBP', 1, '2021-12-27', 146.00, '2021-12-27', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 146.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 73.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 73.00 from ins_payment, other_member;


-- Row 294: 2021-12-30 Charity rowathon
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Charity rowathon', 60.00, 'GBP', 1, '2021-12-30', 60.00, '2021-12-30', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 60.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 30.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 30.00 from ins_payment, other_member;


-- Row 295: 2022-01-01 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 81.00, 'GBP', 1, '2022-01-01', 81.00, '2022-01-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 81.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 40.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 40.50 from ins_payment, other_member;


-- Row 296: 2022-01-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2022-01-01', 24.00, '2022-01-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 297: 2022-01-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 17.50, 'GBP', 1, '2022-01-01', 17.50, '2022-01-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 8.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 8.75 from ins_payment, other_member;


-- Row 298: 2022-01-01 Hot Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot Water', 30.00, 'GBP', 1, '2022-01-01', 30.00, '2022-01-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 30.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 15.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 15.00 from ins_payment, other_member;


-- Row 299: 2022-01-03 Service Charge
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Service Charge', 2389.68, 'GBP', 1, '2022-01-03', 2389.68, '2022-01-03', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 2389.68 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 1194.84 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 1194.84 from ins_payment, other_member;


-- Row 300: 2022-01-03 Ben S. paid Louise B.
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Ben S. paid Louise B.', 1413.18, 'GBP', 1, '2022-01-03', 1413.18, '2022-01-03', 'settlements', null, 'settlement', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 1413.18 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, other_member.user_id, 1413.18 from ins_payment, other_member;


-- Row 301: 2022-01-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 29.00, 'GBP', 1, '2022-01-04', 29.00, '2022-01-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 14.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 14.50 from ins_payment, other_member;


-- Row 302: 2022-01-16 Egypt flights
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Egypt flights', 531.00, 'GBP', 1, '2022-01-16', 531.00, '2022-01-16', 'travel', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 531.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 265.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 265.50 from ins_payment, other_member;


-- Row 303: 2022-01-16 Malta flights easy jet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Malta flights easy jet', 91.00, 'GBP', 1, '2022-01-16', 91.00, '2022-01-16', 'travel', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 91.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 45.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 45.50 from ins_payment, other_member;


-- Row 304: 2022-01-16 Malta hotel
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Malta hotel', 397.00, 'GBP', 1, '2022-01-16', 397.00, '2022-01-16', 'travel', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 397.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 198.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 198.50 from ins_payment, other_member;


-- Row 305: 2022-01-27 Council Tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council Tax', 146.00, 'GBP', 1, '2022-01-27', 146.00, '2022-01-27', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 146.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 73.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 73.00 from ins_payment, other_member;


-- Row 306: 2022-02-01 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 81.00, 'GBP', 1, '2022-02-01', 81.00, '2022-02-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 81.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 40.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 40.50 from ins_payment, other_member;


-- Row 307: 2022-02-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2022-02-01', 24.00, '2022-02-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 308: 2022-02-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 17.50, 'GBP', 1, '2022-02-01', 17.50, '2022-02-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 8.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 8.75 from ins_payment, other_member;


-- Row 309: 2022-02-01 Hot Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot Water', 30.00, 'GBP', 1, '2022-02-01', 30.00, '2022-02-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 30.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 15.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 15.00 from ins_payment, other_member;


-- Row 310: 2022-02-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 29.00, 'GBP', 1, '2022-02-04', 29.00, '2022-02-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 29.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 14.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 14.50 from ins_payment, other_member;


-- Row 311: 2022-02-12 Hot water ( additional )
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot water ( additional )', 104.97, 'GBP', 1, '2022-02-12', 104.97, '2022-02-12', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 104.97 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 52.48 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 52.49 from ins_payment, other_member;


-- Row 312: 2022-03-01 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 81.00, 'GBP', 1, '2022-03-01', 81.00, '2022-03-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 81.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 40.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 40.50 from ins_payment, other_member;


-- Row 313: 2022-03-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2022-03-01', 24.00, '2022-03-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 314: 2022-03-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 17.50, 'GBP', 1, '2022-03-01', 17.50, '2022-03-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 8.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 8.75 from ins_payment, other_member;


-- Row 315: 2022-03-01 Hot Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot Water', 30.00, 'GBP', 1, '2022-03-01', 30.00, '2022-03-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 30.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 15.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 15.00 from ins_payment, other_member;


-- Row 316: 2022-03-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 25.00, 'GBP', 1, '2022-03-04', 25.00, '2022-03-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 25.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.50 from ins_payment, other_member;


-- Row 317: 2022-03-09 Service charge - 2020 balance
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Service charge - 2020 balance', 1549.80, 'GBP', 1, '2022-03-09', 1549.80, '2022-03-09', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 1549.80 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 774.90 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 774.90 from ins_payment, other_member;


-- Row 318: 2022-04-01 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 81.00, 'GBP', 1, '2022-04-01', 81.00, '2022-04-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 81.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 40.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 40.50 from ins_payment, other_member;


-- Row 319: 2022-04-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2022-04-01', 24.00, '2022-04-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 320: 2022-04-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 17.50, 'GBP', 1, '2022-04-01', 17.50, '2022-04-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 8.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 8.75 from ins_payment, other_member;


-- Row 321: 2022-04-01 Hot Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot Water', 30.00, 'GBP', 1, '2022-04-01', 30.00, '2022-04-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 30.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 15.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 15.00 from ins_payment, other_member;


-- Row 322: 2022-04-02 Louise B. paid Ben S.
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Louise B. paid Ben S.', 826.38, 'GBP', 1, '2022-04-02', 826.38, '2022-04-02', 'settlements', null, 'settlement', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 826.38 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, other_member.user_id, 826.38 from ins_payment, other_member;


-- Row 323: 2022-04-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 25.00, 'GBP', 1, '2022-04-04', 25.00, '2022-04-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 25.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.50 from ins_payment, other_member;


-- Row 324: 2022-04-10 Egypt holiday deposit
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Egypt holiday deposit', 600.00, 'GBP', 1, '2022-04-10', 600.00, '2022-04-10', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 600.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 300.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 300.00 from ins_payment, other_member;


-- Row 325: 2022-04-21 Hot water difference
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot water difference', 30.00, 'GBP', 1, '2022-04-21', 30.00, '2022-04-21', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 30.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 15.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 15.00 from ins_payment, other_member;


-- Row 326: 2022-05-01 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 81.00, 'GBP', 1, '2022-05-01', 81.00, '2022-05-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 81.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 40.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 40.50 from ins_payment, other_member;


-- Row 327: 2022-05-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2022-05-01', 24.00, '2022-05-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 328: 2022-05-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 17.50, 'GBP', 1, '2022-05-01', 17.50, '2022-05-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 8.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 8.75 from ins_payment, other_member;


-- Row 329: 2022-05-01 Hot Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot Water', 30.00, 'GBP', 1, '2022-05-01', 30.00, '2022-05-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 30.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 15.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 15.00 from ins_payment, other_member;


-- Row 330: 2022-05-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 25.00, 'GBP', 1, '2022-05-04', 25.00, '2022-05-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 25.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.50 from ins_payment, other_member;


-- Row 331: 2022-05-10 Council revate
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council revate', 75.00, 'GBP', 1, '2022-05-10', 75.00, '2022-05-10', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 75.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 37.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 37.50 from ins_payment, other_member;


-- Row 332: 2022-05-14 Peak District
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Peak District', 488.00, 'GBP', 1, '2022-05-14', 488.00, '2022-05-14', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 488.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 244.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 244.00 from ins_payment, other_member;


-- Row 333: 2022-05-14 Travelodge lake district
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Travelodge lake district', 45.00, 'GBP', 1, '2022-05-14', 45.00, '2022-05-14', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 45.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 22.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 22.50 from ins_payment, other_member;


-- Row 334: 2022-05-17 Premier inn Portsmouth
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Premier inn Portsmouth', 209.00, 'GBP', 1, '2022-05-17', 209.00, '2022-05-17', 'travel', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 209.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 104.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 104.50 from ins_payment, other_member;


-- Row 335: 2022-05-17 Glasgow flights
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Glasgow flights', 70.00, 'GBP', 1, '2022-05-17', 70.00, '2022-05-17', 'travel', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 70.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 35.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 35.00 from ins_payment, other_member;


-- Row 336: 2022-05-28 Ben S. paid Louise B.
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Ben S. paid Louise B.', 500.00, 'GBP', 1, '2022-05-28', 500.00, '2022-05-28', 'settlements', null, 'settlement', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 500.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, other_member.user_id, 500.00 from ins_payment, other_member;


-- Row 337: 2022-06-01 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 81.00, 'GBP', 1, '2022-06-01', 81.00, '2022-06-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 81.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 40.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 40.50 from ins_payment, other_member;


-- Row 338: 2022-06-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2022-06-01', 24.00, '2022-06-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 339: 2022-06-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 17.50, 'GBP', 1, '2022-06-01', 17.50, '2022-06-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 8.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 8.75 from ins_payment, other_member;


-- Row 340: 2022-06-01 Hot Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot Water', 30.00, 'GBP', 1, '2022-06-01', 30.00, '2022-06-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 30.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 15.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 15.00 from ins_payment, other_member;


-- Row 341: 2022-06-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 25.00, 'GBP', 1, '2022-06-04', 25.00, '2022-06-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 25.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.50 from ins_payment, other_member;


-- Row 342: 2022-06-17 Civil ceremony
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Civil ceremony', 674.00, 'GBP', 1, '2022-06-17', 674.00, '2022-06-17', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 674.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 337.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 337.00 from ins_payment, other_member;


-- Row 343: 2022-06-18 Go boats
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Go boats', 95.00, 'GBP', 1, '2022-06-18', 95.00, '2022-06-18', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 95.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 47.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 47.50 from ins_payment, other_member;


-- Row 344: 2022-06-25 France car hire
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'France car hire', 166.00, 'GBP', 1, '2022-06-25', 166.00, '2022-06-25', 'transport', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 166.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 83.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 83.00 from ins_payment, other_member;


-- Row 345: 2022-06-25 Manatee France House
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Manatee France House', 250.00, 'GBP', 1, '2022-06-25', 250.00, '2022-06-25', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 250.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 125.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 125.00 from ins_payment, other_member;


-- Row 346: 2022-07-01 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 81.00, 'GBP', 1, '2022-07-01', 81.00, '2022-07-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 81.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 40.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 40.50 from ins_payment, other_member;


-- Row 347: 2022-07-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2022-07-01', 24.00, '2022-07-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 348: 2022-07-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 17.50, 'GBP', 1, '2022-07-01', 17.50, '2022-07-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 8.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 8.75 from ins_payment, other_member;


-- Row 349: 2022-07-01 Hot Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Hot Water', 30.00, 'GBP', 1, '2022-07-01', 30.00, '2022-07-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 30.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 15.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 15.00 from ins_payment, other_member;


-- Row 350: 2022-07-04 Internet
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Internet', 25.00, 'GBP', 1, '2022-07-04', 25.00, '2022-07-04', 'internet_phone', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 25.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.50 from ins_payment, other_member;


-- Row 351: 2022-07-11 Service charge
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Service charge', 695.00, 'GBP', 1, '2022-07-11', 695.00, '2022-07-11', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 695.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 347.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 347.50 from ins_payment, other_member;


-- Row 352: 2022-07-16 National Trust Membership
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'National Trust Membership', 127.00, 'GBP', 1, '2022-07-16', 127.00, '2022-07-16', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 127.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 63.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 63.50 from ins_payment, other_member;


-- Row 353: 2022-07-22 Handmade Food Deposit
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Handmade Food Deposit', 471.80, 'GBP', 1, '2022-07-22', 471.80, '2022-07-22', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 471.80 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 235.90 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 235.90 from ins_payment, other_member;


-- Row 354: 2022-07-24 Rangers House deposite
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Rangers House deposite', 1770.00, 'GBP', 1, '2022-07-24', 1770.00, '2022-07-24', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 1770.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 885.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 885.00 from ins_payment, other_member;


-- Row 355: 2022-07-24 Egypt
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Egypt', 7090.00, 'GBP', 1, '2022-07-24', 7090.00, '2022-07-24', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 7090.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 3545.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 3545.00 from ins_payment, other_member;


-- Row 356: 2022-07-24 Ben S. paid Louise B.
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Ben S. paid Louise B.', 5885.15, 'GBP', 1, '2022-07-24', 5885.15, '2022-07-24', 'settlements', null, 'settlement', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 5885.15 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, other_member.user_id, 5885.15 from ins_payment, other_member;


-- Row 357: 2022-07-27 Council tax
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Council tax', 152.00, 'GBP', 1, '2022-07-27', 152.00, '2022-07-27', 'other', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 152.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 76.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 76.00 from ins_payment, other_member;


-- Row 358: 2022-08-01 Electrcity
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Electrcity', 81.00, 'GBP', 1, '2022-08-01', 81.00, '2022-08-01', 'utilities', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 81.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 40.50 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 40.50 from ins_payment, other_member;


-- Row 359: 2022-08-01 Water
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Louise Billingham' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Water', 24.00, 'GBP', 1, '2022-08-01', 24.00, '2022-08-01', 'household_bills', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 24.00 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 12.00 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 12.00 from ins_payment, other_member;


-- Row 360: 2022-08-01 Apple music and icloud
with th as (select id from finance_app.households order by created_at asc limit 1),
actor as (select user_id as id from finance_app.household_members where display_name = 'Ben Selby' limit 1),
payer as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Ben Selby' limit 1),
other_member as (select user_id from finance_app.household_members hm join th on hm.household_id = th.id where hm.display_name = 'Louise Billingham' limit 1),
ins_payment as (
  insert into finance_app.payments (household_id, title, amount, currency_code, fx_rate_to_gbp, fx_rate_date, amount_gbp, payment_date, category_key, notes, source_type, created_by)
  select th.id, 'Apple music and icloud', 17.50, 'GBP', 1, '2022-08-01', 17.50, '2022-08-01', 'groceries', null, 'one_off', actor.id from th, actor
  returning id
)
insert into finance_app.payment_contributions (payment_id, user_id, amount)
select ins_payment.id, payer.user_id, 17.50 from ins_payment, payer;
insert into finance_app.payment_splits (payment_id, user_id, amount)
  select ins_payment.id, payer.user_id, 8.75 from ins_payment, payer
  union all
  select ins_payment.id, other_member.user_id, 8.75 from ins_payment, other_member;



commit;
