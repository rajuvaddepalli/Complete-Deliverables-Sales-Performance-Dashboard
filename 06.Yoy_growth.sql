-- ============================================================
-- Script 06: Year-over-Year Growth Analysis
-- ============================================================

USE sales_db;

-- ── Annual Summary ──
SELECT
    YEAR(order_date)                                    AS year,
    ROUND(SUM(sales),2)                                 AS revenue,
    ROUND(SUM(profit),2)                                AS profit,
    COUNT(DISTINCT order_id)                            AS orders,
    COUNT(DISTINCT customer_id)                         AS customers,
    ROUND(SUM(profit)/NULLIF(SUM(sales),0)*100,1)       AS margin_pct
FROM sales_data
GROUP BY YEAR(order_date)
ORDER BY year;


-- ── YOY Revenue Growth with Window Functions ──
SELECT
    year,
    revenue,
    prev_year_revenue,
    ROUND(revenue - prev_year_revenue, 2)               AS yoy_absolute_change,
    ROUND((revenue - prev_year_revenue)
          / NULLIF(prev_year_revenue, 0) * 100, 1)      AS yoy_growth_pct
FROM (
    SELECT
        YEAR(order_date)                                AS year,
        ROUND(SUM(sales),2)                             AS revenue,
        ROUND(LAG(SUM(sales)) OVER (ORDER BY YEAR(order_date)), 2) AS prev_year_revenue
    FROM sales_data
    GROUP BY YEAR(order_date)
) yoy
ORDER BY year;


-- ── Same Period Last Year (SPLY) — Rolling Comparison ──
SELECT
    curr.month,
    ROUND(curr.revenue,2)                               AS current_revenue,
    ROUND(prev.revenue,2)                               AS sply_revenue,
    ROUND((curr.revenue - prev.revenue)
          / NULLIF(prev.revenue,0)*100,1)               AS growth_pct
FROM (
    SELECT DATE_FORMAT(order_date,'%Y-%m') AS month,
           MONTH(order_date) AS m, YEAR(order_date) AS y,
           SUM(sales) AS revenue
    FROM sales_data GROUP BY month, m, y
) curr
LEFT JOIN (
    SELECT MONTH(order_date) AS m, YEAR(order_date) AS y,
           SUM(sales) AS revenue
    FROM sales_data GROUP BY m, y
) prev ON curr.m = prev.m AND curr.y = prev.y + 1
ORDER BY curr.month;


-- ── Cohort: New vs Returning Customers Revenue ──
WITH first_order AS (
    SELECT customer_id, MIN(order_date) AS first_purchase_date
    FROM sales_data
    GROUP BY customer_id
)
SELECT
    YEAR(s.order_date)                                  AS year,
    CASE
        WHEN YEAR(s.order_date) = YEAR(f.first_purchase_date) THEN 'New Customer'
        ELSE 'Returning Customer'
    END                                                 AS customer_type,
    COUNT(DISTINCT s.customer_id)                       AS customers,
    ROUND(SUM(s.sales),2)                               AS revenue
FROM sales_data s
JOIN first_order f ON s.customer_id = f.customer_id
GROUP BY YEAR(s.order_date), customer_type
ORDER BY year, customer_type;
