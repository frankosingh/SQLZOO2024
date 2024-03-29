--Read some more about Nested SELECT else this will become super confusing really fast.

--1. Bigger Than Russia
-- List each country name where the population is larger than 'Russia'.
SELECT name country
FROM world
WHERE population >
(
  SELECT population 
  FROM world
  WHERE name='Russia'
)

  
--2. Richer Than UK
-- Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
SELECT name 
FROM world
WHERE continent = 'Europe' AND gdp/population > 
(
  SELECT gdp/population 
  FROM world           
  WHERE name = 'United Kingdom'
)

--3. Neighbours of Argentina and Australia
--List the name and continent of countries in the continents containing 
--either Argentina or Australia. Order by name of the country.
SELECT name, continent FROM world
WHERE continent IN 
(
  SELECT continent 
  FROM world 
  WHERE name IN ('Argentina','Australia')
)

  
--4. Between Canada and Poland
--Which country has a population that is more than the United Kingdom but 
--less than Germany? Show the name and the population.
SELECT name, population 
FROM world
WHERE population > 
(
  SELECT population
  FROM world
  WHERE name = 'United Kingdom'
)
AND population < 
(
  SELECT population
  FROM world
  WHERE name = 'Germany'
)

  
--5.Percentages of Germany
/*
Show the name and the population of each country in Europe. 
Show the population as a percentage of the population of Germany.
*/
SELECT name, 
  CONCAT(
    ROUND(
      100*population/(
                      SELECT population 
                      FROM world 
                      WHERE name='Germany')),'%') AS percentage 
FROM world
WHERE continent = 'Europe'

  
--6.Bigger than every country in Europe
--Which countries have a GDP greater than every country in Europe?
--(Some countries may have NULL gdp values)  
SELECT name
FROM world
WHERE gdp > ALL 
(
  SELECT gdp
  FROM world
  WHERE continent = ‘Europe’ AND gdp>0
)

  
--7.Largest in each continent
--Find the largest country (by area) in each continent, 
--show the continent, the name and the area.
SELECT continent, name, area 
FROM world x
WHERE area >= ALL
(
  SELECT area 
  FROM world y 
  WHERE y.continent = x.continent AND area>0
)

  
--8. First country of each continent (alphabetically)
--List each continent and the name of the country that comes first alphabetically.
SELECT continent, name 
FROM world x
WHERE name <= ALL
(
  SELECT name 
  FROM world y 
  WHERE x.continent = y.continent
)

  
--9.Tougher questions for this topic from now
--Find the continents where all countries have a population <= 25000000. 
--Then find the names of the countries associated with these continents. 
--Show name, continent, and population.

SELECT name, continent, population FROM world x
WHERE continent IN 
(
  SELECT continent
  FROM world
  GROUP BY continent
  HAVING MAX(population) <= 25000000
)


--10.Three times Bigger
--Some countries have populations more than three times that of all of their neighbours 
--(in the same continent). Give the countries and continents.
SELECT name, continent 
FROM world x
WHERE population/3 > ALL
  (
  SELECT population 
  FROM world y 
  WHERE y.continent = x.continent AND y.name <> x.name
  )

