-- Create fresh database
-- primary key should be unique and non null

DROP DATABASE IF EXISTS company;
CREATE DATABASE company;
USE company;

-- Department table (SINGLE PRIMARY KEY)

CREATE TABLE department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);
-- Insert data into department
INSERT INTO department VALUES (10, 'IT'), (20, 'HR');-- 20 connot be 10 again
-- =========================
-- Manager table (COMPOSITE PRIMARY KEY)
-- =========================
CREATE TABLE manager (
    man_id INT,
    man_name VARCHAR(50),
    dept_id INT,
    PRIMARY KEY (man_id, man_name)
);

-- Insert data into manager (must match composite key rule)
INSERT INTO manager (man_id, man_name, dept_id)
VALUES (1, 'Ravi', 10), -- any one cloum can be same but both combination should not be 
       (1, 'Anu', 20);

-- View data
SELECT * FROM department;
SELECT * FROM manager;