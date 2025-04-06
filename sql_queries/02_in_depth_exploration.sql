-- #Q2 In-depth Exploration:

-- 2.1 Is there a growing trend in the no. of orders placed over the past years?

-- Select the year and count of orders per year
SELECT
    -- Extract the year part from the timestamp
    EXTRACT(YEAR FROM order_purchase_timestamp) AS year_of_purchase,
    -- Count all rows (*) for each group (year)
    COUNT(*) AS number_of_orders
-- Specify the source table
FROM
    `target_sql.orders`
-- Group results by the extracted year to count orders per year
GROUP BY
    year_of_purchase -- Group by the alias defined in SELECT
-- Order results chronologically by year
ORDER BY
    year_of_purchase;

-- End of SQL Statement


-- 2.2 Can we see some kind of monthly seasonality in terms of the no. of orders being placed?

-- Select the year, month, and count of orders per month
SELECT
    -- Extract the year part from the timestamp
    EXTRACT(YEAR FROM order_purchase_timestamp) AS year_of_purchase,
    -- Extract the month part from the timestamp
    EXTRACT(MONTH FROM order_purchase_timestamp) AS month_of_purchase,
    -- Count all rows (*) for each group (year, month)
    COUNT(*) AS number_of_orders
-- Specify the source table
FROM
    `target_sql.orders`
-- Group results first by year, then by month within each year
GROUP BY
    1, -- Corresponds to year_of_purchase
    2  -- Corresponds to month_of_purchase
-- Order results chronologically first by year, then by month
ORDER BY
    1, -- Corresponds to year_of_purchase
    2; -- Corresponds to month_of_purchase

-- End of SQL Statement


-- 2.3 During which part of the day are most orders placed? (Inferred - see note below)
-- Note: Original question text for 2.3 was same as 2.2, using query's purpose here.

-- Select the time period and count of orders
SELECT
    -- Use CASE statement to categorize hour into time periods
    CASE
        WHEN EXTRACT(HOUR FROM order_purchase_timestamp) BETWEEN 0 AND 6 THEN 'Dawn'
        WHEN EXTRACT(HOUR FROM order_purchase_timestamp) BETWEEN 7 AND 12 THEN 'Mornings'
        WHEN EXTRACT(HOUR FROM order_purchase_timestamp) BETWEEN 13 AND 18 THEN 'Afternoon'
        ELSE 'Night'
    END AS Time_Of_Day, -- Alias for the calculated time period
    -- Count all rows (*) for each time period
    count(*) AS Orders_Placed_Count
-- Specify the source table
FROM
    `target_sql.orders`
-- Group results by the calculated time period
GROUP BY
    1 -- Corresponds to Time_Of_Day
-- Order results by the count of orders in descending order
ORDER BY
    2 DESC; -- Corresponds to Orders_Placed_Count

-- End of SQL Statement