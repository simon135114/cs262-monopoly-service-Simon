-- CS262 Lab 8
-- Monopoly Database — Exercises 8.1 & 8.2
-- Author: Simon Lin
-- Date: 2025-11-01


-- LAB 7: Database Schema and Sample Data


-- Drop tables in correct order
DROP TABLE IF EXISTS GameState;
DROP TABLE IF EXISTS PlayerGame;
DROP TABLE IF EXISTS Game CASCADE;
DROP TABLE IF EXISTS Player CASCADE;

-- Create tables
CREATE TABLE Game (
    ID integer PRIMARY KEY,
    time timestamp
);

CREATE TABLE Player (
    ID integer PRIMARY KEY,
    emailAddress varchar(50) NOT NULL,
    name varchar(50)
);

CREATE TABLE PlayerGame (
    gameID integer REFERENCES Game(ID),
    playerID integer REFERENCES Player(ID),
    score numeric,
    PRIMARY KEY (gameID, playerID)
);

CREATE TABLE GameState (
    gameID integer REFERENCES Game(ID),
    playerID integer REFERENCES Player(ID),
    cash numeric NOT NULL DEFAULT 1500,
    properties text[],
    houses integer NOT NULL DEFAULT 0,
    hotels integer NOT NULL DEFAULT 0,
    position integer NOT NULL DEFAULT 0,
    PRIMARY KEY (gameID, playerID)
);

-- Insert sample data
INSERT INTO Game(ID, time) VALUES
(1, '2006-06-27 08:00:00'),
(2, '2006-06-28 13:20:00'),
(3, '2006-06-29 18:41:00')
ON CONFLICT DO NOTHING;

INSERT INTO Player(ID, emailAddress, name) VALUES
(1, 'me@calvin.edu', 'Me'),
(2, 'king@gmail.edu', 'The King'),
(3, 'dog@gmail.edu', 'Dogbreath')
ON CONFLICT DO NOTHING;

INSERT INTO PlayerGame(gameID, playerID, score) VALUES
(1, 1, 0.00),
(1, 2, 0.00),
(1, 3, 2350.00),
(2, 1, 1000.00),
(2, 2, 0.00),
(2, 3, 500.00),
(3, 2, 0.00),
(3, 3, 5500.00)
ON CONFLICT DO NOTHING;

INSERT INTO GameState(gameID, playerID, cash, properties, houses, hotels, position) VALUES
(1, 1, 1500, ARRAY['Mediterranean Avenue'], 0, 0, 0),
(1, 2, 1200, ARRAY['Baltic Avenue','Oriental Avenue'], 1, 0, 5),
(1, 3, 2350, ARRAY[]::text[], 0, 0, 10)
ON CONFLICT DO NOTHING;


-- Exercise 8.1: Single-Table Queries


-- 1. Retrieve a list of all the games, ordered by date with the most recent game first.
SELECT *
FROM Game
ORDER BY time DESC;

-- 2. Retrieve all the games that occurred in the past week.
SELECT *
FROM Game
WHERE time >= NOW() - INTERVAL '7 days'
ORDER BY time DESC;

-- 3. Retrieve a list of players who have (non-NULL) names.
SELECT *
FROM Player
WHERE name IS NOT NULL;

-- 4. Retrieve a list of IDs for players who have some game score larger than 2000.
SELECT DISTINCT playerID
FROM PlayerGame
WHERE score > 2000;

-- 5. Retrieve a list of players who have Gmail accounts.
SELECT *
FROM Player
WHERE emailAddress ILIKE '%@gmail.com%';


-- Exercise 8.2: Multiple-Table Queries

-- 1. Retrieve all “The King”’s game scores in decreasing order.
SELECT PG.score
FROM PlayerGame PG
JOIN Player P ON PG.playerID = P.ID
WHERE P.name = 'The King'
ORDER BY PG.score DESC;

-- 2. Retrieve the name of the winner of the game played on 2006-06-28 13:20:00.
-- Winner = player with max score in that game
SELECT P.name
FROM PlayerGame PG
JOIN Player P ON PG.playerID = P.ID
JOIN Game G ON PG.gameID = G.ID
WHERE G.time = '2006-06-28 13:20:00'
ORDER BY PG.score DESC
LIMIT 1;


-- Optional comments for instructor


-- The clause P1.ID < P2.ID is often used in self-joins to prevent duplicate pairings.
-- Realistic use case: pairing employees for mentorship, pairing friends in a social app, etc.
