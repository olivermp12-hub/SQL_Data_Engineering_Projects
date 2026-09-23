/*
Show the first 10 rows from the job postings table together with the matching company record for each job.
This uses a LEFT JOIN so every job remains in the output, even if there is no matching company.
*/
SELECT
    jpf.*,
    cd.*
FROM
    job_postings_fact AS jpf
LEFT JOIN
    company_dim AS cd
    ON jpf.company_id = cd.company_id   
LIMIT 10;

/*
For each job posting, show the job details along with the company name. 
Use a LEFT JOIN to ensure that all job postings are included, even if there is no 
matching company in the company_dim table.
*/

SELECT 
    jpf.job_id,
    jpf.job_title_short,
    cd.company_id,
    cd.name AS company_name,
    jpf.job_location
FROM
    job_postings_fact AS jpf
LEFT JOIN
    company_dim AS cd
    ON jpf.company_id = cd.company_id   
LIMIT 10;


/*
Return all jobs and all companies, matching them where possible and keeping rows that do not match from either table.
This is useful when you want to see both unmatched jobs and unmatched companies in the same result.
*/
SELECT 
    jpf.job_id,
    jpf.job_title_short,
    cd.company_id,
    cd.name AS company_name,
    jpf.job_location
FROM
    job_postings_fact AS jpf
FULL OUTER JOIN
    company_dim AS cd
    ON jpf.company_id = cd.company_id;


/*
Show the first 10 jobs together with the skills linked to each job.
This joins the job table to the job-skill bridge table and then to the skill lookup table so you can see
 which skills are associated with each job posting.
*/
SELECT 
    jpf.job_id,
    jpf.job_title_short,
    sjd. skill_id,
    sd.skills
FROM
    job_postings_fact AS jpf
LEFT JOIN
    skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
LEFT JOIN
    skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
LIMIT 10;


/*
Show only the jobs that have a matching skill record, and display the skill ID and skill name for each one.
This uses INNER JOIN to exclude jobs or skills that do not have a match in the bridge table or lookup table.
*/
SELECT 
    jpf.job_id,
    jpf.job_title_short,
    sjd.skill_id,
    sd.skills
FROM 
    job_postings_fact AS jpf
INNER JOIN
    skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN
    skills_dim AS sd
    ON sjd.skill_id = sd.skill_id;


    /*
    Find the top 10 companies for job postings. 
    They must have >3000 postings to be included in the results.
    */
    EXPLAIN ANALYZE
    SELECT 
        cd.name AS company_name,
        COUNT(jpf.job_id) AS job_postings_count
    FROM job_postings_fact AS jpf
    LEFT JOIN company_dim AS cd
        ON jpf.company_id = cd.company_id
    WHERE jpf.job_country = 'United States'
    GROUP BY cd.company_id, cd.name
    HAVING COUNT(jpf.job_id) > 3000
    ORDER BY job_postings_count DESC
    LIMIT 10;
