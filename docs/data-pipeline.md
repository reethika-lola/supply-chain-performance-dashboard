# Reproduction Guide

## Prerequisites

- MySQL 8.0+ with `LOCAL INFILE` enabled.
- Tableau Desktop or Tableau Public.
- Python 3.10+ (standard library only) for data profiling.

## Steps

1. Download `DataCoSupplyChainDataset.csv` from the [Kaggle source](https://www.kaggle.com/datasets/shashwatwork/dataco-smart-supply-chain-for-big-data-analysis).
2. Place it in `data/raw/` without renaming it.
3. Run `python scripts/profile_dataset.py`. Review the generated local profile before loading.
4. In MySQL, run `sql/01_create_database.sql` and `sql/02_create_tables.sql`.
5. Edit the absolute path in `sql/03_load_data.sql`, then run it with the MySQL client’s `--local-infile=1` option.
6. Run `sql/04_data_quality_checks.sql`; record any source-specific results.
7. Run `sql/05_data_cleaning.sql`, `sql/06_derived_metrics.sql`, and `sql/views/01_analytical_views.sql`.
8. Run analysis scripts `07` through `12`. Their results supply `docs/business-insights.md` and `docs/recommendations.md`.
9. Connect Tableau to the views according to `tableau/data-connection.md`.
10. Build and validate the dashboards using `tableau/dashboard-guide.md` and `tableau/tableau-build-checklist.md`.

## Validation rule

For the same filtered scope, total revenue from raw staging, `fact_order_items`, `vw_tableau_order_items`, and Tableau must agree. Count orders with distinct `order_id`, not fact rows.
