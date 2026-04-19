-- Drop tables if already exist (for clean run)
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;

-- Create parent table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);

-- Create child table with BOTH cascades
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    product VARCHAR(50),
    customer_id INT,
    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- Insert data into parent
INSERT INTO customers VALUES
(1, 'Asha'),
(2, 'Rahul');

-- Insert data into child
INSERT INTO orders VALUES
(101, 'Laptop', 1),
(102, 'Mobile', 1),
(103, 'Shoes', 2);

-- Check initial data
SELECT * FROM customers;
SELECT * FROM orders;

--  UPDATE CASCADE example
-- Change customer_id from 2 → 20
UPDATE customers
SET customer_id = 20
WHERE customer_id = 2;

-- Check after update
SELECT * FROM customers;
SELECT * FROM orders;

--  DELETE CASCADE example
-- Delete customer_id = 1
DELETE FROM customers
WHERE customer_id = 1;

-- Check after delete
SELECT * FROM customers;
SELECT * FROM orders;