# Introduction
**Exploring the Data Job Market: Insights into Data Analyst Roles** 
 
This project provides a comprehensive analysis of the data job market, with a particular focus on data analyst roles. It examines top-paying positions, the most in-demand skills, and the intersection where high demand meets competitive salaries in the field of data analytics.


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
| Job Title                             | Company Name                | Salary (USD) |
|---------------------------------------|-----------------------------|--------------|
| Data Analyst                          |Mantys                       | 650,000      |
| Director of Analytics                 |Meta                         | 336,500      |
| Associate Director - Data Insights    | AT&T                        | 255,829      |
| Data Analyst, Marketing               |Pinterest Job Advertissements| 232,423      |
| Data Analyst (Hybrid/Remote)          |Uclahealthcareers            | 217,000      |
| Principal Data Analyst (Remote)       |SmartAsset                   | 205,000      |
| Director, Data Analyst - HYBRID       |Inclusively                  | 189,309      |
| Principal Data Analyst, AV Performance|Motional                     | 189,000      |
| Principal Data Analyst                |SmartAsset                   | 186,000      |
| ERM Data Analyst                      |Get It Recruit               | 184,000      |

Here's the breakdown of the top data analyst jobs in 2023:

-**Wide Salary Range:** 
Top 10 paying data analyst roles span from $184,000 to $650,000,
indicating significant salary  potential in the field.

-**Diverse Employers:**
Companies like Mantys, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.

-**Job Title Variety:**
There's a high diversity in job titles, from Data Analyst to Director of Analystics, reflecting varied roles and specialization within data analytics.


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



 ### High Demand Skills

---
This query helped indetify the skills most frequently requeseted in job postings, directing focus to areas with high demand

```sql
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

```
- **SQL and Excel** remains fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.

- **Programming and Visualization Tools** like **Python, Tableau, and Power BI**  are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.

|   Skills     | Demand Count  |
|--------------|---------------|
|    SQL       | 7291          |
|   Excel      | 4611          |
|   Python     | 4330          |
| Tabluea      | 3745          |
| Power BI     | 2609          |

*Table of the demand for the top 5 skills in data analyst job postings*

### Salary Boosting Skills

---
Exploring the average salaries associated with different skills revealed which skills are the highest paying.

```sql

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
    LIMIT 20

```

The breakdown shows the results for the top paying skills for Data Analysts:

- **High Demand for  Big Data & ML Skills:** Top salaries are commanded by analyst skilled in big data technologies (PySpark, Couchbase), machine learning tools (DataRobot, Jupyter), and Python libraries (Pandas, NumPy), reflecting the industry's high
valuation of data processing and predictive modeling capabilities.

- **Software Development & Deployment Profeciency:** Knowledge in development and deployment tools (GitLab, Kurbenetes, Airflow) indicates a lucrative crossover between data analysis and engineering, with a premium on skills that facilitate automation
and efficient data pipeline management.
 

|   Skills     | Avg Salary    |
|--------------|---------------|
|   Pyspark    | 20,8172       |
|   Bitbucket  | 18,9155       |
|   Couchbase  | 16,0515       |
|   Watson     | 16,0515       |
|   Datarobot  | 15,5486       |
|   Gitlab     | 15,4500       |
|   Swift      | 15,3750       |
|   Jupyter    | 15,2777       |
|   Pandas     | 15,1821       |
| Elasticseach | 14,5000       |
|   Golang     | 14,5000       |      
|   Numpy      | 14,3513       |
|   Databricks | 14,1907       |
|   Linux      | 13,6508       |
| Kumbernetes  | 13,2500       |
|   Atlassian  | 13,1162       |
|   Twilio     | 12,7000       |
|   Airflow    | 12,6103       |
| Scikit_learn | 12,5781       |

