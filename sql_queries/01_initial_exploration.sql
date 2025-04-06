-- #Q1 Import the dataset and do usual exploratory analysis steps like checking the structure & characteristics of the dataset:

-- #1.2 Get the time range between which the orders were placed.

-- Select the minimum and maximum timestamps
SELECT
    -- min() finds the earliest date/time in the column
    min(order_purchase_timestamp) AS first_order_date,

    -- max() finds the latest date/time in the column
    max(order_purchase_timestamp) AS last_order_date

-- Specify the source table
FROM
    -- Using backticks for consistency or if project/dataset names require them
    `target_sql.orders`;

-- End of SQL Statement
-- Selecting the desired metadata columns
SELECT
    COLUMN_NAME, -- The name of the column in the table
    DATA_TYPE    -- The data type of the column (e.g., STRING, INT64, TIMESTAMP)

-- Specifying the source of the metadata
FROM
    -- INFORMATION_SCHEMA provides metadata about database objects
    -- Format: `project-id.dataset-id.INFORMATION_SCHEMA.COLUMNS`
    `artful-striker-417618.target_sql.INFORMATION_SCHEMA.COLUMNS`

-- Filtering the results to the specific table of interest
WHERE
    -- TABLE_NAME specifies which table's columns we want to inspect
    TABLE_NAME = 'customers';

-- End of SQL Statement


-- #1.2 Get the time range between which the orders were placed.

-- Select the minimum and maximum timestamps
SELECT
    -- min() finds the earliest date/time in the column
    min(order_purchase_timestamp) AS first_order_date,

    -- max() finds the latest date/time in the column
    max(order_purchase_timestamp) AS last_order_date

-- Specify the source table
FROM
    -- Using backticks for consistency or if project/dataset names require them
    `target_sql.orders`;

-- End of SQL Statement


-- 1.3 Count the Cities & States of customers who ordered during the given period.

-- Select the distinct count of cities and states
SELECT
    -- count(DISTINCT ...) calculates the number of unique values in a column
    count(DISTINCT c.customer_city) AS number_of_cities,

    -- Alias 'c' refers to the customers table defined in the FROM clause
    count(DISTINCT c.customer_state) AS number_of_states

-- Specify the primary table (customers) and assign an alias 'c' for brevity
FROM
    `target_sql.customers` AS c

-- Join customers with orders to include only customers who have placed orders
INNER JOIN
    -- Specify the orders table and assign an alias 'o'
    `target_sql.orders` AS o
    -- Link customers and orders tables on their common column 'customer_id'
    ON c.customer_id = o.customer_id;

-- End of SQL Statement