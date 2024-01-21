--1. Show the name, continent and population of all countries.

SELECT name, continent, population 
  FROM world


--2. Large Countries
--  Show the name for the countries that have a population of at least 200 million. 
--  200 million is 200000000, there are eight zeros.

SELECT name 
  FROM world
  WHERE population >= 200000000


--3. Per capita GDP
--Give the name and the per capita GDP for those countries with a population of at least 200 million.

SELECT name, gdp/population
  FROM world
  WHERE population >= 200000000;


--4. South America in Millions
-- Show the (name) and (population) in millions for the countries of
-- 'South America' Divide the population by 1000000 to get population in
-- millions.

SELECT name country, population/1000000 pop_millions
 FROM world
 WHERE continent = 'South America'


-- 5. France, Germany, Italy
--Show the (name) and (population) for 'France', 'Germany', 'Italy'

SELECT name country, population
 FROM world
 WHERE name IN ('France', 'Germany', 'Italy')

  
-- 6. United
--Identify the countries which have names including the word 'United'

SELECT name country
 FROM world
 WHERE name LIKE '%United%'


--7. Two ways to be big
/* A country is big if it has an area of more than 3 million sq km or 
it has a population of more than 250 million.
Show the countries that are big by area or big by population. 
Show name, population and area.
*/

SELECT name, population, area
  FROM world
  WHERE area > 3000000 OR population > 250000000

  
--8. One or the other(but not both)
/* Exclusive OR (XOR). Show the countries that are big by area (more than 3 million) or 
big by population (more than 250 million) but not both. Show name, population and area.
Australia has a big area but a small population, it should be included.
Indonesia has a big population but a small area, it should be included.
China has a big population and big area, it should be excluded.
United Kingdom has a small population and a small area, it should be excluded.
*/

SELECT name, population , area
 FROM world
 WHERE area > 3000000 XOR population > 250000000


--9. Rounding
/*Show the name and population in millions and 
the GDP in billions for the countries of the continent 'South America'. 
Use the ROUND function to show the values to two decimal places.
For Americas show population in millions(PIM) and GDP in billions(GIB) both to 2 decimal places.
*/

SELECT name, round(population/1000000,2) AS 'PIM', round(GDP/1000000000,2) as GIB
FROM world
WHERE continent = 'South America'


--10. Trillion dollar economies
/*Show the name and per-capita GDP for those countries with a GDP of at least one trillion. 
Round this value to the nearest 1000.
Show per-capita GDP for the trillion dollar countries to the nearest $1000.
*/

select name ,  ROUND(gdp/population, -3)
from world
where gdp >= 1000000000000
