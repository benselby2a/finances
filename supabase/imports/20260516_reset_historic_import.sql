begin;

delete from finance_app.payment_contributions
where payment_id in (
  select id from finance_app.payments where deleted_at is null
);

delete from finance_app.payment_splits
where payment_id in (
  select id from finance_app.payments where deleted_at is null
);

delete from finance_app.payments
where deleted_at is null;

commit;
