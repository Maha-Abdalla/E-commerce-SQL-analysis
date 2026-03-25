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
