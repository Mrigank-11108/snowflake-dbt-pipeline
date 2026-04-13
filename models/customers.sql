CREATE OR REPLACE TABLE CUSTOMERS AS
WITH customer_orders AS (
    SELECT
        user_id,
        MIN(order_date) AS first_order,
        MAX(order_date) AS most_recent_order,
        COUNT(id) AS number_of_orders
    FROM raw_orders
    GROUP BY 1
),
customer_payments AS (
    SELECT
        o.user_id,
        SUM(p.amount) AS customer_lifetime_value
    FROM raw_payments p
    LEFT JOIN raw_orders o ON p.order_id = o.id
    GROUP BY 1
)
SELECT
    c.id AS customer_id,
    c.first_name,
    c.last_name,
    co.first_order,
    co.most_recent_order,
    co.number_of_orders,
    COALESCE(cp.customer_lifetime_value, 0) AS customer_lifetime_value
FROM raw_customers c
LEFT JOIN customer_orders co ON c.id = co.user_id
LEFT JOIN customer_payments cp ON c.id = cp.user_id;