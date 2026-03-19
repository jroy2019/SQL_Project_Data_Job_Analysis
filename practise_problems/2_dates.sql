-- convert to just date
SELECT 
    job_title_short AS job_title,
    job_location AS location,
    job_posted_date::DATE AS date
FROM job_postings_fact
LIMIT 10;

-- preserve date and time (timestamp)
SELECT 
    job_title_short AS job_title,
    job_location AS location,
    job_posted_date AS date_time
FROM job_postings_fact
LIMIT 10;

-- change time zone (assuming sql does not know original time zone)
SELECT 
    job_title_short AS job_title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time
FROM job_postings_fact
LIMIT 10; 

-- Extract month 
SELECT
    job_title_short AS job_title,
    job_location AS location,
    EXTRACT(MONTH FROM job_posted_date) AS month,
    EXTRACT(YEAR FROM job_posted_date) AS year
FROM job_postings_fact
LIMIT 10;

-- Use in tandem with group-by
SELECT
    COUNT(job_id) AS job_count,
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM job_postings_fact
WHERE 
    job_postings_fact.job_title_short IN ('Data Analyst')
GROUP BY 
    month
ORDER BY 
    month;

-- PRACTICE

-- Where run before selct so if condition recquires a var, must be included in condition
-- only non aggregate when there is group should be the col  you want to group by
SELECT
    job_schedule_type,
    AVG(salary_year_avg) AS avg_salary,
    AVG(salary_hour_avg) AS avg_hourly
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) >= 6
GROUP BY job_schedule_type
ORDER BY avg_salary DESC;

-- ORDER SQL run commands
-- 1. FROM
-- 2. WHERE
-- 3. GROUP BY
-- 4. HAVING
-- 5. SELECT
-- 6. ORDER BY
-- 7. LIMIT

SELECT
    COUNT(job_id) AS job_count,
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS month
FROM job_postings_fact
GROUP BY
    month
ORDER BY
    month;

SELECT
    job_postings_fact.job_id AS job_id,
    company_dim.name AS company_name,
    job_postings_fact.job_health_insurance AS health_insurance
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_postings_fact.job_health_insurance = true AND
    EXTRACT(MONTH FROM job_postings_fact.job_posted_date) IN (4, 5, 6);

SELECT
    COUNT(job_postings_fact.job_id) AS job_count,
    company_dim.name AS company_name
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_postings_fact.job_health_insurance = true AND
    EXTRACT(MONTH FROM job_postings_fact.job_posted_date) IN (4, 5, 6)
GROUP BY
    company_name
ORDER BY
    job_count DESC;