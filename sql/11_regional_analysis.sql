USE supply_chain_analytics;
SELECT g.market, g.order_region, ROUND(SUM(f.revenue),2) revenue, ROUND(SUM(f.profit),2) profit,
       COUNT(DISTINCT f.order_id) orders,
       ROUND(100*SUM(f.revenue)/SUM(SUM(f.revenue)) OVER (),2) revenue_contribution_pct
FROM fact_order_items f JOIN dim_geography g ON f.geography_key=g.geography_key
GROUP BY g.market, g.order_region ORDER BY revenue DESC;
