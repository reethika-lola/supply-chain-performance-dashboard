# Interview Preparation

## 30-second explanation

I built a MySQL and Tableau supply-chain analytics project using public DataCo order-item data. I preserved the raw source, designed a star schema at order-item grain, created quality and reconciliation checks, and specified dashboards for sales, profitability, delivery risk, products, and geography.

## 1-minute explanation

The project starts with a public CSV that includes sales, profit, shipping, product, customer-segment, and geographic fields. I load the source into a staging table so it remains unchanged, then create date, product, customer, geography, and shipping dimensions around an order-item fact table. The key modeling decision is to count distinct orders because an order can have several item rows. Tableau connects to cleaned SQL views rather than raw data. I excluded inventory and supplier analysis because the source does not contain those entities.

## 2-minute explanation

I approached this as a recruiter-ready analytics project rather than a dashboard-only exercise. First, I documented source access, licensing as declared by the selected Kaggle listing, the published data dictionary, and known limits. The raw data stays separate from transformations. In MySQL, I use a staging layer, data-quality checks for duplicate IDs, missing business keys, invalid quantities, and date parsing, then build a simple star schema. The fact is at Order Item Id grain; dimensions capture date, product/category, customer segment, geography, and shipping attributes.

The analysis includes KPI, sales, profitability, delivery, regional, and advanced trend queries. It uses joins, CTEs, conditional aggregation, DENSE_RANK, LAG, and running totals for clear business questions. I created Tableau-ready views and a three-dashboard specification. One important integrity point is that the late-delivery-risk field is source-provided. Because there is no promised delivery date, I do not falsely label it on-time delivery. I also set up validation so revenue and distinct orders reconcile from fact to view to Tableau. Results are intentionally not published until the source is executed.

## Technical questions

1. Why stage the data? It preserves raw values and supports repeatable transformations.
2. What is the fact grain? One source Order Item Id.
3. Why use distinct order count? One order may contain many items.
4. Why a star schema? It simplifies joins and business reporting.
5. Why use surrogate keys? They create stable, compact dimension relationships.
6. What does a CTE improve? It improves readability for multi-step logic.
7. What does LAG do here? It compares monthly revenue with the prior month.
8. Why DENSE_RANK? It ranks tied products/categories fairly.
9. How do you prevent divide-by-zero? NULLIF in the denominator.
10. What is an orphan record? A fact row with no matching dimension.
11. How is raw data protected? It is loaded to staging and never overwritten.
12. Why clean text? Trimming prevents duplicate-looking groups.
13. Why exclude email and password? They are unnecessary for analysis and sensitive.
14. Why index foreign keys? To support fact-to-dimension joins.
15. Why use SQL views in Tableau? To centralize KPI-ready logic.
16. How do you validate totals? Reconcile staging, fact, view, and Tableau scope.
17. Why not calculate on-time delivery? No promised delivery date exists.
18. What does source late-delivery risk mean? It is a supplied binary flag.
19. Why exclude inventory? The source lacks inventory records.
20. What is a window function? It calculates across related rows without collapsing them.

## Business questions

1. Why these KPIs? They balance commercial performance, profitability, and operations.
2. How would a manager use the dashboard? To identify segments for investigation.
3. What would you check if sales fell? Month, region, category, product, units, and order counts.
4. How would you investigate delivery risk? Compare shipping mode, market, region, and category.
5. What causes weak margin? It may relate to mix or discount; investigate before asserting cause.
6. How do you validate dashboard numbers? Use matching filters and SQL reconciliation.
7. What is the main limitation? Historical public data lacks operational root-cause fields.
8. What data would improve delivery analysis? Carrier, promised date, route, and dispatch events.
9. What data would improve inventory analysis? On-hand stock, reorder points, supplier, and lead time.
10. Can this analysis prove causality? No; it is descriptive.
11. Why Tableau? It provides an accessible interactive layer over governed SQL views.
12. Why MySQL? It is familiar, reproducible, and appropriate for portfolio-scale analytics.
13. How would you respond to a high-risk region? Validate the segment, then investigate operational context.
14. How would you improve this project? Add verified COGS, returns, inventory, supplier, and carrier data.
15. What is the key modeling lesson? Aggregations must respect the fact table grain.
