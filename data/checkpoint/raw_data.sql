-- Checkpoint: Pre-loaded raw data
-- Use this if you can't get the Python loader working: make load-checkpoint

BEGIN;

-- Clear existing data
TRUNCATE raw.events, raw.invoice_line_items, raw.invoices, raw.subscriptions, raw.customers_snapshot;

-- customers_snapshot
INSERT INTO raw.customers_snapshot (customer_id, snapshot_at, email, country, segment, is_active, employer_id) VALUES
('C001', '2024-12-05T10:00:00Z', 'c001@example.com', 'US', 'SMB', 'Y', 'E001'),
('C001', '2025-03-02 09:30:00', 'c001@example.com', 'US', 'Mid', 'Y', 'E001'),
('C001', '2025-10-15T08:00:00Z', 'c001_new@example.com', 'CA', 'Mid', 'Y', 'E002'),
('C002', '2024-12-20T12:00:00Z', 'c002@example.com', 'US', 'SMB', 'Y', NULL),
('C002', '2025-07-01T00:00:00Z', 'c002@example.com', 'US', 'SMB', 'N', NULL),
('C003', '2025-02-01T00:00:00Z', NULL, 'GB', 'Ent', 'Y', 'E003');

-- subscriptions
INSERT INTO raw.subscriptions (subscription_id, customer_id, plan_name, started_at, ended_at, status) VALUES
('S001', 'C001', 'Basic', '2024-12-01', '2025-05-31', 'ended'),
('S002', 'C001', 'Pro', '2025-05-15', NULL, 'active'),
('S003', 'C002', 'Basic', '2025-01-01', '2025-03-31', 'ended'),
('S004', 'C002', 'Basic', '2025-06-01', '2025-12-31', 'ended'),
('S005', 'C003', 'Enterprise', '2025-02-01', NULL, 'active');

-- invoices
INSERT INTO raw.invoices (invoice_id, customer_id, issued_at, invoice_month, status, paid_at, total_amount) VALUES
('I001', 'C001', '2024-12-10T00:00:00Z', '2024-12-01', 'paid', '2024-12-11T00:00:00Z', 100.00),
('I002', 'C001', '2025-01-10T00:00:00Z', '2025-01-01', 'open', NULL, 100.00),
('I003', 'C001', '2025-02-10T00:00:00Z', '2025-02-01', 'paid', '2025-02-12T00:00:00Z', 120.00),
('I004', 'C002', '2025-03-05T00:00:00Z', '2025-03-01', 'paid', '2025-03-20T00:00:00Z', 80.00),
('I005', 'C002', '2025-06-05T00:00:00Z', '2025-06-01', 'paid', '2025-06-06T00:00:00Z', 80.00),
('I006', 'C003', '2025-02-15T00:00:00Z', '2025-02-01', 'paid', '2025-02-16T00:00:00Z', 500.00),
('I007', 'C003', '2025-03-15T00:00:00Z', '2025-03-01', 'paid', '2025-03-16T00:00:00Z', 500.00);

-- invoice_line_items
INSERT INTO raw.invoice_line_items (invoice_id, line_item_id, type, amount) VALUES
('I001', 'L001', 'subscription', 100.00),
('I003', 'L002', 'subscription', 100.00),
('I003', 'L003', 'tax', 10.00),
('I003', 'L004', 'fee', 5.00),
('I004', 'L005', 'subscription', 80.00),
('I005', 'L006', 'subscription', 80.00),
('I006', 'L007', 'subscription', 450.00),
('I006', 'L008', 'tax', 30.00),
('I006', 'L009', 'fee', 10.00),
('I007', 'L010', 'subscription', 500.00);

-- events (includes duplicates - SQL must handle deduplication)
INSERT INTO raw.events (event_id, event_type, occurred_at, idempotency_key, customer_id, employer_id, invoice_id, session_id, provider_id, amount, currency, status, payload_json) VALUES
('E0001', 'invoice_paid', '2024-12-11T11:00:00Z', 'I001_paid', 'C001', 'E001', 'I001', NULL, NULL, 100.0, 'USD', NULL, '{"invoice_id": "I001", "amount": 100.0, "currency": "USD"}'),
('E0002', 'session_booked', '2025-02-05T15:00:00Z', 'Ssn_100_booked', 'C001', 'E001', NULL, 'SSN100', 'P01', NULL, NULL, NULL, '{"session_id": "SSN100", "provider_id": "P01"}'),
('E0003', 'session_completed', '2025-02-10T16:00:00Z', 'Ssn_100_completed', 'C001', 'E001', NULL, 'SSN100', 'P01', NULL, NULL, NULL, '{"session_id": "SSN100", "provider_id": "P01"}'),
('E0004', 'invoice_paid', '2025-02-12T09:00:00Z', 'I003_paid', 'C001', 'E001', 'I003', NULL, NULL, 120.0, 'USD', NULL, '{"invoice_id": "I003", "amount": 120.0, "currency": "USD"}'),
('E0005', 'invoice_paid', '2025-02-12T09:00:00Z', 'I003_paid', 'C001', 'E001', 'I003', NULL, NULL, 120.0, 'USD', NULL, '{"invoice_id": "I003", "amount": 120.0, "currency": "USD"}'),
('E0006', 'session_booked', '2025-03-01T10:00:00Z', 'Ssn_200_booked', 'C002', NULL, NULL, 'SSN200', 'P02', NULL, NULL, NULL, '{"session_id": "SSN200", "provider_id": "P02"}'),
('E0007', 'session_canceled', '2025-03-02T10:00:00Z', 'Ssn_200_canceled', 'C002', NULL, NULL, 'SSN200', 'P02', NULL, NULL, NULL, '{"session_id": "SSN200", "provider_id": "P02"}'),
('E0008', 'invoice_paid', '2025-03-19T12:00:00Z', 'I004_paid', 'C002', NULL, 'I004', NULL, NULL, 80.0, 'USD', NULL, '{"invoice_id": "I004", "amount": 80.0, "currency": "USD"}'),
('E0009', 'invoice_paid', '2025-06-06T12:00:00Z', 'I005_paid', 'C002', NULL, 'I005', NULL, NULL, 80.0, 'USD', NULL, '{"invoice_id": "I005", "amount": 80.0, "currency": "USD"}'),
('E0010', 'session_completed', '2025-02-20T10:00:00Z', 'Ssn_300_completed', 'C003', 'E003', NULL, 'SSN300', 'P03', NULL, NULL, NULL, '{"session_id": "SSN300", "provider_id": "P03"}');

COMMIT;

-- Verify counts
SELECT 'customers_snapshot' AS table_name, COUNT(*) AS rows FROM raw.customers_snapshot
UNION ALL SELECT 'subscriptions', COUNT(*) FROM raw.subscriptions
UNION ALL SELECT 'invoices', COUNT(*) FROM raw.invoices
UNION ALL SELECT 'invoice_line_items', COUNT(*) FROM raw.invoice_line_items
UNION ALL SELECT 'events', COUNT(*) FROM raw.events;
