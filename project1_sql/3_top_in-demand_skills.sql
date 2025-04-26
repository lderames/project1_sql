/*
  This query retrieves the top 5 skills with the highest demand in the job market,
  providing insights into the most valuable skills for job seekers.*/


SELECT
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
     job_location = 'Anywhere'
GROUP BY
    skills.skills
ORDER BY
    demand_count DESC
LIMIT 5




