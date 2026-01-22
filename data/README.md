# Synthetic raw data

All data here is synthetic and intentionally messy.

## Files
- customers_snapshot.csv
  - multiple snapshots per customer over time; attributes can change
  - timestamps may be inconsistent (timezone vs no timezone)
- subscriptions.csv
  - overlapping ranges and gaps
- invoices.csv
  - system of record for revenue and paid_revenue
- invoice_line_items.csv
  - some invoices have 0 line items
  - some line item sums do not match invoice totals
- events_pages/*.json
  - paginated event logs
  - duplicates exist (same idempotency_key)
  - may conflict with invoice paid records

## Intended edge cases
- customer with months of no activity must still appear in analytics.customer_month (spine)
- invoice with no line items
- invoice with mismatched line items
- duplicated events
- subscription overlaps/gaps
- snapshots changing attributes over time
