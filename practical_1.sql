create database samruddhi;

use sam;
drop table clients;

create table clients(client_no varchar(20),Name varchar(50),city varchar(50),State varchar(50),BalDue int,SP int,SOD date);

Insert into clients values('C001','Pooja','Nashik','Maharashtra',4000,500,'2013-08-03');
Insert into clients values('C002','Ananya','Bangalore','karnataka',6000,800,'2009-05-06');
Insert into clients values('C003','Anushka','Hydrabad','Andhara',8000,200,'2007-08-27');
Insert into clients values('C004','Atharv','mumbai','Maharashtra',1000,100,'2014-03-03');
Insert into clients values('C005','Ajunkya','pune','Maharashtra',6000,500,'2014-08-03');
select * from clients;
Select Name from clients where Name like '_o%';
Select * from clients where city like 'N%';
Select * from clients where city in ('Bangalore','Nashik');
Select * from clients where Month(SOD)=8;
SELECT Name, SP, (SP * 100) AS Newprice 
FROM clients;
select Name from clients where State <> 'Maharashtra';
select count(*) as Total_order
from clients;
select avg(SP) as Average_price
from clients;
SELECT 
    MAX(SP) AS Max_price, 
    MIN(SP) AS Min_price 
FROM Clients;
select count(*) as count_clients from clients
where BalDue>2000;









