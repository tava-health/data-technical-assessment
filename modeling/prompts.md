# Data Modeling Questions

Answer these questions in `candidate_answers.md`. We're looking for thoughtful responses that demonstrate your understanding of data warehouse concepts.

---

## Part A: About Your Implementation

### 1. Data modeling
Briefly explain 1–2 modeling decisions you made and why

### 2. Historical Correctness
- How did you ensure customer attributes (segment, country, etc.) reflect the correct values **as of each month**?
- How did you determine which subscription/plan was active for each month?

### 3. Avoiding Double Counting
Briefly explain your strategy for preventing join fan-out or double counting when combining data from multiple sources (events, invoices, snapshots).

---

## Part B: Data Warehouse Concepts

### 4. Star Schema Design
If you were designing a **dimensional model** (star schema) for this data instead of a single wide table:
- What **fact table(s)** would you create? What would be the grain of each?
- What **dimension tables** would you create?
- Sketch the relationships (describe in words).

### 5. Slowly Changing Dimensions (SCD)
Customer attributes change over time (we have multiple snapshots per customer).

- Explain the difference between **SCD Type 1**, **Type 2**, and **Type 3**
- Which type would you recommend for tracking customer segment changes? Why?
- What are the tradeoffs of each approach?

---

## Part C: Production Considerations

### 6. Refresh Strategy
- Would you use **full refresh** or **incremental refresh** for this table in production?
- If incremental: what would trigger a rebuild of specific partitions?
- How would you handle late-arriving data (e.g., an invoice paid_at gets updated weeks later)?

### 7. Data Quality
- Summarize the data quality checks you added and why they matter.
- What additional checks would you add in a production environment?
