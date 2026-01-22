"""
Senior Data Engineer Assessment - Python Data Loader

Your task: Load the raw source files into Postgres tables.

Run with: python python/load_to_postgres.py
"""

import io
import json
from pathlib import Path

import pandas as pd
import psycopg2


RAW_DIR = Path("data/raw")
EVENTS_DIR = RAW_DIR / "events_pages"
DATABASE_URL = "postgresql://postgres:postgres@localhost:5432/postgres"


def get_conn():
    """Get database connection."""
    return psycopg2.connect(DATABASE_URL)


def copy_df(conn, df: pd.DataFrame, table_name: str, columns: list) -> None:
    """
    Bulk load a DataFrame into Postgres using COPY.
    
    Args:
        conn: psycopg2 connection
        df: DataFrame to load
        table_name: Target table (e.g., "raw.events")
        columns: Column names
    """
    buf = io.StringIO()
    df[columns].to_csv(buf, index=False)
    buf.seek(0)
    
    sql = f"COPY {table_name} ({', '.join(columns)}) FROM STDIN WITH (FORMAT CSV, HEADER TRUE)"
    with conn.cursor() as cur:
        cur.copy_expert(sql, buf)
    conn.commit()


def truncate_raw_tables(conn) -> None:
    """Clear all raw tables before loading."""
    with conn.cursor() as cur:
        cur.execute("TRUNCATE raw.events, raw.invoice_line_items, raw.invoices, raw.subscriptions, raw.customers_snapshot;")
    conn.commit()


# =============================================================================
# TODO: Implement the functions below
# =============================================================================

def load_csv(path: Path) -> pd.DataFrame:
    """
    Load a CSV file into a DataFrame.
    
    No complex cleaning needed - just read the file.
    SQL will handle any data type conversions.
    """
    # TODO: Implement
    pass


def load_events(events_dir: Path) -> pd.DataFrame:
    """
    Load all JSON event pages into a single DataFrame.
    
    Requirements:
    1. Read all page_*.json files from events_dir
    2. Flatten nested structure into columns matching raw.events schema
    """
    # TODO: Implement
    pass


def main():
    conn = get_conn()
    try:
        truncate_raw_tables(conn)
        
        # TODO: Load each source file and copy to its raw table
        # 
        # Source files -> Target tables:
        #   data/raw/customers_snapshot.csv -> raw.customers_snapshot
        #   data/raw/subscriptions.csv -> raw.subscriptions  
        #   data/raw/invoices.csv -> raw.invoices
        #   data/raw/invoice_line_items.csv -> raw.invoice_line_items
        #   data/raw/events_pages/*.json -> raw.events
        
        print("Loading complete.")
        
    finally:
        conn.close()


if __name__ == "__main__":
    main()
