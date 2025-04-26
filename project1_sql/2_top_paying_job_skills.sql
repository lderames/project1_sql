
/* This query provides a detailed look at which high-paying jobs demand certain skills, 
    helping job seekers understand which skills to develop that align with top salaries
*/



--writing the query using CTE

WITH top_paying_job AS (
    SELECT 
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
      
    FROM 
        job_postings_fact
    LEFT JOIN company_dim
        ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
        LIMIT 10
)

SELECT  top_paying_job.*,
        skills.skills
       

FROM top_paying_job

INNER JOIN skills_job_dim AS skills_in_job
    ON skills_in_job.job_id = top_paying_job.job_id
INNER JOIN skills_dim AS skills
    ON skills.skill_id = skills_in_job.skill_id
ORDER BY
    salary_year_avg DESC











