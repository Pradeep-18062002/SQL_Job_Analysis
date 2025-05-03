# Introduction

This project analyzes Data Analyst job postings to identify the most in-demand skills and their associated salaries. By comparing skills demand with average salaries, it provides insights into the highest-paying skills, helping professionals target their career growth effectively. Additionally, it highlights remote work opportunities in the field.

Checkout the SQL Queries Used Here: [Project_SQL_Folder](https://github.com/Pradeep-18062002/SQL_Job_Analysis/tree/main/project_sql)

# Background

### The questions I wanted to answer through my SQL queries were:

- What are the top-paying data analyst jobs?

- What skills are required for these top-paying jobs?

- What skills are most in demand for data analysts?

- Which skills are associated with higher salaries?

- What are the most optimal skills to learn?

# Tools I used

For my deep dive into the data analyst job market, I harnessed the power of several key tools:

- **SQL**: The backbone of my analysis, allowing me to query the database and unearth critical insights.

- **PostgreSQL**: The chosen database management system, ideal for handling the job posting data.

- **Visual Studio Code**: My go-to for database management and executing SQL queries.

- **Git & GitHub**: Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis

### 1) Top Paying Data Analyst Jobs

```sql
SELECT job_id,
  job_title,
  job_location,
  job_schedule_type,
  salary_year_avg,
  job_posted_date,
  name AS company_name
FROM job_postings_fact
  LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Analyst'
  AND job_location = 'Anywhere'
  AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;
```

Key Insights:

- Salary Distribution: Salaries vary widely, with some roles offering exceptionally high compensation. This suggests a mix of entry-level and senior positions.

- Top Paying Jobs: The highest paying roles include senior or director-level titles like “Director of Analytics” and “Associate Director - Data Insights.”

- Job Titles vs Salary: Salaries clearly reflect the seniority or specialization of the role—more strategic roles earn significantly more.

- Posting Timeline vs Salary: Higher-paying jobs were posted throughout the year, with no strong seasonal trend, although the latest posts seem to offer more competitive salaries.

![Top-Paying_Jobs](assets\output.png)

### 2) Top Paying Jobs

```sql
WITH top_paying_jobs AS (
  SELECT job_id,
    job_title,
    salary_year_avg,
    name AS company_name
  FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
  WHERE job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere'
    AND salary_year_avg IS NOT NULL
  ORDER BY salary_year_avg DESC
  LIMIT 10
)
SELECT top_paying_jobs.*,
skills
FROM top_paying_jobs
  INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
  INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
  ORDER BY
    salary_year_avg DESC;

```

Here are the insights:

Top In-Demand Skills:
Skills like SQL, Python, and R are among the most frequently listed, highlighting their essential role in data-related jobs.

Highest Paying Skills:
Skills such as AWS, Power BI, and Machine Learning are associated with higher average salaries, suggesting demand for cloud, BI, and AI expertise.

![Skills associated with top paying jobs](assets\hhh.png)

### 3) High Demand Skills

```sql
SELECT skills_dim.skills,
  count(*) AS skill_count
FROM job_postings_fact
  INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
  INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_postings_fact.job_title_short = 'Data Analyst'
  AND job_work_from_home = TRUE
GROUP BY skills_dim.skills
ORDER BY skill_count DESC
LIMIT 5;
```

![High Demand Skills](assets\output3.png)

Here is the Top In-Demand Skills chart:

SQL leads by a large margin with 7,291 job listings, followed by Excel, Python, Tableau, and Power BI.

This confirms that SQL is both highly paid (as seen earlier) and highly demanded, making it a critical skill for professionals in data-related roles.

### 4) Top Paying Skill

```sql
SELECT skills_dim.skills,
  ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
  INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
  INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_postings_fact.job_title_short = 'Data Analyst'
  AND salary_year_avg IS NOT NULL
  AND job_work_from_home = TRUE
GROUP BY skills_dim.skills
ORDER BY avg_salary DESC
LIMIT 25;

```

![Top Paying Skill](assets\bbbb.png)

PySpark, Bitbucket, and Couchbase are among the highest paying, each offering over $150,000+ on average.

This chart gives a clear, ranked view of which skills fetch the best compensation in remote data analyst jobs.

### 5) Optimal skill (Both Demanding and Popular)

```sql
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
```

![Optimal Skill](assets\hvv.png)

# What I Learned

- Gained hands-on experience using SQL to extract insights from relational job market datasets.

- Identified and visualized top-paying and high-demand skills using Python libraries like Pandas, Matplotlib, and Seaborn.

- Developed a deeper understanding of how to combine salary trends with skill demand to determine optimal career growth opportunities.

# Conclusion

This project provided valuable insights into the intersection of skill demand and salary trends for remote Data Analyst roles. By leveraging SQL for data extraction and Python for visualization, I was able to identify optimal skills that are both highly paid and widely sought after in the job market. These findings can guide professionals in prioritizing skill development to maximize career growth and compensation potential.
