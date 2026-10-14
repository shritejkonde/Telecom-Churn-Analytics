# Telecom Customer Churn Analytics

An end-to-end analytics project: ETL pipeline, SQL analysis and a BI dashboard
to find why telecom customers leave and how much revenue is at risk.

## Problem Statement
Customer churn directly hits recurring revenue. This project identifies which
customer segments churn the most (by contract, tenure, payment method and
internet service) so a business can target retention efforts.

## Dataset
[Telco Customer Churn (Kaggle)](https://www.kaggle.com/datasets/blastchar/telco-customer-churn) - about 7,000 customers, 21 columns.

## Tech Stack
Python, pandas, SQLite, SQL (aggregations, CTEs, joins, window functions), Tableau Public / Power BI

## Pipeline
1. **Extract** - read the raw CSV (`data/raw/telco_churn.csv`)
2. **Transform** - fix blank `TotalCharges`, encode `Churn` as 1/0, create tenure groups, drop duplicates
3. **Load** - write into a SQLite database (`churn.db`, table `customers`)
4. **Analyze** - SQL queries in `sql/analysis.sql`
5. **Visualize** - dashboard in `dashboard/` and `screenshots/`

## Project Structure
```
telecom-churn-analytics/
├── data/raw/telco_churn.csv
├── etl.py
├── run_queries.py
├── sql/analysis.sql
├── dashboard/
├── screenshots/dashboard.png
├── requirements.txt
└── README.md
```

## How to Run
```bash
pip install -r requirements.txt
python etl.py          # builds churn.db
python run_queries.py  # prints the results of every SQL query
```

## Key Insights
> Replace these with the real numbers from `python run_queries.py`.

1. Overall churn rate is **__%**.
2. **______** contracts have the highest churn (**__%**), versus **__%** for ______ contracts.
3. Customers in the **______** tenure group account for the most monthly revenue lost (**$____**).

## Dashboard
![Dashboard](screenshots/dashboard.png)

## Author
Shritej Konde
