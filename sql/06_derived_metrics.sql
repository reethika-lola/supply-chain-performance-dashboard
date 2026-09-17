USE supply_chain_analytics;

INSERT INTO fact_order_items (
  order_item_id, order_id, order_date_key, product_key, customer_key, geography_key, shipping_key,
  quantity, gross_sales, discount_amount, discount_rate, revenue, profit, profit_ratio_pct, item_price
)
SELECT CAST(TRIM(r.order_item_id) AS UNSIGNED), CAST(TRIM(r.order_id) AS UNSIGNED), d.date_key,
       p.product_key, c.customer_key, g.geography_key, s.shipping_key,
       CAST(TRIM(r.order_item_quantity) AS SIGNED), NULLIF(TRIM(r.sales), '') + 0,
       NULLIF(TRIM(r.order_item_discount), '') + 0, NULLIF(TRIM(r.order_item_discount_rate), '') + 0,
       NULLIF(TRIM(r.order_item_total), '') + 0, NULLIF(TRIM(r.order_profit_per_order), '') + 0,
       NULLIF(TRIM(r.order_item_profit_ratio), '') + 0, NULLIF(TRIM(r.order_item_product_price), '') + 0
FROM stg_dataco_raw r
JOIN dim_date d ON d.full_date = DATE(STR_TO_DATE(TRIM(r.order_date_raw), '%m/%d/%Y %H:%i'))
JOIN dim_product p ON p.product_id = CAST(TRIM(r.product_card_id) AS UNSIGNED)
JOIN dim_customer c ON c.customer_id = CAST(TRIM(r.customer_id) AS UNSIGNED)
JOIN dim_geography g ON g.market = COALESCE(NULLIF(TRIM(r.market), ''), 'Unknown')
  AND g.order_region = COALESCE(NULLIF(TRIM(r.order_region), ''), 'Unknown')
  AND g.order_country = COALESCE(NULLIF(TRIM(r.order_country), ''), 'Unknown')
  AND g.order_state = COALESCE(NULLIF(TRIM(r.order_state), ''), 'Unknown')
  AND g.order_city = COALESCE(NULLIF(TRIM(r.order_city), ''), 'Unknown')
JOIN dim_shipping s ON s.shipping_mode = COALESCE(NULLIF(TRIM(r.shipping_mode), ''), 'Unknown')
  AND s.delivery_status = COALESCE(NULLIF(TRIM(r.delivery_status), ''), 'Unknown')
  AND s.late_delivery_risk <=> (NULLIF(TRIM(r.late_delivery_risk), '') + 0)
  AND s.actual_shipping_days <=> (NULLIF(TRIM(r.days_shipping_real), '') + 0)
  AND s.scheduled_shipping_days <=> (NULLIF(TRIM(r.days_shipment_scheduled), '') + 0)
WHERE NULLIF(TRIM(r.order_item_id), '') IS NOT NULL
  AND NULLIF(TRIM(r.order_id), '') IS NOT NULL
  AND NULLIF(TRIM(r.product_card_id), '') IS NOT NULL
  AND NULLIF(TRIM(r.customer_id), '') IS NOT NULL
  AND NULLIF(TRIM(r.order_item_quantity), '') IS NOT NULL;

-- Reject rows missing required keys instead of silently substituting data.
SELECT COUNT(*) AS loaded_fact_rows FROM fact_order_items;
SELECT COUNT(*) - (SELECT COUNT(*) FROM fact_order_items) AS staging_rows_not_loaded FROM stg_dataco_raw;
