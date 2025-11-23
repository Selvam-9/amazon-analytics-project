-- ========================================
-- EXECUTIVE METRICS VIEW
-- ========================================
CREATE OR REPLACE VIEW vw_revenue_summary AS
SELECT 
    year,
    SUM(final_amount_inr) AS total_revenue,
    SUM(quantity) AS total_units,
    COUNT(DISTINCT customer_id) AS active_customers
FROM fact_sales
JOIN dim_date ON fact_sales.date_key = dim_date.date_key
GROUP BY year
ORDER BY year;

-- ========================================
-- CATEGORY PERFORMANCE VIEW
-- ========================================
CREATE OR REPLACE VIEW vw_category_performance AS
SELECT
    dp.category,
    dp.subcategory,
    SUM(fs.final_amount_inr) AS category_revenue,
    SUM(fs.quantity) AS units_sold,
    AVG(fs.customer_rating) AS avg_rating
FROM fact_sales fs
JOIN dim_product dp ON fs.product_id = dp.product_id
GROUP BY dp.category, dp.subcategory;

-- ========================================
-- BRAND MARKET SHARE VIEW
-- ========================================
CREATE OR REPLACE VIEW vw_brand_market_share AS
SELECT
    dp.brand,
    dd.year,
    SUM(fs.final_amount_inr) AS brand_revenue,
    SUM(SUM(fs.final_amount_inr)) OVER (PARTITION BY dd.year) AS year_total,
    SUM(fs.final_amount_inr) / SUM(SUM(fs.final_amount_inr)) OVER (PARTITION BY dd.year) AS market_share
FROM fact_sales fs
JOIN dim_product dp ON fs.product_id = dp.product_id
JOIN dim_date dd ON fs.date_key = dd.date_key
GROUP BY dp.brand, dd.year;

-- ========================================
-- RFM VIEW (Customer Segmentation)
-- ========================================
CREATE OR REPLACE VIEW vw_rfm AS
WITH latest AS (
    SELECT MAX(date_key) AS max_date FROM fact_sales
),
rfm_base AS (
    SELECT
        fs.customer_id,
        MAX(fs.date_key) AS last_purchase,
        COUNT(*) AS frequency,
        SUM(fs.final_amount_inr) AS monetary
    FROM fact_sales fs
    GROUP BY fs.customer_id
)
SELECT
    r.customer_id,
    (SELECT max_date FROM latest) - r.last_purchase AS recency_days,
    r.frequency,
    r.monetary
FROM rfm_base r;

-- ========================================
-- MONTHLY SALES VIEW (for forecasting)
-- ========================================
CREATE OR REPLACE VIEW vw_monthly_sales AS
SELECT
    DATE_TRUNC('month', date_key) AS month,
    SUM(final_amount_inr) AS revenue
FROM fact_sales
GROUP BY DATE_TRUNC('month', date_key)
ORDER BY month;
