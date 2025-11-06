create database sam1;
drop database sam1;

use sam1;
-- Create Products table
CREATE TABLE Product2 (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    unit_price DECIMAL(10,2)
);
INSERT INTO Product2 (product_id, product_name, category, unit_price) VALUES
(101, 'Laptop', 'Electronics', 500.00),
(102, 'Smartphone', 'Electronics', 300.00),
(103, 'Pen', 'Stationery', 30.00),
(104, 'Notebook', 'Stationery', 20.00),
(105, 'Bag', 'Accessories', 15.00);



drop table Sale2;

-- Create Sales table
CREATE TABLE Sale2 (
    sale_id INT PRIMARY KEY,
    product_id INT,
    quantity_sold INT,
    sale_date DATE,
    total_price DECIMAL(10,2),
    FOREIGN KEY (product_id) REFERENCES Product2(product_id)
);
INSERT INTO Sale2 (sale_id, product_id, quantity_sold, sale_date, total_price) VALUES
(1, 101, 5, '2024-01-01', 2500.00),
(2, 102, 3, '2024-01-02', 900.00),
(3, 103, 2, '2024-01-02', 60.00),
(4, 104, 4, '2024-01-03', 80.00),
(5, 105, 6, '2024-01-03', 90.00);

SELECT * FROM Sale2;
SELECT product_name, unit_price 
FROM Product2 
WHERE unit_price = (SELECT MAX(unit_price) FROM Product2);
/* SELECT product_name, unit_price
FROM Product2
ORDER BY unit_price DESC
LIMIT 1;*/

SELECT sale_date, COUNT(*) AS total_sales 
FROM Sale2
GROUP BY sale_date;

SELECT ROUND(SUM(total_price),2) AS total_sales_price FROM Sale2;

SELECT product_name, unit_price 
FROM Product2 
WHERE unit_price BETWEEN 20 AND 600;

SELECT product_id, SUM(quantity_sold) AS total_sold 
FROM Sale2 
GROUP BY product_id 
ORDER BY total_sold DESC 
LIMIT 1;

SELECT product_id, SUM(quantity_sold) AS total_quantity
FROM Sale2
GROUP BY product_id 
HAVING SUM(quantity_sold) > 30;

SELECT p.product_name, (s.quantity_sold * p.unit_price) AS total_price
FROM Sale2 s 
JOIN Product2 p ON s.product_id=p.product_id
WHERE (s.quantity_sold * p.unit_price) > 100;

SELECT sale_id, DATEDIFF(CURDATE(), sale_date) AS days_since_sale
FROM Sale2;
SELECT AVG(quantity_sold) AS avg_quantity_sold FROM Sale2;
