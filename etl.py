"""ETL pipeline: Extract the raw Telco churn CSV, Transform it with pandas,
Load it into a SQLite database (a small data warehouse)."""
import sqlite3
import pandas as pd

RAW_PATH = "data/raw/telco_churn.csv"
DB_PATH = "churn.db"


def extract(path):
    return pd.read_csv(path)


def transform(df):
    df = df.copy()
    # TotalCharges has blank strings for brand-new customers -> numeric
    df["TotalCharges"] = pd.to_numeric(df["TotalCharges"], errors="coerce").fillna(0)
    # Churn: Yes/No -> 1/0 so it can be summed in SQL
    df["Churn"] = df["Churn"].map({"Yes": 1, "No": 0})
    # Tenure buckets (months)
    df["tenure_group"] = pd.cut(
        df["tenure"], bins=[-1, 12, 24, 48, 72],
        labels=["0-1yr", "1-2yr", "2-4yr", "4-6yr"],
    ).astype(str)
    df = df.drop_duplicates(subset="customerID")
    return df


def load(df, db_path):
    with sqlite3.connect(db_path) as conn:
        df.to_sql("customers", conn, if_exists="replace", index=False)


if __name__ == "__main__":
    raw = extract(RAW_PATH)
    clean = transform(raw)
    load(clean, DB_PATH)
    print(f"Loaded {len(clean)} rows into {DB_PATH} (table: customers)")
