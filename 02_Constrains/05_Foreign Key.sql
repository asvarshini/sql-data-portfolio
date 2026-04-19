-- Foreign Key Example

DROP DATABASE IF EXISTS company;
CREATE DATABASE company;
USE company;

-- Parent table
CREATE TABLE department (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(30)
);

-- Child table
CREATE TABLE manager (
    man_id INT NOT NULL,
    man_dep VARCHAR(30),
    FOREIGN KEY (man_id) REFERENCES department(emp_id)
);

-- Insert into parent first
INSERT INTO department (emp_id, emp_name)
VALUES
(1, 'abc'),
(2, 'xyz');

-- Valid insert (matches parent keys)
INSERT INTO manager (man_id, man_dep)
VALUES
(1, 'tech');

-- This will fail because 3 does not exist in department
-- INSERT INTO manager (man_id, man_dep)
-- VALUES (3, 'data');

-- View data
SELECT * FROM department;
SELECT * FROM manager;