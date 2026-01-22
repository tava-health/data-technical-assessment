BEGIN;

CREATE SCHEMA IF NOT EXISTS raw;
CREATE SCHEMA IF NOT EXISTS analytics;

-- ---------- RAW TABLES ----------
DROP TABLE IF EXISTS raw.customers_snapshot;
CREATE TABLE raw.customers_snapshot (
  customer_id      TEXT NOT NULL,
  snapshot_at      TIMESTAMPTZ,
  email            TEXT,
  country          TEXT,
  segment          TEXT,
  is_active        TEXT,
  employer_id      TEXT
);

DROP TABLE IF EXISTS raw.subscriptions;
CREATE TABLE raw.subscriptions (
  subscription_id  TEXT NOT NULL,
  customer_id      TEXT NOT NULL,
  plan_name        TEXT,
  started_at       DATE,
  ended_at         DATE,
  status           TEXT
);

DROP TABLE IF EXISTS raw.invoices;
CREATE TABLE raw.invoices (
  invoice_id       TEXT NOT NULL,
  customer_id      TEXT NOT NULL,
  issued_at        TIMESTAMPTZ,
  invoice_month    DATE,
  status           TEXT,
  paid_at          TIMESTAMPTZ,
  total_amount     NUMERIC(12,2)
);

DROP TABLE IF EXISTS raw.invoice_line_items;
CREATE TABLE raw.invoice_line_items (
  invoice_id       TEXT NOT NULL,
  line_item_id     TEXT NOT NULL,
  type             TEXT,
  amount           NUMERIC(12,2)
);

DROP TABLE IF EXISTS raw.events;
CREATE TABLE raw.events (
  event_id         TEXT NOT NULL,
  event_type       TEXT NOT NULL,
  occurred_at      TIMESTAMPTZ,
  idempotency_key  TEXT,
  customer_id      TEXT,
  employer_id      TEXT,
  invoice_id       TEXT,
  session_id       TEXT,
  provider_id      TEXT,
  amount           NUMERIC(12,2),
  currency         TEXT,
  status           TEXT,
  payload_json     JSONB
);

-- ---------- ANALYTICS HELPERS ----------
DROP TABLE IF EXISTS analytics.dim_month;
CREATE TABLE analytics.dim_month (
  month_date DATE PRIMARY KEY
);

-- Seed months from 2024-12-01 through 2026-12-01 inclusive
INSERT INTO analytics.dim_month(month_date)
SELECT d::date
FROM generate_series('2024-12-01'::date, '2026-12-01'::date, interval '1 month') AS d;

COMMIT;
