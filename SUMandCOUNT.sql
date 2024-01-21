--1. Total World Population
--Show the total world population
SELECT SUM(population) pop_world
FROM world

-- 2.List of continents
-- List all the continents - just once each.
SELECT DISTINCT continent
FROM world

-- 3.GDP of a country 
-- Give the total GDP of Africa
SELECT SUM(gdp) gdp_Africa
FROM world
WHERE continent = 'Africa'

-- 4. Count the big countries
-- How many countries have an area of at least 1000000
SELECT COUNT(name) num_countries
FROM world
WHERE area >= 1000000

-- 5.Baltic States population 
-- What is the total population of ('Estonia', 'Latvia', 'Lithuania')
SELECT SUM(population)
FROM world
WHERE name in ('Estonia','Latvia','Lithuania')

-- 6.Counting the countries of each continent 
-- For each continent show the continent and number of countries.
SELECT continent, COUNT(name) num_countries
FROM world
GROUP BY continent

-- 7.Counting big countries in each continent 
-- For each continent show the continent and number of countries with
-- populations of at least 10 million.
SELECT continent, COUNT(name) num_countries
FROM world
WHERE population >= 10E6
GROUP BY continent

-- 8. Counting big continents 
-- List the continents with total populations of at least 100 million.
SELECT continent
FROM world
GROUP BY continent
HAVING SUM(population) >= 100E6
