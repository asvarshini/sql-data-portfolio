-- =========================================================
-- PROJECT : SPORTS LEAGUE MANAGEMENT SYSTEM
-- AUTHOR  : Varshini
-- DATABASE: MySQL
-- =========================================================

-- =========================================================
-- 1. CREATE DATABASE
-- =========================================================

DROP DATABASE IF EXISTS sports;

CREATE DATABASE sports;

USE sports;

-- =========================================================
-- 2. CREATE TABLE : TEAMS
-- =========================================================

CREATE TABLE teams
(
    team_id INT PRIMARY KEY,

    team_name VARCHAR(30) NOT NULL UNIQUE,

    city VARCHAR(30) NOT NULL
);

-- =========================================================
-- 3. CREATE TABLE : PLAYERS
-- =========================================================

CREATE TABLE players
(
    player_id INT PRIMARY KEY,

    player_name VARCHAR(30) NOT NULL,

    age INT NOT NULL CHECK(age >= 18),

    position VARCHAR(30) NOT NULL,

    team_id INT NOT NULL,

    FOREIGN KEY(team_id)
    REFERENCES teams(team_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- =========================================================
-- 4. CREATE TABLE : MATCHES
-- =========================================================

CREATE TABLE matches
(
    match_id INT PRIMARY KEY,

    match_date DATE NOT NULL,

    home_team_id INT NOT NULL,

    away_team_id INT NOT NULL,

    home_score INT DEFAULT 0,

    away_score INT DEFAULT 0,

    CHECK(home_score >= 0),

    CHECK(away_score >= 0),

    FOREIGN KEY(home_team_id)
    REFERENCES teams(team_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    FOREIGN KEY(away_team_id)
    REFERENCES teams(team_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- =========================================================
-- 5. CREATE TABLE : STATS
-- =========================================================

CREATE TABLE stats
(
    stat_id INT PRIMARY KEY,

    player_id INT NOT NULL,

    match_id INT NOT NULL,

    goals INT DEFAULT 0,

    assists INT DEFAULT 0,

    yellow_cards INT DEFAULT 0,

    red_cards INT DEFAULT 0,

    CHECK(goals >= 0),

    CHECK(assists >= 0),

    FOREIGN KEY(player_id)
    REFERENCES players(player_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    FOREIGN KEY(match_id)
    REFERENCES matches(match_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- =========================================================
-- 6. CREATE TABLE : COACHES
-- =========================================================

CREATE TABLE coaches
(
    coach_id INT PRIMARY KEY,

    coach_name VARCHAR(30) NOT NULL,

    team_id INT UNIQUE,

    experience_years INT CHECK(experience_years >= 0),

    FOREIGN KEY(team_id)
    REFERENCES teams(team_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- =========================================================
-- 7. INSERT VALUES INTO TEAMS
-- =========================================================

INSERT INTO teams(team_id, team_name, city)
VALUES
(1,'Lions','Mandya'),
(2,'Tigers','Mysore'),
(3,'Foxes','Bangalore'),
(4,'Cheetah','Mangalore'),
(5,'Rabbits','Hassan');

-- =========================================================
-- 8. INSERT VALUES INTO PLAYERS
-- =========================================================

INSERT INTO players(player_id, player_name, age, position, team_id)
VALUES
(101,'Varshini',22,'Forward',1),
(102,'Hasini',20,'Defender',1),
(103,'Anshu',21,'Center',1),
(104,'Harshitha',20,'Forward',2),
(105,'Neha',20,'Midfielder',2);

-- =========================================================
-- 9. INSERT VALUES INTO MATCHES
-- =========================================================

INSERT INTO matches(match_id, match_date, home_team_id, away_team_id, home_score, away_score)
VALUES
(1,'2026-06-22',1,2,21,22),
(2,'2026-06-23',1,2,19,18),
(3,'2026-06-24',2,1,21,22);

-- =========================================================
-- 10. INSERT VALUES INTO STATS
-- =========================================================

INSERT INTO stats(stat_id, player_id, match_id, goals, assists, yellow_cards, red_cards)
VALUES
(31,101,1,12,4,1,0),
(32,102,1,10,6,2,1),
(33,103,2,11,2,3,1),
(34,104,2,13,1,1,0),
(35,105,1,22,4,1,1);

-- =========================================================
-- 11. INSERT VALUES INTO COACHES
-- =========================================================

INSERT INTO coaches(coach_id, coach_name, team_id, experience_years)
VALUES
(200,'Punith',1,10),
(201,'Sankar',2,12);

-- =========================================================
-- ==================== QUERIES =============================
-- =========================================================


-- =========================================================
-- QUERY 1
-- DISPLAY ALL TEAMS
-- =========================================================

SELECT * FROM teams;


-- =========================================================
-- QUERY 2
-- DISPLAY ALL PLAYERS
-- =========================================================

SELECT * FROM players;


-- =========================================================
-- QUERY 3
-- DISPLAY ALL MATCHES
-- =========================================================

SELECT * FROM matches;


-- =========================================================
-- QUERY 4
-- DISPLAY ALL PLAYER STATISTICS
-- =========================================================

SELECT * FROM stats;


-- =========================================================
-- QUERY 5
-- DISPLAY ALL COACH DETAILS
-- =========================================================

SELECT * FROM coaches;


-- =========================================================
-- QUERY 6
-- DISPLAY TEAM NAME AND PLAYER NAME
-- =========================================================

SELECT t.team_name,
       p.player_name
FROM teams t
JOIN players p
ON t.team_id = p.team_id;


-- =========================================================
-- QUERY 7
-- DISPLAY PLAYERS BELONGING TO TEAM 1
-- =========================================================

SELECT *
FROM players
WHERE team_id = 1;


-- =========================================================
-- QUERY 8
-- DISPLAY MATCHES PLAYED BY TEAM 1
-- =========================================================

SELECT *
FROM matches
WHERE home_team_id = 1;


-- =========================================================
-- QUERY 9
-- DISPLAY TOP 2 PLAYERS BASED ON GOALS
-- =========================================================

SELECT s.goals,
       p.player_name
FROM stats s
JOIN players p
ON s.player_id = p.player_id
ORDER BY s.goals DESC
LIMIT 2;


-- =========================================================
-- QUERY 10
-- COUNT TOTAL NUMBER OF PLAYERS
-- =========================================================

SELECT COUNT(*) AS total_players
FROM players;


-- =========================================================
-- QUERY 11
-- DISPLAY AVERAGE AGE OF PLAYERS
-- =========================================================

SELECT AVG(age) AS average_age
FROM players;


-- =========================================================
-- QUERY 12
-- DISPLAY MAXIMUM GOALS SCORED
-- =========================================================

SELECT MAX(goals) AS highest_goals
FROM stats;


-- =========================================================
-- QUERY 13
-- DISPLAY TOTAL GOALS SCORED BY EACH PLAYER
-- =========================================================

SELECT p.player_name,
       SUM(s.goals) AS total_goals
FROM players p
JOIN stats s
ON p.player_id = s.player_id
GROUP BY p.player_name;


-- =========================================================
-- QUERY 14
-- DISPLAY TEAMS HAVING MORE THAN 2 PLAYERS
-- =========================================================

SELECT t.team_name,
       COUNT(p.player_id) AS total_players
FROM teams t
JOIN players p
ON t.team_id = p.team_id
GROUP BY t.team_name
HAVING COUNT(p.player_id) > 2;


-- =========================================================
-- QUERY 15
-- DISPLAY MATCH WINNER DETAILS
-- =========================================================

SELECT match_id,
       home_team_id,
       away_team_id,
       home_score,
       away_score,

CASE

WHEN home_score > away_score
THEN 'Home Team Won'

WHEN away_score > home_score
THEN 'Away Team Won'

ELSE 'Match Draw'

END AS result

FROM matches;


-- =========================================================
-- QUERY 16
-- UPDATE PLAYER AGE
-- =========================================================

UPDATE players
SET age = 23
WHERE player_id = 101;


-- =========================================================
-- QUERY 17
-- DELETE COACH RECORD
-- =========================================================

DELETE FROM coaches
WHERE coach_id = 201;


-- =========================================================
-- QUERY 18
-- DISPLAY PLAYERS WITH GOALS GREATER THAN 10
-- =========================================================

SELECT p.player_name,
       s.goals
FROM players p
JOIN stats s
ON p.player_id = s.player_id
WHERE s.goals > 10;


-- =========================================================
-- QUERY 19
-- DISPLAY TEAM AND COACH DETAILS
-- =========================================================

SELECT t.team_name,
       c.coach_name,
       c.experience_years
FROM teams t
JOIN coaches c
ON t.team_id = c.team_id;


-- =========================================================
-- QUERY 20
-- DISPLAY PLAYER DETAILS IN ASCENDING ORDER OF AGE
-- =========================================================

SELECT *
FROM players
ORDER BY age ASC;


-- =========================================================
-- END OF PROJECT
-- =========================================================