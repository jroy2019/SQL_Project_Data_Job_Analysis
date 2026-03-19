SELECT
    job_title_short AS job_title,
    company_id,
    job_location
FROM january_jobs

UNION -- removes duplicates

SELECT
    job_title_short AS job_title,
    company_id,
    job_location
FROM february_jobs

UNION
SELECT
    job_title_short AS job_title,
    company_id,
    job_location
FROM march_jobs;

SELECT
    job_title_short AS job_title,
    company_id,
    job_location
FROM january_jobs

UNION ALL-- keeps duplicates

SELECT
    job_title_short AS job_title,
    company_id,
    job_location
FROM february_jobs

UNION ALL
SELECT
    job_title_short AS job_title,
    company_id,
    job_location
FROM march_jobs;

SELECT
    january_jobs.job_title_short AS job_title,
    skills_dim.skills AS skill,
    skills_dim.type AS skill_type
FROM january_jobs
LEFT JOIN skills_job_dim ON january_jobs.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE january_jobs.salary_year_avg > 70000

UNION ALL

SELECT
    february_jobs.job_title_short AS job_title,
    skills_dim.skills AS skill,
    skills_dim.type AS skill_type
FROM february_jobs
LEFT JOIN skills_job_dim ON february_jobs.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE february_jobs.salary_year_avg > 70000
UNION ALL

SELECT
    march_jobs.job_title_short AS job_title,
    skills_dim.skills AS skill,
    skills_dim.type AS skill_type
FROM march_jobs
LEFT JOIN skills_job_dim ON march_jobs.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE march_jobs.salary_year_avg > 70000;

SELECT 
    job_title_short AS job_title,
    salary_year_avg AS salary,
    job_location,
    job_via,
    job_posted_date::DATE AS job_posted_date
FROM (
    SELECT *
    FROM january_jobs

    UNION ALL
    SELECT *
    FROM february_jobs

    UNION ALL
    SELECT *
    FROM march_jobs
) AS q1_jobs
WHERE salary_year_avg > 70000 AND job_title_short = 'Data Analyst'
ORDER BY salary_year_avg DESC;

SELECT 
    q1_jobs.job_title_short AS job_title,
    q1_jobs.salary_year_avg AS salary,
    skills_dim.skills AS skill,
    skills_dim.type AS skill_type
FROM (
    SELECT *
    FROM january_jobs

    UNION ALL
    SELECT *
    FROM february_jobs

    UNION ALL
    SELECT *
    FROM march_jobs
) AS q1_jobs
LEFT JOIN skills_job_dim ON q1_jobs.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE q1_jobs.salary_year_avg > 70000
ORDER BY q1_jobs.salary_year_avg DESC