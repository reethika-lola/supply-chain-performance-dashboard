USE supply_chain_analytics;

-- Row-count and key validation
SELECT 'staging' AS layer, COUNT(*) AS rows, COUNT(DISTINCT order_item_id) AS distinct_order_item_ids
FROM stg_dataco_raw
UNION ALL
SELECT 'fact', COUNT(*), COUNT(DISTINCT order_item_id) FROM fact_order_items
UNION ALL
SELECT 'tableau_view', COUNT(*), COUNT(DISTINCT order_item_id) FROM vw_tableau_order_items;

-- Totals must agree between the fact and Tableau source.
SELECT 'fact' AS layer, ROUND(SUM(revenue),2) revenue, COUNT(DISTINCT order_id) orders, SUM(quantity) units, ROUND(SUM(profit),2) profit
FROM fact_order_items
UNION ALL
SELECT 'tableau_view', ROUND(SUM(revenue),2), COUNT(DISTINCT order_id), SUM(quantity), ROUND(SUM(profit),2)
FROM vw_tableau_order_items;

-- Orphan checks must return zero rows.
SELECT 'missing_date' AS issue, COUNT(*) AS rows
FROM fact_order_items f LEFT JOIN dim_date d ON f.order_date_key=d.date_key WHERE d.date_key IS NULL
UNION ALL SELECT 'missing_product', COUNT(*) FROM fact_order_items f LEFT JOIN dim_product p ON f.product_key=p.product_key WHERE p.product_key IS NULL
UNION ALL SELECT 'missing_customer', COUNT(*) FROM fact_order_items f LEFT JOIN dim_customer c ON f.customer_key=c.customer_key WHERE c.customer_key IS NULL
UNION ALL SELECT 'missing_geography', COUNT(*) FROM fact_order_items f LEFT JOIN dim_geography g ON f.geography_key=g.geography_key WHERE g.geography_key IS NULL
UNION ALL SELECT 'missing_shipping', COUNT(*) FROM fact_order_items f LEFT JOIN dim_shipping s ON f.shipping_key=s.shipping_key WHERE s.shipping_key IS NULL;
