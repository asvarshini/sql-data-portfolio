-- =========================
-- JOIN DATASET
-- =========================

DROP DATABASE IF EXISTS join_practice;
CREATE DATABASE join_practice;
USE join_practice;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    product VARCHAR(50),
    customer_id INT
);

-- Insert data
INSERT INTO customers VALUES
(1, 'Asha'),
(2, 'Rahul'),
(3, 'Sneha'),
(4, 'Kiran');

INSERT INTO orders VALUES
(101, 'Laptop', 1),
(102, 'Mobile', 1),
(103, 'Shoes', 2),
(104, 'Watch', 5);  -- No matching customer

-- =========================
-- BASIC CHECK
-- =========================
SELECT * FROM customers;
SELECT * FROM orders;

-- =========================
-- INNER JOIN (only matching)
-- =========================
SELECT *
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id;

-- =========================
-- LEFT JOIN (all customers)
-- =========================
SELECT *
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id;

-- =========================
-- RIGHT JOIN (all orders)
-- =========================
SELECT *
FROM customers c
RIGHT JOIN orders o
ON c.customer_id = o.customer_id;

-- =========================
-- FULL JOIN (MySQL workaround)
-- =========================
SELECT *
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id

UNION

SELECT *
FROM customers c
RIGHT JOIN orders o
ON c.customer_id = o.customer_id;

-- =========================
-- LEFT EXCLUSIVE JOIN (customers with no orders)
-- =========================
SELECT *
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;

-- =========================
-- RIGHT EXCLUSIVE JOIN (orders with no customer)
-- =========================
SELECT *
FROM customers c
RIGHT JOIN orders o
ON c.customer_id = o.customer_id
WHERE c.customer_id IS NULL;

-- =========================
-- FULL EXCLUSIVE JOIN (non-matching on both sides)
-- =========================
SELECT *
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL

UNION

SELECT *
FROM customers c
RIGHT JOIN orders o
ON c.customer_id = o.customer_id
WHERE c.customer_id IS NULL;

-- =========================
-- SELF JOIN (same table)
-- Example: customers with same ID (just demo)
-- =========================
SELECT c1.customer_name, c2.customer_name
FROM customers c1
JOIN customers c2
ON c1.customer_id = c2.customer_id;