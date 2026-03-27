/*
Question 4: What skills are the top paying for Data Analyst, across all locations?
- Find the average salary associated with each skill for Data Analyst roles
- Focuses on roles with specified salaries
- Why? provides an overview of which skills are lucrative for Data Analysts
    when usued in conjunction with Question 2, it can help Data Analysts to understand which skills are in demand and lucrative.
*/

SELECT
    skills_dim.skills AS skill,
    ROUND(AVG(job_postings_fact.salary_year_avg),2) AS avg_salary
FROM 
    skills_job_dim
LEFT JOIN 
    job_postings_fact ON skills_job_dim.job_id = job_postings_fact.job_id
LEFT JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst' AND
    job_postings_fact.salary_year_avg IS NOT NULL -- SQL AVg automatically ignores NULL values, just making it explicit
GROUP BY
    skill
ORDER BY
    avg_salary DESC
LIMIT 25;

/* 
Here is a breakdown of the top-paying skills for Data Analysts:
Niche/legacy skills (SVN, Solidity) dominate — scarcity drives massive premiums
Infrastructure/DevOps (Terraform, Kafka, Ansible) pays more than pure "data" skills — engineering-adjacent analysts earn more
ML frameworks (PyTorch, TensorFlow) cluster around $120–127k — high supply keeps them lower than anticipated despite the hype (still higher than traditional data analysis skills)

Key-takeaway: For Data Analysts, specializing in niche/legacy skills or engineering-adjacent tools can lead to higher salaries. (Personally, I'll be learning Kafka)

25 top paying skills
[
  {
    "skill": "svn",
    "avg_salary": "400000.00"
  },
  {
    "skill": "solidity",
    "avg_salary": "179000.00"
  },
  {
    "skill": "couchbase",
    "avg_salary": "160515.00"
  },
  {
    "skill": "datarobot",
    "avg_salary": "155485.50"
  },
  {
    "skill": "golang",
    "avg_salary": "155000.00"
  },
  {
    "skill": "mxnet",
    "avg_salary": "149000.00"
  },
  {
    "skill": "dplyr",
    "avg_salary": "147633.33"
  },
  {
    "skill": "vmware",
    "avg_salary": "147500.00"
  },
  {
    "skill": "terraform",
    "avg_salary": "146733.83"
  },
  {
    "skill": "twilio",
    "avg_salary": "138500.00"
  },
  {
    "skill": "gitlab",
    "avg_salary": "134126.00"
  },
  {
    "skill": "kafka",
    "avg_salary": "129999.16"
  },
  {
    "skill": "puppet",
    "avg_salary": "129820.00"
  },
  {
    "skill": "keras",
    "avg_salary": "127013.33"
  },
  {
    "skill": "pytorch",
    "avg_salary": "125226.20"
  },
  {
    "skill": "perl",
    "avg_salary": "124685.75"
  },
  {
    "skill": "ansible",
    "avg_salary": "124370.00"
  },
  {
    "skill": "hugging face",
    "avg_salary": "123950.00"
  },
  {
    "skill": "tensorflow",
    "avg_salary": "120646.83"
  },
  {
    "skill": "cassandra",
    "avg_salary": "118406.68"
  },
  {
    "skill": "notion",
    "avg_salary": "118091.67"
  },
  {
    "skill": "atlassian",
    "avg_salary": "117965.60"
  },
  {
    "skill": "bitbucket",
    "avg_salary": "116711.75"
  },
  {
    "skill": "airflow",
    "avg_salary": "116387.26"
  },
  {
    "skill": "scala",
    "avg_salary": "115479.53"
  }
]
*/