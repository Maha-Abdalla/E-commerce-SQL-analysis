-- Total revenue
SELECT SUM(payment_value) AS total_revenue FROM payments;

-- Orders by status
SELECT order_status, COUNT(*) AS total_orders
FROM orders
GROUP BY order_status;

-- Top cities
SELECT customers.customer_city, COUNT(*) AS total_orders
FROM orders
JOIN customers 
ON orders.customer_id = customers.customer_id
GROUP BY customers.customer_city
ORDER BY total_orders DESC
LIMIT 5;

-- Top orders
SELECT order_id, SUM(payment_value) AS order_total
FROM payments
GROUP BY order_id
ORDER BY order_total DESC
LIMIT 5;

-- Monthly revenue trend
SELECT 
    strftime('%Y-%m', orders.order_purchase_timestamp) AS month,
    SUM(CAST(payments.payment_value AS REAL)) AS revenue
FROM payments
JOIN orders 
ON payments.order_id = orders.order_id
WHERE orders.order_purchase_timestamp IS NOT NULL
GROUP BY month
ORDER BY month;

-- Repeat customer percentage
SELECT 
    ROUND(
        100.0 * SUM(CASE WHEN order_count > 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS repeat_customer_percentage
FROM (
    SELECT 
        customer_id,
        COUNT(order_id) AS order_count
    FROM orders
    GROUP BY customer_id
);

-- Average order value
SELECT 
    AVG(order_total) AS avg_order_value
FROM (
    SELECT 
        order_id,
        SUM(CAST(payment_value AS REAL)) AS order_total
    FROM payments
    GROUP BY order_id
);

