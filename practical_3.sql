use sam;
create table World(country VARCHAR(50),continent VARCHAR(50),area INT, 
population BIGINT,gdp BIGINT);
drop table World;
INSERT INTO World (country, continent, area, population, gdp) VALUES
('Afghanistan', 'Asia', 652230, 25500100, 20343000000),
('Albania', 'Europe', 28748, 2874810, 12960000000),
('Algeria', 'Africa', 2381741, 37100000, 188681000000),
('Andorra', 'Europe', 468, 78115, 3712000000),
('Angola', 'Africa', 1246700, 20609294, 100990000000);
select * from World;

Select population from World Where country = 'Angola';
Select SUM(population) AS Africa_Population From World Where continent = 'Africa';
Select country,population from World Where country IN ('Algeria','Afghanistan');
SELECT country,area From World Where area between 200000 AND 2500000;
Select DISTINCT continent From World Where continent LIKE 'Y%';
Select country from World Where country LIKE '%g%';
select country from  World Where Length(country)=4;
Select Sum(population) AS Total_Population 
from world;
select Distinct continent from World;
Select Sum(GDP) AS Total_GDP_Africa 
from world where continent = 'Africa';

 


