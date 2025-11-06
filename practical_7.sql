create database vibhuti77;
use vibhuti77;
CREATE TABLE Student(
    student_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    grade CHAR(1),
    major VARCHAR(50)
);

INSERT INTO Student VALUES
(1,'John','Doe',20,'A','Computer Science'),
(2,'Jane','Smith',21,'B','Mathematics'),
(3,'Alex','Johnson',22,'A','Physics'),
(4,'Emily','Davis',23,'C','Biology'),
(5,'David','Duck',21,'B','Mathematics'),
(6,'Don','Dev',22,'A','Mathematics');

SELECT * FROM Student;
  
SET SQL_SAFE_UPDATES = 0;
UPDATE Student SET first_name='Jenne' WHERE student_id=2;

SELECT * FROM Student WHERE grade='A';

SELECT major, COUNT(*) AS total_students 
FROM Student 
GROUP BY major;

 SELECT * FROM Student ORDER BY age ASC;
 
 SELECT * FROM Student WHERE age=(SELECT MAX(age) FROM Student);
SELECT * FROM Student WHERE age=(SELECT MIN(age) FROM Student);

UPDATE Student SET major='Computer Science' WHERE student_id=2;

DELETE FROM Student WHERE student_id=6;

SELECT major, COUNT(*) AS total_A 
FROM Student 
WHERE grade='A' 
GROUP BY major;

SELECT grade, COUNT(*) AS total_students
FROM Student
GROUP BY grade
HAVING COUNT(*) > 2;
