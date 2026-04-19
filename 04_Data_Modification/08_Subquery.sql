-- =========================
-- CREATE DATABASE
-- =========================
DROP DATABASE IF EXISTS e_commerce;
CREATE DATABASE e_commerce;
USE e_commerce;

-- =========================
-- CREATE TABLE
-- =========================
CREATE TABLE sales (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50),
    product VARCHAR(50),
    category VARCHAR(50),
    quantity INT,
    price DECIMAL(10,2),
    order_date DATE
);

-- =========================
-- INSERT DATA
-- =========================
INSERT INTO sales VALUES
(1, 'Asha', 'Bangalore', 'Laptop', 'Electronics', 1, 60000, '2023-09-01'),
(2, 'Rahul', 'Mumbai', 'Mobile', 'Electronics', 1, 25000, '2023-09-02'),
(3, 'Sneha', 'Delhi', 'Shoes', 'Fashion', 2, 3000, '2023-09-03'),
(4, 'Asha', 'Bangalore', 'Headphones', 'Electronics', 2, 2000, '2023-09-05'),
(5, 'Arjun', 'Chennai', 'Watch', 'Accessories', 1, 5000, '2023-09-06'),
(6, 'Meena', 'Hyderabad', 'T-shirt', 'Fashion', 3, 800, '2023-09-07'),
(7, 'Rahul', 'Mumbai', 'Laptop', 'Electronics', 1, 60000, '2023-09-08'),
(8, 'Divya', 'Bangalore', 'Bag', 'Accessories', 2, 1500, '2023-09-09'),
(9, 'Rohit', 'Delhi', 'Mobile', 'Electronics', 1, 25000, '2023-09-10'),
(10, 'Kiran', 'Pune', 'Shoes', 'Fashion', 1, 3000, '2023-09-11');

-- =========================
-- BASIC CHECK
-- =========================
SELECT * FROM sales;

-- =========================
-- 1. SUBQUERY IN WHERE
-- Orders with price greater than average price
-- =========================
SELECT *
FROM sales
WHERE price > (
    SELECT AVG(price) FROM sales
);

-- =========================
-- 2. SUBQUERY WITH IN
-- Customers who bought Electronics
-- =========================
SELECT *
FROM sales
WHERE customer_name IN (
    SELECT customer_name
    FROM sales
    WHERE category = 'Electronics'
);

-- =========================
-- 3. SUBQUERY WITH NOT IN
-- Customers who never bought Electronics
-- =========================
SELECT *
FROM sales
WHERE customer_name NOT IN (
    SELECT customer_name
    FROM sales
    WHERE category = 'Electronics'
);

-- =========================
-- 4. SUBQUERY IN SELECT
-- Show each order with overall average price
-- =========================
SELECT order_id, product, price,
       (SELECT AVG(price) FROM sales) AS avg_price
FROM sales;

-- =========================
-- 5. SUBQUERY IN FROM
-- Average price per category > 10000
-- =========================
SELECT *
FROM (
    SELECT category, AVG(price) AS avg_price
    FROM sales
    GROUP BY category
) AS temp
WHERE avg_price > 10000;

-- =========================
-- 6. CORRELATED SUBQUERY
-- Orders where price is greater than category average
-- =========================
SELECT *
FROM sales s1
WHERE price > (
    SELECT AVG(price)
    FROM sales s2
    WHERE s1.category = s2.category
);