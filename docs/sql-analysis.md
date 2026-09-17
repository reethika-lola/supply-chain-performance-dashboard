# SQL Analysis Guide

All SQL is written for MySQL 8 and has been statically reviewed against the project schema. It was not executed because neither MySQL nor a compatible SQL runtime is installed in this environment.

| File | Business question | Technique | Output meaning |
|---|---|---|---|
| 04_data_quality_checks.sql | Is the source fit for modeling? | null checks, duplicate checks, parsing tests, distributions | Identifies issues before transformation |
| 07_kpi_analysis.sql | What is overall commercial and delivery performance? | aggregates, distinct count, conditional aggregation | Executive KPI row |
| 08_sales_analysis.sql | How do sales change and which products/categories lead? | grouping, ordering, ranking | Trend and top-N tables |
| 09_profitability_analysis.sql | Which categories/products generate profit and margin? | aggregation, HAVING, safe division | Profitability prioritization |
| 10_delivery_analysis.sql | Which modes and regions show higher delivery risk? | joins, conditional aggregation | Comparative operations measures |
| 11_regional_analysis.sql | Where are revenue and profit concentrated? | joins, contribution window calculation | Market/region performance |
| 12_advanced_analysis.sql | How does performance change month to month? | CTE, LAG, running total, DENSE_RANK | MoM and concentration analysis |
| 13_validation.sql | Do facts, views, and dimensions reconcile? | UNION ALL, distinct counts, orphan checks | Publishing gate |

## Guardrails

- The fact table is at Order Item Id grain. Use distinct Order Id for orders.
- Revenue is sourced from Order Item Total, while gross sales is retained separately.
- Profit uses source Order Profit Per Order; it is not reconstructed from unavailable cost data.
- Late delivery risk is a published flag. It is not transformed into an on-time SLA claim.
- Every margin expression uses NULLIF to prevent divide-by-zero errors.
