# Senior Data Engineer Technical Assessment

Welcome! This take-home assessment is designed to evaluate your skills in data engineering fundamentals: Python data loading, SQL transformations, and data modeling concepts. The exercise simulates a real-world scenario with messy source data that needs to be cleaned, loaded, and transformed into an analytics-ready dataset. This is not a production system, prioritize clarity and correctness over extensibility.

**Expected time:** 3-4 hours

---

## The Challenge

You will work through three parts:

| Part | Focus |
|------|-------|
| **Python** | Load messy CSV/JSON data into Postgres |
| **SQL** | Transform raw data into an analytics mart |
| **Modeling** | Answer data warehouse design questions |

---

## What Success Looks Like
- Correctness and robustness
- Code clarity and structure
- Reasonable, documented assumptions
- Data modeling decisions
- Ability to validate and reason about data


---

## Getting Started

### 1. Download the Repository

Download this repo as a zip file. **Do not fork or create pull requests** — this is a public repo.

### 2. Start Postgres

```bash
docker compose up -d
```

### 3. Initialize Database Schema

```bash
make db-init
```

### 4. Set Up Python Environment

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

You're now ready to start the assessment.

---

## What You Need to Do

### Part 1: Python Data Loading

Implement `python/load_to_postgres.py` to:
- Load CSV files into the corresponding `raw.*` tables
- Load paginated JSON event files, flattening nested structures

See [`python/README.md`](python/README.md) for detailed requirements.

**Run your loader:**
```bash
python python/load_to_postgres.py
```

**Stuck on Python?** You can load pre-parsed data to proceed with SQL:
```bash
make load-checkpoint
```

### Part 2: SQL Transformations

Build `analytics.customer_month` — a denormalized monthly analytics table. Work in:
- `sql/01_transform.sql` — your main SQL logic
- `sql/02_checks.sql` — add at least 4 data quality checks

See [`sql/README.md`](sql/README.md) for detailed requirements and column specifications.

**Run your transformations:**
```bash
make sql-transform
```

**Run data quality checks:**
```bash
make sql-checks
```

### Part 3: Data Modeling

Answer the conceptual questions in [`modeling/prompts.md`](modeling/prompts.md). Write your responses in `modeling/candidate_answers.md`.

---

## Tech Stack

- **Postgres 16** (via Docker)
- **Python 3.10+** recommended
- **pandas** + **psycopg2-binary**

---

## Important Notes

- **Revenue / paid_revenue**: Use `raw.invoices` as the system of record
- **Events**: Behavioral logs that may contain duplicates or delays
- The source data is intentionally messy — timestamps may be inconsistent, some records may be missing fields
- See [`data/README.md`](data/README.md) for known edge cases

---

## Bonus Ideas (Optional)

If you have extra time and want to demonstrate additional skills:

- Add Python unit tests for your loader functions
- Implement idempotent/incremental loading (safe to re-run)
- Add structured logging with timing metrics
- Create an additional analytical view (e.g., cohort analysis)
- Add more comprehensive data quality checks

---

## Submission Instructions

This repository is public. **Do not open a PR here.**

1. Complete the assessment in your local copy
2. Create a `SUBMISSION.md` file with:
   - How to run your solution
   - Assumptions and tradeoffs you made
   - What you would improve with more time
3. Submit by emailing a zip of your completed folder to the engineering leader you're working with

---

## Useful Commands

```bash
make help          # Show all available commands
make db-init       # Create schemas and tables
make db-reset      # Drop and recreate everything
make sql-transform # Run your transformation SQL
make sql-checks    # Run data quality checks
make psql          # Open interactive psql session
```

---

Thank you for taking the time to complete this assessment. We're excited to see your work!
