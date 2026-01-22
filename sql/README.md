# SQL Challenge: Build an Analytics Mart

Transform the raw data (loaded via Python) into an analytics-ready monthly table.

## Files

| File | Purpose |
|------|---------|
| `00_schema.sql` | Creates raw and analytics schemas (run via `make db-init`) |
| `01_transform.sql` | **Your main work** — build analytics.customer_month |
| `02_checks.sql` | Data quality checks — add at least 4 of your own |

---

## Required Output: `analytics.customer_month`

### Required Columns

| Column | Type | Description |
|--------|------|-------------|
| `customer_id` | TEXT | Customer identifier |
| `month` | DATE | First day of month (e.g., '2025-01-01') |
| `revenue` | NUMERIC | Sum of `total_amount` from invoices **issued** in this month |
| `paid_revenue` | NUMERIC | Sum of `total_amount` from invoices **paid** in this month |
| `sessions_booked` | INT | Count of `session_booked` events |
| `sessions_completed` | INT | Count of `session_completed` events |
| `sessions_canceled` | INT | Count of `session_canceled` events |
| `active_subscription_flag` | BOOLEAN | TRUE if any subscription was active during this month |
| `plan_name` | TEXT | Plan name of an active subscription |
| `segment` | TEXT | Customer segment **as-of month end** |
| `country` | TEXT | Customer country **as-of month end** |
| `employer_id` | TEXT | Employer ID **as-of month end** |
| `is_active` | BOOLEAN | Is-active flag **as-of month end** |
| `paid_flag` | INT | 1 if `paid_revenue > 0`, else 0 |
| `invoice_anomaly_count` | INT | Count of invoices **issued** in this month where line items don't match total |

---

## Key Requirements

### A. Month Spine
Include ALL (customer_id, month) combinations, even for months with no activity. Use `analytics.dim_month` for the month calendar.

### B. Event Deduplication
Deduplicate `raw.events` by `idempotency_key`.

### C. Point-in-Time Customer Attributes
Customer attributes should reflect their values **as of the end of each month**, based on `raw.customers_snapshot`.

### D. Subscription Status
Determine whether a subscription was active during each month and capture the plan name.

### E. Invoice Anomalies
Flag invoices where the line item amounts don't match the invoice total (use a reasonable threshold like $1.00). Note: Invoices with no line items ARE considered anomalies (expected sum is 0, which doesn't match total).

### F. Avoid Double Counting
Ensure your joins don't multiply rows. Add a comment explaining your approach.

---

## Running

```bash
make sql-transform   # Run your transformation
make sql-checks      # Run data quality checks
make psql            # Interactive SQL session
```

---

## Data Quality Checks

We provide 3 baseline checks in `02_checks.sql`. Add **at least 4 more** checks of your own.
