-- purpose is to create bins (high med, low salary) based on existing features and stratifying based on feature values
SELECT 
    job_title_short AS job_title,
    job_location AS location,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location LIKE '%Australia%' OR job_location LIKE '%New Zealand%' THEN 'Local'
        ELSE 'Not applicable'
    END AS location_category
FROM job_postings_fact;

SELECT 
    COUNT(job_id) AS job_count,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location LIKE '%Australia%' OR job_location LIKE '%New Zealand%' THEN 'Local'
        ELSE 'Not applicable'
    END AS location_category
FROM job_postings_fact
WHERE 
    job_title_short In ('Data Analyst', 'Data Scientist', 'Data Engineer')
GROUP BY 
    location_category
ORDER BY 
    job_count DESC;

SELECT
    COUNT(job_id) AS job_count,
    CASE
        WHEN salary_year_avg >= 100000 THEN 'High Salary'
        WHEN salary_year_avg >= 50000 AND salary_year_avg < 100000 THEN 'Medium Salary'
        WHEN salary_year_avg < 50000 THEN 'Low Salary'
        ELSE 'Yearly salary not provided'
    END AS salary_category
FROM job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    salary_category
ORDER BY
    job_count DESC;

    
