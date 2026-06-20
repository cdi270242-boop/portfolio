-- ============================================================
-- Additional Rows for Customer Segmentation DB
-- Extends existing data (user_id 1-10, order_id 101-116)
-- ============================================================

-- 15 new customers (user_id 11-25)
INSERT INTO customer_profiles
    (user_id, first_name, last_name, email, age, gender, city, state_province, country, signup_date, last_active_date, segment_id, lifetime_value, total_orders, avg_order_value)
VALUES
(11, 'Charlotte', 'Harris',   'charlotte.h@example.com',   29, 'F', 'Seattle',       'WA', 'US', '2021-03-12', '2024-11-08', 1, 3100.00, 22, 140.91),
(12, 'Mason',     'Clark',    'mason.clark@example.com',    41, 'M', 'Denver',        'CO', 'US', '2020-07-19', '2024-10-30', 1, 1540.00, 11, 140.00),
(13, 'Amelia',    'Lewis',    'amelia.lewis@example.com',   33, 'F', 'Nashville',     'TN', 'US', '2022-05-01', '2024-11-11', 2,  890.00,  9, 98.89),
(14, 'Logan',     'Walker',   'logan.walker@example.com',   26, 'M', 'Portland',      'OR', 'US', '2023-01-15', '2024-09-20', 3,  275.00,  3, 91.67),
(15, 'Harper',    'Hall',     'harper.hall@example.com',    37, 'F', 'Las Vegas',     'NV', 'US', '2021-11-22', '2024-07-14', 5,  430.00,  5, 86.00),
(16, 'Elijah',    'Allen',    'elijah.allen@example.com',   23, 'M', 'Minneapolis',   'MN', 'US', '2024-08-05', '2024-11-13', 4,   65.00,  1, 65.00),
(17, 'Evelyn',    'Young',    'evelyn.young@example.com',   44, 'F', 'Atlanta',       'GA', 'US', '2019-09-30', '2023-08-01', 6,  190.00,  3, 63.33),
(18, 'Aiden',     'Hernandez','aiden.h@example.com',        31, 'M', 'Miami',         'FL', 'US', '2022-02-28', '2024-11-01', 2,  720.00,  7, 102.86),
(19, 'Abigail',   'King',     'abigail.king@example.com',   28, 'F', 'Baltimore',     'MD', 'US', '2023-06-10', '2024-10-25', 3,  340.00,  4, 85.00),
(20, 'Lucas',     'Wright',   'lucas.wright@example.com',   35, 'M', 'Louisville',    'KY', 'US', '2021-08-14', '2024-11-09', 2,  610.00,  6, 101.67),
(21, 'Mia',       'Scott',    'mia.scott@example.com',      27, 'F', 'Milwaukee',     'WI', 'US', '2024-09-01', '2024-11-12', 4,   99.00,  1, 99.00),
(22, 'James',     'Green',    'james.green@example.com',    50, 'M', 'Albuquerque',   'NM', 'US', '2018-05-20', '2023-06-15', 6,  310.00,  5, 62.00),
(23, 'Luna',      'Baker',    'luna.baker@example.com',     32, 'F', 'Tucson',        'AZ', 'US', '2022-10-03', '2024-10-18', 2,  840.00,  8, 105.00),
(24, 'Henry',     'Adams',    'henry.adams@example.com',    39, 'M', 'Fresno',        'CA', 'US', '2021-04-25', '2024-06-30', 5,  500.00,  6, 83.33),
(25, 'Zoey',      'Nelson',   'zoey.nelson@example.com',    24, 'F', 'Sacramento',    'CA', 'US', '2023-11-15', '2024-11-10', 4,  110.00,  1, 110.00);


-- 30 new purchase records (order_id 117-146)
INSERT INTO purchase_history (user_id, order_id, order_date, total_amount, item_count, category, payment_method) VALUES
(11, 117, '2024-11-08', 389.00,  3, 'Electronics',    'credit_card'),
(11, 118, '2024-10-22', 145.00,  2, 'Clothing',       'paypal'),
(11, 119, '2024-09-30', 210.00,  1, 'Home Decor',     'credit_card'),
(12, 120, '2024-10-30', 320.00,  2, 'Electronics',    'debit_card'),
(12, 121, '2024-10-10', 175.00,  3, 'Groceries',      'credit_card'),
(13, 122, '2024-11-11', 130.00,  2, 'Beauty',         'paypal'),
(13, 123, '2024-10-28',  98.00,  1, 'Clothing',       'credit_card'),
(13, 124, '2024-10-05', 210.00,  2, 'Electronics',    'credit_card'),
(14, 125, '2024-09-20',  89.00,  1, 'Groceries',      'debit_card'),
(14, 126, '2024-08-15', 110.00,  2, 'Clothing',       'paypal'),
(15, 127, '2024-07-14', 155.00,  1, 'Beauty',         'credit_card'),
(15, 128, '2024-06-20',  95.00,  2, 'Groceries',      'debit_card'),
(16, 129, '2024-11-13',  65.00,  1, 'Clothing',       'paypal'),
(17, 130, '2023-08-01',  75.00,  1, 'Home Decor',     'credit_card'),
(18, 131, '2024-11-01', 220.00,  2, 'Electronics',    'credit_card'),
(18, 132, '2024-10-15',  85.00,  1, 'Beauty',         'paypal'),
(19, 133, '2024-10-25', 140.00,  2, 'Clothing',       'credit_card'),
(19, 134, '2024-09-10',  99.00,  1, 'Groceries',      'debit_card'),
(20, 135, '2024-11-09', 175.00,  2, 'Electronics',    'credit_card'),
(20, 136, '2024-10-20',  90.00,  1, 'Home Decor',     'paypal'),
(20, 137, '2024-09-25', 130.00,  2, 'Clothing',       'credit_card'),
(21, 138, '2024-11-12',  99.00,  1, 'Beauty',         'paypal'),
(22, 139, '2023-06-15',  85.00,  2, 'Groceries',      'debit_card'),
(23, 140, '2024-10-18', 260.00,  2, 'Electronics',    'credit_card'),
(23, 141, '2024-09-30', 115.00,  1, 'Clothing',       'paypal'),
(23, 142, '2024-09-01',  95.00,  2, 'Groceries',      'credit_card'),
(24, 143, '2024-06-30', 199.00,  1, 'Electronics',    'credit_card'),
(24, 144, '2024-05-15',  88.00,  2, 'Home Decor',     'debit_card'),
(25, 145, '2024-11-10', 110.00,  1, 'Beauty',         'paypal'),
(1,  146, '2024-11-14', 299.00,  2, 'Electronics',    'credit_card');  -- existing customer, new order


-- Additional segment events for new customers
INSERT INTO segment_events (user_id, old_segment_id, new_segment_id, triggered_by) VALUES
(15, 2, 5, 'etl_job'),   -- Harper downgraded to At Risk
(17, 5, 6, 'etl_job'),   -- Evelyn moved to Churned
(22, 3, 6, 'etl_job'),   -- James moved to Churned
(24, 2, 5, 'etl_job'),   -- Henry downgraded to At Risk
(11, 2, 1, 'etl_job');   -- Charlotte upgraded to VIP


-- ============================================================
-- Quick sanity checks
-- ============================================================

-- Total customers per segment
SELECT cs.segment_name, COUNT(cp.profile_id) AS customer_count
FROM customer_segments cs
LEFT JOIN customer_profiles cp ON cs.segment_id = cp.segment_id
GROUP BY cs.segment_name
ORDER BY customer_count DESC;

-- Total purchase records
SELECT COUNT(*) AS total_orders, ROUND(SUM(total_amount), 2) AS total_revenue
FROM purchase_history;
