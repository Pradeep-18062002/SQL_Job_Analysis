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
/*
 Here are the key insights from the top 10 paying skills for Data Analysts and related roles based on the provided dataset:-
 
 1. Top Paying Skills:
 Pyspark and Bitbucket are the highest-paying skills in this dataset, with average salaries above $200,000. This suggests that expertise in data processing (PySpark) and version control systems (Bitbucket) are in high demand and can command premium compensation.
 
 2. Strong Demand for Data Science and AI Tools:
 Watson and Datarobot are also among the top skills, with average salaries ranging from $150,000 to $175,000. These tools are widely used in the field of AI and machine learning, indicating that professionals with expertise in AI tools are highly valued.
 
 3. Cloud Technologies:
 Couchbase (a NoSQL database), along with Watson and Datarobot, highlights the importance of expertise in cloud-based technologies and data solutions, which are growing rapidly in the industry.
 
 4. Familiarity with Collaborative Tools:
 GitLab (a version control system) and Jupyter (a web-based interactive computing environment) are important tools in data analysis and development. These skills also have significant average salaries, indicating that tools promoting collaboration and data analysis (Jupyter) are highly sought after.
 
 5. Data Visualization and Analysis:
 Pandas, a well-known library for data manipulation and analysis, is also in the top 10, suggesting that data analysis and manipulation skills remain fundamental and continue to be rewarded with competitive salaries.
 
 6. Programming Languages:
 Swift and Elasticsearch also appear in the top 10, suggesting that programming skills and the ability to work with technologies that manage and retrieve large datasets (like Elasticsearch) are valuable in the job market.
 
 Conclusion:
 The highest-paying skills in 2023 for Data Analyst roles focus on big data processing, AI, and cloud technologies.
 
 Having expertise in tools like PySpark, Bitbucket, Watson, and Datarobot can significantly boost earning potential.
 
 Collaboration tools (like GitLab and Jupyter) and data manipulation libraries (like Pandas) are still in high demand and crucial to success in this field.
 
 
 */