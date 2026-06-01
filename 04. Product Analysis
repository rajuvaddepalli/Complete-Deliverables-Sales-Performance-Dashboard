-- ============================================================
-- Script 04: Product & Category Analysis
-- ============================================================

USE sales_db;

-- ── Category-Level Performance ──
SELECT
    category,
    COUNT(DISTINCT product_id)                          AS products,
    COUNT(DISTINCT order_id)                            AS orders,
    SUM(quantity)                                       AS units_sold,
    ROUND(SUM(sales), 2)                                AS revenue,
    ROUND(SUM(profit), 2)                               AS profit,
    ROUND(SUM(profit)/NULLIF(SUM(sales),0)*100,1)       AS margin_pct
FROM sales_data
GROUP BY category
ORDER BY revenue DESC;


-- ── Sub-Category Performance ──
SELECT
    category,
    sub_category,
    ROUND(SUM(sales), 2)                                AS revenue,
    ROUND(SUM(profit), 2)                               AS profit,
    ROUND(SUM(profit)/NULLIF(SUM(sales),0)*100,1)       AS margin_pct,
    SUM(quantity)                                       AS units_sold
FROM sales_data
GROUP BY category, sub_category
ORDER BY category, revenue DESC;


-- ── Top 10 Products by Revenue ──
SELECT
    ROW_NUMBER() OVER (ORDER BY SUM(sales) DESC)        AS rank_no,
    product_name,
    category,
    sub_category,
    ROUND(SUM(sales), 2)                                AS revenue,
    ROUND(SUM(profit), 2)                               AS profit,
    SUM(quantity)                                       AS units_sold
FROM sales_data
GROUP BY product_name, category, sub_category
ORDER BY revenue DESC
LIMIT 10;


-- ── Bottom 10 Products by Profit (loss-makers) ──
SELECT
    product_name,
    category,
    ROUND(SUM(sales), 2)    AS revenue,
    ROUND(SUM(profit), 2)   AS profit,
    ROUND(AVG(discount)*100,1) AS avg_discount_pct
FROM sales_data
GROUP BY product_name, category
HAVING profit < 0
ORDER BY profit ASC
LIMIT 10;


-- ── YOY Category Growth ──
SELECT
    category,
    YEAR(order_date)                                    AS year,
    ROUND(SUM(sales),2)                                 AS revenue,
    ROUND(SUM(sales) - LAG(SUM(sales)) OVER (
        PARTITION BY category ORDER BY YEAR(order_date)
    ), 2)                                               AS yoy_change,
    ROUND((SUM(sales) - LAG(SUM(sales)) OVER (
        PARTITION BY category ORDER BY YEAR(order_date)
    )) / NULLIF(LAG(SUM(sales)) OVER (
        PARTITION BY category ORDER BY YEAR(order_date)
    ), 0) * 100, 1)                                     AS yoy_growth_pct
FROM sales_data
GROUP BY category, YEAR(order_date)
ORDER BY category, year;
