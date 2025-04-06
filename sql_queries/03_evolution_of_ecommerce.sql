-- #Q3 Evolution of E-commerce orders in the Brazil region:

-- 3.1 Get the month-on-month no. of orders placed in each state.

-- Select the state, formatted month/year, and order count
SELECT
    c.customer_state,
    -- Format the timestamp to 'YYYY-MM' string for monthly grouping
    FORMAT_TIMESTAMP('%Y-%m', o.order_purchase_timestamp) AS Year_Month,
    -- Count total orders for each state/month combination
    COUNT(*) AS number_of_orders
-- Start with the customers table, alias 'c'
FROM
    `target_sql.customers` AS c
-- Join with orders table, alias 'o', on the customer ID
JOIN
    `target_sql.orders` AS o ON c.customer_id = o.customer_id
-- Group by state and the formatted month/year
GROUP BY
    c.customer_state,
    Year_Month -- Group by the alias defined in SELECT
-- Order results primarily by state, then chronologically by month/year
ORDER BY
    c.customer_state,
    Year_Month;

-- End of SQL Statement


-- 3.2 How are the customers distributed across all the states?

-- Select state, count of unique customers, and percentage distribution
SELECT
    customer_state,
    -- Count the distinct unique customer identifiers per state
    COUNT(DISTINCT customer_unique_id) AS number_of_unique_customer,
    -- Calculate the percentage of total unique customers in this state
    ROUND(
        COUNT(DISTINCT customer_unique_id) -- Unique customers in this state
        / -- Divided by
        -- Subquery to get the total count of unique customers across all states
        (SELECT COUNT(DISTINCT customer_unique_id) FROM `target_sql.customers`)
        * 100, -- Multiply by 100 to get percentage
        2 -- Round the result to 2 decimal places
    ) AS percentage_of_customer_distribution
-- Specify the source table
FROM
    `target_sql.customers`
-- Group results by state to aggregate counts per state
GROUP BY
    customer_state
-- Order results by the calculated percentage in descending order
ORDER BY
    percentage_of_customer_distribution DESC; -- Order by alias

-- End of SQL Statement