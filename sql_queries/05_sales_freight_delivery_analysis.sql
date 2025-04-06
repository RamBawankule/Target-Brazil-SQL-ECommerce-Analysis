-- #Q5 Analysis based on sales, freight and delivery time.

-- 5.1 Find the no. of days taken to deliver each order and the difference from estimated delivery.

-- Select order ID and calculated time differences
SELECT
    order_id,
    -- Calculate days between delivery and purchase date
    DATE_DIFF(DATE(order_delivered_customer_date), DATE(order_purchase_timestamp), DAY) AS delivery_time,
    -- Calculate days between delivery and estimated delivery date (Negative = Late, Positive = Early)
    DATE_DIFF(DATE(order_delivered_customer_date), DATE(order_estimated_delivery_date), DAY) AS diff_estimated_delivery
-- Specify the source table
FROM
    `target_sql.orders`
-- Order results by order ID for consistency
ORDER BY
    order_id;

-- End of SQL Statement


-- 5.2 Find out the top 5 states with the highest & lowest average freight value.

-- CTE for top 5 states with highest average freight
WITH highest_freight AS (
    SELECT
        c.customer_state,
        -- Calculate average freight value per state, rounded
        ROUND(AVG(oi.freight_value), 2) AS avg_freight
    FROM
        `target_sql.orders` AS o
    JOIN `target_sql.order_items` AS oi ON o.order_id = oi.order_id
    JOIN `target_sql.customers` AS c ON o.customer_id = c.customer_id
    GROUP BY c.customer_state
    -- Order by average freight descending to find highest
    ORDER BY avg_freight DESC
    -- Limit to top 5
    LIMIT 5
),
-- CTE for bottom 5 states with lowest average freight
lowest_freight AS (
    SELECT
        c.customer_state,
        -- Calculate average freight value per state, rounded
        ROUND(AVG(oi.freight_value), 2) AS avg_freight
    FROM
        `target_sql.orders` AS o
    JOIN `target_sql.order_items` AS oi ON o.order_id = oi.order_id
    JOIN `target_sql.customers` AS c ON o.customer_id = c.customer_id
    GROUP BY c.customer_state
    -- Order by average freight ascending to find lowest
    ORDER BY avg_freight ASC
    -- Limit to bottom 5
    LIMIT 5
)
-- Combine highest freight results, adding a label
SELECT CONCAT("HIGH FREIGHT : ", customer_state) AS customer_state_rank, avg_freight
FROM highest_freight
-- Combine with lowest freight results using UNION ALL
UNION ALL
-- Combine lowest freight results, adding a label
SELECT CONCAT("LOW FREIGHT : ", customer_state) AS customer_state_rank, avg_freight
FROM lowest_freight;

-- End of SQL Statement


-- 5.3 Find out the top 5 states with the highest & lowest average delivery time.

-- CTE to calculate average delivery time per state
WITH cte AS (
    SELECT
        customer_state AS state,
        -- Calculate average difference in days between delivery and purchase
        AVG(datetime_diff(order_delivered_customer_date, order_purchase_timestamp, DAY)) AS avg_delivery_time
    FROM
        `target_sql.customers` AS c
    JOIN
        `target_sql.orders` AS o ON c.customer_id = o.customer_id
    -- Ensure order was delivered before calculating diff
    WHERE o.order_delivered_customer_date IS NOT NULL
    GROUP BY state
),
-- CTE to rank states by delivery time (fastest and slowest)
rankings AS (
    SELECT
        state,
        avg_delivery_time,
        -- Rank states by longest delivery time (1 = slowest)
        DENSE_RANK() OVER (ORDER BY avg_delivery_time DESC) as rnk_slow,
        -- Rank states by shortest delivery time (1 = fastest)
        DENSE_RANK() OVER (ORDER BY avg_delivery_time ASC) as rnk_fast
    FROM cte
)
-- Select the top 5 slowest and top 5 fastest states
SELECT
    -- Create a label indicating if it's a fast or slow rank and the rank number
    CASE
        WHEN rnk_slow <= 5 THEN CONCAT('SLOWEST - ', rnk_slow)
        WHEN rnk_fast <= 5 THEN CONCAT('FASTEST - ', rnk_fast)
    END AS speed_rank_label,
    state,
    -- Round the average delivery time for display
    ROUND(avg_delivery_time, 2) AS Avg_delivery_time
FROM rankings
-- Filter to include only states ranked in the top 5 for either slowest or fastest
WHERE rnk_slow <= 5 OR rnk_fast <= 5
-- Order by the label for clear grouping of fastest/slowest
ORDER BY speed_rank_label;

-- End of SQL Statement


-- 5.4 Find out the top 5 states where the order delivery is really fast compared to the estimated date.

-- Select state and average difference between estimated and actual delivery
SELECT
    c.customer_state,
    -- Calculate average days difference: Estimated - Actual (Positive means delivered earlier)
    ROUND(AVG(DATE_DIFF(o.order_estimated_delivery_date, o.order_delivered_customer_date, DAY)), 2) AS avg_diff_estimated_actual
FROM
    `target_sql.orders` AS o
JOIN
    `target_sql.customers` AS c ON o.customer_id = c.customer_id
-- Ensure both dates are present to calculate the difference
WHERE o.order_estimated_delivery_date IS NOT NULL
  AND o.order_delivered_customer_date IS NOT NULL
-- Group by state to calculate average difference per state
GROUP BY
    c.customer_state
-- Order by the average difference descending (higher positive value means delivered earlier)
ORDER BY
    avg_diff_estimated_actual DESC
-- Limit to the top 5 states with the earliest average delivery compared to estimate
LIMIT 5;

-- End of SQL Statement