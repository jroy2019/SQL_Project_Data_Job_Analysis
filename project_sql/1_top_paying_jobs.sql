/*
Question 1: What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available remotely.
- Filter job postings with specified salaries
- Why? Highlight the top-paying oppurtunities for Data Analysts, offering insights employment oppurtunities.
*/

SELECT
    job_postings_fact.job_id,
    job_postings_fact.job_title,
    job_postings_fact.job_location,
    job_postings_fact.job_schedule_type,
    job_postings_fact.salary_year_avg AS average_yearly_salary,
    job_postings_fact.job_posted_date::DATE AS posted_date,
    company_dim.name AS company_name
FROM 
    job_postings_fact
LEFT JOIN 
    company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
   job_title_short = 'Data Analyst' AND
   job_location LIKE '%Australia%' AND
   salary_year_avg IS NOT NULL
ORDER BY 
    salary_year_avg DESC
LIMIT 10;  