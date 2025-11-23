-- ==============================
-- CREATE RAW TABLES
-- ==============================

CREATE TABLE raw_transactions (
    transaction_id        VARCHAR(50),
    order_date            DATE,
    customer_id           VARCHAR(50),
    product_id            VARCHAR(50),
    product_name          TEXT,
    category              VARCHAR(100),
    subcategory           VARCHAR(100),
    brand                 VARCHAR(100),
    original_price_inr    NUMERIC(12,2),
    discount_percent      NUMERIC(5,2),
    discounted_price_inr  NUMERIC(12,2),
    quantity              INT,
    subtotal_inr          NUMERIC(12,2),
    delivery_charges      NUMERIC(12,2),
    final_amount_inr      NUMERIC(12,2),
    customer_city         VARCHAR(100),
    customer_state        VARCHAR(100),
    customer_tier         VARCHAR(50),
    customer_spending_tier VARCHAR(50),
    customer_age_group    VARCHAR(50),
    payment_method        VARCHAR(50),
    delivery_days         INT,
    delivery_type         VARCHAR(50),
    is_prime_member       BOOLEAN,
    is_festival_sale      BOOLEAN,
    festival_name         VARCHAR(100),
    customer_rating       NUMERIC(3,1),
    return_status         VARCHAR(50),
    order_month           INT,
    order_year            INT,
    order_quarter         INT,
    product_weight_kg     NUMERIC(8,3),
    is_prime_eligible     BOOLEAN,
    product_rating        NUMERIC(3,1),
    order_day             INT
);

-- Customer dimension
CREATE TABLE dim_customer (
    customer_id          VARCHAR(50) PRIMARY KEY,
    customer_city        VARCHAR(100),
    customer_state       VARCHAR(100),
    customer_tier        VARCHAR(50),
    customer_spending_tier VARCHAR(50),
    customer_age_group   VARCHAR(50),
    is_prime_member      BOOLEAN
);

-- Product dimension
CREATE TABLE dim_product (
    product_id           VARCHAR(50) PRIMARY KEY,
    product_name         TEXT,
    category             VARCHAR(100),
    subcategory          VARCHAR(100),
    brand                VARCHAR(100),
    product_weight_kg    NUMERIC(8,3),
    is_prime_eligible    BOOLEAN,
    product_rating       NUMERIC(3,1)
);

-- Date dimension
CREATE TABLE dim_date (
    date_key             DATE PRIMARY KEY,
    day                  INT,
    month                INT,
    year                 INT,
    quarter              INT,
    month_name           VARCHAR(20),
    day_name             VARCHAR(20),
    week_of_year         INT
);
