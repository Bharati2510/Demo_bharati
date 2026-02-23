select * from hospital ;

ALTER TABLE hospital 
RENAME COLUMN `Patients Count` TO patients_count;

ALTER TABLE hospital 
RENAME COLUMN `Hospital Name` TO Hospital_Name;

ALTER TABLE hospital 
RENAME COLUMN `Medical Expenses` TO Medical_Expenses;


ALTER TABLE hospital 
RENAME column `Admission Date` TO Admission_Date;


ALTER TABLE hospital 
RENAME column `Discharge Date` TO Discharge_Date;


ALTER TABLE hospital 
RENAME column `Doctors Count` TO Doctors_Count;

#1 Total Number of Patients
  #Write an SQL query to find the total number of patients across all hospitals.
select sum(patients_count) as total_patients
from hospital  ;

#2Average Number of Doctors per Hospital
#Retrieve the average count of doctors available in each hospital.

select hospital_name,avg(doctors_count) as avg_doctors
from hospital 
group by hospital_name ;

#Top 3 Departments with the Highest Number of Patients
#Find the top 3 hospital departments that have the highest number of patients.

select department,sum(patients_count)as total_patients
from hospital 
group by department 
order by total_patients desc
limit 3;


#4Hospital with the Maximum Medical Expenses
#Identify the hospital that recorded the highest medical expenses.
 
select hospital_name,max(medical_expenses)as max_expenses
from hospital 
group by hospital_name
order by max_expenses desc
limit 1;

#5Daily Average Medical Expenses
#Calculate the average medical expenses per day for each hospital.
select hospital_name,admission_date,avg(medical_expenses)as avg_expenses
from hospital 
group by hospital_name,admission_date
order by hospital_name,admission_date;

#6Longest Hospital Stay
#Find the patient with the longest stay by calculating the difference between Discharge Date and Admission Date.

SELECT hospital_name,department,patients_count,
       DATEDIFF(
           STR_TO_DATE(discharge_date,'%d-%m-%Y'),
           STR_TO_DATE(admission_date,'%d-%m-%Y')
       ) AS longest_stay
FROM hospital
WHERE STR_TO_DATE (discharge_date,'%d-%m-%Y') IS NOT NULL
  AND STR_TO_DATE(admission_date,'%d-%m-%Y') IS NOT NULL
ORDER BY longest_stay DESC
LIMIT 1;

#7.Total Patients Treated Per City
#Count the total number of patients treated in each city.
select * from hospital ;

SELECT location,SUM(patients_count) AS total_patients
FROM hospital
GROUP BY location
ORDER BY total_patients DESC;

#8.Average Length of Stay Per Department
#Calculate the average number of days patients spend in each department.

UPDATE hospital
SET admission_date  = STR_TO_DATE(admission_date,'%d-%m-%Y')
WHERE admission_date IS NOT NULL
  AND STR_TO_DATE(admission_date,'%d-%m-%Y') IS NOT NULL;

UPDATE hospital
SET discharge_date  = STR_TO_DATE(discharge_date,'%d-%m-%Y')
WHERE discharge_date IS NOT NULL
  AND STR_TO_DATE(discharge_date,'%d-%m-%Y') IS NOT NULL;

SELECT department,AVG(DATEDIFF(discharge_date, admission_date)) AS avg_stay_days
FROM hospital 
where discharge_date >= admission_date
GROUP BY department
ORDER BY avg_stay_days DESC;


#9.Identify the Department with the Lowest Number of Patients
#Find the department with the least number of patients.

SELECT department,SUM(patients_count) AS total_patients
FROM hospital
GROUP BY department
ORDER BY total_patients ASC
LIMIT 1;

#10.Monthly Medical Expenses Report
#Group the data by month and calculate the total medical expenses for each month.

SELECT 
MONTH(admission_date) AS month,
SUM(medical_expenses) AS total_medical_expenses
FROM hospital
GROUP BY MONTH(admission_date)
ORDER BY  month;
       