WITH top_demand_skills AS(
  SELECT skills_dim.skills,
    skills_dim.skill_id,
    count(*) AS skill_demand
  FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
  WHERE job_postings_fact.job_title_short = 'Data Analyst'
    AND job_work_from_home = TRUE
    AND salary_year_avg IS NOT NULL
  GROUP BY skills_dim.skill_id
),
top_paying_skills AS(
  SELECT skills_dim.skills,
    skills_dim.skill_id,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
  FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
  WHERE job_postings_fact.job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
  GROUP BY skills_dim.skill_id
)
SELECT top_paying_skills.skill_id,
  top_paying_skills.skills,
  top_demand_skills.skill_demand,
  top_paying_skills.avg_salary
FROM top_demand_skills
  INNER JOIN top_paying_skills ON top_demand_skills.skill_id = top_paying_skills.skill_id
WHERE skill_demand > 10
ORDER BY avg_salary DESC,
  skill_demand DESC
LIMIT 25;