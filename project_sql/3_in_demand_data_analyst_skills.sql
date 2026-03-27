/*
Question 3: What are the most in-demand skills for data analysts?
- Filter the job postings to include only those for data analyst positions (change the job title filter as needed) across all locations.
- Aggregate skills from job descriptions and count their occurrences.
- List the top 10 most frequently mentioned skills in data analyst job postings.
    helping you to identify the common skills that employers acrooss data analyst roles, which can guide your learning and career development efforts.
*/

SELECT 
    skills_dim.skills AS skill,
    COUNT(*) AS skill_count
FROM
    skills_job_dim
LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_id IN
    (SELECT 
        job_id
     FROM
        job_postings_fact
     WHERE
        job_title_short = 'Data Analyst')
GROUP BY
    skill
ORDER BY
    skill_count DESC
LIMIT 10;

/*
Here is a breakdown of the 10 most in-demand skills for data analysts in 2023:
SQL is the leading skill with a count of 92,628 (25,597 counts higher than second-place).
Excel is still very popular with a count of 67,031 and holding the second place.
However, programming languages like Python (57,326 counts) and R (30,075 counts) are also in top 10 in demand skills (likely going to become more popular in future)
Data visualisation tools like Tableau (46,554 counts) and Power BI (39,468 counts) are also highly sought after.
PowerPoint and Word are also in the top 10, likely because of the need to present
Business specific tools like sas (28,068 counts) and sap (11,297 counts) are also in demand.

Skill count top 10 data analyst skills
[
  {
    "skill": "sql",
    "skill_count": "92628"
  },
  {
    "skill": "excel",
    "skill_count": "67031"
  },
  {
    "skill": "python", 
    "skill_count": "57326"
  },
  {
    "skill": "tableau",
    "skill_count": "46554"
  },
  {
    "skill": "power bi",
    "skill_count": "39468"
  },
  {
    "skill": "r",
    "skill_count": "30075"
  },
  {
    "skill": "sas",
    "skill_count": "28068"
  },
  {
    "skill": "powerpoint",
    "skill_count": "13848"
  },
  {
    "skill": "word",
    "skill_count": "13591"
  },
  {
    "skill": "sap",
    "skill_count": "11297"
  }
]
*/