-- 1. Basic data preview
SELECT *
FROM olist_orders_dataset
LIMIT 10;


-- 2. Total number of orders
SELECT COUNT(*) AS total_orders
FROM olist_orders_dataset;


-- 3. Orders by status
SELECT 
    order_status,
    COUNT(*) AS total_orders
FROM olist_orders_dataset
GROUP BY order_status
ORDER BY total_orders DESC;


-- 4. Total sales (using order items price)
SELECT 
    SUM(price) AS total_sales
FROM olist_order_items_dataset;


-- 5. Total freight value
SELECT 
    SUM(freight_value) AS total_freight
FROM olist_order_items_dataset;


-- 6. Total revenue (price + freight)
SELECT 
    SUM(price + freight_value) AS total_revenue
FROM olist_order_items_dataset;


-- 7. Orders per customer
SELECT 
    customer_id,
    COUNT(order_id) AS total_orders
FROM olist_orders_dataset
GROUP BY customer_id
ORDER BY total_orders DESC
LIMIT 10;


-- 8. Join orders + customers
SELECT 
    o.order_id,
    o.order_status,
    c.customer_city,
    c.customer_state
FROM olist_orders_dataset o
JOIN olist_customers_dataset c
ON o.customer_id = c.customer_id
LIMIT 10;


-- 9. Sales by state
SELECT 
    c.customer_state,
    SUM(oi.price) AS total_sales
FROM olist_order_items_dataset oi
JOIN olist_orders_dataset o
    ON oi.order_id = o.order_id
JOIN olist_customers_dataset c
    ON o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY total_sales DESC;


-- 10. Top 10 customers by spending
SELECT 
    o.customer_id,
    SUM(oi.price) AS total_spent
FROM olist_order_items_dataset oi
JOIN olist_orders_dataset o
    ON oi.order_id = o.order_id
GROUP BY o.customer_id
ORDER BY total_spent DESC
LIMIT 10;


-- 11. Average order value
SELECT 
    AVG(price) AS avg_order_value
FROM olist_order_items_dataset;


-- 12. Monthly order trend
SELECT 
    strftime('%Y-%m', order_purchase_timestamp) AS month,
    COUNT(*) AS total_orders
FROM olist_orders_dataset
GROUP BY month
ORDER BY month;
