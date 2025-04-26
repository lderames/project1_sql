/* This query provides a detailed analysis of the top in demand skills an applicant should have, 
   helping them identify which skills they should optimize to increase their chances of securing 
   a job as a Data Analyst.
*/



--writing the query using CTE

WITH skills_demand AS (
    SELECT
        skills.skill_id,
        skills.skills,
        COUNT(skills_in_job.job_id) AS demand_count

    FROM job_postings_fact AS job_posting
        INNER JOIN
    skills_job_dim AS skills_in_job
                ON job_posting.job_id = skills_in_job.job_id
        INNER JOIN
            skills_dim AS skills 
                ON skills_in_job.skill_id = skills.skill_id 
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    GROUP BY
        skills.skill_id
    
),


 average_salary AS (
    SELECT
        skills.skill_id,
        skills.skills,
        ROUND(AVG(salary_year_avg),0) AS avg_salary
    FROM 
        job_postings_fact AS job_posting

    INNER JOIN skills_job_dim AS skills_in_job
        ON skills_in_job.job_id = job_posting.job_id
    INNER JOIN skills_dim AS skills
        ON skills.skill_id = skills_in_job.skill_id

    WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    GROUP BY 
        skills.skill_id
  
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM 
    skills_demand
INNER JOIN average_salary
    ON skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 10
ORDER BY
     avg_salary DESC,
    demand_count DESC
    LIMIT 25
   


--rewriting query more concisely

SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg),0) AS avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim
    ON  job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id)  > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25
