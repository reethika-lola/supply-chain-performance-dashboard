# Tableau Dashboard Specification

This is a Tableau-native build specification, not a claim that a Tableau workbook has been created.

## Shared foundation

Source: MySQL view vw_tableau_order_items.  
Global filters: order date, market or region, category, and shipping mode.  
Shared calculations: Total Orders as a distinct count of order_id; Profit Margin as profit divided by revenue; Late Delivery Risk % as average of the source flag; Schedule Variance as actual shipping days minus scheduled shipping days.

## 1. Supply Chain Executive Overview

Layout: six KPI cards across the top, monthly trend on the left, category and market bars in the center, and order status/top products on the right.

Worksheets:
- KPI cards: revenue, distinct orders, units, profit, margin, average actual shipping days, and late delivery risk percent.
- Monthly Revenue Trend: month of order date by revenue.
- Revenue by Market: market by revenue.
- Revenue by Category: category by revenue.
- Order Status: delivery status by distinct orders.
- Top Products: product name by revenue, top 10.

Actions: selecting a category or market filters the product chart; selecting a product highlights its marks.

## 2. Delivery and Operations

Layout: four KPI cards across the top, shipping-mode comparison and regional heatmap in the first row, trend and distribution below.

Worksheets:
- Shipping Mode Performance: mode by average actual days, scheduled days, and late-risk percent.
- Regional Risk: order region by late-risk percent.
- Delivery-Risk Trend: month by late-risk percent.
- Delay-risk by Category: category by delayed-risk distinct orders.
- Schedule Variance Distribution: histogram of variance days.

Tooltip: order count, actual days, scheduled days, variance, and late-risk percent. The dashboard must not call any measure on-time delivery because promised date is absent.

## 3. Product and Profitability

Layout: four KPI cards, category bars and a scatterplot on the first row, product leaders and profit trend below.

Worksheets:
- Category Revenue and Profit: category by revenue and profit.
- Top Products by Revenue: product by revenue, top 10.
- Top Products by Profit: product by profit, top 10.
- Revenue versus Profit: product scatterplot, size by units.
- Monthly Profit Trend: order month by profit.

Optional parameter: Select Metric with Revenue, Profit, Distinct Orders, and Units. Use only to change a comparative category/market chart, not core KPI definitions.
