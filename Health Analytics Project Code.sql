CREATE DATABASE healthdata;
USE healthdata;

-- 1. Count & Pct F vs M that have OCD & -- Average Obsession Score by Gender
with data as(
SELECT

Gender,
count(`Patient ID`) as patient_count,
round(avg(`Y-BOCS Score (Obsessions)`),2) as avg_obs_score

FROM healthdata.ocd_patient_dataset
Group By 1
Order by 2
)

SELECT 
sum(case when Gender = 'Female' then patient_count else 0 end) as count_female,
sum(case when Gender = 'Male' then patient_count else 0 end) as count_male,

round(sum(case when Gender = 'Female' then patient_count else 0 end)/
(sum(case when Gender = 'Female' then patient_count else 0 end)+sum(case when Gender = 'Male' then patient_count else 0 end)) *100,2)
as pct_female,

round(sum(case when Gender = 'Male' then patient_count else 0 end)/
(sum(case when Gender = 'Female' then patient_count else 0 end)+sum(case when Gender = 'Male' then patient_count else 0 end)) *100,2)
as pct_male

FROM data
;

-- 2. Count of Patients by Ethnicity and thier respective Average Obsession Score

SELECT
  Ethnicity,
  count(`Patient ID`) as patient_count,
  avg(`Y-BOCS Score (Obsessions)`) as obs_score
FROM healthdata.ocd_patient_dataset
group by 1
Order by 2;



-- 3. Number of people diagnosed with OCD per month

alter table healthdata.ocd_patient_dataset
modify `OCD Diagnosis Date` date;

select
date_format(`OCD Diagnosis Date`, '%Y-%m-01 00:00:00') as month,
-- `OCD Diagnosis Date`
 count(`Patient ID`) patient_count
 from healthdata.ocd_patient_dataset
 group by 1
 order by 1
 ;
 
-- 4. What is the most common Obsession Type (Count) & it's respective Average Obesession Score

SELECT
`Obsession Type`,
count(`Patient ID`) as patient_count,
round(avg(`Y-BOCS Score (Obsessions)`),2) as obs_score
from healthdata.ocd_patient_dataset
group by 1
order by 2
;

-- 5. What is the most common Compulsion type (Count) & it's respective Average Obesession Score

SELECT
`Compulsion Type`,
count(`Patient ID`) as patient_count,
round(avg(`Y-BOCS Score (Obsessions)`),2) as obs_score
from healthdata.ocd_patient_dataset
group by 1
order by 2
;




