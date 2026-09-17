USE supply_chain_analytics;

-- Rebuild all analytical tables from immutable staging data.
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE fact_order_items; TRUNCATE TABLE dim_shipping; TRUNCATE TABLE dim_geography;
TRUNCATE TABLE dim_customer; TRUNCATE TABLE dim_product; TRUNCATE TABLE dim_date;
SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO dim_date (date_key, full_date, calendar_year, calendar_quarter, calendar_month, month_name, year_month)
SELECT DISTINCT DATE_FORMAT(d, '%Y%m%d') + 0, d, YEAR(d), QUARTER(d), MONTH(d),
       DATE_FORMAT(d, '%M'), DATE_FORMAT(d, '%Y-%m')
FROM (
  SELECT DATE(STR_TO_DATE(TRIM(order_date_raw), '%m/%d/%Y %H:%i')) AS d
  FROM stg_dataco_raw
) x WHERE d IS NOT NULL;

INSERT INTO dim_product (product_id, product_name, product_category_id, category_id, category_name,
                         department_id, department_name, list_price, product_status)
SELECT CAST(TRIM(product_card_id) AS UNSIGNED), NULLIF(TRIM(product_name), ''),
       NULLIF(TRIM(product_category_id), '') + 0, NULLIF(TRIM(category_id), '') + 0,
       NULLIF(TRIM(category_name), ''), NULLIF(TRIM(department_id), '') + 0, NULLIF(TRIM(department_name), ''),
       NULLIF(TRIM(product_price), '') + 0, NULLIF(TRIM(product_status), '') + 0
FROM stg_dataco_raw
WHERE NULLIF(TRIM(product_card_id), '') IS NOT NULL
GROUP BY product_card_id, product_name, product_category_id, category_id, category_name,
         department_id, department_name, product_price, product_status;

INSERT INTO dim_customer (customer_id, customer_segment, customer_city, customer_state, customer_country)
SELECT CAST(TRIM(customer_id) AS UNSIGNED), NULLIF(TRIM(customer_segment), ''), NULLIF(TRIM(customer_city), ''),
       NULLIF(TRIM(customer_state), ''), NULLIF(TRIM(customer_country), '')
FROM stg_dataco_raw WHERE NULLIF(TRIM(customer_id), '') IS NOT NULL
GROUP BY customer_id, customer_segment, customer_city, customer_state, customer_country;

INSERT INTO dim_geography (market, order_region, order_country, order_state, order_city, latitude, longitude)
SELECT COALESCE(NULLIF(TRIM(market), ''), 'Unknown'), COALESCE(NULLIF(TRIM(order_region), ''), 'Unknown'),
       COALESCE(NULLIF(TRIM(order_country), ''), 'Unknown'), COALESCE(NULLIF(TRIM(order_state), ''), 'Unknown'),
       COALESCE(NULLIF(TRIM(order_city), ''), 'Unknown'), NULLIF(TRIM(latitude), '') + 0, NULLIF(TRIM(longitude), '') + 0
FROM stg_dataco_raw
GROUP BY market, order_region, order_country, order_state, order_city, latitude, longitude;

INSERT INTO dim_shipping (shipping_mode, delivery_status, late_delivery_risk, actual_shipping_days, scheduled_shipping_days)
SELECT COALESCE(NULLIF(TRIM(shipping_mode), ''), 'Unknown'), COALESCE(NULLIF(TRIM(delivery_status), ''), 'Unknown'),
       NULLIF(TRIM(late_delivery_risk), '') + 0, NULLIF(TRIM(days_shipping_real), '') + 0,
       NULLIF(TRIM(days_shipment_scheduled), '') + 0
FROM stg_dataco_raw
GROUP BY shipping_mode, delivery_status, late_delivery_risk, days_shipping_real, days_shipment_scheduled;
