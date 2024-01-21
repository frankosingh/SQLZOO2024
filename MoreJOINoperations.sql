/*
The database consists of three tables movie , actor and casting .

movie
id	title	yr	director	budget	gross 

actor
id	name 

casting
movieid	actorid	ord
*/

--1. 1962 movies
-- List the films where the yr is 1962.(Show title and id)
SELECT id, title
FROM movie
WHERE yr=1962

  
--2. Specific movie release
--Give release year of 'Citizen Kane'
SELECT yr 
FROM movie
WHERE title = 'Citizen Kane'

  
--3. Strak Trek movies
--List all of the Star Trek movies, include the id, title and yr 
--(all of these movies include the words Star Trek in the title). Order results by year.
SELECT id, title, yr
FROM movie
WHERE title LIKE 'Star Trek%'
ORDER BY yr


--4. id for a particular actor
--What id number does the actor'Glenn Close' have?
SELECT id from actor where name = 'Glenn Close'


--5. id for a particular movie
--What is the id of the film 'Casablanca'?
SELECT id
FROM movie 
WHERE title = 'Casablanca'


--6. Cast list for a movie (given the movie id)
--Obtain the cast list for 'Casablanca'. Movie id from previous query(11768)
SELECT name
FROM actor JOIN casting ON (actorid=actor.id)
WHERE movieid= 11768


--7. Cast list for a movie with its title
--Obtain the cast list for the film 'Alien'
SELECT name 
FROM  movie JOIN casting ON movie.id=movieid
            JOIN actor   ON actorid=actor.id
WHERE title = 'Alien'


--8. Actor's movie list
--List the films in which 'Harrison Ford' has appeared
SELECT title
FROM  movie JOIN casting ON movie.id=movieid
            JOIN actor   ON actorid=actor.id
WHERE name = 'Harrison Ford'

--9. List of movies as a supporting actor
--List the films where 'Harrison Ford' has appeared - but not in the starring role.
--[Note: the ord field of casting gives the position of the actor. 
--If ord=1 then this actor is in the starring role]
SELECT title
FROM  movie JOIN casting ON movie.id=movieid
            JOIN actor   ON actorid=actor.id
WHERE name = 'Harrison Ford' AND ord <> 1


--10. Lead actors' movies in a particular year
--List the films together with the leading star for all 1962 films.
SELECT title, name 
FROM movie JOIN casting ON (movieid=movie.id)
           JOIN actor ON (actorid=actor.id)
WHERE yr = 1962 and ord = 1


/*11. Harder Questions
Busy years for an Actor
Which were the busiest years for 'Rock Hudson', 
show the year and the number of movies he made 
each year for any year in which he made more than 2 movies.
*/
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2


--12. Lead actor in Julie Andrews' movies
--List the film title and the leading actor for all of the films 'Julie Andrews' played in.
SELECT title, name 
FROM movie JOIN casting ON movie.id = movieid
           JOIN actor ON actor.id =actorid
WHERE ord=1 AND movieid IN
(
  SELECT movieid  
  FROM casting JOIN actor ON actor.id=actorid
  WHERE name='Julie Andrews'
)

--13. Actor with many leading roles
--Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.
SELECT DISTINCT name     
FROM actor 
JOIN casting  ON casting.actorid = actor.id
WHERE actorid IN 
(
SELECT actorid 
FROM casting
WHERE ord = 1 
GROUP BY actorid
HAVING count(actorid) >= 15)
ORDER BY name


--14. Movie released in a particular year
-- List the films released in the year 1978 
-- ordered by the number of actors in the cast, then by title.
SELECT title, COUNT(actorid) as cast
FROM movie JOIN casting on id=movieid
WHERE yr = 1978
GROUP BY title
ORDER BY cast DESC, title

--15. List of people who worked with a particular actor
-- List all the people who have worked with 'Art Garfunkel'.
SELECT distinct actor.name
FROM movie JOIN casting ON casting.movieid = movie.id
           JOIN actor ON actor.id = casting.actorid
WHERE movie.id IN 
(
SELECT movieid
from casting join actor on id =actorid 
WHERE actor.name = 'Art Garfunkel') 
AND actor.name <> 'Art Garfunkel'
