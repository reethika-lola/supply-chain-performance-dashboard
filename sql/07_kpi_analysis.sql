USE supply_chain_analytics;
SELECT
  COUNT(DISTINCT f.order_id) AS total_orders,
  COUNT(*) AS order_items,
  SUM(f.quantity) AS units_sold,
  ROUND(SUM(f.revenue), 2) AS total_revenue,
  ROUND(SUM(f.profit), 2) AS total_profit,
  ROUND(100 * SUM(f.profit) / NULLIF(SUM(f.revenue), 0), 2) AS profit_margin_pct,
  ROUND(SUM(f.revenue) / NULLIF(COUNT(DISTINCT f.order_id), 0), 2) AS average_order_value,
  ROUND(AVG(s.actual_shipping_days), 2) AS avg_actual_shipping_days,
  ROUND(AVG(s.scheduled_shipping_days), 2) AS avg_scheduled_shipping_days,
  ROUND(100 * AVG(s.late_delivery_risk = 1), 2) AS late_delivery_risk_pct
FROM fact_order_items f JOIN dim_shipping s ON f.shipping_key = s.shipping_key;
