# Supply Chain Performance Dashboard

### SQL | Tableau | Data Analytics

A polished, reproducible supply-chain analytics portfolio project using the public [DataCo Smart Supply Chain dataset](https://www.kaggle.com/datasets/shashwatwork/dataco-smart-supply-chain-for-big-data-analysis).

## Overview

This project models public order-item data into a MySQL 8 star schema and Tableau-ready views for sales, profitability, delivery-risk, product, customer-segment, and geographic analysis.

**Completed:** source-aware data model, ingestion and quality checks, analytical SQL, Tableau build package, validation logic, and recruiter documentation.  
**Intentionally not claimed:** CSV-derived results, a native Tableau workbook, screenshots, or executed MySQL output.

## Business Problem

Management needs a clear view of commercial performance and fulfillment patterns to identify product, market, and shipping segments worth investigating. Read the [business problem](docs/business-problem.md) and [business questions](docs/business-questions.md).

## Objectives

- Preserve the raw source and create a reproducible analytical pipeline.
- Measure revenue, order volume, units, profit, margin, shipping duration, and source late-delivery risk.
- Prevent incorrect aggregation by modeling at order-item grain.
- Deliver a Tableau-ready dashboard specification with traceable KPI logic.

## Dataset

- **Dataset:** DataCo SMART SUPPLY CHAIN FOR BIG DATA ANALYSIS
- **Source:** [Kaggle](https://www.kaggle.com/datasets/shashwatwork/dataco-smart-supply-chain-for-big-data-analysis)
- **Structured file:** DataCoSupplyChainDataset.csv
- **License:** the selected Kaggle listing declares CC0; the raw CSV is not redistributed in this repository.
- **Scope:** sales, profit, shipping, product, customer segment, and geography.
- **Exclusions:** no verified inventory, supplier, warehouse, carrier, COGS, or promised-delivery-date entity.

The [data access record](docs/data-profile.md) clearly distinguishes verified source metadata from unavailable execution results. See the [data dictionary](docs/data-dictionary.md) for the source fields used.

## Architecture and Model

Public dataset → raw CSV → profiling → MySQL staging → cleaning → star schema → analytical views → Tableau → business insights.

- [Architecture](docs/architecture.md)
- [Star data model](docs/data-model.md)
- [Pipeline and execution order](docs/data-pipeline.md)
- [SQL run order](sql/README.md)

## KPI Framework

| Area | KPIs |
|---|---|
| Commercial | Total Revenue, Total Orders, Units Sold, Average Order Value |
| Profitability | Total Profit, Profit Margin |
| Operations | Average Actual Shipping Days, Schedule Variance, Late Delivery Risk % |
| Segmentation | Monthly, market/region, category, product, and shipping-mode performance |

Definitions, source fields, SQL logic, Tableau formulas, and caveats are in [KPI definitions](docs/kpi-definitions.md).

## SQL Analysis

The MySQL 8 layer includes staging, cleaning, dimensions, an order-item fact table, Tableau views, quality checks, KPI queries, sales/profitability/delivery/regional analysis, CTEs, window functions, and reconciliation checks.

- [Analysis guide](docs/sql-analysis.md)
- [Static validation record](docs/static-validation.md)
- [SQL scripts](sql/)

Orders always use a distinct count of Order Id because the fact table grain is one Order Item Id.

## Tableau Dashboard

Three Tableau dashboards are specified:

1. Supply Chain Executive Overview
2. Delivery and Operations
3. Product and Profitability

The [Tableau dashboard specification](docs/tableau-dashboard-guide.md), [calculated fields](tableau/calculated-fields.md), [source connection](tableau/data-connection.md), and [build checklist](tableau/tableau-build-checklist.md) are ready for Tableau Desktop or Tableau Public. A native workbook is not included because Tableau software was unavailable for validation.

## Insights and Recommendations

No numerical business claim is published without an executed source-data query. The [insights](docs/business-insights.md) and [recommendations](docs/recommendations.md) retain evidence-first templates, avoiding invented results.

## Repository Structure

    data/        Source policy, raw and processed locations
    docs/        Business, model, profiling, KPI, validation, and career material
    scripts/     Source-data profiler
    sql/         MySQL schema, load, cleaning, views, analysis, and validation
    tableau/     Tableau-ready build package
    screenshots/ Location for genuine Tableau exports only

## Tech Stack

MySQL 8 · Tableau Desktop/Public · Python standard library for profiling · GitHub

## Skills Demonstrated

SQL joins, CTEs, window functions, data quality, relational modeling, KPI design, analytical views, Tableau dashboard design, validation, business communication, and documentation.

## Limitations and Future Enhancements

See [limitations](docs/limitations.md). With a verified operational source, future work could add inventory, supplier, carrier, cost-of-goods, returns, and promised-delivery-date analysis.

## Career Materials

- [Interview preparation](docs/interview-preparation.md)
- [Resume bullets](docs/resume-bullets.md)

## Author

Reethika Lola
