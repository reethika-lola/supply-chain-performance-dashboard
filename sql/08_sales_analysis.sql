USE supply_chain_analytics;
-- Monthly trend
SELECT d.year_month, ROUND(SUM(f.revenue),2) revenue, COUNT(DISTINCT f.order_id) orders, SUM(f.quantity) units
FROM fact_order_items f JOIN dim_date d ON f.order_date_key=d.date_key
GROUP BY d.year_month ORDER BY d.year_month;
-- Category performance
SELECT p.category_name, ROUND(SUM(f.revenue),2) revenue, COUNT(DISTINCT f.order_id) orders, SUM(f.quantity) units
FROM fact_order_items f JOIN dim_product p ON f.product_key=p.product_key
GROUP BY p.category_name ORDER BY revenue DESC;
-- Top 10 products
SELECT p.product_name, ROUND(SUM(f.revenue),2) revenue, SUM(f.quantity) units,
       DENSE_RANK() OVER (ORDER BY SUM(f.revenue) DESC) AS revenue_rank
FROM fact_order_items f JOIN dim_product p ON f.product_key=p.product_key
GROUP BY p.product_name ORDER BY revenue DESC LIMIT 10;
