USE supply_chain_analytics;
CREATE OR REPLACE VIEW vw_tableau_order_items AS
SELECT f.order_item_id, f.order_id, d.full_date AS order_date, d.year_month, d.calendar_year,
       p.product_name, p.category_name, p.department_name, c.customer_segment,
       g.market, g.order_region, g.order_country, g.order_state, s.shipping_mode, s.delivery_status,
       s.late_delivery_risk, s.actual_shipping_days, s.scheduled_shipping_days,
       s.actual_shipping_days-s.scheduled_shipping_days AS schedule_variance_days,
       f.quantity, f.revenue, f.profit,
       100*f.profit/NULLIF(f.revenue,0) AS profit_margin_pct
FROM fact_order_items f JOIN dim_date d ON f.order_date_key=d.date_key
JOIN dim_product p ON f.product_key=p.product_key JOIN dim_customer c ON f.customer_key=c.customer_key
JOIN dim_geography g ON f.geography_key=g.geography_key JOIN dim_shipping s ON f.shipping_key=s.shipping_key;

CREATE OR REPLACE VIEW vw_monthly_sales AS
SELECT year_month, SUM(revenue) total_revenue, SUM(profit) total_profit, COUNT(DISTINCT order_id) total_orders,
       SUM(quantity) units_sold, 100*SUM(profit)/NULLIF(SUM(revenue),0) profit_margin_pct
FROM vw_tableau_order_items GROUP BY year_month;

CREATE OR REPLACE VIEW vw_regional_performance AS
SELECT market, order_region, SUM(revenue) total_revenue, SUM(profit) total_profit,
       COUNT(DISTINCT order_id) total_orders, AVG(actual_shipping_days) avg_actual_shipping_days,
       100*AVG(late_delivery_risk=1) late_delivery_risk_pct
FROM vw_tableau_order_items GROUP BY market, order_region;

CREATE OR REPLACE VIEW vw_product_performance AS
SELECT category_name, product_name, SUM(revenue) total_revenue, SUM(profit) total_profit,
       SUM(quantity) units_sold, 100*SUM(profit)/NULLIF(SUM(revenue),0) profit_margin_pct
FROM vw_tableau_order_items GROUP BY category_name, product_name;

CREATE OR REPLACE VIEW vw_delivery_performance AS
SELECT shipping_mode, delivery_status, market, order_region, category_name,
       COUNT(DISTINCT order_id) total_orders, AVG(actual_shipping_days) avg_actual_shipping_days,
       AVG(scheduled_shipping_days) avg_scheduled_shipping_days,
       AVG(schedule_variance_days) avg_schedule_variance_days, 100*AVG(late_delivery_risk=1) late_delivery_risk_pct
FROM vw_tableau_order_items GROUP BY shipping_mode, delivery_status, market, order_region, category_name;
