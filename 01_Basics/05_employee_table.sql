-- Create database
CREATE DATABASE IF NOT EXISTS xyz;
USE xyz;

-- Create employee table
CREATE TABLE employee (
    id INT PRIMARY KEY,
    name VARCHAR(30),
    salary FLOAT NOT NULL
);

-- Insert employee data
INSERT INTO employee (id, name, salary) VALUES
(1, 'Adam', 25000),
(2, 'Bob', 30000),
(3, 'Casey', 40000);

-- View all employees
SELECT * FROM employee;