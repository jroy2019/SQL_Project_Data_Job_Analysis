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

/*
Here is the breakdown for highest paying Data Analyst jobs in Australia from 2023:
Highest paying role is a Data Analyst/Engineer with Perigon Group
Only 4 recorded Data Analyst roles in Australia with annual salalary details.
Data Analyst roles in Australia ranges between $135,0000 - $57,500. 

[
  {
    "job_id": 1039859,
    "job_title": "Data Analyst / Engineer",
    "job_location": "Sydney NSW, Australia",
    "job_schedule_type": "Full-time",
    "average_yearly_salary": "135000.0",
    "posted_date": "2023-06-29",
    "company_name": "Perigon Group"
  },
  {
    "job_id": 897521,
    "job_title": "Data Analyst - Insights",
    "job_location": "Australia",
    "job_schedule_type": "Full-time",
    "average_yearly_salary": "118500.0",
    "posted_date": "2023-11-16",
    "company_name": "DoorDash"
  },
  {
    "job_id": 666919,
    "job_title": "Data Analyst - MarTech",
    "job_location": "Brisbane QLD, Australia",
    "job_schedule_type": "Full-time",
    "average_yearly_salary": "100500.0",
    "posted_date": "2023-07-24",
    "company_name": "Entain"
  },
  {
    "job_id": 597606,
    "job_title": "FM Data Analyst",
    "job_location": "Balcatta WA, Australia",
    "job_schedule_type": "Full-time",
    "average_yearly_salary": "57500.0",
    "posted_date": "2023-07-21",
    "company_name": "Sodexo"
  }
]
*/



