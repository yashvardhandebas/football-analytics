-- ============================================================
-- FILE: 03_analysis.sql
-- PURPOSE: Core analytical queries — answering the project's
--          key business questions with SQL
-- ============================================================

USE football_analytics;


-- ════════════════════════════════════════════════════════════
-- SECTION A: POSSESSION & TACTICS
-- ════════════════════════════════════════════════════════════

-- ── A1. Does possession win matches? ─────────────────────────
-- Hypothesis: teams with >55% possession win more often
SELECT
    CASE
        WHEN ms.home_possession > 55        THEN 'High (>55%)'
        WHEN ms.home_possession BETWEEN
             45 AND 55                      THEN 'Balanced (45-55%)'
        ELSE                                     'Low (<45%)'
    END                                                             AS possession_category,
    COUNT(*)                                                        AS matches,
    SUM(CASE WHEN m.match_outcome = 'Home Win' THEN 1 ELSE 0 END)  AS wins,
    ROUND(AVG(CASE WHEN m.match_outcome = 'Home Win'
              THEN 100.0 ELSE 0 END), 1)                           AS win_rate_pct
FROM match_stats ms
JOIN football_matches m ON ms.match_id = m.match_id
GROUP BY possession_category
ORDER BY win_rate_pct DESC;


-- ── A2. Best formations by win rate ──────────────────────────
SELECT
    ms.home_formation                                               AS formation,
    COUNT(*)                                                        AS matches_used,
    SUM(CASE WHEN m.match_outcome = 'Home Win' THEN 1 ELSE 0 END)  AS wins,
    ROUND(AVG(CASE WHEN m.match_outcome = 'Home Win'
              THEN 100.0 ELSE 0 END), 1)                           AS win_rate_pct,
    ROUND(AVG(ms.home_xg), 2)                                      AS avg_xg_created
FROM match_stats ms
JOIN football_matches m ON ms.match_id = m.match_id
GROUP BY ms.home_formation
ORDER BY win_rate_pct DESC;


-- ── A3. Pass accuracy vs match outcome ───────────────────────
-- Do accurate passing teams win more?
SELECT
    CASE
        WHEN ms.home_pass_accuracy >= 88    THEN 'Elite (>=88%)'
        WHEN ms.home_pass_accuracy >= 82    THEN 'Good (82-88%)'
        ELSE                                     'Average (<82%)'
    END                                                             AS pass_accuracy_tier,
    COUNT(*)                                                        AS matches,
    ROUND(AVG(CASE WHEN m.match_outcome = 'Home Win'
              THEN 100.0 ELSE 0 END), 1)                           AS win_rate_pct,
    ROUND(AVG(ms.home_xg), 2)                                      AS avg_xg
FROM match_stats ms
JOIN football_matches m ON ms.match_id = m.match_id
GROUP BY pass_accuracy_tier
ORDER BY win_rate_pct DESC;


-- ════════════════════════════════════════════════════════════
-- SECTION B: xG ANALYSIS
-- ════════════════════════════════════════════════════════════

-- ── B1. xG vs actual goals — team overperformance ────────────
-- Positive diff = clinical finishers. Negative = wasting chances
SELECT
    m.home_team                                     AS team,
    m.competition_name,
    SUM(m.fulltime_home)                            AS actual_goals,
    ROUND(SUM(ms.home_xg), 2)                      AS expected_goals,
    ROUND(SUM(m.fulltime_home) - SUM(ms.home_xg), 2) AS xg_overperformance
FROM football_matches m
JOIN match_stats ms ON m.match_id = ms.match_id
GROUP BY m.home_team, m.competition_name
ORDER BY xg_overperformance DESC;


-- ── B2. Does winning the xG battle predict the result? ───────
SELECT
    CASE
        WHEN ms.home_xg > ms.away_xg   THEN 'Home team had higher xG'
        WHEN ms.home_xg < ms.away_xg   THEN 'Away team had higher xG'
        ELSE                                 'xG tied'
    END                                                             AS xg_advantage,
    COUNT(*)                                                        AS matches,
    SUM(CASE WHEN m.match_outcome = 'Home Win' THEN 1 ELSE 0 END)  AS home_wins,
    SUM(CASE WHEN m.match_outcome = 'Away Win' THEN 1 ELSE 0 END)  AS away_wins,
    SUM(CASE WHEN m.match_outcome = 'Draw'     THEN 1 ELSE 0 END)  AS draws
FROM match_stats ms
JOIN football_matches m ON ms.match_id = m.match_id
GROUP BY xg_advantage;


-- ════════════════════════════════════════════════════════════
-- SECTION C: HOME ADVANTAGE
-- ════════════════════════════════════════════════════════════

-- ── C1. Home vs away performance overall ─────────────────────
SELECT
    'Home' AS side,
    ROUND(AVG(fulltime_home), 2)    AS avg_goals_scored,
    ROUND(AVG(home_points), 2)      AS avg_points,
    SUM(CASE WHEN match_outcome = 'Home Win' THEN 1 ELSE 0 END)    AS wins,
    COUNT(*)                        AS total_matches,
    ROUND(SUM(CASE WHEN match_outcome = 'Home Win' THEN 1 ELSE 0 END)
          * 100.0 / COUNT(*), 1)   AS win_rate_pct
FROM football_matches
UNION ALL
SELECT
    'Away' AS side,
    ROUND(AVG(fulltime_away), 2),
    ROUND(AVG(away_points), 2),
    SUM(CASE WHEN match_outcome = 'Away Win' THEN 1 ELSE 0 END),
    COUNT(*),
    ROUND(SUM(CASE WHEN match_outcome = 'Away Win' THEN 1 ELSE 0 END)
          * 100.0 / COUNT(*), 1)
FROM football_matches;


-- ── C2. Home advantage by competition ────────────────────────
SELECT
    competition_name,
    ROUND(AVG(fulltime_home) - AVG(fulltime_away), 2)              AS home_goal_advantage,
    ROUND(SUM(CASE WHEN match_outcome = 'Home Win' THEN 1 ELSE 0 END)
          * 100.0 / COUNT(*), 1)                                   AS home_win_pct,
    ROUND(SUM(CASE WHEN match_outcome = 'Away Win' THEN 1 ELSE 0 END)
          * 100.0 / COUNT(*), 1)                                   AS away_win_pct
FROM football_matches
GROUP BY competition_name
ORDER BY home_win_pct DESC;


-- ════════════════════════════════════════════════════════════
-- SECTION D: PLAYER PERFORMANCE
-- ════════════════════════════════════════════════════════════

-- ── D1. Top 20 goal scorers ───────────────────────────────────
SELECT
    player_name,
    team,
    COUNT(DISTINCT match_id)        AS matches_played,
    SUM(goals)                      AS total_goals,
    SUM(assists)                    AS total_assists,
    SUM(goals) + SUM(assists)       AS goal_contributions,
    ROUND(SUM(goals) * 1.0
          / COUNT(DISTINCT match_id), 2)   AS goals_per_game,
    ROUND(AVG(rating), 2)           AS avg_rating
FROM player_stats
GROUP BY player_name, team
ORDER BY total_goals DESC
LIMIT 20;


-- ── D2. Most consistent performers by avg rating ─────────────
-- Min 5 appearances to filter out one-game wonders
SELECT
    player_name,
    team,
    COUNT(DISTINCT match_id)        AS appearances,
    ROUND(AVG(rating), 2)           AS avg_rating,
    SUM(goals)                      AS goals,
    SUM(assists)                    AS assists,
    ROUND(AVG(pass_accuracy), 1)    AS avg_pass_accuracy
FROM player_stats
GROUP BY player_name, team
HAVING appearances >= 5
ORDER BY avg_rating DESC
LIMIT 20;


-- ── D3. Best passers on the pitch ─────────────────────────────
SELECT
    player_name,
    team,
    ROUND(AVG(pass_accuracy), 1)    AS avg_pass_accuracy,
    ROUND(AVG(passes), 0)           AS avg_passes_per_game,
    COUNT(DISTINCT match_id)        AS appearances
FROM player_stats
GROUP BY player_name, team
HAVING appearances >= 5
ORDER BY avg_pass_accuracy DESC
LIMIT 15;


-- ════════════════════════════════════════════════════════════
-- SECTION E: DISCIPLINE & REFEREES
-- ════════════════════════════════════════════════════════════

-- ── E1. Does discipline affect results? ──────────────────────
-- Compare avg cards for winning vs losing teams
SELECT
    m.match_outcome,
    ROUND(AVG(ms.home_yellow_cards), 2)                AS avg_yellow_cards,
    ROUND(AVG(ms.home_red_cards), 2)                   AS avg_red_cards,
    ROUND(AVG(ms.home_fouls), 2)                       AS avg_fouls,
    ROUND(AVG(ms.home_xg), 2)                          AS avg_xg,
    COUNT(*)                                            AS matches
FROM football_matches m
JOIN match_stats ms ON m.match_id = ms.match_id
WHERE m.match_outcome IS NOT NULL
GROUP BY m.match_outcome
ORDER BY avg_yellow_cards;


-- ── E2. Strictest referees (min 5 matches) ───────────────────
SELECT
    m.referee,
    COUNT(*)                                                        AS matches,
    ROUND(AVG(ms.home_yellow_cards + ms.away_yellow_cards), 2)     AS avg_yellows_per_game,
    SUM(ms.home_red_cards + ms.away_red_cards)                     AS total_reds,
    ROUND(AVG(ms.home_fouls + ms.away_fouls), 1)                   AS avg_fouls_per_game
FROM football_matches m
JOIN match_stats ms ON m.match_id = ms.match_id
WHERE m.referee IS NOT NULL AND m.referee != ''
GROUP BY m.referee
HAVING matches >= 5
ORDER BY avg_yellows_per_game DESC
LIMIT 15;


-- ── E3. Which competition has the most cards? ────────────────
SELECT
    m.competition_name,
    COUNT(*)                                                        AS matches,
    ROUND(AVG(ms.home_yellow_cards + ms.away_yellow_cards), 2)     AS avg_yellows_per_game,
    ROUND(AVG(ms.home_fouls + ms.away_fouls), 1)                   AS avg_fouls_per_game
FROM football_matches m
JOIN match_stats ms ON m.match_id = ms.match_id
GROUP BY m.competition_name
ORDER BY avg_yellows_per_game DESC;
