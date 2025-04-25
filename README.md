# Introduction
**Exploring the Data Job Market: Insights into Data Analyst Roles** 
 
This project provides a comprehensive analysis of the data job market, with a particular focus on data analyst roles. It examines top-paying positions, the most in-demand skills, and the intersection where high demand meets competitive salaries in the field of data analytics.

For the SQL queries, please click the link: (https://github.com/lderames/project1_sql/tree/main/project1_sql)

# Background 

**Key Questions Driving My SQL Analysis**  

Through my SQL queries, I aimed to uncover critical insights about the data analyst job market, focusing on:  

1. **Top-Paying Roles** – Identifying the highest-paying data analyst positions.  
2. **Required Skills** – Determining the essential skills for securing top-paying jobs.  
3. **High-Demand Skills** – Analyzing which skills are most sought after by employers.  
4. **Salary-Boosting Skills** – Exploring which skills are associated with higher salaries.  
5. **Optimal Learning Path** – Understanding the most valuable skills to develop for career advancement.  

# Tools I Used

**Exploring the Data Analyst Job Market: A Technical Deep Dive**  

For my in-depth analysis of the data analyst job market, I leveraged several powerful tools:  

- **SQL** – The backbone of my analysis, enabling efficient database querying and extraction of critical insights.  
- **PostgreSQL** – My database management system of choice, well-suited for handling extensive job posting data.  
- **GitHub** – An essential platform for organizing and sharing SQL scripts, analysis, and findings.  

# The Analysis

Each query for this project aimed at investigating specific aspects of the data analyst job market.
Here's how I approached each question:

### Top Paying Roles
---
To identify the highest-paying roles, I filtered data analyst position by average yearly salary
and location, focusing on remote jobs. This query higlights the high opportunities in the field.

```sql
SELECT 
    job_id,
    job_title,
     name AS company_name,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date

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
```
Here's the breakdown of the top data analyst jobs in 2023:

-**Wide Salary Range:** 
Top 10 paying data analyst roles span from $184,000 to $65,000,
indicating significant salary  potential in the field.

-**Diverse Employers:**
Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showig a broad interest across different industries.

-**Job Title Variety:**
There's a high diversity in job titles, from Data Analyst to Director of Analystics, reflectin varied roles and specialization within data anlytics.

---
### Required Skills
---

To determine the essential skills required to secure a high-paying job as a Data Analyst, I filtered skills based on their average yearly salary. 
This analysis highlights the skills associated with the highest earnings, providing valuable insights for career growth.

```sql
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
    salary_year_avg DESC;
```

**Top Skills to Learn for High-Paying Data Analyst Roles**  

- **Programming Languages** – Proficiency in SQL, Python and R for data manipulation and analysis.  
- **Data Visualization** – Expertise in Tableau, Power BI and Excel for creating insightful visual reports.  
- **Database Management** – Strong knowledge of Azure and AWS for handling large-scale data storage and processing.  

This combination of technical skills plays a crucial role in securing top-tier roles in data analytics.  

---
