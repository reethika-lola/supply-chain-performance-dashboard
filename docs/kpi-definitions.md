# KPI Definitions

| KPI | Business meaning | Source fields | MySQL logic | Tableau calculation | Caveat |
|---|---|---|---|---|---|
| Total Revenue | Net item revenue in the selected scope | Order Item Total | SUM(revenue) | SUM([revenue]) | Source item total is used rather than an inferred value |
| Total Orders | Unique commercial orders | Order Id | COUNT(DISTINCT order_id) | COUNTD([order_id]) | Fact grain is one order item |
| Units Sold | Units across item rows | Order Item Quantity | SUM(quantity) | SUM([quantity]) | Includes retained source rows only |
| Average Order Value | Revenue per distinct order | Order Item Total, Order Id | SUM(revenue) / COUNT(DISTINCT order_id) | SUM([revenue]) / COUNTD([order_id]) | Safe division is required |
| Total Profit | Source profit contribution | Order Profit Per Order | SUM(profit) | SUM([profit]) | Not recomputed without COGS |
| Profit Margin | Profit relative to revenue | Profit, Order Item Total | SUM(profit) / NULLIF(SUM(revenue),0) | SUM([profit]) / NULLIF(SUM([revenue]),0) | Null when revenue is zero |
| Avg Actual Shipping Days | Typical actual shipping duration | Days for shipping (real) | AVG(actual_shipping_days) | AVG([actual_shipping_days]) | Not a promised-date SLA |
| Avg Scheduled Shipping Days | Typical planned shipping duration | Days for shipment (scheduled) | AVG(scheduled_shipping_days) | AVG([scheduled_shipping_days]) | Scheduled days are not an expected delivery date |
| Schedule Variance | Actual minus scheduled shipping duration | Actual and scheduled days | AVG(actual - scheduled) | AVG([schedule_variance_days]) | Positive values indicate a longer actual duration |
| Late Delivery Risk % | Share with source risk flag equal to 1 | Late_delivery_risk | 100 * AVG(flag = 1) | AVG([late_delivery_risk]) | Source-provided risk flag; do not call it on-time delivery |
| Delayed-Risk Orders | Distinct orders carrying source risk | Order Id, Late_delivery_risk | COUNT(DISTINCT CASE WHEN flag=1 THEN order_id END) | COUNTD(IF [late_delivery_risk]=1 THEN [order_id] END) | Reflects source flag only |
| Monthly Revenue | Revenue trend by order month | order date, Order Item Total | GROUP BY year_month | MONTH([order_date]), SUM([revenue]) | Requires parsed dates |
| Revenue Growth | Change from prior month | Monthly revenue | LAG(monthly revenue) | Table calculation from prior month | Prior month must exist |
| Regional Sales | Revenue by market/region | Market, Order Region, revenue | GROUP BY market, region | SUM([revenue]) by region | Geographic meaning is source-defined |
| Category Sales | Revenue by product category | Category Name, revenue | GROUP BY category_name | SUM([revenue]) by category | Category text should be cleaned |
| Product Profitability | Product revenue, profit, and margin | Product Name, revenue, profit | GROUP BY product_name | Product-level measures | Interpret with order volume |
