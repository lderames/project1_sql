# Introduction
**Exploring the Data Job Market: Insights into Data Analyst Roles** 
 
This project provides a comprehensive analysis of the data job market, with a particular focus on data analyst roles. It examines top-paying positions, the most in-demand skills, and the intersection where high demand meets competitive salaries in the field of data analytics.
 Datasets:[Download Here](https://drive.google.com/drive/folders/1moeWYoUtUklJO6NJdWo9OV8zWjRn0rjN)

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

Each query for this project aimed at investigating specific aspects of the data analyst job market. Here's how I approached each question:


---

### Top Paying Roles

---
_To identify the highest-paying roles, I filtered data analyst position by average yearly salary
and location, focusing on remote jobs. This query higlights the high opportunities in the field._

```sql
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
```

Here's the breakdown of the top data analyst jobs in 2023:

-**Wide Salary Range:** 
Top 10 paying data analyst roles span from $184,000 to $650,000,
indicating significant salary  potential in the field.

-**Diverse Employers:**
Companies like Mantys, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.

-**Job Title Variety:**
There's a high diversity in job titles, from Data Analyst to Director of Analystics, reflecting varied roles and specialization within data analytics.


| Job Title                             | Company Name                | Salary (USD)  |
|---------------------------------------|-----------------------------|---------------|
| Data Analyst                          |Mantys                       | $650,000      |
| Director of Analytics                 |Meta                         | $336,500      |
| Associate Director - Data Insights    | AT&T                        | $255,829      |
| Data Analyst, Marketing               |Pinterest Job Advertissements| $232,423      |
| Data Analyst (Hybrid/Remote)          |Uclahealthcareers            | $217,000      |
| Principal Data Analyst (Remote)       |SmartAsset                   | $205,000      |
| Director, Data Analyst - HYBRID       |Inclusively                  | $189,309      |
| Principal Data Analyst, AV Performance|Motional                     | $189,000      |
| Principal Data Analyst                |SmartAsset                   | $186,000      |
| ERM Data Analyst                      |Get It Recruit               | $184,000      |

*Table of the companies and data analyst roles that gives the highest salary.*

---

### Required Skills

---

_To determine the essential skills required to secure a high-paying job as a Data Analyst, I filtered skills based on their average yearly salary. 
This analysis highlights the skills associated with the highest earnings, providing valuable insights for career growth._

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

 ### High Demand Skills

---
_This query helped indetify the skills most frequently requeseted in job postings, directing focus to areas with high demand._

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

*Table of the demand for the top 5 skills in data analyst job postings.*

---

### Salary Boosting Skills

---
_Exploring the average salaries associated with different skills revealed which skills are the highest paying._

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
    LIMIT 10

```

The breakdown shows the results for the top paying skills for Data Analysts:

- **High Demand for  Big Data & ML Skills:** Top salaries are commanded by analyst skilled in big data technologies (PySpark, Couchbase), machine learning tools (DataRobot, Jupyter), and Python libraries (Pandas, NumPy), reflecting the industry's high
valuation of data processing and predictive modeling capabilities.

- **Software Development & Deployment Profeciency:** Knowledge in development and deployment tools (GitLab, Kurbenetes, Airflow) indicates a lucrative crossover between data analysis and engineering, with a premium on skills that facilitate automation
and efficient data pipeline management.

-**Cloud Computing Experties:** Familiarity with cloud and data engineering tools (Elasticsearch, Databricks, GCP) underscores the growing importance of cloud-based environments, suggesting that cloud proficiency boosts earning potential in data analytics.
 

|   Skills     | Avg Salary    |
|--------------|---------------|
|   Pyspark    | $20,8172       |
|   Bitbucket  | $18,9155       |
|   Couchbase  | $16,0515       |
|   Watson     | $16,0515       |
|   Datarobot  | $15,5486       |
|   Gitlab     | $15,4500       |
|   Swift      | $15,3750       |
|   Jupyter    | $15,2777       |
|   Pandas     | $15,1821       |
| Elasticseach | $14,5000       |

*Table of the average salary for the top 10 paying skills for data analysts.*

---

### Optimal Learning Path 
---

_By integrating insights from both demand and salary data, this query seeks to identify high-value skills — those that are not only in demand but also command competitive salaries. The goal is to provide a strategic foundation for skill development and career growth._

```sql
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

```

- **High Demand for Big Data & ML Skills:** Python and R remain highly sought-after, with demand counts of 236 and 148, respectively. Despite their popularity, their average salaries—$101,397 for Python and $100,499 for R—suggest that proficiency in these languages is valuable but also widely available. 

- **Cloud Tools and Technologies:** Specialized cloud-based technologies, including Snowflake, Azure, AWS, and BigQuery, exhibit strong demand alongside competitive salaries. This trend underscores the growing importance of cloud platforms and big data technologies in modern data analysis.

- **Business Intelligence & Visualization:** Tableau and Looker play a crucial role in translating data into actionable insights. With demand counts of 230 and 49, respectively, and average salaries of $99,288 and $103,795, their significance in business intelligence and data visualization is evident.

- **Database Technologies:** The persistent demand for expertise in both traditional and NoSQL databases—such as Oracle, SQL Server, and NoSQL—reinforces the need for strong data management skills. Average salaries ranging from $97,786 to $104,534 highlight their continued relevance in the data ecosystem.


| Skill ID | Skill       | Demand Count | Average Salary |
|----------|------------|--------------|---------------|
| 8        | Go         | 27           | $115,320      |
| 234      | Confluence | 11           | $114,210      |
| 97       | Hadoop     | 22           | $113,193      |
| 80       | Snowflake  | 37           | $112,948      |
| 74       | Azure      | 34           | $111,225      |
| 77       | BigQuery   | 13           | $109,654      |
| 76       | AWS        | 32           | $108,317      |
| 4        | Java       | 17           | $106,906      |
| 194      | SSIS       | 12           | $106,683      |
| 233      | Jira       | 20           | $104,918      |


*Table of the most optimal skills for data analyst sorted by salary.*

---


# Conclusions

### Insights


1. **Top-Paying Data Analyst Jobs:** Remote data analyst roles span a wide salary range, with the highest reaching **$650,000**, demonstrating the lucrative opportunities available in the field.  

2. **Key Skills for High-Paying Roles:** Advanced proficiency in **SQL** is a common requirement for top-paying positions, highlighting its critical importance in securing competitive salaries.  

3. **Most In-Demand Skills:** **SQL** stands out as the most sought-after skill among job seekers, reinforcing its central role in data analytics careers.  

4. **Skills with Higher Salaries:** Specialized skills like **SVN** and **Solidity** command higher average salaries, signaling a strong market demand for niche technical expertise.  

5. **Optimal Skills for Career Growth:** **SQL** not only leads in demand but also offers a **high average salary**, making it one of the most valuable skills for data analysts aiming to maximize their market potential.  



