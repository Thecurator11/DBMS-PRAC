use sam;
create table Courses(Course_Id INT PRIMARY KEY,Course_Name VARCHAR(100) NOT NULL);
INSERT INTO Courses (course_id, course_name)
VALUES (101, 'Computer Science'),
       (102, 'Data Science');
create table Students(Student_Id INT PRIMARY KEY,First_Name VARCHAR(50) NOT NULL,Last_Name VARCHAR(50),email VARCHAR(100) UNIQUE,
age INT CHECK(age >=18),Course_Id INT,addmision_date DATE DEFAULT(CURRENT_DATE),FOREIGN KEY(Course_Id)REFERENCES Courses(Course_Id));

INSERT INTO Students (student_id, first_name, last_name, email, age, course_id)
VALUES (1, 'Pooja', 'Sharma', 'pooja@gmail.com', 20, 101),
       (2, 'Ananya', 'Patil', 'ananya@gmail.com', 22, 102);
select * from Courses;
select * from Students;