USE supply_chain_analytics;
SELECT p.category_name, ROUND(SUM(f.revenue),2) revenue, ROUND(SUM(f.profit),2) profit,
       ROUND(100*SUM(f.profit)/NULLIF(SUM(f.revenue),0),2) margin_pct
FROM fact_order_items f JOIN dim_product p ON f.product_key=p.product_key
GROUP BY p.category_name ORDER BY profit DESC;

SELECT p.product_name, ROUND(SUM(f.revenue),2) revenue, ROUND(SUM(f.profit),2) profit,
       ROUND(100*SUM(f.profit)/NULLIF(SUM(f.revenue),0),2) margin_pct
FROM fact_order_items f JOIN dim_product p ON f.product_key=p.product_key
GROUP BY p.product_name HAVING SUM(f.revenue) > 0 ORDER BY margin_pct ASC LIMIT 10;
