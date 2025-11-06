-- 1️⃣ Create Products table (if not already)
use sam;

CREATE TABLE Product1 (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    unit_price DECIMAL(10,2)
);
CREATE TABLE Sales2 (
    sale_id INT PRIMARY KEY,
    product_id INT,
    quantity_sold INT,
    sale_date DATE,
    total_price DECIMAL(10,2),
    FOREIGN KEY (product_id) REFERENCES Product1(product_id)
);
-- 2️⃣ Insert Products data FIRST
INSERT INTO Product1 (product_id, product_name, category, unit_price) VALUES
(101, 'Laptop', 'Electronics', 500.00),
(102, 'Mobile', 'Electronics', 300.00),
(103, 'Pen', 'Stationery', 30.00),
(104, 'Notebook', 'Stationery', 20.00),
(105, 'Bag', 'Accessories', 15.00);

-- 3️⃣ Now insert into Sales1
INSERT INTO Sales2 (sale_id, product_id, quantity_sold, sale_date, total_price) VALUES
(1, 101, 5, '2024-01-01', 2500.00),
(2, 102, 3, '2024-01-02', 900.00),
(3, 103, 2, '2024-01-02', 60.00),
(4, 104, 4, '2024-01-03', 80.00),
(5, 105, 6, '2024-01-03', 90.00);

Select * from Product1;
select * from Sales2;
select product_name,unit_price from Product1;
select * from Sales2 where total_price>100;
select sale_id,total_price from Sales2 where sale_date = '2024-01-03';
SELECT SUM(quantity_sold) AS Total_Quantity_Sold 
FROM Sales2;
SELECT product_name, unit_price 
FROM Product1 
ORDER BY unit_price DESC;
SELECT AVG(total_price) AS AVG_Total_Price
from Sales2;
SELECT product_name, category 
FROM Product1 
ORDER BY category ASC;
SELECT SUM(S.quantity_sold) AS Total_Electronics_Sold
FROM Sales2 S
JOIN Product1 P ON S.product_id = P.product_id
WHERE P.category = 'Electronics';
SELECT P.product_name, (S.quantity_sold * P.unit_price) AS total_price
FROM Sales2 S
JOIN Product1 P ON S.product_id = P.product_id;
SELECT 
    MONTH(sale_date) AS Sale_Month, 
    COUNT(*) AS Sales_Count
FROM Sales2
GROUP BY MONTH(sale_date);












