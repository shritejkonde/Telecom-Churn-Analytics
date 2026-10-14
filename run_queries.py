"""Runs every query in sql/analysis.sql and prints the results,
so you can copy real numbers into the README and dashboard."""
import sqlite3
import pandas as pd

with open("sql/analysis.sql") as f:
    queries = [q.strip() for q in f.read().split(";") if q.strip()]

with sqlite3.connect("churn.db") as conn:
    for i, q in enumerate(queries, 1):
        print(f"\n--- Query {i} ---")
        print(pd.read_sql_query(q, conn).to_string(index=False))
