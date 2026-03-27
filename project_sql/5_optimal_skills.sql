/*
Question 5: What is the most optimal skills to learn based of demand and pay?
Count the number of times skills has been mentioned in Data Analyst (change as recquired) job postings like in Question 3
Combine this with analysis from Question 4 whewre we found average salary of each skill
- Why? helps Data Analysts to identify which skills are both in demand and lucrative,
    guiding their learning priorities.
*/

-- troubleshooting duplicate keys for sas (skill_id = 186 and 7)
DELETE FROM 
    skills_job_dim 
WHERE 
    skill_id = 186;
DELETE FROM 
    skills_dim 
WHERE 
    skill_id = 186;

-- order by number of postings
SELECT 
    skills_dim.skill_id,
    skills_dim.skills AS skill,
    ROUND(AVG(job_postings_fact.salary_year_avg), 2) AS avg_salary,
    COUNT(*) AS number_of_postings
FROM
    skills_job_dim
INNER JOIN job_postings_fact ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst' AND
    job_postings_fact.salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skill_id,
    skills_dim.skills       
ORDER BY
    number_of_postings DESC,
    avg_salary DESC
LIMIT 10;

/*  
Here is a breakdown of optimal skills based on above query:
SQL dominates demand with 3,083 postings and a solid $96k avg salary — the clearest "learn this first" skill for Data Analysts.
Python and R punch above their weight — both have strong demand and are among the highest paying ($101k and $98k respectively), making them the best ROI after SQL.
Office tools (Excel, Word, PowerPoint) are high demand but lower pay — useful to have, but shouldn't be a learning priority if salary growth is the goal.

[
  {
    "skill_id": 0,
    "skill": "sql",
    "avg_salary": "96435.33",
    "number_of_postings": "3083"
  },
  {
    "skill_id": 181,
    "skill": "excel",
    "avg_salary": "86418.90",
    "number_of_postings": "2143"
  },
  {
    "skill_id": 1,
    "skill": "python",
    "avg_salary": "101511.85",
    "number_of_postings": "1840"
  },
  {
    "skill_id": 182,
    "skill": "tableau",
    "avg_salary": "97978.08",
    "number_of_postings": "1659"
  },
  {
    "skill_id": 5,
    "skill": "r",
    "avg_salary": "98707.80",
    "number_of_postings": "1073"
  },
  {
    "skill_id": 183,
    "skill": "power bi",
    "avg_salary": "92323.60",
    "number_of_postings": "1044"
  },
  {
    "skill_id": 188,
    "skill": "word",
    "avg_salary": "82940.76",
    "number_of_postings": "527"
  },
  {
    "skill_id": 196,
    "skill": "powerpoint",
    "avg_salary": "88315.61",
    "number_of_postings": "524"
  },
  {
    "skill_id": 7,
    "skill": "sas",
    "avg_salary": "93707.36",
    "number_of_postings": "500"
  },
  {
    "skill_id": 61,
    "skill": "sql server",
    "avg_salary": "96191.42",
    "number_of_postings": "336"
  }
]
*/


-- order by salary
SELECT 
    skills_dim.skill_id,
    skills_dim.skills AS skill,
    ROUND(AVG(job_postings_fact.salary_year_avg), 2) AS avg_salary,
    COUNT(*) AS number_of_postings
FROM
    skills_job_dim
INNER JOIN job_postings_fact ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst' AND
    job_postings_fact.salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skill_id,
    skills_dim.skills
HAVING
    COUNT(*) > 10          -- use HAVING to filter by aggregates (can't do it WHERE because of order of execution on SQL) 
ORDER BY
    avg_salary DESC,
    number_of_postings DESC
LIMIT 10;

/* 
Here is a breakdown of optimal skills based on above query:
High salaries cluster around niche/technical skills — ML tools (PyTorch, TensorFlow), data engineering (Kafka, Airflow, Scala), and infrastructure (Linux, Cassandra) all pay $114k+, but demand is low (11-71 postings vs SQL's 3,083), so these are specialist skills, not entry points.
The sweet spot for job seekers is the middle ground — skills like Python and Tableau from the demand list offer strong salaries and meaningful demand, making them more strategically valuable.

[
  {
    "skill_id": 98,
    "skill": "kafka",
    "avg_salary": "129999.16",
    "number_of_postings": "40"
  },
  {
    "skill_id": 101,
    "skill": "pytorch",
    "avg_salary": "125226.20",
    "number_of_postings": "20"
  },
  {
    "skill_id": 31,
    "skill": "perl",
    "avg_salary": "124685.75",
    "number_of_postings": "20"
  },
  {
    "skill_id": 99,
    "skill": "tensorflow",
    "avg_salary": "120646.83",
    "number_of_postings": "24"
  },
  {
    "skill_id": 63,
    "skill": "cassandra",
    "avg_salary": "118406.68",
    "number_of_postings": "11"
  },
  {
    "skill_id": 219,
    "skill": "atlassian",
    "avg_salary": "117965.60",
    "number_of_postings": "15"
  },
  {
    "skill_id": 96,
    "skill": "airflow",
    "avg_salary": "116387.26",
    "number_of_postings": "71"
  },
  {
    "skill_id": 3,
    "skill": "scala",
    "avg_salary": "115479.53",
    "number_of_postings": "59"
  },
  {
    "skill_id": 169,
    "skill": "linux",
    "avg_salary": "114883.20",
    "number_of_postings": "58"
  },
  {
    "skill_id": 234,
    "skill": "confluence",
    "avg_salary": "114153.12",
    "number_of_postings": "62"
  }
]
*/