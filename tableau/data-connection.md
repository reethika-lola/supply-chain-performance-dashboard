# Data Connection

1. In Tableau Desktop choose Connect, To a Server, MySQL.
2. Connect to database supply_chain_analytics.
3. Drag vw_tableau_order_items to the data source canvas.
4. Confirm order_date is Date and revenue, profit, and profit_margin_pct are numeric.
5. Create an extract only after MySQL validation passes.

This source is at item grain. Every order measure must be a distinct count of order_id.
