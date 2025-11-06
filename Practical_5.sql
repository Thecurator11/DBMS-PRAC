-- Create Products table
use sam;
drop table Product;

CREATE TABLE Product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    unit_price DECIMAL(10,2)
);
INSERT INTO Product (product_id, product_name, category, unit_price) VALUES
(101, 'Laptop', 'Electronics', 500.00),
(102, 'Smartphone', 'Electronics', 300.00),
(103, 'Pen', 'Stationery', 30.00),
(104, 'Notebook', 'Stationery', 20.00),
(105, 'Bag', 'Accessories', 15.00),
(106, 'Smartwatch', 'Electronics', 250.00);  
-- Create Sales table

drop table Sale3;

CREATE TABLE Sale3 (
    sale_id INT PRIMARY KEY,
    product_id INT,
    quantity_sold INT,
    sale_date DATE,
    total_price DECIMAL(10,2),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);
INSERT INTO Sale3 (sale_id, product_id, quantity_sold, sale_date, total_price) VALUES
(1, 101, 5, '2024-01-01', 2500.00),
(2, 102, 3, '2024-01-02', 900.00),
(3, 103, 2, '2024-01-02', 60.00),
(4, 104, 4, '2024-01-03', 80.00),
(5, 105, 6, '2024-01-03', 90.00);
SELECT * 
FROM Sale3;

SELECT SUM(total_price) AS Total_Revenue 
FROM Sale3;
SELECT AVG(unit_price) AS Average_Unit_Price 
FROM Product;
SELECT sale_id, product_id, total_price 
FROM Sale3
WHERE quantity_sold > 4;
SELECT sale_id, DATE_FORMAT(sale_date, '%Y-%m-%d') AS formatted_date 
FROM Sale3;
SELECT *
FROM Product
WHERE product_id NOT IN (SELECT product_id FROM Sale3);

SELECT category, AVG(unit_price) AS avg_price
FROM Product
GROUP BY category
ORDER BY avg_price DESC
LIMIT 1;

SELECT S.*
FROM Sale3 S
JOIN Product P ON S.product_id = P.product_id
WHERE P.product_name LIKE '%Smart%';

SELECT P.product_name, SUM(S.total_price) AS total_revenue
FROM Sale3 S
JOIN Product P ON S.product_id = P.product_id
GROUP BY P.product_name;

SELECT S.sale_id, S.sale_date, S.total_price, P.product_name
FROM Sale3 S
JOIN Product P ON S.product_id = P.product_id;







