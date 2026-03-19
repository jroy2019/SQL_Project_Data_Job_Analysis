-- Subquery (temporary table)
SELECT *
FROM (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) AS janaury_jobs;

-- CTE (Common Table Expression)
WITH january_jobs AS (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
)
SELECT *
FROM january_jobs;

SELECT *
FROM job_postings_fact  
WHERE 
    job_no_degree_mention = true;

SELECT 
    name AS company_name
FROM company_dim
WHERE(
    company_id IN (
        SELECT 
            company_id
        FROM 
            job_postings_fact
        WHERE 
            job_no_degree_mention = true
    )
)

WITH company_job_count AS (
    SELECT
        COUNT(job_id) AS job_count,
        company_id
    FROM 
        job_postings_fact
    GROUP BY 
        company_id
)

SELECT
    company_dim.name AS company_name,
    company_job_count.job_count
FROM company_dim
LEFT JOIN company_job_count ON company_dim.company_id = company_job_count.company_id
ORDER BY company_job_count.job_count DESC;

-- practise problems
SELECT
    skills
FROM skills_dim;

SELECT
    COUNT(job_postings_fact.job_id) AS skill_count,
    skills_job_dim.skill_id AS skill_id
FROM job_postings_fact
LEFT JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
GROUP BY skills_job_dim.skill_id
ORDER BY skill_count DESC
LIMIT 5;

SELECT
    skills
FROM skills_dim
WHERE skill_id IN (
    SELECT
        skills_job_dim.skill_id
    FROM job_postings_fact
    LEFT JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    GROUP BY skills_job_dim.skill_id
    ORDER BY COUNT(job_postings_fact.job_id) DESC
    LIMIT 5
);

SELECT
    COUNT(*) AS job_count,
    company_id
FROM job_postings_fact
GROUP BY company_id;

WITH company_job_count AS (
    SELECT
        COUNT(*) AS job_count,
        company_id
    FROM job_postings_fact
    GROUP BY company_id
)

SELECT
    company_dim.name AS company_name,
    CASE
        WHEN company_job_count.job_count > 50 THEN 'Large'
        WHEN company_job_count.job_count < 10 THEN 'Small'
        ELSE 'Medium'
    END AS job_posting_volume
FROM company_dim
LEFT JOIN company_job_count ON company_dim.company_id = company_job_count.company_id;

SELECT
    job_id
FROM job_postings_fact
WHERE 
    job_location = 'Anywhere';

WITH remote_jobs AS (
    SELECT
        job_id
    FROM job_postings_fact
    WHERE 
        job_location = 'Anywhere' 
        )

SELECT
    skills_job_dim.skill_id AS skill_id,
    skills_dim.skills AS skill_name,
    COUNT(*) AS skill_count
FROM skills_job_dim
INNER JOIN remote_jobs ON skills_job_dim.job_id = remote_jobs.job_id
LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
GROUP BY skills_job_dim.skill_id, skills_dim.skills
ORDER BY skill_count DESC
LIMIT 5;
