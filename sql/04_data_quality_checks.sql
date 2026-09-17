USE supply_chain_analytics;

SELECT COUNT(*) AS rows_loaded, COUNT(DISTINCT order_item_id) AS distinct_order_item_ids
FROM stg_dataco_raw;

SELECT order_item_id, COUNT(*) AS occurrences
FROM stg_dataco_raw GROUP BY order_item_id HAVING COUNT(*) > 1;

SELECT
  SUM(order_item_id IS NULL OR TRIM(order_item_id) = '') AS missing_order_item_id,
  SUM(order_id IS NULL OR TRIM(order_id) = '') AS missing_order_id,
  SUM(customer_id IS NULL OR TRIM(customer_id) = '') AS missing_customer_id,
  SUM(product_card_id IS NULL OR TRIM(product_card_id) = '') AS missing_product_id,
  SUM(order_item_quantity REGEXP '^-?[0-9]+$' AND CAST(order_item_quantity AS SIGNED) <= 0) AS nonpositive_quantity,
  SUM(sales REGEXP '^-?[0-9.]+$' AND CAST(sales AS DECIMAL(14,2)) < 0) AS negative_gross_sales
FROM stg_dataco_raw;

SELECT delivery_status, COUNT(*) AS rows_per_status
FROM stg_dataco_raw GROUP BY delivery_status ORDER BY rows_per_status DESC;

SELECT market, COUNT(*) AS rows_per_market
FROM stg_dataco_raw GROUP BY market ORDER BY rows_per_market DESC;

-- Review parsing before production use: dataset commonly uses m/d/Y H:i formatting.
SELECT order_date_raw, shipping_date_raw
FROM stg_dataco_raw
WHERE STR_TO_DATE(order_date_raw, '%m/%d/%Y %H:%i') IS NULL
   OR STR_TO_DATE(shipping_date_raw, '%m/%d/%Y %H:%i') IS NULL
LIMIT 50;
