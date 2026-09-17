# Calculated Fields

| Field | Formula | Purpose |
|---|---|---|
| Total Orders | COUNTD([order_id]) | Correct order count |
| Profit Margin % | SUM([profit]) / NULLIF(SUM([revenue]),0) | Profitability ratio |
| Avg Schedule Variance Days | AVG([schedule_variance_days]) | Actual minus scheduled shipping |
| Late Delivery Risk % | AVG([late_delivery_risk]) | Source risk flag as a rate |
| Delayed-Risk Orders | COUNTD(IF [late_delivery_risk] = 1 THEN [order_id] END) | Affected-order volume |
| Revenue Contribution % | SUM([revenue]) / TOTAL(SUM([revenue])) | Share within view |

Format rates as percentages. Do not label source late-delivery-risk as On-Time %.
