
-- This query offers insights for job seeker that highlights the top-paying opportunities for Data Analyst that are available remotely.


SELECT 
    job_title,
     name AS company_name,
    salary_year_avg

FROM 
    job_postings_fact
LEFT JOIN company_dim
    ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
    LIMIT 10


