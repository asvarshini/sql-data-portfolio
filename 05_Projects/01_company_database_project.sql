-- =========================
-- DATABASE SETUP
-- =========================
DROP DATABASE IF EXISTS company;
CREATE DATABASE company;
USE company;

-- =========================
-- DROP TABLES (safe)
-- =========================
DROP TABLE IF EXISTS WORKS_ON;
DROP TABLE IF EXISTS DEPENDENT;
DROP TABLE IF EXISTS PROJECT;
DROP TABLE IF EXISTS DEPT_LOCATION;
DROP TABLE IF EXISTS EMPLOYEE;
DROP TABLE IF EXISTS DEPARTMENT;

-- =========================
-- CREATE TABLES
-- =========================

CREATE TABLE DEPARTMENT (
    Dname VARCHAR(30) NOT NULL,
    Dnumber INT PRIMARY KEY,
    mgr_ssn INT UNIQUE,
    mgr_start_date DATE
);

CREATE TABLE EMPLOYEE (
    Fname VARCHAR(20) NOT NULL,
    MINIT CHAR(1),
    LNAME VARCHAR(20) NOT NULL,
    SSN INT PRIMARY KEY,
    Bdate DATE,
    Address VARCHAR(100),
    Sex CHAR(1),
    Salary INT CHECK (Salary > 0),
    super_ssn INT,
    DNO INT,
    FOREIGN KEY (super_ssn) REFERENCES EMPLOYEE(SSN),
    FOREIGN KEY (DNO) REFERENCES DEPARTMENT(Dnumber)
);

CREATE TABLE DEPT_LOCATION (
    Dnumber INT,
    Dlocation VARCHAR(30),
    PRIMARY KEY (Dnumber, Dlocation),
    FOREIGN KEY (Dnumber) REFERENCES DEPARTMENT(Dnumber)
);

CREATE TABLE PROJECT (
    Pname VARCHAR(30) NOT NULL,
    Pnumber INT PRIMARY KEY,
    Plocation VARCHAR(30),
    Dnum INT,
    FOREIGN KEY (Dnum) REFERENCES DEPARTMENT(Dnumber)
);

CREATE TABLE WORKS_ON (
    ESSN INT,
    Pno INT,
    hours INT CHECK (hours >= 0),
    PRIMARY KEY (ESSN, Pno),
    FOREIGN KEY (ESSN) REFERENCES EMPLOYEE(SSN),
    FOREIGN KEY (Pno) REFERENCES PROJECT(Pnumber)
);

CREATE TABLE DEPENDENT (
    essn INT,
    Dependent_name VARCHAR(30),
    sex CHAR(1),
    Bdate DATE,
    Relationship VARCHAR(20),
    PRIMARY KEY (essn, Dependent_name),
    FOREIGN KEY (essn) REFERENCES EMPLOYEE(SSN)
);

-- =========================
-- INSERT DATA
-- =========================

INSERT INTO EMPLOYEE VALUES 
('John','A','Smith',111111111,'1980-06-15','Bangalore','M',80000,NULL,NULL),
('Alice','B','Johnson',222222222,'1985-02-20','Mysore','F',75000,111111111,NULL),
('Robert','C','Brown',333333333,'1990-09-10','Chennai','M',70000,111111111,NULL),
('Mary','D','Davis',444444444,'1988-12-05','Hyderabad','F',65000,222222222,NULL),
('Michael','E','Wilson',555555555,'1979-04-18','Pune','M',90000,NULL,NULL),
('Sophia','F','Taylor',666666666,'1992-07-25','Delhi','F',72000,333333333,NULL);

INSERT INTO DEPARTMENT VALUES 
('Research', 5, 111111111, '2020-01-01'),
('Administration', 4, 222222222, '2019-03-15'),
('IT', 1, 333333333, '2021-07-10'),
('HR', 2, 444444444, '2018-05-20'),
('Finance', 3, 555555555, '2017-09-12'),
('Marketing', 6, 666666666, '2022-11-01');

-- Update employee department numbers
UPDATE EMPLOYEE SET DNO = 5 WHERE SSN = 111111111;
UPDATE EMPLOYEE SET DNO = 4 WHERE SSN = 222222222;
UPDATE EMPLOYEE SET DNO = 1 WHERE SSN = 333333333;
UPDATE EMPLOYEE SET DNO = 2 WHERE SSN = 444444444;
UPDATE EMPLOYEE SET DNO = 3 WHERE SSN = 555555555;
UPDATE EMPLOYEE SET DNO = 6 WHERE SSN = 666666666;

INSERT INTO DEPT_LOCATION VALUES 
(5, 'Bangalore'),
(4, 'Mysore'),
(1, 'Chennai'),
(2, 'Hyderabad'),
(3, 'Pune'),
(6, 'Delhi');

INSERT INTO PROJECT VALUES 
('AI_Project', 101, 'Stafford', 5),
('Cloud_System', 102, 'Bangalore', 1),
('Payroll_App', 103, 'Mysore', 3),
('Recruitment_Portal', 104, 'Hyderabad', 2),
('Market_Analysis', 105, 'Delhi', 6),
('Admin_Automation', 106, 'Stafford', 4);

INSERT INTO WORKS_ON VALUES 
(111111111, 101, 20),
(222222222, 106, 15),
(333333333, 102, 25),
(444444444, 104, 18),
(555555555, 103, 22),
(666666666, 105, 30);

INSERT INTO DEPENDENT VALUES 
(111111111, 'Chris', 'M', '2010-05-15', 'Son'),
(222222222, 'Emma', 'F', '2012-08-20', 'Daughter'),
(333333333, 'Olivia', 'F', '2015-11-10', 'Daughter'),
(444444444, 'Liam', 'M', '2008-01-25', 'Son'),
(555555555, 'Noah', 'M', '2013-09-05', 'Son'),
(666666666, 'Ava', 'F', '2016-03-12', 'Daughter');
-- =========================
-- QUERIES
-- =========================

-- 1. Employees working in Research department
SELECT e.Fname, e.Address
FROM EMPLOYEE e
JOIN DEPARTMENT d 
ON e.DNO = d.Dnumber
WHERE d.Dname = 'Research';
-- 2. Projects in Stafford with department and manager details
SELECT p.Pnumber, p.Dnum, e.Lname, e.Address, e.Bdate
FROM PROJECT p
JOIN DEPARTMENT d ON p.Dnum = d.Dnumber
JOIN EMPLOYEE e ON d.mgr_ssn = e.SSN
WHERE p.Plocation = 'Stafford';
-- 3. Employee and their immediate supervisor (Self Join)
SELECT 
    e.Fname AS Employee, 
    s.Fname AS Supervisor
FROM EMPLOYEE e
LEFT JOIN EMPLOYEE s
ON e.super_ssn = s.SSN;
-- 4. Employees who have a dependent with same first name and same sex
SELECT e.Fname, e.Sex
FROM EMPLOYEE e
JOIN DEPENDENT d 
ON e.Fname = d.Dependent_name 
AND e.Sex = d.Sex;
-- 5. Employee numbers who work on projects in specific locations
SELECT e.SSN
FROM EMPLOYEE e
JOIN WORKS_ON w ON e.SSN = w.ESSN
JOIN PROJECT p ON w.Pno = p.Pnumber
WHERE p.Plocation IN ('Bellaire', 'Houston', 'Stafford');
-- 6. Salary statistics (sum, max, min, avg)
SELECT 
    SUM(Salary) AS total_salary,
    MAX(Salary) AS max_salary,
    MIN(Salary) AS min_salary,
    AVG(Salary) AS avg_salary
FROM EMPLOYEE;