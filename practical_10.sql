create database vibhuti10;
use vibhuti10;
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


SELECT * FROM Employee WHERE Address='Mumbai';

SELECT * FROM Employee ORDER BY Salary DESC LIMIT 1;

SELECT * FROM Employee ORDER BY Salary DESC;

SELECT * FROM Employee WHERE Address NOT IN ('Nasik','Pune');

SELECT * FROM Employee WHERE Ename LIKE '%r';

SELECT Address, COUNT(*) FROM Employee GROUP BY Address HAVING COUNT(*) >= 2;

SELECT Address, MAX(Salary) FROM Employee GROUP BY Address;

SELECT Address, MAX(Salary) FROM Employee GROUP BY Address HAVING MAX(Salary) > 19000;

SELECT COUNT(*) FROM Employee WHERE Address='Mumbai';

DELETE FROM Employee
WHERE Salary > 30000;
