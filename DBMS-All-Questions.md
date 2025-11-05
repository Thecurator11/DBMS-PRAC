# DBMS PRACTICAL QUESTION BANK - COMPLETE GUIDE (Q1-Q22)

## **BASIC SETUP COMMANDS - START HERE**

### 1. Database Creation
```sql
CREATE DATABASE practice_db;
USE practice_db;
```

### 2. General Table Alteration Commands
```sql
-- Add column
ALTER TABLE table_name ADD COLUMN column_name datatype;

-- Drop column
ALTER TABLE table_name DROP COLUMN column_name;

-- Modify column
ALTER TABLE table_name MODIFY column_name datatype;
```

---

## **Q1: CLIENTS TABLE - Basic Queries (Questions 1-10)**

### Table Creation:
```sql
CREATE TABLE clients (
    client_no VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(50),
    baldue INT,
    SP INT,
    SOD DATE
);

INSERT INTO clients VALUES
('C001', 'Pooja', 'Nashik', 'Maharashtra', 4000, 500, '2013-08-03'),
('C002', 'Ananya', 'Banglore', 'Karnataka', 6000, 800, '2009-05-06'),
('C003', 'Anushka', 'Hydrabad', 'Andhra', 8000, 200, '2007-08-27'),
('C004', 'Atharva', 'Mumbai', 'Maharashtra', 1000, 100, '2014-03-03'),
('C005', 'Ajunkya', 'Pune', 'Maharashtra', 6000, 500, '2014-08-03');
```

### Solutions:
1. **List names of client having 'o' as second letter**
   ```sql
   SELECT name FROM clients WHERE name LIKE '_o%';
   ```

2. **List the client who lives in city that starts with N**
   ```sql
   SELECT name, city FROM clients WHERE city LIKE 'N%';
   ```

3. **List the clients living in Banglore or Nashik**
   ```sql
   SELECT name, city FROM clients WHERE city IN ('Banglore', 'Nashik');
   ```

4. **List the client who placed order in August month**
   ```sql
   SELECT name, SOD FROM clients WHERE MONTH(SOD) = 8;
   ```

5. **Calculate new selling price as original S.P. + 100 and rename as Newprice**
   ```sql
   SELECT name, SP, SP + 100 AS Newprice FROM clients;
   ```

6. **List the name of Client not from Maharashtra**
   ```sql
   SELECT name, state FROM clients WHERE state <> 'Maharashtra';
   ```

7. **Count total number of orders**
   ```sql
   SELECT COUNT(*) AS total_orders FROM clients;
   ```

8. **Calculate average price of all products**
   ```sql
   SELECT AVG(SP) AS average_price FROM clients;
   ```

9. **Calculate Maximum and Minimum S.P. and rename as Max_price and Min_Price**
   ```sql
   SELECT MAX(SP) AS Max_price, MIN(SP) AS Min_price FROM clients;
   ```

10. **Count number of clients whose baldue > 2000**
    ```sql
    SELECT COUNT(*) AS count_clients FROM clients WHERE baldue > 2000;
    ```

---

## **Q2: STUDENTS & COURSES TABLE - Constraints**

### Table Creation:
```sql
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100)
);

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    age INT CHECK (age >= 18),
    course_id INT,
    admission_date DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
```

---

## **Q3: WORLD TABLE - Geographic Data**

### Table Creation:
```sql
CREATE TABLE world (
    country VARCHAR(100),
    continent VARCHAR(50),
    area BIGINT,
    population BIGINT,
    gdp BIGINT
);

INSERT INTO world VALUES
('Afghanistan', 'Asia', 652230, 25500100, 20343000000),
('Albania', 'Europe', 28748, 2831741, 12960000000),
('Algeria', 'Africa', 2381741, 37100000, 188681000000),
('Andorra', 'Europe', 468, 78115, 3712000000),
('Angola', 'Africa', 1246700, 20609294, 100990000000);
```

### Solutions:
1. **Select population of Country Angola**
   ```sql
   SELECT population FROM world WHERE country = 'Angola';
   ```

2. **Select Population of Continent 'Africa'**
   ```sql
   SELECT SUM(population) AS africa_population FROM world WHERE continent = 'Africa';
   ```

3. **Show the name and population for 'Algeria', 'Afghanistan'**
   ```sql
   SELECT country, population FROM world WHERE country IN ('Algeria', 'Afghanistan');
   ```

4. **Show country and area for countries with area between 200,000 and 250,000**
   ```sql
   SELECT country, area FROM world WHERE area BETWEEN 200000 AND 250000;
   ```

5. **Find the continent that starts with Y**
   ```sql
   SELECT DISTINCT continent FROM world WHERE continent LIKE 'Y%';
   ```

6. **Find countries that contain the letter g**
   ```sql
   SELECT country FROM world WHERE country LIKE '%g%';
   ```

7. **Find countries that have exactly four characters**
   ```sql
   SELECT country FROM world WHERE LENGTH(country) = 4;
   ```

8. **Show the total population of the world**
   ```sql
   SELECT SUM(population) AS world_population FROM world;
   ```

9. **List all continents - just once each**
   ```sql
   SELECT DISTINCT continent FROM world;
   ```

10. **Give the total GDP of Africa**
    ```sql
    SELECT SUM(gdp) AS africa_gdp FROM world WHERE continent = 'Africa';
    ```

---

## **Q4-Q6: PRODUCTS & SALES TABLES**

### Table Creation:
```sql
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    unit_price DECIMAL(10,2)
);

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    quantity_sold INT,
    sale_date DATE,
    total_price DECIMAL(10,2),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Sample Data
INSERT INTO products VALUES
(1, 'Smart TV', 'Electronics', 500.00),
(2, 'Laptop', 'Electronics', 800.00),
(3, 'Chair', 'Furniture', 150.00);

INSERT INTO sales VALUES
(1, 1, 2, '2024-01-03', 1000.00),
(2, 2, 1, '2024-01-05', 800.00),
(3, 1, 5, '2024-02-10', 2500.00);
```

### Q4 Solutions:
1. **Retrieve product_name and unit_price from Products table**
   ```sql
   SELECT product_name, unit_price FROM products;
   ```

2. **Filter Sales table to show only sales with total_price greater than $100**
   ```sql
   SELECT * FROM sales WHERE total_price > 100;
   ```

3. **Retrieve sale_id and total_price for sales made on January 3, 2024**
   ```sql
   SELECT sale_id, total_price FROM sales WHERE sale_date = '2024-01-03';
   ```

4. **Calculate total quantity_sold from Sales table**
   ```sql
   SELECT SUM(quantity_sold) AS total_quantity FROM sales;
   ```

5. **Retrieve product_name and unit_price ordering by unit_price descending**
   ```sql
   SELECT product_name, unit_price FROM products ORDER BY unit_price DESC;
   ```

6. **Calculate average total_price of sales**
   ```sql
   SELECT AVG(total_price) AS avg_total_price FROM sales;
   ```

7. **Retrieve product_name and category ordering by category ascending**
   ```sql
   SELECT product_name, category FROM products ORDER BY category ASC;
   ```

8. **Calculate total quantity_sold of products in 'Electronics' category**
   ```sql
   SELECT SUM(s.quantity_sold) AS electronics_quantity 
   FROM sales s 
   JOIN products p ON s.product_id = p.product_id 
   WHERE p.category = 'Electronics';
   ```

9. **Retrieve product_name and total_price calculating as quantity_sold * unit_price**
   ```sql
   SELECT p.product_name, (s.quantity_sold * p.unit_price) AS total_price 
   FROM sales s 
   JOIN products p ON s.product_id = p.product_id;
   ```

10. **Count number of sales made in each month**
    ```sql
    SELECT MONTH(sale_date) AS month, COUNT(*) AS sales_count 
    FROM sales 
    GROUP BY MONTH(sale_date);
    ```

---

## **Q7: STUDENT TABLE - CRUD Operations**

### Table Creation:
```sql
CREATE TABLE student (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    grade CHAR(1),
    major VARCHAR(100)
);

INSERT INTO student VALUES
(1, 'John', 'Doe', 20, 'A', 'Computer Science'),
(2, 'Jane', 'Smith', 21, 'B', 'Mathematics'),
(3, 'Alex', 'Johnson', 22, 'A', 'Physics'),
(4, 'Emily', 'Davis', 23, 'C', 'Biology'),
(5, 'David', 'Duck', 21, 'B', 'Mathematics'),
(6, 'Don', 'Dev', 22, 'A', 'Mathematics');
```

### Solutions:
1. **Create and display table**
   ```sql
   SELECT * FROM student;
   ```

2. **Change name of student Jane to Jenne**
   ```sql
   UPDATE student SET first_name = 'Jenne' WHERE first_name = 'Jane';
   ```

3. **Find Students with Grade A**
   ```sql
   SELECT * FROM student WHERE grade = 'A';
   ```

4. **Count Number of Students in Each Major**
   ```sql
   SELECT major, COUNT(*) AS student_count FROM student GROUP BY major;
   ```

5. **Order Students by Age Ascending**
   ```sql
   SELECT * FROM student ORDER BY age ASC;
   ```

6. **Find Oldest/Youngest Student**
   ```sql
   -- Oldest
   SELECT * FROM student WHERE age = (SELECT MAX(age) FROM student);
   -- Youngest
   SELECT * FROM student WHERE age = (SELECT MIN(age) FROM student);
   ```

7. **Update Student's Major of student_id=2**
   ```sql
   UPDATE student SET major = 'Physics' WHERE student_id = 2;
   ```

8. **Delete Student Record of id=6**
   ```sql
   DELETE FROM student WHERE student_id = 6;
   ```

9. **Count Students in each Major where grade='A'**
   ```sql
   SELECT major, COUNT(*) AS count_grade_a 
   FROM student WHERE grade = 'A' GROUP BY major;
   ```

10. **Count Students in Each Grade having count greater than 2**
    ```sql
    SELECT grade, COUNT(*) AS student_count 
    FROM student GROUP BY grade HAVING COUNT(*) > 2;
    ```

---

## **Q8: EMPLOYEE TABLE - Advanced Queries**

### Table Creation:
```sql
CREATE TABLE employee (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    hire_date DATE,
    position VARCHAR(100)
);

INSERT INTO employee VALUES
(1, 'John', 'Doe', 'IT', 60000, '2021-05-15', 'Software Engineer'),
(2, 'Jane', 'Smith', 'HR', 55000, '2020-03-10', 'HR Specialist'),
(3, 'Alex', 'Johnson', 'IT', 70000, '2019-09-22', 'DevOps Engineer'),
(4, 'Emily', 'Davis', 'Finance', 80000, '2021-02-18', 'Analyst'),
(5, 'David', 'Duck', 'IT', 40000, '2020-06-05', 'Software Engineer'),
(6, 'Don', 'Dev', 'Finance', 90000, '2019-08-03', 'Developer');
```

### Solutions:
1. **Select All Data from Employee Table**
   ```sql
   SELECT * FROM employee;
   ```

2. **Select Employees in IT Department**
   ```sql
   SELECT * FROM employee WHERE department = 'IT';
   ```

3. **Count Number of Employees in Each Department**
   ```sql
   SELECT department, COUNT(*) AS emp_count FROM employee GROUP BY department;
   ```

4. **Find Average Salary in Each Department**
   ```sql
   SELECT department, AVG(salary) AS avg_salary FROM employee GROUP BY department;
   ```

5. **List Employees Hired After 1 February 2021**
   ```sql
   SELECT * FROM employee WHERE hire_date > '2021-02-01';
   ```

6. **Increase salary of IT department employees by 5000**
   ```sql
   UPDATE employee SET salary = salary + 5000 WHERE department = 'IT';
   ```

7. **Find highest salary in each department**
   ```sql
   SELECT department, MAX(salary) AS max_salary FROM employee GROUP BY department;
   ```

8. **Count Employees in Each Department Having More Than 1 Employee**
   ```sql
   SELECT department, COUNT(*) AS emp_count 
   FROM employee GROUP BY department HAVING COUNT(*) > 1;
   ```

9. **Find employee with Highest/Lowest salary**
   ```sql
   -- Highest
   SELECT * FROM employee WHERE salary = (SELECT MAX(salary) FROM employee);
   -- Lowest
   SELECT * FROM employee WHERE salary = (SELECT MIN(salary) FROM employee);
   ```

10. **Delete Employee Record having last name=Dev**
    ```sql
    DELETE FROM employee WHERE last_name = 'Dev';
    ```

---

## **Q9-Q10: EMPLOYEE MANAGEMENT QUERIES**

### Table Creation:
```sql
CREATE TABLE emp (
    eid INT PRIMARY KEY,
    ename VARCHAR(50),
    address VARCHAR(100),
    salary INT,
    commission INT
);

CREATE TABLE project (
    prno INT PRIMARY KEY,
    addr VARCHAR(100)
);

INSERT INTO emp VALUES
(1, 'Amita', 'Pune', 35000, 5000),
(2, 'Neha', 'Pune', 25000, NULL),
(3, 'Sagar', 'Nasik', 28000, 2000),
(4, 'Sneha', 'Mumbai', 19000, NULL),
(5, 'Shubham', 'Mumbai', 25000, 3000);

INSERT INTO project VALUES
(10, 'Mumbai'),
(20, 'Pune'),
(30, 'Jalgaon');
```

### Q9 Solutions:
1. **Find different locations from where employees belong**
   ```sql
   SELECT DISTINCT address FROM emp;
   ```

2. **What is maximum and minimum salary**
   ```sql
   SELECT MAX(salary) AS max_salary, MIN(salary) AS min_salary FROM emp;
   ```

3. **Display employee table in ascending order of salary**
   ```sql
   SELECT * FROM emp ORDER BY salary ASC;
   ```

4. **Find employees who live in Nasik or Pune**
   ```sql
   SELECT ename FROM emp WHERE address IN ('Nasik', 'Pune');
   ```

5. **Find employees who do not get commission**
   ```sql
   SELECT ename FROM emp WHERE commission IS NULL;
   ```

6. **Change city of Amita to Nashik**
   ```sql
   UPDATE emp SET address = 'Nashik' WHERE ename = 'Amita';
   ```

7. **Find employees whose name starts with 'A'**
   ```sql
   SELECT * FROM emp WHERE ename LIKE 'A%';
   ```

8. **Find count of staff from each city**
   ```sql
   SELECT address, COUNT(*) AS staff_count FROM emp GROUP BY address;
   ```

9. **Find city wise minimum salary**
   ```sql
   SELECT address, MIN(salary) AS min_salary FROM emp GROUP BY address;
   ```

10. **Find city wise maximum salary having maximum salary greater than 26000**
    ```sql
    SELECT address, MAX(salary) AS max_salary 
    FROM emp GROUP BY address HAVING MAX(salary) > 26000;
    ```

---

## **Q11-Q22: ADVANCED TOPICS**

### Q11: Database Design (Employee-Position-Duty)
```sql
CREATE TABLE employee_duty (
    emp_no INT,
    skill VARCHAR(50),
    pay_rate DECIMAL(10,2)
);

CREATE TABLE position (
    posting_no INT,
    skill VARCHAR(50)
);

CREATE TABLE duty_allocation (
    posting_no INT,
    emp_no INT,
    day DATE,
    shift VARCHAR(10)
);
```

### Q12: Doctor-Hospital Database
```sql
CREATE TABLE doctor (
    doctor_no INT PRIMARY KEY,
    doctor_name VARCHAR(100),
    address VARCHAR(200),
    city VARCHAR(50)
);

CREATE TABLE hospital (
    hospital_no INT PRIMARY KEY,
    name VARCHAR(100),
    street VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE doc_hosp (
    doctor_no INT,
    hospital_no INT,
    date DATE,
    FOREIGN KEY (doctor_no) REFERENCES doctor(doctor_no),
    FOREIGN KEY (hospital_no) REFERENCES hospital(hospital_no)
);
```

### Q13: JOINs and VIEWs
```sql
-- INNER JOIN
SELECT s.studentname, c.coursename 
FROM student s 
INNER JOIN course c ON s.courseid = c.courseid;

-- LEFT JOIN
SELECT s.studentname, c.coursename 
FROM student s 
LEFT JOIN course c ON s.courseid = c.courseid;

-- CREATE VIEW
CREATE VIEW student_course_view AS
SELECT s.studentname, c.coursename 
FROM student s 
JOIN course c ON s.courseid = c.courseid;
```

### Q14: TRIGGERs
```sql
-- AFTER INSERT TRIGGER
DELIMITER //
CREATE TRIGGER after_student_insert
AFTER INSERT ON student
FOR EACH ROW
BEGIN
    INSERT INTO audit_log VALUES (NEW.rollno, 'INSERT', NOW());
END//
DELIMITER ;
```

### Q15-Q17: PL/SQL Programming
```sql
-- PL/SQL Block Example
DELIMITER //
CREATE PROCEDURE proc_Grade(IN student_marks INT, OUT grade_category VARCHAR(50))
BEGIN
    IF student_marks >= 990 AND student_marks <= 1500 THEN
        SET grade_category = 'Distinction';
    ELSEIF student_marks >= 900 AND student_marks <= 989 THEN
        SET grade_category = 'First Class';
    ELSEIF student_marks >= 825 AND student_marks <= 899 THEN
        SET grade_category = 'Higher Second Class';
    ELSE
        SET grade_category = 'Pass';
    END IF;
END//
DELIMITER ;
```

### Q18: JDBC Connectivity
```java
// Basic JDBC Connection
Connection conn = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/practice_db", "username", "password");
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery("SELECT * FROM student");
```

### Q19-Q22: MongoDB Operations
```javascript
// Find All Employees
db.employee.find()

// Find Employees in IT Department
db.employee.find({"department": "IT"})

// Count Employees in Each Department
db.employee.aggregate([
    {$group: {_id: "$department", count: {$sum: 1}}}
])

// Calculate Average Salary by Department
db.employee.aggregate([
    {$group: {_id: "$department", avgSalary: {$avg: "$salary"}}}
])

// Map-Reduce for Total Salary
db.employee.mapReduce(
    function() { emit(null, this.salary); },
    function(key, values) { return Array.sum(values); },
    {out: "total_salary"}
)
```

---

## **INSTRUCTOR TIPS & IMPORTANT POINTS:**

1. **Always start with database creation and table structure**
2. **Use proper data types (VARCHAR, INT, DATE, DECIMAL)**
3. **Apply constraints (PRIMARY KEY, FOREIGN KEY, UNIQUE, NOT NULL, CHECK)**
4. **Use ALIAS (AS) for readable column names**
5. **Master pattern matching with LIKE ('%', '_')**
6. **Know aggregate functions (COUNT, SUM, AVG, MAX, MIN)**
7. **Understand GROUP BY and HAVING clauses**
8. **Practice JOINs (INNER, LEFT, RIGHT, FULL OUTER)**
9. **Learn VIEWs, TRIGGERs, and stored procedures**
10. **Know NoSQL operations for MongoDB**

**Good luck with your practical exam!**