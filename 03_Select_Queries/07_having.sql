-- Create database
CREATE DATABASE IF NOT EXISTS e_commerce;
USE e_commerce;

-- Create table
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

-- Insert sample data
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
-- HAVING clause examples

-- Products ordered more than once
SELECT product, COUNT(*) AS total_orders
FROM sales
GROUP BY product
HAVING total_orders > 1;

-- Cities where maximum quantity ordered is less than 2
SELECT city, MAX(quantity) AS max_quantity
FROM sales
WHERE price > 2000
GROUP BY city
HAVING max_quantity < 2
ORDER BY max_quantity DESC;

-- Cities with total revenue greater than 50000
SELECT city, SUM(price * quantity) AS revenue
FROM sales
GROUP BY city
HAVING revenue > 50000
ORDER BY revenue DESC;
-- if you want to add 2 column use + sign not sum example
question 1 :List all movies and their combined sales in millions of dollars 
SELECT *,
       (Domestic_sales + International_sales) / 1000000 AS combined_sales
FROM movies m
JOIN boxoffice o
ON m.id = o.movie_id;
question 2 :List all movies and their ratings in percent 
SELECT m.title,
       rating * 10 AS rating_percent
FROM movies m
JOIN boxoffice b
ON m.id = b.movie_id;

queston 3 :List all movies that were released on even number years 
SELECT Title, Year
FROM movies
WHERE Year % 2 = 0;
-- SQL clause order reference
-- SELECT columns,(function aggreation,AS)
-- FROM table
-- WHERE condition
-- GROUP BY columns
-- HAVING condition
-- ORDER BY columns
-- Limit condition
