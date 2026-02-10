--- TOP PAYING SKILLS FOR DATA SCIENTIST
SELECT 
    skills,
    ROUND(AVG(salary_year_avg),2) AS salary_per_skill
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Scientist'
    AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    salary_per_skill DESC
LIMIT 10