/*
Question: What are the most in-demand skills for data engineers?
-Identify the top 10 most in-demand skills for data engineers
-Focus on remote job postings
-Why?
-Retrieve the top 10 skills with the highest demand in the remote job market,
 providing insights into the most valuable skills for data engineers seeking remote work.
*/

SELECT 
    sd.skills,
    COUNT(jpf.*) AS demand_count
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd 
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd 
    ON sjd.skill_id = sd.skill_id
WHERE 
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_work_from_home = TRUE
GROUP BY 
    sd.skills
ORDER BY 
    demand_count DESC
LIMIT 10;

/*
Here's the breakdown of the most demanded skills for data engineers:
SQL and Python are by far the most in-demand skills, with 38,368 and 38,117 job postings.
Cloud platforms like AWS and Azure are also highly sought after, with 24,514 and 18,707 postings.
Big data technologies like Spark and Airflow are also in high demand, with 17,591 and 13,395 postings.
Snowflake and Databricks are also popular skills, with 11,781 and 10,962 postings.
Java and Kafka are also in demand, with 9,993 and 9,315 postings.

Key takeaways:
- SQL and Python are essential skills for data engineers, with a high number of job postings.
- Cloud platforms like AWS and Azure are also important skills to have, as they are in high demand.
- Big data technologies like Spark and Airflow are also valuable skills for data engineers.
- Data pipeline tools like Snowflake, Airflow and Databricks show growing demand
- Java and Kafka round out the top 10 most in-demand skills for data engineers

┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │        38368 │
│ python     │        38117 │
│ aws        │        24514 │
│ azure      │        18707 │
│ spark      │        17591 │
│ airflow    │        13395 │
│ snowflake  │        11781 │
│ databricks │        10962 │
│ java       │         9993 │
│ kafka      │         9315 │
├────────────┴──────────────┤
│ 10 rows         2 columns │
└───────────────────────────┘
*/