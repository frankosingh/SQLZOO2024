/* Database Details
stops(id, name)
route(num, company, pos, stop)
*/

--1. How many stops are in the database?
SELECT COUNT(id)
FROM stops


--2. Find the id value for the stop 'Craiglockhart'
SELECT id
FROM stops
WHERE name = 'Craiglockhart'


--3. Give the id and the name for the stops on the '4''LRT' service
SELECT id, name
FROM stops JOIN route ON id=stop
WHERE num = '4'
AND company = 'LRT'


--4.The query shown gives the number of routes that visit either London Road (149) 
--or Craiglockhart (53). Run the query and notice the two services that link 
--these stops have a count of 2. 
--Add a HAVING clause to restrict the output to these two routes
SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(*)>1


/*5.Execute the self join shown and observe that
 b.stop gives all the places you can get to from 
  Craiglockhart, without changing routes. Change the query so that it 
  shows the services from Craiglockhart to London Road.
*/

SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON (a.company = b.company AND a.num = b.num)
WHERE a.stop = 53 
AND b.stop = 149


/* 6. Change the query so that the services between 'Craiglockhart'
   and 'London Road' are shown.
*/
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num)
             JOIN stops stopa ON (a.stop=stopa.id)
             JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name='London Road'

  
--7. Give a list of all services which connect stops 115 and 137('Haymarket' and 'Leith')
SELECT DISTINCT a.company, a.num
  FROM route a 
    JOIN route b 
      ON (a.company = b.company 
        AND a.num = b.num)
  WHERE (a.stop = 115 
    AND b.stop = 137)


--8. Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'
SELECT DISTINCT a.company , a.num
FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num)
     JOIN stops stopa ON (a.stop=stopa.id)
     JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name = 'Craiglockhart' AND stopb.name = 'Tollcross'


/*9. Give a distinct list of the stops which may be reached from 'Craiglockhart' 
by taking one bus, including 'Craiglockhart' itself, offered by the LRT company. 
Include the company and bus no. of the relevant services.
*/
SELECT DISTINCT stopb.name, b.company, b.num
FROM route a JOIN route b ON (a.company = b.company AND a.num = b.num)
            JOIN stops stopa ON (a.stop = stopa.id)
            JOIN stops stopb ON (b.stop = stopb.id)
  WHERE stopa.name = 'Craiglockhart' 


/* 10. Find the routes involving two buses that can go from Craiglockhart to Lochend.
Show the bus no. and company for the first bus, the name of the stop for the transfer,
and the bus no. and company for the second bus.
*/
SELECT x.num, x.company, x.name, y.num, y.company 
FROM 
(
SELECT DISTINCT stopb.name, b.company, b.num
FROM route a JOIN route b ON (a.company = b.company AND a.num = b.num)
      JOIN stops stopa ON (a.stop = stopa.id)
      JOIN stops stopb ON (b.stop = stopb.id)
  
WHERE stopa.name = 'Craiglockhart') x JOIN
  (
  SELECT DISTINCT stopc.name, c.company, c.num
  FROM route c 
  JOIN route d ON (c.company = d.company AND c.num=d.num)
  JOIN stops stopc ON (c.stop = stopc.id)
  JOIN stops stopd ON (d.stop = stopd.id)
WHERE stopd.name = 'Lochend') y ON (y.name = x.name) 
ORDER BY x.num, name, y.num
