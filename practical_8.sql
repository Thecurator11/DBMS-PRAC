CREATE DATABASE company8;
USE company8;
CREATE TABLE Employee (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    hire_date DATE,
    position VARCHAR(50)
);
INSERT INTO Employee (employee_id, first_name, last_name, department, salary, hire_date, position) VALUES
(1, 'John', 'Doe', 'IT', 60000, '2021-05-15', 'Software Engineer'),
(2, 'Jane', 'Smith', 'HR', 55000, '2020-03-10', 'HR Specialist'),
(3, 'Alex', 'Johnson', 'IT', 70000, '2019-09-22', 'DevOps Engineer'),
(4, 'Emily', 'Davis', 'Finance', 80000, '2021-02-18', 'Analyst'),
(5, 'David', 'Duck', 'IT', 40000, '2020-06-05', 'Software Engineer'),
(6, 'Don', 'Dev', 'Finance', 90000, '2019-08-03', 'Developer');
SELECT * FROM Employee;
SELECT * FROM Employee
WHERE department = 'IT';

SELECT department, COUNT(*) AS total_employees
FROM Employee
GROUP BY department;

SELECT department, AVG(salary) AS avg_salary
FROM Employee
GROUP BY department;

SELECT * FROM Employee
WHERE hire_date > '2021-02-01';

UPDATE Employee
SET salary = salary + 5000
WHERE department = 'IT';

SELECT * FROM Employee WHERE department = 'IT';
SELECT department, MAX(salary) AS highest_salary
FROM Employee
GROUP BY department;

SELECT department, COUNT(*) AS total_employees
FROM Employee
GROUP BY department
HAVING COUNT(*) > 1;

SELECT * FROM Employee
WHERE salary = (SELECT MAX(salary) FROM Employee);

SELECT * FROM Employee
WHERE salary = (SELECT MIN(salary) FROM Employee);

DELETE FROM Employee
WHERE last_name = 'Dev';

