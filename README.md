# Supply Chain Performance Dashboard

### SQL | Tableau | Data Analytics

A recruiter-focused supply-chain analytics portfolio project built around the public [DataCo Smart Supply Chain dataset](https://www.kaggle.com/datasets/shashwatwork/dataco-smart-supply-chain-for-big-data-analysis).

> Status: the GitHub project, MySQL pipeline, and Tableau build package are complete. The raw CSV requires the account-authenticated Kaggle download, so numerical findings and a native Tableau workbook remain deliberately unclaimed until the pipeline is executed.

## Project Overview

This project turns public order-item data into a clean MySQL analytical model and Tableau-ready views. It covers commercial performance, product profitability, delivery timing, delivery-risk segmentation, customer segment, and geography—without fabricating unsupported supplier or inventory analysis.

## Business Problem

Management needs a concise way to monitor sales, profit, product mix, delivery performance, and geographic variation. Read the [business problem](docs/business-problem.md) and supported [business questions](docs/business-questions.md).

## Dataset

- **Name:** DataCo SMART SUPPLY CHAIN FOR BIG DATA ANALYSIS
- **Source:** [Kaggle](https://www.kaggle.com/datasets/shashwatwork/dataco-smart-supply-chain-for-big-data-analysis)
- **Expected file:** DataCoSupplyChainDataset.csv
- **Reported scale:** approximately 180,519 order-item rows and 53 listed columns (verify with the included profiler)
- **License:** the selected Kaggle listing declares CC0; raw data is not redistributed here.
- **Scope:** sales, profit, delivery, product, customer, and geography. No actual supplier, inventory, warehouse, or promised-delivery-date entity is modeled.

Detailed download, attribution, and caveats are in [data/README.md](data/README.md).

## Data Architecture

Public dataset → raw CSV → profiling → MySQL staging → cleaning/derived metrics → star schema → analytical views → Tableau → findings.

See the [architecture diagram](docs/architecture.md), [data model](docs/data-model.md), and [reproduction guide](docs/data-pipeline.md).

## KPI Framework

- Total Revenue
- Total Orders (distinct order IDs)
- Units Sold
- Average Order Value
- Total Profit and Profit Margin
- Average Actual Shipping Days
- Late Delivery Risk %
- Average Schedule Variance Days

Definitions, formulas, and caveats: [KPI framework](docs/kpi-definitions.md).

## SQL Analysis

The MySQL 8 scripts provide:

- Immutable source staging and schema creation
- Data-quality checks and cleaning transformations
- Order-item fact table with date, product, customer, geography, and shipping dimensions
- Sales, profitability, delivery, regional, and window-function analysis
- Tableau-ready views

Start with [sql/01_create_database.sql](sql/01_create_database.sql) and follow the numbered files.

## Tableau Dashboard

Three professional dashboard designs are specified:

1. **Supply Chain Executive Overview**
2. **Delivery & Operations**
3. **Product & Profitability**

The source connection, calculated fields, worksheet layouts, interactions, and validation checklist are in [tableau/](tableau/README.md). A native workbook is not included because Tableau Desktop was unavailable for validation.

## Key Insights and Recommendations

Numerical results are intentionally pending the authenticated source download and pipeline execution. This prevents fabricated evidence. The exact templates for populated results are in [business insights](docs/business-insights.md) and [recommendations](docs/recommendations.md).

## Project Structure

```text
.
├── data/          # source policy and local data locations
├── docs/          # business, model, KPI, quality, and career documentation
├── scripts/       # source-data profiler
├── sql/           # MySQL schema, load, cleaning, analysis, and views
├── tableau/       # Tableau build package
└── screenshots/   # genuine dashboard exports to add after build
```

## Tools & Technologies

- MySQL 8
- Tableau Desktop or Tableau Public
- Python 3 standard library (profiling only)
- GitHub

## How to Reproduce

1. Download the CSV from the linked Kaggle page and place it in data/raw.
2. Run: python scripts/profile_dataset.py
3. Execute SQL scripts 01 through 06, then create views.
4. Run SQL analyses 07 through 12.
5. Connect Tableau to vw_tableau_order_items.
6. Build, validate, and export the three dashboards.
7. Write only calculated results into the insights and recommendation documents.

## Validation

Revenue must match across raw staging, fact_order_items, vw_tableau_order_items, and Tableau for the same filter scope. Orders are always counted with distinct order_id.

## Limitations

See [limitations](docs/limitations.md). The main analytical guardrails are that this is historical public data, delivery risk is source-provided, and no inventory/supplier or promised-delivery analysis is claimed.

## Career Materials

- [Interview preparation](docs/interview-preparation.md)
- [Resume bullets](docs/resume-bullets.md)

## Author

Reethika Lola
