# Interview Preparation

## 30-second explanation

I built a MySQL and Tableau supply-chain analytics project using DataCo public order-item data. I preserved raw data, profiled it, created a star schema at order-item grain, validated revenue and distinct-order logic, and designed dashboards for sales, profitability, delivery risk, products, and geography.

## Technical and business questions

1. Why a staging table? It preserves source data and makes reruns traceable.
2. What is the fact grain? One source Order Item Id.
3. Why distinct order count? An order can contain multiple line items.
4. Why surrogate keys? Compact, stable dimension joins.
5. Why a star schema? Clear analysis and Tableau performance.
6. What does a CTE improve? Readability and reuse in a query.
7. What does LAG answer? Month-over-month revenue change.
8. What does DENSE_RANK answer? Product/category rankings with ties.
9. How is divide-by-zero handled? NULLIF in the denominator.
10. What is an orphan check? A fact record with no dimension match.
11. Why preserve raw data? Auditability and reproducibility.
12. Why trim text? Avoid false groups caused by spacing.
13. Why omit email/password? They are unnecessary and sensitive.
14. Why index fact foreign keys? Faster joins and filters.
15. Why use views for Tableau? Central business logic.
16. How are totals validated? Compare staging, fact, view, and Tableau.
17. Why not calculate on-time delivery? There is no promised delivery date.
18. What does late delivery risk measure? A source-provided binary flag.
19. Why exclude inventory? The source has no inventory entity.
20. What is a window function? A calculation across related rows without collapsing them.
21. Why these KPIs? They cover volume, profitability, and fulfillment timing.
22. How would you investigate delays? Segment by mode, market, region, and category.
23. How would management use it? Prioritize patterns for investigation.
24. Why SQL? Repeatable transformations and metric definitions.
25. Why Tableau? Fast visual exploration for business users.
26. How would you investigate poor margin? Compare mix, product, and discount patterns.
27. What delivery root-cause data is missing? Carrier, promised date, route, and dispatch events.
28. What inventory data is missing? On-hand, reorder point, supplier, and lead time.
29. Can it prove causality? No, it is descriptive.
30. What is the key modeling lesson? Aggregate according to fact grain.
