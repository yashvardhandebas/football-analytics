# 📋 Key Findings — European Football 2024/25

> A plain-English summary of the most important discoveries from analysing  
> **1,941 matches** across 6 competitions: Premier League, La Liga, Serie A,  
> Bundesliga, Ligue 1, and UEFA Champions League.

---

## 🔑 Finding 1 — Home Advantage Is Worth ~10 Points a Season

**What the data says:**
- Home teams win **42.9%** of matches vs **33.3%** for away sides
- Home teams average **1.54 goals** per game vs **1.34** for away teams
- Home teams earn **1.52 points** per game vs **1.24** for away teams

**Why it matters:**  
That 0.28 point gap per game compounds over a 38-game season to roughly **10 extra points** just from playing at home. In the Premier League, 10 points is the difference between Champions League football and a mid-table finish. Home advantage isn't a myth — it's measurable, consistent, and significant.

---

## 🔑 Finding 2 — The First 45 Minutes Decide 3 Out of 4 Matches

**What the data says:**
| Halftime Status | Matches | Final Home Win Rate |
|---|---|---|
| Winning at HT | 665 | 75.3% |
| Drawing at HT | 748 | 35.7% |
| Losing at HT | 528 | 12.1% |

**Why it matters:**  
Only **1 in 8 teams** losing at halftime manage to come back and win. This has a direct tactical implication — a slow start is extremely costly. Coaches and analysts should focus heavily on first-half performance rather than banking on second-half recoveries.

---

## 🔑 Finding 3 — Champions League Has the Strongest Home Advantage

**What the data says:**
| Competition | Home Win % | Away Win % |
|---|---|---|
| UEFA Champions League | 50.8% | 35.4% |
| Ligue 1 | 46.7% | 33.0% |
| La Liga | 44.5% | 30.0% |
| Premier League | 40.8% | 34.7% |
| Serie A | 39.7% | 31.8% |
| Bundesliga | 38.6% | 36.3% |

**Why it matters:**  
The Champions League shows the most extreme home advantage — likely driven by iconic stadiums, elite atmospheres, and the extra pressure on visiting sides. The Bundesliga is the most balanced competition with away teams winning nearly as often as home sides (38.6% vs 36.3%).

---

## 🔑 Finding 4 — 1-1 Is the Most Common Scoreline in European Football

**What the data says:**
- **1-1** occurred 224 times — the most common result
- The top 4 scorelines (1-1, 1-0, 2-1, 1-2) account for **37%** of all matches
- Low-scoring games (0-0, 1-0, 0-1, 1-1) make up over **40%** of all matches

**Why it matters:**  
A single goal decides or changes the vast majority of football matches. This reinforces why xG efficiency and defensive solidity matter more than volume of chances — converting the one or two best chances you get is what wins games.

---

## 🔑 Finding 5 — Dortmund and Bayern Are Europe's Most Clinical Finishers

**What the data says:**
| Team | Competition | Actual Goals | Expected Goals | Overperformance |
|---|---|---|---|---|
| Borussia Dortmund | Bundesliga | 44 | 37.64 | **+6.36** |
| FC Bayern München | Bundesliga | 53 | 47.05 | **+5.95** |
| OGC Nice | Ligue 1 | 38 | 33.04 | +4.96 |
| FC Barcelona | UCL | 24 | 20.07 | +3.93 |
| Manchester City FC | Premier League | 43 | 39.80 | +3.20 |

**Why it matters:**  
Both German giants scored 6 and 5 more goals respectively than their chances warranted — the highest overperformance in Europe. This suggests elite finishing quality that goes beyond just creating chances. Notably, both Bundesliga clubs top this list, pointing to a pattern of finishing efficiency in German football.

---

## 🔑 Finding 6 — Leicester and Ipswich Were the Most Wasteful Sides

**What the data says:**
| Team | Competition | Actual Goals | Expected Goals | Underperformance |
|---|---|---|---|---|
| Leicester City FC | Premier League | 15 | 20.35 | **−5.35** |
| Ipswich Town FC | Premier League | 14 | 18.63 | **−4.63** |
| Wolverhampton Wanderers FC | Premier League | 27 | 31.45 | −4.45 |
| Southampton FC | Premier League | 13 | 17.28 | −4.28 |

**Why it matters:**  
The bottom four in xG underperformance are all Premier League sides who struggled in 2024/25. Leicester and Ipswich's inability to convert their chances directly contributed to their relegation battles — they weren't just creating fewer chances, they were wasting the ones they had. This is a clear finishing problem, not a chance creation problem.

---

## 🔑 Finding 7 — Formation Alone Doesn't Decide Matches

**What the data says:**
| Formation | Matches | Win Rate | Avg xG Created |
|---|---|---|---|
| 4-4-2 | 467 | 43.7% | 1.64 |
| 4-3-3 | 514 | 43.2% | 1.59 |
| 4-2-3-1 | 524 | 43.1% | 1.73 |
| 3-5-2 | 436 | 41.3% | 1.60 |

**Why it matters:**  
All 4 formations have win rates within **2.4% of each other** — a statistically negligible gap. The 4-2-3-1 creates the most xG per game (1.73) but doesn't convert that into the highest win rate. This suggests that **player quality and execution** matter far more than the shape a team plays. Tactical flexibility is more valuable than rigidly sticking to one formation.

---

## 📌 Summary Table

| # | Finding | Key Number |
|---|---|---|
| 1 | Home advantage worth ~10 points/season | 42.9% vs 33.3% win rate |
| 2 | First half decides 3 in 4 matches | 75.3% HT leaders win |
| 3 | UCL has strongest home advantage | 50.8% home win rate |
| 4 | 1-1 is the most common scoreline | 224 occurrences |
| 5 | Dortmund most clinical finishers in Europe | +6.36 xG overperformance |
| 6 | Leicester & Ipswich most wasteful sides | −5.35 and −4.63 xG |
| 7 | Formation has minimal impact on win rate | All within 2.4% of each other |

---

## 🛠️ Tools Used
- **MySQL** — data storage and SQL analysis
- **Python / pandas** — data manipulation
- **Google Colab** — analysis notebook and visualisations
- **seaborn / matplotlib** — charts

## 📁 Data Note
Match results are from the official 2024/25 season across all 6 competitions. Extended stats (xG, possession, player data) are synthetically generated using realistic statistical distributions for portfolio demonstration purposes.
