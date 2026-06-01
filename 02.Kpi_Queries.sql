-- ============================================================
-- Script 02: Core KPI Calculations
-- These are the headline numbers for the executive dashboard
-- ============================================================

USE sales_db;

-- ── KPI 1: Total Revenue, Profit, Orders, Avg Order Value ──
SELECT
    COUNT(DISTINCT order_id)                            AS total_orders,
    ROUND(SUM(sales), 2)                                AS total_revenue,
    ROUND(SUM(profit), 2)                               AS total_profit,
    ROUND(SUM(profit) / NULLIF(SUM(sales), 0) * 100, 1) AS profit_margin_pct,
    ROUND(SUM(sales) / COUNT(DISTINCT order_id), 2)     AS avg_order_value,
    ROUND(AVG(discount) * 100, 1)                       AS avg_discount_pct
FROM sales_data;


-- ── KPI 2: Monthly Revenue Trend ──
SELECT
    DATE_FORMAT(order_date, '%Y-%m')    AS month,
    YEAR(order_date)                    AS year,
    MONTH(order_date)                   AS month_num,
    COUNT(DISTINCT order_id)            AS orders,
    ROUND(SUM(sales), 2)                AS revenue,
    ROUND(SUM(profit), 2)               AS profit,
    ROUND(SUM(profit)/SUM(sales)*100,1) AS margin_pct
FROM sales_data
GROUP BY DATE_FORMAT(order_date, '%Y-%m'), YEAR(order_date), MONTH(order_date)
ORDER BY year, month_num;


-- ── KPI 3: Quarterly Performance ──
SELECT
    YEAR(order_date)                    AS year,
    QUARTER(order_date)                 AS quarter,
    CONCAT('Q', QUARTER(order_date), '-', YEAR(order_date)) AS period,
    ROUND(SUM(sales), 2)                AS revenue,
    ROUND(SUM(profit), 2)               AS profit,
    COUNT(DISTINCT order_id)            AS orders,
    COUNT(DISTINCT customer_id)         AS unique_customers
FROM sales_data
GROUP BY YEAR(order_date), QUARTER(order_date)
ORDER BY year, quarter;


-- ── KPI 4: Current Month vs Previous Month ──
SELECT
    curr.month,
    curr.revenue                        AS current_revenue,
    prev.revenue                        AS prev_revenue,
    ROUND((curr.revenue - prev.revenue) / NULLIF(prev.revenue, 0) * 100, 1) AS mom_growth_pct
FROM (
    SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(sales) AS revenue
    FROM sales_data GROUP BY month
) curr
LEFT JOIN (
    SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(sales) AS revenue
    FROM sales_data GROUP BY month
) prev ON DATE_FORMAT(DATE_SUB(STR_TO_DATE(CONCAT(curr.month,'-01'),'%Y-%m-%d'), INTERVAL 1 MONTH),'%Y-%m') = prev.month
ORDER BY curr.month;
