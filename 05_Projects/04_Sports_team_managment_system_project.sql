CREATE TABLE TEAMS (
    team_id INT PRIMARY KEY,
    team_name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE PLAYERS (
    player_id INT PRIMARY KEY,
    player_name VARCHAR(50),
    age INT,
    position VARCHAR(30),
    team_id INT,
    FOREIGN KEY (team_id) REFERENCES TEAMS(team_id)
);

CREATE TABLE MATCHES (
    match_id INT PRIMARY KEY,
    match_date DATE,
    home_team_id INT,
    away_team_id INT,
    home_score INT,
    away_score INT,
    FOREIGN KEY (home_team_id) REFERENCES TEAMS(team_id),
    FOREIGN KEY (away_team_id) REFERENCES TEAMS(team_id)
);

CREATE TABLE STATS (
    stat_id INT PRIMARY KEY,
    player_id INT,
    match_id INT,
    goals INT,
    assists INT,
    yellow_cards INT,
    red_cards INT,
    FOREIGN KEY (player_id) REFERENCES PLAYERS(player_id),
    FOREIGN KEY (match_id) REFERENCES MATCHES(match_id)
);

CREATE TABLE COACHES (
    coach_id INT PRIMARY KEY,
    coach_name VARCHAR(50),
    team_id INT,
    experience_years INT,
    FOREIGN KEY (team_id) REFERENCES TEAMS(team_id)
);

-- //Insert Sample Tuples
-- //TEAMS

INSERT INTO TEAMS VALUES (1, 'Tigers', 'Bangalore');
INSERT INTO TEAMS VALUES (2, 'Warriors', 'Mysore');
INSERT INTO TEAMS VALUES (3, 'Falcons', 'Hubli');
INSERT INTO TEAMS VALUES (4, 'Lions', 'Belgaum');
INSERT INTO TEAMS VALUES (5, 'Sharks', 'Mangalore');

-- //PLAYERS 
INSERT INTO PLAYERS VALUES (101, 'Rahul', 24, 'Forward', 1);
INSERT INTO PLAYERS VALUES (102, 'Aman', 22, 'Midfielder', 1);
INSERT INTO PLAYERS VALUES (103, 'Kiran', 26, 'Defender', 2);
INSERT INTO PLAYERS VALUES (104, 'Rohit', 25, 'Forward', 2);
INSERT INTO PLAYERS VALUES (105, 'Vijay', 23, 'Goalkeeper', 3);

-- //MATCHES
INSERT INTO MATCHES VALUES (201, '2026-05-01', 1, 2, 3, 2);
INSERT INTO MATCHES VALUES (202, '2026-05-03', 2, 3, 1, 1);
INSERT INTO MATCHES VALUES (203, '2026-05-05', 4, 1, 0, 2);
INSERT INTO MATCHES VALUES (204, '2026-05-07', 5, 2, 1, 4);
INSERT INTO MATCHES VALUES (205, '2026-05-09', 3, 4, 2, 2);

-- //STATS
INSERT INTO STATS VALUES (1, 101, 201, 2, 1, 0, 0);
INSERT INTO STATS VALUES (2, 102, 201, 1, 2, 1, 0);
INSERT INTO STATS VALUES (3, 104, 202, 1, 0, 0, 0);
INSERT INTO STATS VALUES (4, 104, 204, 3, 1, 1, 0);
INSERT INTO STATS VALUES (5, 101, 203, 2, 0, 0, 0);

-- //COACHES
INSERT INTO COACHES VALUES (301, 'Suresh', 1, 10);
INSERT INTO COACHES VALUES (302, 'Mahesh', 2, 8);
INSERT INTO COACHES VALUES (303, 'Ramesh', 3, 12);
INSERT INTO COACHES VALUES (304, 'Anil', 4, 7);
INSERT INTO COACHES VALUES (305, 'Prakash', 5, 9);

-- //List All Players in a Specific Team (team_id = 1)

SELECT * FROM PLAYERS WHERE team_id = 1;

-- //Get the Result of All Matches Where Team 2 Played

SELECT *
FROM MATCHES
WHERE home_team_id = 2
   OR away_team_id = 2;

-- //Find Top 5 Players with the Most Goals

SELECT P.player_name,
       SUM(S.goals) AS total_goals
FROM PLAYERS P
JOIN STATS S
ON P.player_id = S.player_id
GROUP BY P.player_name
ORDER BY total_goals DESC
LIMIT 5;