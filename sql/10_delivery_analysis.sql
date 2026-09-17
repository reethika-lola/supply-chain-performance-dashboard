USE supply_chain_analytics;
SELECT s.shipping_mode, COUNT(DISTINCT f.order_id) orders,
       ROUND(AVG(s.actual_shipping_days),2) avg_actual_days,
       ROUND(AVG(s.scheduled_shipping_days),2) avg_scheduled_days,
       ROUND(AVG(s.actual_shipping_days-s.scheduled_shipping_days),2) avg_schedule_variance_days,
       ROUND(100*AVG(s.late_delivery_risk=1),2) late_delivery_risk_pct
FROM fact_order_items f JOIN dim_shipping s ON f.shipping_key=s.shipping_key
GROUP BY s.shipping_mode ORDER BY late_delivery_risk_pct DESC;

SELECT g.order_region, COUNT(DISTINCT f.order_id) orders,
       ROUND(AVG(s.actual_shipping_days),2) avg_actual_days,
       ROUND(100*AVG(s.late_delivery_risk=1),2) late_delivery_risk_pct
FROM fact_order_items f JOIN dim_geography g ON f.geography_key=g.geography_key
JOIN dim_shipping s ON f.shipping_key=s.shipping_key
GROUP BY g.order_region ORDER BY late_delivery_risk_pct DESC;
