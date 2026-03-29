
-- inspect payment table

SELECT *
FROM payment
LIMIT 10;

-- total sales per month
SELECT
    EXTRACT(MONTH FROM payment_date) AS month,
    SUM(amount) AS total_sales
FROM 
    payment
GROUP BY 
    month
ORDER BY
    month;

-- dates of first and last records
SELECT
    MIN(payment_date) AS first_date,
    MAX(payment_date) AS last_date
FROM 
    payment; 
-- from 14 feb to 14 may

-- runniong total per customer
WITH customer_payments AS (
    SELECT 
    payment.customer_id,
    customer.first_name AS customer_name,
    SUM(payment.amount) AS monthly_payment,
    EXTRACT(MONTH FROM payment.payment_date) AS month
FROM 
    payment
JOIN customer ON payment.customer_id = customer.customer_id
GROUP BY 
    payment.customer_id,
    month,
    customer.first_name
ORDER BY  
    customer_name,
    month,
    customer_id
)

SELECT
    customer_id,
    customer_name,
    SUM(monthly_payment) OVER (PARTITION BY customer_id ORDER BY month) AS running_total,
    month
FROM 
    customer_payments
ORDER BY 
    customer_name,
    customer_id, 
    month;

-- daily moving average for april (first 12 days)

WITH april_payments AS (
    SELECT
    DATE_TRUNC('day', payment_date) AS payment_day,
    SUM(amount) AS daily_total
FROM
    payment
WHERE 
    EXTRACT(MONTH FROM payment_date) = 4 AND
    EXTRACT(DAY FROM payment_date) < 13
GROUP BY
    DATE_TRUNC('day', payment_date)
    ORDER BY
    payment_day
)

SELECT
    EXTRACT(DAY FROM payment_day) AS day,
    daily_total,
    CASE 
        WHEN ROW_NUMBER() OVER (ORDER BY payment_day) >= 7 
        THEN AVG(daily_total) OVER (
            ORDER BY payment_day 
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)
    ELSE
        NULL
    END AS moving_average
FROM
    april_payments
ORDER BY
    payment_day;

