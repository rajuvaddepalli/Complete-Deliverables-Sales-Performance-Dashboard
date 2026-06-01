-- ============================================================
-- Script 03: Regional Sales Analysis
-- ============================================================

USE sales_db;

-- ── Regional Revenue & Profit Summary ──
SELECT
    region,
    COUNT(DISTINCT customer_id)                         AS customers,
    COUNT(DISTINCT order_id)                            AS orders,
    ROUND(SUM(sales), 2)                                AS revenue,
    ROUND(SUM(profit), 2)                               AS profit,
    ROUND(SUM(profit) / NULLIF(SUM(sales),0) * 100, 1) AS margin_pct,
    ROUND(AVG(discount) * 100, 1)                       AS avg_discount_pct,
    ROUND(SUM(sales) / COUNT(DISTINCT order_id), 2)     AS avg_order_value
FROM sales_data
GROUP BY region
ORDER BY revenue DESC;


-- ── Revenue Share by Region (%) ──
SELECT
    region,
    ROUND(SUM(sales), 2)                                AS revenue,
    ROUND(SUM(sales) / SUM(SUM(sales)) OVER () * 100, 1) AS revenue_share_pct
FROM sales_data
GROUP BY region
ORDER BY revenue DESC;


-- ── State-Level Breakdown (Top 15 States) ──
SELECT
    state,
    region,
    ROUND(SUM(sales), 2)    AS revenue,
    ROUND(SUM(profit), 2)   AS profit,
    COUNT(DISTINCT order_id) AS orders
FROM sales_data
GROUP BY state, region
ORDER BY revenue DESC
LIMIT 15;


-- ── Region × Segment Cross-Tab ──
SELECT
    region,
    segment,
    ROUND(SUM(sales), 2)    AS revenue,
    COUNT(DISTINCT order_id) AS orders
FROM sales_data
GROUP BY region, segment
ORDER BY region, revenue DESC;


-- ── High Discount Regions (risk flag) ──
SELECT
    region,
    ROUND(AVG(discount)*100,1)  AS avg_discount_pct,
    ROUND(SUM(sales),2)         AS revenue,
    ROUND(SUM(profit),2)        AS profit,
    CASE
        WHEN AVG(discount) > 0.20 THEN 'HIGH RISK'
        WHEN AVG(discount) > 0.15 THEN 'MEDIUM'
        ELSE 'HEALTHY'
    END AS discount_flag
FROM sales_data
GROUP BY region
ORDER BY avg_discount_pct DESC;
