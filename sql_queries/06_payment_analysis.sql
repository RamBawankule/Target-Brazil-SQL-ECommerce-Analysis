-- #Q6 Alysis based on the payments:

-- 6.1 Find the month on month no. of orders placed using different payment types.

-- Select the formatted month, payment type, and distinct order count
SELECT
    -- Format the timestamp to 'YYYY-MM' string
    FORMAT_TIMESTAMP('%Y-%m', o.order_purchase_timestamp) AS month,
    p.payment_type,
    -- Count distinct order IDs for each payment type and month
    COUNT(DISTINCT o.order_id) AS order_count
-- Start with the payments table (alias 'p')
FROM
    `target_sql.payments` AS p
-- Join payments to orders (alias 'o') to get the purchase timestamp
JOIN
    `target_sql.orders` AS o ON o.order_id = p.order_id
-- Group by payment type and the formatted month
GROUP BY
    p.payment_type,
    month -- Group by alias defined in SELECT
-- Order results chronologically by month, then alphabetically by payment type (case-insensitive)
ORDER BY
    month,
    LOWER(p.payment_type);

-- End of SQL Statement


-- 6.2 Find the no. of orders placed on the basis of the payment installments that have been paid.

-- Select the number of installments and the count of distinct orders
SELECT
    payment_installments,
    -- Count distinct order IDs for each installment number
    COUNT(DISTINCT order_id) AS order_count
-- Specify the source table
FROM
    `target_sql.payments`
-- Exclude records where installments might be 0 (assuming these are not relevant installments)
WHERE
    payment_installments <> 0
-- Group results by the number of payment installments
GROUP BY
    payment_installments
-- Order results by the number of installments in ascending order
ORDER BY
    payment_installments;

-- End of SQL Statement