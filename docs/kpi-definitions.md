# KPI Definitions

| KPI | Formula | Tableau calculation | Caveat |
|---|---|---|---|
| Total Revenue | SUM(revenue) | SUM([revenue]) | Uses source Order Item Total as net item revenue |
| Total Orders | COUNT(DISTINCT order_id) | COUNTD([order_id]) | Fact rows are order items |
| Units Sold | SUM(quantity) | SUM([quantity]) | Uses retained source rows |
| Average Order Value | revenue / distinct orders | SUM([revenue]) / COUNTD([order_id]) | Guard against zero orders |
| Total Profit | SUM(profit) | SUM([profit]) | Uses source Order Profit Per Order |
| Profit Margin | profit / revenue | SUM([profit]) / SUM([revenue]) | Return null when revenue is zero |
| Avg Actual Shipping Days | AVG(actual_shipping_days) | AVG([actual_shipping_days]) | Not a promised-delivery metric |
| Late Delivery Risk % | Average source flag | AVG([late_delivery_risk]) | Source-provided flag, not an SLA result |
| Schedule Variance Days | actual minus scheduled | AVG([schedule_variance_days]) | Positive means actual exceeded scheduled |
