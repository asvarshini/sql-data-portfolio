NULL represents a missing or unknown value in a database. 
It is different from 0 or an empty string (''). 
Using NULL helps avoid incorrect calculations (such as averages) when data is unavailable. 
To check for NULL values in SQL, use IS NULL or IS NOT NULL instead of =.

    
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
-- How do we check for NULL?
WHERE Name IS NULL
