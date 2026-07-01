SQL Clause

| Clause     | Purpose                                                   | Example                                      |
| ---------- | --------------------------------------------------------- | -------------------------------------------- |
| `SELECT`   | Chooses the columns or expressions to display.            | `SELECT Title, Year`                         |
| `FROM`     | Specifies the table to retrieve data from.                | `FROM movies`                                |
| `JOIN`     | Combines rows from two tables based on a matching column. | `JOIN boxoffice b ON movies.id = b.movie_id` |
| `WHERE`    | Filters rows that satisfy a condition.                    | `WHERE Year > 2000`                          |
| `AS`       | Gives a custom name (alias) to a column.                  | `rating * 10 AS rating_percent`              |
| `ORDER BY` | Sorts the result.                                         | `ORDER BY Year DESC`                         |
| `LIMIT`    | Limits the number of rows returned.                       | `LIMIT 5`                                    |

Common aggregate functions uses after select 
    | **Function**    | **Description**                                                      |
| --------------- | -------------------------------------------------------------------- |
| `COUNT(*)`      | Counts the total number of rows in the table or group.               |
| `COUNT(column)` | Counts the number of **non-NULL** values in the specified column.    |
| `MIN(column)`   | Returns the smallest numerical value in the specified column.        |
| `MAX(column)`   | Returns the largest numerical value in the specified column.         |
| `AVG(column)`   | Returns the average of all numerical values in the specified column. |
| `SUM(column)`   | Returns the sum of all numerical values in the specified column.     |


Common Conditions Used in WHERE
    
| Condition     | Meaning                             | Example                                                 |
| ------------- | ----------------------------------- | ------------------------------------------------------- |
| `=`           | Equal to                            | `WHERE Year = 2010`                                     |
| `!=` or `<>`  | Not equal to                        | `WHERE Year != 2010`                                    |
| `>`           | Greater than                        | `WHERE Rating > 8`                                      |
| `<`           | Less than                           | `WHERE Rating < 8`                                      |
| `>=`          | Greater than or equal to            | `WHERE Rating >= 8`                                     |
| `<=`          | Less than or equal to               | `WHERE Rating <= 8`                                     |
| `BETWEEN`     | Value within a range                | `WHERE Year BETWEEN 2000 AND 2010`                      |
| `NOT BETWEEN` | Value outside a range               | `WHERE Year NOT BETWEEN 2000 AND 2010`                  |
| `IN`          | Matches any value in a list         | `WHERE Director IN ('Pete Docter', 'Brad Bird')`        |
| `NOT IN`      | Does not match any value in a list  | `WHERE Director NOT IN ('Pete Docter')`                 |
| `LIKE`        | Pattern matching                    | `WHERE Title LIKE 'Toy%'`                               |
| `NOT LIKE`    | Excludes a pattern                  | `WHERE Title NOT LIKE '%Story%'`                        |
| `%`           | Wildcard (any number of characters) | `'Toy%'`, `'%Cars%'`                                    |
| `_`           | Wildcard (exactly one character)    | `'C_rs'`                                                |
| `IS NULL`     | Finds NULL values                   | `WHERE Director IS NULL`                                |
| `IS NOT NULL` | Finds non-NULL values               | `WHERE Director IS NOT NULL`                            |
| `AND`         | Both conditions must be true        | `WHERE Rating > 8 AND Year > 2005`                      |
| `OR`          | At least one condition must be true | `WHERE Rating > 8 OR Year > 2005`                       |
| `NOT`         | Negates a condition                 | `WHERE NOT Rating > 8`                                  |
| `%` (Modulo)  | Finds even/odd numbers              | `WHERE Year % 2 = 0` (Even), `WHERE Year % 2 = 1` (Odd) |




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
-- If we want to retrieve absolutely all the columns of data from a table, we can then use the asterisk (*)
SELECT * 
FROM mytable;
-- Select query for a specific columns
SELECT column, another_column, …
FROM mytable;

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


