create database vibhuti13;
use vibhuti13;

CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50),
    CourseID INT
);
INSERT INTO Student VALUES
(1, 'Amita', 101),
(2, 'Neha', 102),
(3, 'Sagar', 103),
(4, 'Sneha', 106),
(5, 'Shubham', 105);
CREATE TABLE Course (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(50)
);
INSERT INTO Course VALUES
(101, 'Physics'),
(102, 'Chemistry'),
(104, 'Biology');

SELECT Student.StudentID, Student.StudentName, Course.CourseName
FROM Student
INNER JOIN Course ON Student.CourseID = Course.CourseID;

SELECT Student.StudentID, Student.StudentName, Course.CourseName
FROM Student
LEFT JOIN Course ON Student.CourseID = Course.CourseID;

SELECT Student.StudentName, Course.CourseID, Course.CourseName
FROM Student
RIGHT JOIN Course ON Student.CourseID = Course.CourseID;

SELECT Student.StudentID, Student.StudentName, Course.CourseName
FROM Student
LEFT JOIN Course ON Student.CourseID = Course.CourseID
UNION
SELECT Student.StudentID, Student.StudentName, Course.CourseName
FROM Student
RIGHT JOIN Course ON Student.CourseID = Course.CourseID;

CREATE VIEW StudentCourseView AS
SELECT Student.StudentID, Student.StudentName, Course.CourseName
FROM Student
LEFT JOIN Course ON Student.CourseID = Course.CourseID;

SELECT * FROM StudentCourseView;

CREATE VIEW NoCourseView AS
SELECT StudentID, StudentName
FROM Student
WHERE CourseID NOT IN (SELECT CourseID FROM Course);
SELECT * FROM NoCourseView;
