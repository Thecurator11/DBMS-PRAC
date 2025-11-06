create database vibhuti11;
use vibhuti11;

CREATE TABLE Employee (
    emp_no INT PRIMARY KEY,
    emp_name VARCHAR(50),
    skill VARCHAR(50),
    pay_rate DECIMAL(10,2)
);
INSERT INTO Employee (emp_no, emp_name, skill, pay_rate) VALUES
(100, 'Ahire', 'Networking', 25000.00),
(101, 'Bhushan', 'Database', 28000.00),
(102, 'Sneha', 'Web Development', 30000.00),
(103, 'Ravi', 'Networking', 22000.00),
(104, 'Priya', 'Database', 26000.00),
(105, 'Amit', 'Testing', 24000.00);

CREATE TABLE Position1 (
    posting_no INT PRIMARY KEY,
    skill VARCHAR(50)
);
INSERT INTO Position1 (posting_no, skill) VALUES
(1, 'Networking'),
(2, 'Database'),
(3, 'Web Development'),
(4, 'Testing');


CREATE TABLE Duty_allocation (
    posting_no INT,
    emp_no INT,
    day DATE,
    shift VARCHAR(20),
    FOREIGN KEY (emp_no) REFERENCES Employee(emp_no),
    FOREIGN KEY (posting_no) REFERENCES Position1(posting_no)
);
INSERT INTO Duty_allocation (posting_no, emp_no, day, shift) VALUES
(2, 101, '2003-04-02', 'Morning'),
(2, 101, '2003-04-15', 'Evening'),
(3, 102, '2003-05-01', 'Night'),
(1, 100, '2003-04-10', 'Morning'),
(4, 105, '2003-04-20', 'Evening'),
(1, 103, '2003-04-18', 'Morning');

SELECT *
FROM Duty_allocation
WHERE emp_no = 101 
  AND day LIKE '2003-04%';


SELECT d.shift, d.day, d.posting_no
FROM Duty_allocation d
JOIN Employee e ON d.emp_no = e.emp_no
WHERE e.emp_name = 'Bhushan';

SELECT * 
FROM Employee
WHERE pay_rate >= (
    SELECT pay_rate 
    FROM Employee 
    WHERE emp_name = 'Ahire'
);

SELECT emp_name, pay_rate 
FROM Employee
WHERE emp_no < 1000 
AND pay_rate > (
    SELECT MIN(pay_rate) 
    FROM Employee 
    WHERE emp_no >= 1000
);

SELECT * 
FROM Employee
WHERE pay_rate = (SELECT MIN(pay_rate) FROM Employee);

