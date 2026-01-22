-- =============================================================================
-- DATA QUALITY CHECKS
-- =============================================================================
-- 
-- We provide 3 baseline checks below.
-- Add at least 4 additional checks of your own.
-- 
-- For each check:
-- - Add a comment explaining what it validates
-- - Specify the expected result (usually 0 rows for "no violations")
-- =============================================================================


-- ---------------------------------------------------------------------------
-- BASELINE CHECK 1: Uniqueness of (customer_id, month)
-- ---------------------------------------------------------------------------
-- Expected: 0 rows

SELECT customer_id, month, COUNT(*) AS row_count
FROM analytics.customer_month
GROUP BY 1, 2
HAVING COUNT(*) > 1;


-- ---------------------------------------------------------------------------
-- BASELINE CHECK 2: Month must be first-of-month
-- ---------------------------------------------------------------------------
-- Expected: 0 rows

SELECT *
FROM analytics.customer_month
WHERE month <> date_trunc('month', month)::date;


-- ---------------------------------------------------------------------------
-- BASELINE CHECK 3: Revenue should never be negative
-- ---------------------------------------------------------------------------
-- Expected: 0 rows

SELECT *
FROM analytics.customer_month
WHERE revenue < 0 OR paid_revenue < 0;


-- =============================================================================
-- CANDIDATE CHECKS (add at least 4 below)
-- =============================================================================


-- ---------------------------------------------------------------------------
-- CHECK A: (describe what this validates)
-- ---------------------------------------------------------------------------
-- Expected: (describe expected result)

-- YOUR SQL HERE


-- ---------------------------------------------------------------------------
-- CHECK B: (describe what this validates)
-- ---------------------------------------------------------------------------
-- Expected: (describe expected result)

-- YOUR SQL HERE


-- ---------------------------------------------------------------------------
-- CHECK C: (describe what this validates)
-- ---------------------------------------------------------------------------
-- Expected: (describe expected result)

-- YOUR SQL HERE


-- ---------------------------------------------------------------------------
-- CHECK D: (describe what this validates)
-- ---------------------------------------------------------------------------
-- Expected: (describe expected result)

-- YOUR SQL HERE
