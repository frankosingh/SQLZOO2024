/*Three tables : 
game(id,mdate,stadium,team1,team2)
eteam(id,teamname,coach)
goal(matchid,teamid,player,gtime)
*/

/* 1. The first example shows the goal scored by a player with the last name 'Bender'. 
The * says to list all the columns in the table 
- a shorter way of saying matchid, teamid, player, gtime.
Modify it to show the matchid and player name for all goals scored by Germany. 
To identify German players, check for: teamid = 'GER'
*/
SELECT matchid, player 
FROM goal
WHERE teamid = 'GER'

  
--2. Show id, stadium, team1, team2 for just game 1012
SELECT DISTINCT id,stadium,team1,team2
FROM game, goal 
WHERE id = 1012


--3. Show the player, teamid, stadium and mdate for every German goal.
SELECT player, teamid, stadium, mdate
FROM game JOIN goal ON (id=matchid)
WHERE teamid = 'GER'


--4. Show the team1, team2 and player for every goal scored by 
-- a player called Mario player.
SELECT team1, team2, player
FROM game JOIN goal ON (id=matchid)
WHERE player LIKE 'Mario%'

  
--5. Show player, teamid, coach, gtime for all goals scored in the first 10 minutes
SELECT player, teamid, coach, gtime
FROM goal JOIN eteam ON (id=teamid)
WHERE gtime<=10


--6.List the dates of the matches and the name of the team in 
-- which 'Fernando Santos' was the team1 coach.
SELECT mdate, teamname
FROM game JOIN eteam ON (team1=eteam.id)
WHERE coach = 'Fernando Santos'

  
--7.List the player for every goal scored in a game 
-- where the stadium was 'National Stadium, Warsaw'
SELECT player 
FROM game JOIN goal ON (id = matchid)
WHERE stadium = 'National Stadium, Warsaw'


--8. Difficulty increases from here
--Instead show the name of all players who scored a goal against Germany.
SELECT DISTINCT player
FROM game JOIN goal ON matchid = id 
WHERE teamid!='GER' AND (team1 = 'GER' OR team2 = 'GER')


--9.Show teamname and the total number of goals scored.
SELECT teamname, COUNT(player)
FROM eteam JOIN goal ON id=teamid
GROUP BY teamname


--10.Show the stadium and the number of goals scored in each stadium.
SELECT stadium, COUNT(gtime) AS 'Number of Goals' 
FROM game JOIN goal ON id = matchid
GROUP BY stadium


--11.For every match involving 'POL', show the matchid, date and the number of goals scored.
SELECT matchid, mdate, COUNT(gtime) AS 'Number of Goals'
FROM game JOIN goal ON matchid = id 
WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY matchid


--12.For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'
SELECT matchid, mdate, COUNT(gtime) AS 'no. of goals'
FROM goal JOIN game ON (matchid = id)
WHERE (team1 = 'GER' or team2 = 'GER') AND teamid = 'GER'
GROUP BY matchid


--13.List every match with the goals scored by each team.
-- Sort your result by mdate, matchid, team1 and team2.
SELECT mdate, team1, team2,
SUM(CASE 
    WHEN teamid=team1 
    THEN 1 
    ELSE 0 
    END) AS score1, 
SUM(CASE 
    WHEN teamid=team2 
    THEN 1 
    ELSE 0 
    END) AS score2
FROM game LEFT JOIN goal ON matchid = id
GROUP BY mdate, matchid, team1, team2
 
