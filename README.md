## Beyond the Scoreline: A Data Analysis of European Football 2024/25

> **Why this project?**  
> Everyone knows the final score. But *why* do certain teams win despite fewer shots? Does possession actually matter? Which players consistently outperform their xG? This project goes beyond the scoreline to uncover the hidden patterns driving results in the 2024/25 Premier League season.

---

## Problem Statement

Football clubs, coaches, and analysts are drowning in raw match data with no clear story. This project answers:

- What **actually** wins football matches — shots, xG, or possession?
- Which teams **punch above their weight** vs their expected goals?
- Does **home advantage** still exist in modern football?
- Who are the **best individual performers** per 90 minutes?
- Which **formations** produce the best results?
- Are **fouls and cards** costing teams points?

---

## Project Structure

```
football-analytics/
│
├── README.md
├── data/
│   └── raw/
│       ├── football_matches.csv      # 1,941 match records
│       ├── match_stats.csv           # Possession, xG, shots, cards per match
│       ├── lineups.csv               # Starting XI for first 1,000 matches
│       └── player_stats.csv          # Per-player stats for first 1,000 matches
│
├── sql/
│   ├── 01_schema.sql                 # Table creation
│   ├── 02_eda.sql                    # Exploratory queries
│   └── 03_analysis.sql              # Core analytical queries
│
├── notebooks/
│   └── football_analysis.ipynb      # Full analysis in Google Colab
│
└── reports/
    └── key_findings.md              # Plain-English summary of insights
```

---

## Dataset Overview

| Table | Rows | Description |
|---|---|---|
| `football_matches` | 1,941 | Match results, scorelines, referee, competition |
| `match_stats` | 1,941 | Possession, shots, xG, pass accuracy, cards, formation |
| `lineups` | 22,000 | Starting XI per team for 1,000 matches |
| `player_stats` | 22,000 | Goals, assists, shots, passes, tackles, rating per player |

**Key columns:** `match_id` links all 4 tables together.

---

##Analysis Sections

| # | Question | Method |
|---|---|---|
| 1 | Data overview & quality check | pandas, describe() |
| 2 | Match outcome distribution | Countplot, pie chart |
| 3 | Does possession win matches? | Group by + bar chart |
| 4 | xG vs actual goals — who over/underperforms? | Scatter plot |
| 5 | Home vs away advantage | Stacked bar |
| 6 | Best formations by win rate | Group by + bar |
| 7 | Top scorers & assisters | Aggregation + horizontal bar |
| 8 | Discipline — cards, fouls vs points | Correlation heatmap |
| 9 | Referee analysis — who books the most? | Group by referee |
| 10 | Key findings & recommendations | Markdown summary |

---

## Tools & Stack

| Tool | Purpose |
|---|---|
| **MySQL** | Data storage & SQL analysis |
| **Python** | Data manipulation & visualisation |
| **pandas** | Dataframe operations |
| **seaborn / matplotlib** | Charts and plots |
| **pandasql** | Run SQL queries on CSVs in Colab |
| **Google Colab** | Notebook environment |
| **GitHub** | Version control & portfolio hosting |

---

##  How to Run

### Option 1 — Google Colab (Recommended)
Click the badge below to open the notebook directly in Colab — no setup needed:

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/yashvardhandebas/football-analytics/blob/main/notebooks/football_analysis.ipynb)

All data loads automatically from this GitHub repo via raw URLs.

### Option 2 — Local Setup
```bash
git clone https://github.com/yashvardhandebas/football-analytics.git
cd football-analytics
pip install pandas seaborn matplotlib pandasql
jupyter notebook notebooks/football_analysis.ipynb
```

### Option 3 — MySQL Import
```bash
mysql -u your_user -p your_database < sql/01_schema.sql
# Then load your CSVs or use the generated INSERT file
```

---

##  Key Findings

> Full findings in [`reports/key_findings.md`](reports/key_findings.md)

- 📈 Teams with **>55% possession win 54%** of matches vs 38% for low-possession sides — but counter-attacking football clearly works
- ⚽ **xG is a stronger predictor of long-term success** than actual goals scored in any single match
- 🏠 Home teams win **~46%** of matches vs 29% for away sides — home advantage is real but shrinking
- 🟨 Teams that average **>2 yellow cards per match lose 12% more** often than disciplined sides
- 🧱 The **4-3-3** formation has the highest win rate across the dataset

---

##  Author

**Yashvardhan Debas**  
Aspiring Data Analyst | Football & Data Enthusiast  
[GitHub](https://github.com/yashvardhandebas) 

---

## 📁 Data Note

Match results are from the 2024/25 Premier League season. Extended stats (xG, possession, player data) are synthetically generated using realistic statistical distributions for portfolio demonstration purposes.
