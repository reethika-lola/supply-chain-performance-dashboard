USE supply_chain_analytics;
WITH monthly AS (
 SELECT d.year_month, SUM(f.revenue) revenue
 FROM fact_order_items f JOIN dim_date d ON f.order_date_key=d.date_key GROUP BY d.year_month
)
SELECT year_month, ROUND(revenue,2) revenue,
       ROUND(100*(revenue-LAG(revenue) OVER(ORDER BY year_month))/NULLIF(LAG(revenue) OVER(ORDER BY year_month),0),2) mom_growth_pct,
       ROUND(SUM(revenue) OVER(ORDER BY year_month),2) running_revenue
FROM monthly ORDER BY year_month;

WITH category_sales AS (
 SELECT p.category_name, SUM(f.revenue) revenue
 FROM fact_order_items f JOIN dim_product p ON f.product_key=p.product_key GROUP BY p.category_name
)
SELECT category_name, ROUND(revenue,2) revenue,
       ROUND(100*revenue/SUM(revenue) OVER(),2) contribution_pct,
       DENSE_RANK() OVER(ORDER BY revenue DESC) revenue_rank
FROM category_sales ORDER BY revenue_rank;
