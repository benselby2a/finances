begin;
-- Generated import from manatee-towers_2026-05-16_export.csv (existing categories + settlements)


insert into finance_app.categories (key, label, icon_key, sort_order, is_active) values ('settlements', 'Settlements', 'repeat', 85, true) on conflict (key) do nothing;

commit;
