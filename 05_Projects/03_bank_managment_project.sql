-- =========================================================
-- PROJECT : BANK MANAGEMENT SYSTEM
-- AUTHOR  : Varshini
-- DATABASE: MySQL
-- =========================================================


-- =========================================================
-- 1. CREATE DATABASE
-- =========================================================

DROP DATABASE IF EXISTS bank;

CREATE DATABASE bank;

USE bank;


-- =========================================================
-- 2. CREATE TABLE : BRANCH
-- =========================================================

CREATE TABLE BRANCH
(
    branch_name VARCHAR(50) PRIMARY KEY,

    branch_city VARCHAR(50) NOT NULL,

    assets REAL CHECK(assets >= 0)
);


-- =========================================================
-- 3. CREATE TABLE : ACCOUNT
-- =========================================================

CREATE TABLE ACCOUNT
(
    accno INT PRIMARY KEY,

    branch_name VARCHAR(50) NOT NULL,

    balance REAL DEFAULT 0 CHECK(balance >= 0),

    FOREIGN KEY(branch_name)
    REFERENCES BRANCH(branch_name)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


-- =========================================================
-- 4. CREATE TABLE : CUSTOMER
-- =========================================================

CREATE TABLE CUSTOMER
(
    customer_name VARCHAR(50) PRIMARY KEY,

    customer_street VARCHAR(50) NOT NULL,

    city VARCHAR(50) NOT NULL
);


-- =========================================================
-- 5. CREATE TABLE : DEPOSITOR
-- =========================================================

CREATE TABLE DEPOSITOR
(
    customer_name VARCHAR(50),

    accno INT,

    PRIMARY KEY(customer_name, accno),

    FOREIGN KEY(customer_name)
    REFERENCES CUSTOMER(customer_name)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    FOREIGN KEY(accno)
    REFERENCES ACCOUNT(accno)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


-- =========================================================
-- 6. CREATE TABLE : LOAN
-- =========================================================

CREATE TABLE LOAN
(
    loan_number INT PRIMARY KEY,

    branch_name VARCHAR(50) NOT NULL,

    amount REAL CHECK(amount > 0),

    FOREIGN KEY(branch_name)
    REFERENCES BRANCH(branch_name)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


-- =========================================================
-- 7. CREATE TABLE : BORROWER
-- =========================================================

CREATE TABLE BORROWER
(
    customer_name VARCHAR(50),

    loan_number INT,

    PRIMARY KEY(customer_name, loan_number),

    FOREIGN KEY(customer_name)
    REFERENCES CUSTOMER(customer_name)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    FOREIGN KEY(loan_number)
    REFERENCES LOAN(loan_number)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


-- =========================================================
-- 8. INSERT VALUES INTO BRANCH
-- =========================================================

INSERT INTO BRANCH VALUES
('Main', 'Mysuru', 5000000),
('Kuvempunagar', 'Mysuru', 2000000),
('Vijayanagar', 'Bengaluru', 3000000),
('Rajajinagar', 'Bengaluru', 2500000),
('MG Road', 'Mumbai', 6000000);


-- =========================================================
-- 9. INSERT VALUES INTO ACCOUNT
-- =========================================================

INSERT INTO ACCOUNT VALUES
(101, 'Main', 25000),
(102, 'Main', 50000),
(103, 'Kuvempunagar', 30000),
(104, 'Vijayanagar', 70000),
(105, 'Rajajinagar', 45000);


-- =========================================================
-- 10. INSERT VALUES INTO CUSTOMER
-- =========================================================

INSERT INTO CUSTOMER VALUES
('Ravi', 'Ashok Street', 'Mysuru'),
('Sita', 'Temple Road', 'Mysuru'),
('Arjun', 'MG Road', 'Bengaluru'),
('Meena', 'Church Street', 'Bengaluru'),
('Kiran', 'Marine Drive', 'Mumbai');


-- =========================================================
-- 11. INSERT VALUES INTO DEPOSITOR
-- =========================================================

INSERT INTO DEPOSITOR VALUES
('Ravi', 101),
('Ravi', 102),
('Sita', 103),
('Arjun', 104),
('Meena', 105);


-- =========================================================
-- 12. INSERT VALUES INTO LOAN
-- =========================================================

INSERT INTO LOAN VALUES
(201, 'Main', 100000),
(202, 'Kuvempunagar', 150000),
(203, 'Vijayanagar', 200000),
(204, 'Rajajinagar', 120000),
(205, 'MG Road', 300000);


-- =========================================================
-- 13. INSERT VALUES INTO BORROWER
-- =========================================================

INSERT INTO BORROWER VALUES
('Ravi', 201),
('Sita', 202),
('Arjun', 203),
('Meena', 204),
('Kiran', 205);


-- =========================================================
-- ==================== QUERIES =============================
-- =========================================================


-- =========================================================
-- QUERY 1
-- LIST ALL CUSTOMERS WITH ACCOUNT NUMBER AND BALANCE
-- =========================================================

SELECT c.customer_name,
       a.accno,
       a.balance
FROM CUSTOMER c
JOIN DEPOSITOR d
ON c.customer_name = d.customer_name
JOIN ACCOUNT a
ON d.accno = a.accno;


-- =========================================================
-- QUERY 2
-- FIND CUSTOMERS WHO HAVE ACCOUNT IN MYSURU BRANCHES
-- =========================================================

SELECT DISTINCT d.customer_name
FROM DEPOSITOR d
JOIN ACCOUNT a
ON d.accno = a.accno
JOIN BRANCH b
ON a.branch_name = b.branch_name
WHERE b.branch_city = 'Mysuru';


-- =========================================================
-- QUERY 3
-- FIND TOTAL NUMBER OF ACCOUNTS IN EACH BRANCH
-- =========================================================

SELECT branch_name,
       COUNT(*) AS total_accounts
FROM ACCOUNT
GROUP BY branch_name;


-- =========================================================
-- QUERY 4
-- FIND TOTAL DEPOSIT AMOUNT IN EACH BRANCH
-- =========================================================

SELECT branch_name,
       SUM(balance) AS total_balance
FROM ACCOUNT
GROUP BY branch_name;


-- =========================================================
-- QUERY 5
-- FIND CUSTOMERS WHO HAVE LOANS
-- =========================================================

SELECT DISTINCT customer_name
FROM BORROWER;


-- =========================================================
-- QUERY 6
-- FIND CUSTOMERS WHO HAVE BOTH LOAN AND DEPOSIT ACCOUNT
-- =========================================================

SELECT DISTINCT d.customer_name
FROM DEPOSITOR d
JOIN BORROWER b
ON d.customer_name = b.customer_name;


-- =========================================================
-- QUERY 7
-- FIND CUSTOMERS WHO HAVE DEPOSIT ACCOUNT BUT NO LOAN
-- =========================================================

SELECT DISTINCT d.customer_name
FROM DEPOSITOR d
WHERE d.customer_name NOT IN
(
    SELECT customer_name
    FROM BORROWER
);


-- =========================================================
-- QUERY 8
-- FIND CUSTOMERS WHO HAVE LOAN BUT NO DEPOSIT ACCOUNT
-- =========================================================

SELECT DISTINCT b.customer_name
FROM BORROWER b
WHERE b.customer_name NOT IN
(
    SELECT customer_name
    FROM DEPOSITOR
);


-- =========================================================
-- QUERY 9
-- FIND BRANCH HAVING MAXIMUM ASSETS
-- =========================================================

SELECT branch_name,
       assets
FROM BRANCH
WHERE assets =
(
    SELECT MAX(assets)
    FROM BRANCH
);


-- =========================================================
-- QUERY 10
-- FIND CUSTOMERS LIVING IN BENGALURU WITH ACCOUNT IN MAIN BRANCH
-- =========================================================

SELECT DISTINCT c.customer_name
FROM CUSTOMER c
JOIN DEPOSITOR d
ON c.customer_name = d.customer_name
JOIN ACCOUNT a
ON d.accno = a.accno
WHERE c.city = 'Bengaluru'
AND a.branch_name = 'Main';


-- =========================================================
-- QUERY 11
-- FIND LOAN DETAILS FROM MAIN BRANCH
-- =========================================================

SELECT loan_number,
       amount
FROM LOAN
WHERE branch_name = 'Main';


-- =========================================================
-- QUERY 12
-- FIND CUSTOMERS WHOSE BALANCE IS GREATER THAN 50000
-- =========================================================

SELECT DISTINCT d.customer_name
FROM DEPOSITOR d
JOIN ACCOUNT a
ON d.accno = a.accno
WHERE a.balance > 50000;


-- =========================================================
-- QUERY 13
-- INCREASE BALANCE BY 10 PERCENT FOR MYSURU BRANCHES
-- =========================================================

UPDATE ACCOUNT
SET balance = balance + (balance * 0.10)
WHERE branch_name IN
(
    SELECT branch_name
    FROM BRANCH
    WHERE branch_city = 'Mysuru'
);


-- =========================================================
-- QUERY 14
-- FIND AVERAGE ACCOUNT BALANCE IN EACH CITY
-- =========================================================

SELECT b.branch_city,
       AVG(a.balance) AS avg_balance
FROM ACCOUNT a
JOIN BRANCH b
ON a.branch_name = b.branch_name
GROUP BY b.branch_city;


-- =========================================================
-- QUERY 15
-- FIND CUSTOMERS HAVING MORE THAN ONE LOAN
-- =========================================================

SELECT customer_name
FROM BORROWER
GROUP BY customer_name
HAVING COUNT(loan_number) > 1;


-- =========================================================
-- QUERY 16
-- FIND CUSTOMERS HAVING AT LEAST TWO ACCOUNTS IN MAIN BRANCH
-- =========================================================

SELECT d.customer_name
FROM DEPOSITOR d
JOIN ACCOUNT a
ON d.accno = a.accno
WHERE a.branch_name = 'Main'
GROUP BY d.customer_name
HAVING COUNT(d.accno) >= 2;


-- =========================================================
-- QUERY 17
-- DELETE ALL ACCOUNTS IN BENGALURU BRANCHES
-- =========================================================

DELETE FROM DEPOSITOR
WHERE accno IN
(
    SELECT accno
    FROM ACCOUNT
    WHERE branch_name IN
    (
        SELECT branch_name
        FROM BRANCH
        WHERE branch_city = 'Bengaluru'
    )
);

DELETE FROM ACCOUNT
WHERE branch_name IN
(
    SELECT branch_name
    FROM BRANCH
    WHERE branch_city = 'Bengaluru'
);


-- =========================================================
-- END OF PROJECT
-- =========================================================