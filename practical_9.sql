create database vibhuti9;
use vibhuti9;

CREATE TABLE Employee(
    Eid INT PRIMARY KEY,
    Ename VARCHAR(30),
    Address VARCHAR(30),
    Salary INT,
    Commission INT
);

INSERT INTO Employee VALUES 
(1,'Amita','Pune',35000,5000),
(2,'Neha','Pune',25000,0),
(3,'Sagar','Nasik',28000,2000),
(4,'Sneha','Mumbai',19000,0),
(5,'Shubham','Mumbai',25000,3000);

SELECT DISTINCT Address FROM Employee;

 SELECT MAX(Salary), MIN(Salary) FROM Employee;

SELECT * FROM Employee ORDER BY Salary ASC;

SELECT * FROM Employee WHERE Address IN ('Nasik','Pune');

SELECT * FROM Employee WHERE Commission = 0 OR Commission IS NULL;

UPDATE Employee SET Address='Nashik' WHERE Ename='Amita';

SELECT * FROM Employee WHERE Ename LIKE 'A%';

SELECT Address, COUNT(*) FROM Employee GROUP BY Address;

SELECT Address, MIN(Salary) FROM Employee GROUP BY Address;

SELECT Address, MAX(Salary) 
FROM Employee
GROUP BY Address
HAVING MAX(Salary) > 26000;
