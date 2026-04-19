-- CHECK constraint example

DROP DATABASE IF EXISTS company;
CREATE DATABASE company;
USE company;

-- Table with CHECK constraint
CREATE TABLE department (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(30),
    salary FLOAT CHECK (salary >= 100000)
);

-- Valid insert (passes CHECK constraint)
INSERT INTO department (emp_id, emp_name, salary)
VALUES (1, 'var', 200000);

--  Invalid insert (will FAIL because salary < 100000)
-- INSERT INTO department (emp_id, emp_name, salary)
-- VALUES (2, 'shri', 5000);

-- View data
SELECT * FROM department;