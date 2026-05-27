-- ============================================================
-- FILE: 02_eda.sql
-- PURPOSE: Exploratory Data Analysis — understand the shape,
--          distribution and quality of the dataset before
--          drawing any conclusions
-- ============================================================

USE football_analytics;

-- ── 1. How many matches per competition? ─────────────────────
-- First thing any analyst checks: what does our data cover?
SELECT
    competition_name,
    COUNT(*)                                    AS total_matches,
    COUNT(DISTINCT home_team)                   AS teams,
    MIN(DATE(date_utc))                         AS season_start,
    MAX(DATE(date_utc))                         AS season_end
FROM football_matches
GROUP BY competition_name
ORDER BY total_matches DESC;


-- ── 2. Match outcome distribution overall ────────────────────
-- How often does home/away/draw happen across all competitions?
SELECT
    match_outcome,
    COUNT(*)                                            AS total,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 1)  AS percentage
FROM football_matches
WHERE match_outcome IS NOT NULL
GROUP BY match_outcome
ORDER BY total DESC;


-- ── 3. Outcome split per competition ─────────────────────────
-- Does home advantage vary by league?
SELECT
    competition_name,
    SUM(CASE WHEN match_outcome = 'Home Win' THEN 1 ELSE 0 END)  AS home_wins,
    SUM(CASE WHEN match_outcome = 'Draw'     THEN 1 ELSE 0 END)  AS draws,
    SUM(CASE WHEN match_outcome = 'Away Win' THEN 1 ELSE 0 END)  AS away_wins,
    COUNT(*)                                                       AS total_matches,
    ROUND(SUM(CASE WHEN match_outcome = 'Home Win' THEN 1 ELSE 0 END)
          * 100.0 / COUNT(*), 1)                                  AS home_win_pct
FROM football_matches
GROUP BY competition_name
ORDER BY home_win_pct DESC;


-- ── 4. Goals distribution ────────────────────────────────────
-- What is the average, min and max goals per match?
SELECT
    competition_name,
    ROUND(AVG(total_goals), 2)   AS avg_goals_per_match,
    MAX(total_goals)             AS highest_scoring_match,
    MIN(total_goals)             AS lowest_scoring_match,
    SUM(total_goals)             AS total_goals_in_season
FROM football_matches
GROUP BY competition_name
ORDER BY avg_goals_per_match DESC;


-- ── 5. Most common scorelines ────────────────────────────────
SELECT
    CONCAT(fulltime_home, '-', fulltime_away)   AS scoreline,
    COUNT(*)                                    AS occurrences
FROM football_matches
GROUP BY scoreline
ORDER BY occurrences DESC
LIMIT 10;


-- ── 6. Halftime vs fulltime — who comes back? ────────────────
-- How many teams losing at halftime come back to win?
SELECT
    CASE
        WHEN halftime_home < halftime_away  THEN 'Losing at HT'
        WHEN halftime_home = halftime_away  THEN 'Drawing at HT'
        ELSE                                     'Winning at HT'
    END                                                             AS halftime_status,
    COUNT(*)                                                        AS matches,
    SUM(CASE WHEN match_outcome = 'Home Win' THEN 1 ELSE 0 END)    AS ended_home_win,
    ROUND(AVG(CASE WHEN match_outcome = 'Home Win'
              THEN 1.0 ELSE 0 END) * 100, 1)                       AS home_win_rate
FROM football_matches
GROUP BY halftime_status
ORDER BY home_win_rate DESC;


-- ── 7. Possession summary stats ──────────────────────────────
SELECT
    ROUND(AVG(home_possession), 1)          AS avg_home_possession,
    ROUND(AVG(away_possession), 1)          AS avg_away_possession,
    ROUND(AVG(home_shots), 1)               AS avg_home_shots,
    ROUND(AVG(away_shots), 1)               AS avg_away_shots,
    ROUND(AVG(home_xg), 2)                  AS avg_home_xg,
    ROUND(AVG(away_xg), 2)                  AS avg_away_xg,
    ROUND(AVG(home_yellow_cards), 2)        AS avg_home_yellows,
    ROUND(AVG(away_yellow_cards), 2)        AS avg_away_yellows
FROM match_stats;


-- ── 8. Data quality check — any nulls in key columns? ────────
SELECT
    SUM(CASE WHEN match_outcome  IS NULL THEN 1 ELSE 0 END) AS null_outcome,
    SUM(CASE WHEN fulltime_home  IS NULL THEN 1 ELSE 0 END) AS null_ft_home,
    SUM(CASE WHEN fulltime_away  IS NULL THEN 1 ELSE 0 END) AS null_ft_away,
    SUM(CASE WHEN referee        IS NULL THEN 1 ELSE 0 END) AS null_referee,
    SUM(CASE WHEN date_utc       IS NULL THEN 1 ELSE 0 END) AS null_date
FROM football_matches;
