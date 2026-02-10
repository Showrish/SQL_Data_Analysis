--- Question: What are the most optimal skills to learn, i.e, that's in high demand and high-paying.

WITH in_demand_skills AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_dim.skills) AS demand_count
    FROM job_postings_fact 
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE
        job_title_short = 'Data Scientist'
        AND
        salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id
), top_paying_skills AS (
    SELECT 
        skills_dim.skill_id,
        ROUND(AVG(salary_year_avg),2) AS salary_per_skill
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Scientist'
        AND
        salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id
)

SELECT 
    in_demand_skills.skill_id,
    in_demand_skills.skills,
    demand_count,
    salary_per_skill
FROM
    in_demand_skills
INNER JOIN top_paying_skills ON in_demand_skills.skill_id = top_paying_skills.skill_id
WHERE demand_count > 10
ORDER BY
    salary_per_skill DESC,
    demand_count DESC
LIMIT 25