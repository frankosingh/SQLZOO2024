--1. Winners from 1950
--Change the query shown so that it displays Nobel prizes for 1950

SELECT yr, subject, winner
  FROM nobel
  WHERE yr = 1950

  
-- 2.1962 Literature
--Show who won the 1962 prize for Literature.
SELECT winner winner_1962
FROM nobel
WHERE yr = 1962
AND subject = 'Literature'

  
-- 3. Albert Einstein
--Show the year and subject that won 'Albert Einstein' his prize.
SELECT yr, subject
FROM nobel
WHERE winner = 'Albert Einstein'

  
-- 4. Recent Peace Prizes
--Give the name of the 'Peace' winners since the year 2000, including 2000.

SELECT winner winner_peace
FROM nobel
WHERE subject = 'Peace'
AND yr >= 2000

  
-- 5. Literature in 1980s
-- Show all details (yr, subject, winner) of the Literature prize winners for
-- 1980 to 1989 inclusive.
SELECT *
FROM nobel
WHERE subject = 'Literature'
AND yr BETWEEN 1980 AND 1989

  
--6 Only Presidents
/*
Theodore Roosevelt
Thomas Woodrow Wilson
Jimmy Carter
Barack Obama
*/
SELECT * 
FROM nobel
WHERE winner IN ('Theodore Roosevelt', 'Thomas Woodrow Wilson', 'Jimmy Carter', 'Barack Obama')

  
--7. John
-- Show the winners with first name John
SELECT winner
FROM nobel
WHERE winner LIKE 'John%'


--8. Chemistry and Physics from different years
--Show the year, subject, and name of physics winners for 
--1980 together with the chemistry winners for 1984.
SELECT * 
FROM nobel
WHERE yr = 1980 AND subject = 'physics'
   OR yr = 1984 AND subject = 'chemistry'

--9.Exclude Chemists and Medics
--Show the year, subject, and name of winners for 1980 excluding chemistry and medicine
SELECT *
FROM nobel
WHERE yr = 1980 AND subject <> 'chemistry' 
      AND subject <> 'medicine' 

--10.Early Medicine, Late Literature
--Show year, subject, and name of people who won a 'Medicine' prize in an early year 
--(before 1910, not including 1910)
--together with winners of a 'Literature' prize in a later year 
--(after 2004, including 2004)
SELECT * FROM nobel
WHERE subject = 'medicine' AND yr < 1910
   OR subject = 'literature' AND yr >= 2004

--11. Umlaut
--Find all details of the prize won by PETER GRÜNBERG
--(Please read about how to use Non-ASCII Characters using keyboard)
SELECT *
FROM nobel
WHERE winner = 'Peter GrÜnberg'

--12.Apostrophe
--Find all details of the prize won by EUGENE O'NEILL
SELECT * FROM nobel
WHERE winner = "Eugene O'Neill"

--13.Knights of the realm in order
--List the winners, year and subject where the winner starts with Sir. 
--Show the the most recent first, then by name order.
SELECT winner, yr, subject FROM nobel
WHERE winner LIKE 'Sir%'
ORDER BY yr DESC,winner


--14. Chemistry and Physics Last
--Show the 1984 winners and subject ordered by subject and winner name; 
--but list chemistry and physics last.(This can be tricky for beginners)
--(Go through the Youtube tutorial for this video)
SELECT winner, subject
  FROM nobel
 WHERE yr=1984
 ORDER BY 
 CASE WHEN subject IN ('physics','chemistry') 
      THEN 1 
      ELSE 0 
  END, subject,winner


