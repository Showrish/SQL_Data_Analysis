--- MOST IN DEMAND SKILLS FOR DATA SCIENTIST

SELECT 
    skills_dim.skills,
    COUNT(skills_dim.skills)
FROM job_postings_fact 
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    job_title_short = 'Data Scientist'
GROUP BY
    skills_dim.skills
ORDER BY
    COUNT(skills_dim.skills) DESC
LIMIT 10