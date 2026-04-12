Use retail_sales_db;
-- ======================
-- BASIC KPIs
-- ======================

SELECT SUM(quantity * price) AS total_revenue 
FROM sales;

SELECT COUNT(order_id) AS total_orders 
FROM sales;

SELECT COUNT(DISTINCT customer_id) AS total_customers 
FROM sales;

SELECT SUM(quantity) AS total_quantity_sold 
FROM sales;


-- ======================
-- BUSINESS ANALYSIS
-- ======================

-- City-wise Revenue
SELECT city, 
       SUM(quantity * price) AS revenue
FROM sales
GROUP BY city
ORDER BY revenue DESC;

-- Product-wise Revenue
SELECT product_name, 
       SUM(quantity * price) AS revenue
FROM sales
GROUP BY product_name
ORDER BY revenue DESC;

-- Top 5 Products by Revenue
SELECT product_name, 
       SUM(quantity * price) AS revenue
FROM sales
GROUP BY product_name
ORDER BY revenue DESC
LIMIT 5;

-- Bottom 5 Products by Revenue
SELECT product_name, 
       SUM(quantity * price) AS revenue
FROM sales
GROUP BY product_name
ORDER BY revenue ASC
LIMIT 5;


-- ======================
-- TIME & TREND ANALYSIS
-- ======================

-- Monthly Revenue Trend
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month,
       SUM(quantity * price) AS monthly_revenue
FROM sales
GROUP BY 1
ORDER BY 1;


-- ======================
-- CUSTOMER ANALYSIS
-- ======================

-- Repeat Customers
SELECT customer_id, 
       COUNT(order_id) AS total_orders
FROM sales
GROUP BY customer_id
HAVING COUNT(order_id) > 1;

-- Top 5 Customers by Spending
SELECT customer_id, 
       SUM(quantity * price) AS total_spent
FROM sales
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 5;

-- Average Order Value
SELECT SUM(quantity * price) / COUNT(DISTINCT order_id) AS avg_order_value
FROM sales;


-- ======================
-- ADDITIONAL INSIGHTS
-- ======================

-- Product Ranking using Window Function
SELECT 
    product_name,
    SUM(quantity * price) AS revenue,
    RANK() OVER (ORDER BY SUM(quantity * price) DESC) AS rank_position
FROM sales
GROUP BY product_name
ORDER BY revenue DESC;

-- Order Categorization using CASE Statement
SELECT 
    order_id,
    quantity * price AS order_value,
    CASE 
        WHEN quantity * price > 50000 THEN 'High Value'
        WHEN quantity * price BETWEEN 20000 AND 50000 THEN 'Medium Value'
        ELSE 'Normal'
    END AS order_category
FROM sales
ORDER BY order_value DESC;
   
