create database e_commerce;
use e_commerce;

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
-- WHERE clause and filtering examples
-- Get all unique categories
SELECT DISTINCT category FROM sales;
-- Get all Electronics products
SELECT * FROM sales
WHERE category = 'Electronics';
-- Orders from Bangalore with price >= 3000
SELECT * FROM sales
WHERE city = 'Bangalore' AND price >= 3000;
-- Orders between specific dates (range filtering)
SELECT * FROM sales
WHERE order_date BETWEEN '2023-09-01' AND '2023-09-07';
-- Orders from selected cities (multiple values)
SELECT * FROM sales
WHERE city IN ('Delhi', 'Mumbai');
-- Exclude specific city
SELECT * FROM sales
WHERE city NOT IN ('Delhi');
-- Exclude specific city
SELECT * FROM sales
WHERE city NOT IN ('Delhi');
select * from sales where quantity =1 limit 3 ;
select * from sales order by price asc;
-- Example of operators:
-- Arithmetic: +, -, *, /
-- Comparison: =, >, <, >=, <=
-- Logical: AND, OR, NOT


