
/* This query provides a detailed look at which top skills have the highest salary, 
    helping job seekers understand which skills to develop that align with top salaries
*/


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
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
GROUP BY 
    skills.skills
ORDER BY
    avg_salary DESC 
    LIMIT 10