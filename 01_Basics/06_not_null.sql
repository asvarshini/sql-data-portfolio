CREATE TABLE department (
    emp_id INT NOT NULL,
    emp_name VARCHAR(50) NOT NULL
);

--  Error (missing values)
-- INSERT INTO department VALUES ();

--  Error (one value missing)
-- INSERT INTO department (emp_id) VALUES (1);

--  Correct
INSERT INTO department VALUES (1, 'Varshini');

SELECT * FROM department;