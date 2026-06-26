-- ============================================================
-- Customer Segmentation Schema Extension
-- Built to work alongside a DummyJSON ETL database
-- ============================================================

-- 1. CUSTOMER SEGMENTS (lookup table)
-- Defines the segment buckets we'll assign users to
CREATE TABLE IF NOT EXISTS customer_segments (
    segment_id      INT AUTO_INCREMENT PRIMARY KEY,
    segment_name    VARCHAR(50)  NOT NULL UNIQUE,
    description     TEXT,
    min_order_count INT          DEFAULT 0,
    min_total_spend DECIMAL(10,2) DEFAULT 0.00,
    created_at      TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO customer_segments (segment_name, description, min_order_count, min_total_spend) VALUES
('VIP',          'High spend, high frequency buyers',          10,  1000.00),
('Loyal',        'Consistent buyers with moderate spend',       5,   500.00),
('Occasional',   'Infrequent buyers, moderate spend',           2,   100.00),
('New',          'First-time or very recent customers',         1,     0.00),
('At Risk',      'Previously active, no recent purchases',      0,     0.00),
('Churned',      'No purchases in 180+ days',                   0,     0.00);


-- 2. CUSTOMER PROFILES
-- Enriched user table pulling from DummyJSON users
CREATE TABLE IF NOT EXISTS customer_profiles (
    profile_id       INT AUTO_INCREMENT PRIMARY KEY,
    user_id          INT          NOT NULL UNIQUE,   -- FK to your users table
    first_name       VARCHAR(50),
    last_name        VARCHAR(50),
    email            VARCHAR(100),
    age              INT,
    gender           VARCHAR(10),
    city             VARCHAR(100),
    state_province   VARCHAR(100),
    country          VARCHAR(100),
    signup_date      DATE,
    last_active_date DATE,
    segment_id       INT,
    lifetime_value   DECIMAL(10,2) DEFAULT 0.00,
    total_orders     INT           DEFAULT 0,
    avg_order_value  DECIMAL(10,2) DEFAULT 0.00,
    FOREIGN KEY (segment_id) REFERENCES customer_segments(segment_id)
);

INSERT INTO customer_profiles
    (user_id, first_name, last_name, email, age, gender, city, state_province, country, signup_date, last_active_date, segment_id, lifetime_value, total_orders, avg_order_value)
VALUES
(1,  'Emily',   'Johnson', 'emily.johnson@example.com',  28, 'F', 'Chicago',     'IL', 'US', '2022-01-15', '2024-11-01', 1, 2340.50, 18, 130.03),
(2,  'Michael', 'Williams','michael.w@example.com',      34, 'M', 'Phoenix',     'AZ', 'US', '2021-06-10', '2024-10-20', 1, 1875.00, 12, 156.25),
(3,  'Sophia',  'Brown',   'sophia.brown@example.com',   22, 'F', 'Houston',     'TX', 'US', '2023-03-22', '2024-11-10', 4,  125.00,  1, 125.00),
(4,  'James',   'Davis',   'james.davis@example.com',    45, 'M', 'Philadelphia','PA', 'US', '2020-11-05', '2024-06-01', 5,  640.00,  6, 106.67),
(5,  'Olivia',  'Martinez','olivia.m@example.com',       30, 'F', 'San Antonio', 'TX', 'US', '2022-08-19', '2024-11-12', 2,  780.00,  7, 111.43),
(6,  'Liam',    'Garcia',  'liam.garcia@example.com',    27, 'M', 'Dallas',      'TX', 'US', '2023-07-04', '2024-09-15', 3,  310.00,  3, 103.33),
(7,  'Ava',     'Wilson',  'ava.wilson@example.com',     38, 'F', 'San Jose',    'CA', 'US', '2019-04-30', '2024-01-10', 6,  230.00,  4,  57.50),
(8,  'Noah',    'Anderson','noah.a@example.com',         31, 'M', 'Austin',      'TX', 'US', '2022-12-01', '2024-11-05', 2,  920.00,  8, 115.00),
(9,  'Isabella','Taylor',  'isabella.t@example.com',     25, 'F', 'Jacksonville','FL', 'US', '2023-10-10', '2024-11-13', 4,   89.99,  1,  89.99),
(10, 'Ethan',   'Thomas',  'ethan.thomas@example.com',   52, 'M', 'Columbus',    'OH', 'US', '2018-02-14', '2023-12-20', 6,  175.00,  3,  58.33);


-- 3. PURCHASE HISTORY
-- Summarized order history per customer (for segmentation logic)
CREATE TABLE IF NOT EXISTS purchase_history (
    history_id      INT AUTO_INCREMENT PRIMARY KEY,
    user_id         INT           NOT NULL,
    order_id        INT,                            -- FK to your carts/orders table if it exists
    order_date      DATE          NOT NULL,
    total_amount    DECIMAL(10,2) NOT NULL,
    item_count      INT           DEFAULT 1,
    category        VARCHAR(50),
    payment_method  VARCHAR(30),
    FOREIGN KEY (user_id) REFERENCES customer_profiles(user_id)
);

INSERT INTO purchase_history (user_id, order_id, order_date, total_amount, item_count, category, payment_method) VALUES
(1, 101, '2024-11-01', 249.99,  2, 'Electronics',    'credit_card'),
(1, 102, '2024-10-15', 129.50,  1, 'Clothing',       'paypal'),
(1, 103, '2024-09-20', 310.00,  3, 'Groceries',      'credit_card'),
(2, 104, '2024-10-20', 450.00,  1, 'Electronics',    'debit_card'),
(2, 105, '2024-10-01', 199.00,  2, 'Home Decor',     'credit_card'),
(3, 106, '2024-11-10', 125.00,  1, 'Clothing',       'paypal'),
(4, 107, '2024-06-01',  75.00,  2, 'Groceries',      'credit_card'),
(4, 108, '2024-05-10', 200.00,  1, 'Electronics',    'credit_card'),
(5, 109, '2024-11-12', 185.00,  2, 'Beauty',         'credit_card'),
(5, 110, '2024-10-30',  95.00,  1, 'Clothing',       'paypal'),
(6, 111, '2024-09-15', 160.00,  3, 'Groceries',      'debit_card'),
(7, 112, '2024-01-10',  89.99,  1, 'Home Decor',     'credit_card'),
(8, 113, '2024-11-05', 320.00,  2, 'Electronics',    'credit_card'),
(8, 114, '2024-10-20', 145.00,  1, 'Clothing',       'paypal'),
(9, 115, '2024-11-13',  89.99,  1, 'Beauty',         'credit_card'),
(10,116, '2023-12-20',  55.00,  1, 'Groceries',      'debit_card');


-- 4. SEGMENT EVENTS (audit log of segment changes)
-- Useful for tracking how customers move between segments over time
CREATE TABLE IF NOT EXISTS segment_events (
    event_id         INT AUTO_INCREMENT PRIMARY KEY,
    user_id          INT         NOT NULL,
    old_segment_id   INT,
    new_segment_id   INT         NOT NULL,
    event_date       TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
    triggered_by     VARCHAR(50) DEFAULT 'manual',  -- 'manual', 'etl_job', 'rule_engine'
    FOREIGN KEY (user_id)        REFERENCES customer_profiles(user_id),
    FOREIGN KEY (old_segment_id) REFERENCES customer_segments(segment_id),
    FOREIGN KEY (new_segment_id) REFERENCES customer_segments(segment_id)
);

INSERT INTO segment_events (user_id, old_segment_id, new_segment_id, triggered_by) VALUES
(1, 2, 1, 'etl_job'),   -- Emily upgraded from Loyal to VIP
(4, 2, 5, 'etl_job'),   -- James downgraded to At Risk
(7, 5, 6, 'etl_job');   -- Ava moved to Churned


-- ============================================================
-- USEFUL SEGMENTATION QUERIES
-- ============================================================

-- View all customers with their current segment
SELECT
    cp.user_id,
    CONCAT(cp.first_name, ' ', cp.last_name) AS customer_name,
    cs.segment_name,
    cp.lifetime_value,
    cp.total_orders,
    cp.avg_order_value,
    cp.last_active_date
FROM customer_profiles cp
JOIN customer_segments cs ON cp.segment_id = cs.segment_id
ORDER BY cp.lifetime_value DESC;


-- Count customers per segment
SELECT
    cs.segment_name,
    COUNT(cp.profile_id)         AS customer_count,
    ROUND(AVG(cp.lifetime_value), 2) AS avg_ltv,
    ROUND(SUM(cp.lifetime_value), 2) AS total_revenue
FROM customer_segments cs
LEFT JOIN customer_profiles cp ON cs.segment_id = cp.segment_id
GROUP BY cs.segment_name
ORDER BY total_revenue DESC;


-- Top categories purchased per segment
SELECT
    cs.segment_name,
    ph.category,
    COUNT(*)                          AS purchase_count,
    ROUND(SUM(ph.total_amount), 2)    AS total_spent
FROM purchase_history ph
JOIN customer_profiles cp ON ph.user_id = cp.user_id
JOIN customer_segments cs ON cp.segment_id = cs.segment_id
GROUP BY cs.segment_name, ph.category
ORDER BY cs.segment_name, total_spent DESC;


-- Re-segment customers based on current spend/order rules
-- (Run this to update segments dynamically)
UPDATE customer_profiles cp
JOIN customer_segments cs ON cs.segment_id = (
    SELECT segment_id FROM customer_segments
    WHERE cp.total_orders  >= min_order_count
      AND cp.lifetime_value >= min_total_spend
    ORDER BY min_total_spend DESC
    LIMIT 1
)
SET cp.segment_id = cs.segment_id;
