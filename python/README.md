# Python Data Loader

Load the raw source files into Postgres.  Simple, readable Python is preferred.  Pandas is already included.

## Your Task

Implement `load_to_postgres.py` to:

1. **Load CSV files** into their corresponding `raw.*` tables
2. **Load JSON event pages** into `raw.events`, flattening the nested structure

## Source Files

| File | Target Table |
|------|--------------|
| `data/raw/customers_snapshot.csv` | `raw.customers_snapshot` |
| `data/raw/subscriptions.csv` | `raw.subscriptions` |
| `data/raw/invoices.csv` | `raw.invoices` |
| `data/raw/invoice_line_items.csv` | `raw.invoice_line_items` |
| `data/raw/events_pages/*.json` | `raw.events` |

## Running

```bash
python python/load_to_postgres.py
```

## Schema Reference

See `sql/00_schema.sql` for column definitions.

---

## Can't Get Python Working?

If you're stuck on Python and want to focus on SQL, you can load pre-parsed data:

```bash
make load-checkpoint
```

This loads sample data into the raw tables so you can proceed with the SQL portion.
