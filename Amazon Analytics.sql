CREATE TABLE fact_sales AS
SELECT
    transaction_id,
    order_date,
    customer_id,
    product_id,
    quantity,
    final_amount_inr,
    delivery_days,
    delivery_type,
    discount_percent,
    discounted_price_inr,
    original_price_inr,
    payment_method,
    return_status,
    customer_rating
FROM facts_transactions;
