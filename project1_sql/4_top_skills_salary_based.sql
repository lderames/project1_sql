
/* This query provides a detailed look at which top skills have the highest salary, 
    helping job seekers understand which skills to develop that align with top salaries
*/

--writing the query using CTE

WITH top_salary AS (

    SELECT
        job_id,
        ROUND(AVG(salary_year_avg),0) AS avg_salary
    FROM 
        job_postings_fact
    WHERE
        job_title_short = 'Data Analyst' AND
        job_work_from_home = TRUE AND
        salary_year_avg IS NOT NULL
    GROUP BY job_id
    ORDER BY
        avg_salary DESC 
)

SELECT
    skills.skills AS skill_name, 
    top_salary.avg_salary

FROM top_salary

INNER JOIN skills_job_dim AS skills_in_job
    ON skills_in_job.job_id = top_salary.job_id
INNER JOIN skills_dim AS skills
    ON skills.skill_id = skills_in_job.skill_id;


--rewriting query more concisely

SELECT
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
    job_work_from_home = TRUE AND
    salary_year_avg IS NOT NULL
GROUP BY 
    skills.skills
ORDER BY
    avg_salary DESC 