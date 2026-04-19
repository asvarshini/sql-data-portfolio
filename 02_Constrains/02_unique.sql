-- Demonstrating UNIQUE constraint

CREATE DATABASE IF NOT EXISTS college;
USE college;

-- Create table with UNIQUE constraint
CREATE TABLE student (
    student_id INT,
    student_name VARCHAR(50) NOT NULL,
    CONSTRAINT unique_student_id UNIQUE (student_id)
);

-- Insert valid data
INSERT INTO student (student_id, student_name)
VALUES
(101, 'Anu'),
(102, 'Ravi');

--  This will fail (duplicate value)
-- INSERT INTO student VALUES (101, 'Duplicate');

-- View data
SELECT * FROM student;

