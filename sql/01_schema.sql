-- ============================================================
-- FILE: 01_schema.sql
-- PURPOSE: Create all tables for European Football 2024/25
-- COMPETITIONS: Premier League, La Liga, Serie A,
--               Bundesliga, Ligue 1, UEFA Champions League
-- ============================================================

CREATE DATABASE IF NOT EXISTS football_analytics;
USE football_analytics;

-- ── Core match results ───────────────────────────────────────
CREATE TABLE IF NOT EXISTS football_matches (
    competition_code    VARCHAR(20),
    competition_name    VARCHAR(100),
    season              VARCHAR(20),
    match_id            INT PRIMARY KEY,
    matchday            INT,
    stage               VARCHAR(50),
    status              VARCHAR(30),
    date_utc            VARCHAR(50),
    referee             VARCHAR(100),
    home_team_id        INT,
    home_team           VARCHAR(100),
    away_team_id        INT,
    away_team           VARCHAR(100),
    fulltime_home       INT,
    fulltime_away       INT,
    halftime_home       INT,
    halftime_away       INT,
    goal_difference     INT,
    total_goals         INT,
    match_outcome       VARCHAR(20),
    home_points         INT,
    away_points         INT,
    referee_id          INT
);

-- ── Per-match tactical & physical stats ─────────────────────
CREATE TABLE IF NOT EXISTS match_stats (
    id                      INT AUTO_INCREMENT PRIMARY KEY,
    match_id                INT,
    home_possession         DECIMAL(4,1),
    away_possession         DECIMAL(4,1),
    home_shots              INT,
    away_shots              INT,
    home_shots_on_target    INT,
    away_shots_on_target    INT,
    home_xg                 DECIMAL(5,2),
    away_xg                 DECIMAL(5,2),
    home_pass_accuracy      DECIMAL(4,1),
    away_pass_accuracy      DECIMAL(4,1),
    home_yellow_cards       INT,
    away_yellow_cards       INT,
    home_red_cards          INT,
    away_red_cards          INT,
    home_fouls              INT,
    away_fouls              INT,
    home_formation          VARCHAR(10),
    away_formation          VARCHAR(10),
    FOREIGN KEY (match_id) REFERENCES football_matches(match_id)
);

-- ── Starting lineups ─────────────────────────────────────────
CREATE TABLE IF NOT EXISTS lineups (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    match_id        INT,
    team_id         INT,
    team            VARCHAR(100),
    player_name     VARCHAR(100),
    position        VARCHAR(10),
    shirt_number    INT,
    FOREIGN KEY (match_id) REFERENCES football_matches(match_id)
);

-- ── Individual player performance per match ──────────────────
CREATE TABLE IF NOT EXISTS player_stats (
    id                  INT AUTO_INCREMENT PRIMARY KEY,
    match_id            INT,
    team_id             INT,
    team                VARCHAR(100),
    player_name         VARCHAR(100),
    minutes_played      INT,
    goals               INT,
    assists             INT,
    shots               INT,
    shots_on_target     INT,
    passes              INT,
    pass_accuracy       DECIMAL(4,1),
    tackles             INT,
    yellow_cards        INT,
    red_cards           INT,
    rating              DECIMAL(3,1),
    FOREIGN KEY (match_id) REFERENCES football_matches(match_id)
);
