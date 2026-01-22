BEGIN;

-- =============================================================================
-- SQL TRANSFORMATION: Build analytics.customer_month
-- =============================================================================
-- 
-- Your task: Transform raw.* tables into a denormalized monthly analytics table.
-- 
-- Key challenges:
-- - Deduplicate events
-- - Detect invoice anomalies
-- - Build a customer-month spine (include months with no activity)
-- - Join customer attributes as-of month end (point-in-time)
-- - Determine subscription status per month
-- - Aggregate metrics without double counting
--
-- You may create staging tables, views, or CTEs as needed.
-- The final output must be: analytics.customer_month
-- =============================================================================


-- ---------------------------------------------------------------------------
-- STEP 1: Deduplicate events
-- ---------------------------------------------------------------------------
-- Deduplicate by idempotency_key
-- ---------------------------------------------------------------------------

-- YOUR CODE HERE


-- ---------------------------------------------------------------------------
-- STEP 2: Invoice reconciliation
-- ---------------------------------------------------------------------------
-- Join invoices to line items and identify anomalies where the line item
-- amounts don't match the invoice total (threshold: > $1.00 difference)
-- ---------------------------------------------------------------------------

-- YOUR CODE HERE


-- ---------------------------------------------------------------------------
-- STEP 3: Build customer-month spine
-- ---------------------------------------------------------------------------
-- Create a complete spine of (customer_id, month) covering all customers
-- and all months. Use analytics.dim_month for the month list.
-- 
-- Customers may appear in any raw table - collect them all.
-- Months with zero activity must still appear in the output.
-- ---------------------------------------------------------------------------

-- YOUR CODE HERE


-- ---------------------------------------------------------------------------
-- STEP 4: Customer attributes as-of month end
-- ---------------------------------------------------------------------------
-- For each (customer_id, month), determine the customer's attributes
-- (segment, country, employer_id, is_active) as they were at the end
-- of that month, based on raw.customers_snapshot.
-- ---------------------------------------------------------------------------

-- YOUR CODE HERE


-- ---------------------------------------------------------------------------
-- STEP 5: Subscription as-of
-- ---------------------------------------------------------------------------
-- For each (customer_id, month), determine:
-- - active_subscription_flag: whether any subscription was active during the month
-- - plan_name: the plan name (pick any if multiple subscriptions overlap)
-- ---------------------------------------------------------------------------

-- YOUR CODE HERE


-- ---------------------------------------------------------------------------
-- STEP 6: Aggregate and build final table
-- ---------------------------------------------------------------------------
-- Combine all components into analytics.customer_month.
-- Aggregate events and invoices to the customer-month grain.
-- Compute derived columns (e.g., paid_flag).
--
-- IMPORTANT: Add a comment explaining how you avoided double counting.
-- ---------------------------------------------------------------------------

DROP TABLE IF EXISTS analytics.customer_month;
CREATE TABLE analytics.customer_month (
  customer_id TEXT NOT NULL,
  month       DATE NOT NULL,

  -- Revenue metrics
  revenue      NUMERIC(12,2) NOT NULL DEFAULT 0,
  paid_revenue NUMERIC(12,2) NOT NULL DEFAULT 0,

  -- Session metrics
  sessions_booked    INT NOT NULL DEFAULT 0,
  sessions_completed INT NOT NULL DEFAULT 0,
  sessions_canceled  INT NOT NULL DEFAULT 0,

  -- Subscription status
  active_subscription_flag BOOLEAN,
  plan_name TEXT,

  -- Customer attributes as-of month end
  segment     TEXT,
  country     TEXT,
  employer_id TEXT,
  is_active   BOOLEAN,

  -- Paid indicator
  paid_flag INT NOT NULL DEFAULT 0,

  -- Invoice anomalies
  invoice_anomaly_count INT NOT NULL DEFAULT 0,

  PRIMARY KEY (customer_id, month)
);

-- TODO: INSERT INTO analytics.customer_month SELECT ...

COMMIT;
