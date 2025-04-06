-- #Q4 Impact on Economy: Analyze the money movement by e-commerce by looking at order prices, freight and others.

-- 4.1 Get the % increase in the cost of orders from year 2017 to 2018 (Jan-Aug only) - Yearwise Comparison.

-- Define Common Table Expression (CTE) for 2017 payments (Jan-Aug)
WITH payments_2017 AS (
    SELECT
        -- Calculate total payment value for the period
        SUM(p.payment_value) AS total_payment_2017
    FROM
        `target_sql.payments` AS p
    -- Join payments with orders to filter by date
    JOIN
        `target_sql.orders` AS o ON p.order_id = o.order_id
    -- Filter for year 2017
    WHERE
        EXTRACT(YEAR FROM o.order_purchase_timestamp) = 2017
        -- Filter for months January (1) to August (8)
        AND EXTRACT(MONTH FROM o.order_purchase_timestamp) BETWEEN 1 AND 8
),
-- Define CTE for 2018 payments (Jan-Aug)
payments_2018 AS (
    SELECT
        -- Calculate total payment value for the period
        SUM(p.payment_value) AS total_payment_2018
    FROM
        `target_sql.payments` AS p
    -- Join payments with orders to filter by date
    JOIN
        `target_sql.orders` AS o ON p.order_id = o.order_id
    -- Filter for year 2018
    WHERE
        EXTRACT(YEAR FROM o.order_purchase_timestamp) = 2018
        -- Filter for months January (1) to August (8)
        AND EXTRACT(MONTH FROM o.order_purchase_timestamp) BETWEEN 1 AND 8
)
-- Calculate the overall percentage increase between the two periods
SELECT
    -- Formula: ((New - Old) / Old) * 100, rounded to 2 decimal places
    ROUND(((total_payment_2018 - total_payment_2017) / total_payment_2017) * 100, 2) AS percentage_increase
-- Select from the results of the two CTEs (cross join implicitly as each returns one row)
FROM
    payments_2017, payments_2018;

-- End of SQL Statement


-- 4.1 Get the % increase in the cost of orders from year 2017 to 2018 (Jan-Aug only) - Monthwise Comparison.

-- Define CTE for 2017 monthly payments (Jan-Aug)
WITH payments_2017 AS (
    SELECT
        -- Extract the month number
        EXTRACT(MONTH FROM o.order_purchase_timestamp) AS month,
        -- Calculate total payment value for each month
        SUM(p.payment_value) AS total_payment_2017
    FROM
        `target_sql.payments` AS p
    JOIN
        `target_sql.orders` AS o ON p.order_id = o.order_id
    WHERE
        EXTRACT(YEAR FROM o.order_purchase_timestamp) = 2017
        AND EXTRACT(MONTH FROM o.order_purchase_timestamp) BETWEEN 1 AND 8
    -- Group by month to get monthly sums
    GROUP BY
        month
),
-- Define CTE for 2018 monthly payments (Jan-Aug)
payments_2018 AS (
    SELECT
        -- Extract the month number
        EXTRACT(MONTH FROM o.order_purchase_timestamp) AS month,
        -- Calculate total payment value for each month
        SUM(p.payment_value) AS total_payment_2018
    FROM
        `target_sql.payments` AS p
    JOIN
        `target_sql.orders` AS o ON p.order_id = o.order_id
    WHERE
        EXTRACT(YEAR FROM o.order_purchase_timestamp) = 2018
        AND EXTRACT(MONTH FROM o.order_purchase_timestamp) BETWEEN 1 AND 8
    -- Group by month to get monthly sums
    GROUP BY
        month
)
-- Select month, payments for both years, and calculate monthly percentage increase
SELECT
    p17.month,
    -- Round the payment values for display
    ROUND(p17.total_payment_2017, 2) AS total_payment_2017,
    ROUND(p18.total_payment_2018, 2) AS total_payment_2018,
    -- Calculate the percentage increase for each month
    ROUND(((p18.total_payment_2018 - p17.total_payment_2017) / p17.total_payment_2017) * 100, 2) AS percentage_increase
-- Join the 2017 and 2018 CTE results on the month number
FROM
    payments_2017 AS p17
JOIN
    payments_2018 AS p18 ON p17.month = p18.month
-- Order results by percentage increase in descending order
ORDER BY
    percentage_increase DESC;

-- End of SQL Statement


-- 4.2 Calculate the Total & Average value of order price for each state.

-- Select state, total payment value, and average payment value
SELECT
    c.customer_state,
    -- Calculate the sum of payment values per state, rounded
    ROUND(SUM(p.payment_value), 2) AS total_amount,
    -- Calculate the average payment value per state, rounded
    ROUND(AVG(p.payment_value), 2) AS avg_amount
-- Start with the payments table (alias 'p')
FROM
    `target_sql.payments` AS p
-- Join payments to orders (alias 'o')
JOIN
    `target_sql.orders` AS o ON p.order_id = o.order_id
-- Join orders to customers (alias 'c') to get the state
JOIN
    `target_sql.customers` AS c ON o.customer_id = c.customer_id
-- Group results by customer state to aggregate amounts
GROUP BY
    c.customer_state
-- Order results alphabetically by state
ORDER BY
    c.customer_state;

-- End of SQL Statement


-- 4.3 Calculate the Total & Average value of order freight for each state.

-- Select state, total freight value, and average freight value
SELECT
    c.customer_state,
    -- Calculate the sum of freight values per state, rounded
    ROUND(SUM(oi.freight_value), 2) AS total_freight,
    -- Calculate the average freight value per state, rounded
    ROUND(AVG(oi.freight_value), 2) AS avg_freight
-- Start with the orders table (alias 'o')
FROM
    `target_sql.orders` AS o
-- Join orders to order items (alias 'oi') to get freight value
JOIN
    `target_sql.order_items` AS oi ON o.order_id = oi.order_id
-- Join orders to customers (alias 'c') to get the state
JOIN
    `target_sql.customers` AS c ON o.customer_id = c.customer_id
-- Group results by customer state to aggregate freight values
GROUP BY
    c.customer_state
-- Order results alphabetically by state
ORDER BY
    c.customer_state;

-- End of SQL Statement