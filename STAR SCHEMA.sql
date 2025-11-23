-- ==============================
-- STAR SCHEMA
-- ==============================

CREATE TABLE fact_sales (
    transaction_id        VARCHAR(50),
    date_key              DATE,
    customer_id           VARCHAR(50),
    product_id            VARCHAR(50),
    quantity              INT,
    final_amount_inr      NUMERIC(12,2),
    subtotal_inr          NUMERIC(12,2),
    discount_percent      NUMERIC(5,2),
    delivery_days         INT,
    delivery_type         VARCHAR(50),
    payment_method        VARCHAR(50),
    is_festival_sale      BOOLEAN,
    festival_name         VARCHAR(100),
    return_status         VARCHAR(50),
    customer_rating       NUMERIC(3,1),
    PRIMARY KEY (transaction_id)
);

-- Foreign keys
ALTER TABLE fact_sales
    ADD CONSTRAINT fk_sales_date
    FOREIGN KEY (date_key)
    REFERENCES dim_date(date_key);

ALTER TABLE fact_sales
    ADD CONSTRAINT fk_sales_customer
    FOREIGN KEY (customer_id)
    REFERENCES dim_customer(customer_id);

ALTER TABLE fact_sales
    ADD CONSTRAINT fk_sales_product
    FOREIGN KEY (product_id)
    REFERENCES dim_product(product_id);
