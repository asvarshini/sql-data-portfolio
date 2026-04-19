-- DEFAULT constraint example

DROP DATABASE IF EXISTS company;
CREATE DATABASE company;
USE company;

-- Table with DEFAULT value
CREATE TABLE department (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(30),
    salary FLOAT DEFAULT 100000
);

-- Insert without salary (DEFAULT will apply)
INSERT INTO department (emp_id, emp_name)
VALUES
(1, 'var'),
(2, 'shri');

-- View data
SELECT * FROM department;