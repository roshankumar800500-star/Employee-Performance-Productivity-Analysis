CREATE DATABASE employee_db;
USE employee_db;

DESCRIBE employee;
SELECT*FROM employee;
ALTER TABLE employee
MODIFY COLUMN Hire_Date DATE;  -- ye hmne use kr liya hai

ALTER TABLE employee
MODIFY COLUMN Monthly_Salary INT;  -- ye hmne use kr liya hai

SELECT COUNT(*) AS Total_Employee FROM employee;
SELECT *FROM employee LIMIT 10;
SELECT*FROM employee ORDER BY Employee_ID DESC;

SELECT COUNT(*) AS Total_Columns FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'employee_db'
AND TABLE_NAME = 'employee';

DESCRIBE employee;

SELECT
SUM(Employee_ID IS NULL) AS Employee_ID_Null,
SUM(Department IS NULL) AS Department_Null,
SUM(Gender IS NULL) AS Gender_Null,
SUM(Age IS NULL) AS Age_Null,
SUM(Job_Title IS NULL) AS Job_Title_Null,
SUM(Hire_Date IS NULL) AS Hire_Date_Null,
SUM(Performance_Score IS NULL) AS Performance_Null,
SUM(Monthly_Salary IS NULL) AS Salary_Null,
SUM(Employee_Satisfaction_Score IS NULL) AS Satisfaction_Null
FROM employee;

SELECT Employee_ID, COUNT(*) AS Total
FROM employee
GROUP BY Employee_ID
HAVING COUNT(*) > 1;

SELECT DISTINCT Department FROM employee;
SELECT DISTINCT Job_Title FROM employee ORDER BY Job_Title;
SELECT Gender, COUNT(*) AS Total FROM employee GROUP BY Gender;
SELECT Resigned, COUNT(*) AS Total FROM employee GROUP BY Resigned;
SELECT MIN(Monthly_Salary) AS Minimum_Salary, MAX(Monthly_Salary) AS Maximum_Salary, AVG(Monthly_Salary) AS Average_Salary
FROM employee;

SELECT MIN(Performance_Score) AS Minimum_Performance, MAX(Performance_Score) AS Maximum_Performance,
AVG(Performance_Score) AS Average_Performance FROM employee;

SELECT Department,COUNT(*) AS Total_Employees FROM employee GROUP BY Department ORDER BY Total_Employees DESC;
SELECT Gender,COUNT(*) AS Total FROM employee GROUP BY Gender;
SELECT Job_Title,COUNT(*) AS Total FROM employee GROUP BY Job_Title ORDER BY Total DESC;
SELECT Education_Level,COUNT(*) AS Total FROM employee GROUP BY Education_Level ORDER BY Total DESC;
SELECT ROUND(AVG(Age),2) AS Average_Age FROM employee;

SELECT Department,ROUND(AVG(Monthly_Salary),2) AS Average_Salary FROM employee GROUP BY Department ORDER BY Average_Salary DESC;

SELECT Department,MAX(Monthly_Salary) AS Highest_Salary FROM employee GROUP BY Department ORDER BY Highest_Salary DESC;
SELECT Department,MIN(Monthly_Salary) AS Lowest_Salary FROM employee GROUP BY Department ORDER BY Lowest_Salary DESC;

SELECT Department, SUM(Monthly_Salary) AS Total_Salary FROM employee GROUP BY Department ORDER BY Total_Salary DESC;

SELECT Employee_ID,Department,Monthly_Salary,
CASE
WHEN Monthly_Salary < 5000 THEN 'Low Salary'
WHEN Monthly_Salary BETWEEN 5000 AND 8000 THEN 'Medium Salary'
ELSE 'High Salary'
END AS Salary_Category
FROM employee;

SELECT Department, ROUND(AVG(Performance_Score),2) AS Avg_Performance FROM employee GROUP BY Department ORDER BY Avg_Performance DESC;

SELECT MAX(Performance_Score) AS Highest_Performance FROM employee;

SELECT Employee_ID,Department,Performance_Score FROM employee
WHERE Performance_Score =
(
SELECT MAX(Performance_Score)
FROM employee
);

SELECT Department,ROUND(AVG(Overtime_Hours),2) AS Avg_Overtime FROM employee GROUP BY Department ORDER BY Avg_Overtime DESC; 

SELECT Employee_ID, Department,Overtime_Hours FROM employee ORDER BY Overtime_Hours DESC LIMIT 10;

SELECT Job_Title,ROUND(AVG(Overtime_Hours),2) AS Avg_Overtime FROM employee GROUP BY Job_Title ORDER BY Avg_Overtime DESC;

SELECT Employee_ID,Overtime_Hours,
    CASE
        WHEN Overtime_Hours < 5 THEN 'Low'
        WHEN Overtime_Hours BETWEEN 5 AND 15 THEN 'Medium'
        ELSE 'High'
    END AS Overtime_Category
FROM employee;

SELECT Performance_Score,ROUND(AVG(Overtime_Hours),2) AS Avg_Overtime FROM employee GROUP BY Performance_Score ORDER BY
Performance_Score DESC;

SELECT Department,ROUND(AVG(Employee_Satisfaction_Score),2) AS Avg_Satisfaction FROM employee GROUP BY Department
ORDER BY Avg_Satisfaction DESC;

SELECT Job_Title,ROUND(AVG(Employee_Satisfaction_Score),2) AS Avg_Satisfaction FROM employee GROUP BY Job_Title
ORDER BY Avg_Satisfaction DESC;

SELECT ROUND(AVG(Employee_Satisfaction_Score),2) AS Overall_Satisfaction FROM employee;

SELECT Employee_ID,Employee_Satisfaction_Score,
    CASE
        WHEN Employee_Satisfaction_Score < 2 THEN 'Low'
        WHEN Employee_Satisfaction_Score BETWEEN 2 AND 4 THEN 'Medium'
        ELSE 'High'
    END AS Satisfaction_Level
FROM employee;

SELECT Performance_Score,ROUND(AVG(Employee_Satisfaction_Score),2) AS Avg_Satisfaction FROM employee GROUP BY Performance_Score
ORDER BY Performance_Score DESC;

SELECT Promotions,COUNT(*) AS Total_Employees FROM employee GROUP BY Promotions ORDER BY Promotions DESC;

SELECT Department,SUM(Promotions) AS Total_Promotions FROM employee GROUP BY Department ORDER BY Total_Promotions DESC;
SELECT Department,ROUND(AVG(Promotions),2) AS Avg_Promotions FROM employee GROUP BY Department ORDER BY Avg_Promotions DESC;

SELECT Years_At_Company,ROUND(AVG(Promotions),2) AS Avg_Promotion FROM employee GROUP BY Years_At_Company
ORDER BY Years_At_Company;

SELECT Performance_Score,ROUND(AVG(Promotions),2) AS Avg_Promotion FROM employee GROUP BY Performance_Score
ORDER BY Performance_Score DESC;

SELECT ROUND(AVG(Years_At_Company),2) AS Avg_Experience FROM employee;

SELECT Years_At_Company,COUNT(*) AS Employees FROM employee GROUP BY Years_At_Company ORDER BY Years_At_Company;

SELECT Years_At_Company,ROUND(AVG(Monthly_Salary),2) AS Avg_Salary FROM employee GROUP BY Years_At_Company
ORDER BY Years_At_Company;

SELECT Years_At_Company,ROUND(AVG(Performance_Score),2) AS Avg_Performance FROM employee GROUP BY Years_At_Company
ORDER BY Years_At_Company;

SELECT * FROM employee ORDER BY Years_At_Company DESC LIMIT 10;

SELECT YEAR(Hire_Date) AS Hire_Year,COUNT(*) AS Total_Hires FROM employee GROUP BY YEAR(Hire_Date) ORDER BY Hire_Year;

SELECT MONTH(Hire_Date) AS Hire_Month,COUNT(*) AS Total_Hires FROM employee GROUP BY MONTH(Hire_Date) ORDER BY Hire_Month;

SELECT YEAR(Hire_Date) AS Hire_Year,ROUND(AVG(Monthly_Salary),2) AS Avg_Salary FROM employee GROUP BY YEAR(Hire_Date) ORDER BY Hire_Year;

SELECT YEAR(Hire_Date) AS Hire_Year,ROUND(AVG(Performance_Score),2) AS Avg_Performance FROM employee GROUP BY YEAR(Hire_Date)
ORDER BY Hire_Year;

SELECT Employee_ID,Hire_Date,TIMESTAMPDIFF(YEAR, Hire_Date, CURDATE()) AS Experience FROM employee;

WITH AvgSalary AS
(
SELECT Department,ROUND(AVG(Monthly_Salary),2) AS Avg_Salary FROM employee GROUP BY Department
)

SELECT *FROM AvgSalary ORDER BY Avg_Salary DESC;

WITH AvgSalary AS
(
SELECT Department,AVG(Monthly_Salary) AS Avg_Salary FROM employee GROUP BY Department
)
SELECT *FROM AvgSalary WHERE Avg_Salary > 6400;

WITH AvgPerformance AS
(
SELECT Department,ROUND(AVG(Performance_Score),2) AS Avg_Performance FROM employee GROUP BY Department
)
SELECT *FROM AvgPerformance ORDER BY Avg_Performance DESC;

SELECT Employee_ID,Department,Monthly_Salary,
ROW_NUMBER() OVER(
PARTITION BY Department
ORDER BY Monthly_Salary DESC
) AS Row_Num
FROM employee;

SELECT Employee_ID,Department,Monthly_Salary,
RANK() OVER(PARTITION BY Department ORDER BY Monthly_Salary DESC
) AS Salary_Rank
FROM employee;



SELECT Employee_ID,Department,Monthly_Salary,
DENSE_RANK() OVER (PARTITION BY Department ORDER BY Monthly_Salary DESC
    ) AS Salary_Dense_Rank
FROM employee;

WITH SalaryRank AS
(SELECT Employee_ID,Department,Monthly_Salary,
DENSE_RANK() OVER(PARTITION BY Department ORDER BY Monthly_Salary DESC) AS Rank_No FROM employee
)
SELECT *FROM SalaryRank WHERE Rank_No <= 3;

WITH SalaryRank AS
(
SELECT Employee_ID,Department,Monthly_Salary,
ROW_NUMBER() OVER(PARTITION BY Department ORDER BY Monthly_Salary) AS rn FROM employee
)
SELECT *FROM SalaryRank WHERE rn = 1;

SELECT Employee_ID,Department,Monthly_Salary,
NTILE(4) OVER(ORDER BY Monthly_Salary DESC) AS Salary_Quartile
FROM employee;

SELECT Employee_ID,Department,Monthly_Salary,
LEAD(Monthly_Salary) OVER(ORDER BY Monthly_Salary DESC) AS Next_Salary
FROM employee;

SELECT Employee_ID,Department,Monthly_Salary,
LAG(Monthly_Salary) OVER(ORDER BY Monthly_Salary DESC) AS Previous_Salary
FROM employee;

SELECT Employee_ID,Department,Monthly_Salary,
FIRST_VALUE(Monthly_Salary)
OVER(PARTITION BY Department ORDER BY Monthly_Salary DESC
) AS Highest_Salary_Department
FROM employee;

SELECT Employee_ID,Department,Monthly_Salary,
LAST_VALUE(Monthly_Salary)
OVER(PARTITION BY Department ORDER BY Monthly_Salary DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
) AS Lowest_Salary_Department
FROM employee;

WITH HighestSalary AS
(
SELECT Employee_ID,Department,Monthly_Salary,
ROW_NUMBER() OVER(PARTITION BY Department ORDER BY Monthly_Salary DESC
) AS rn
FROM employee
)
SELECT *FROM HighestSalary WHERE rn = 1;

WITH LowestSalary AS
(
SELECT Employee_ID,Department,Monthly_Salary,
ROW_NUMBER() OVER(PARTITION BY Department ORDER BY Monthly_Salary) AS rn
FROM employee
)
SELECT *FROM LowestSalary WHERE rn = 1;

SELECT Employee_ID,Department,Performance_Score,
DENSE_RANK() OVER(ORDER BY Performance_Score DESC
) AS Performance_Rank
FROM employee;

SELECT Employee_ID,Monthly_Salary,SUM(Monthly_Salary)
OVER(ORDER BY Employee_ID
) AS Running_Total_Salary
FROM employee;

SELECT Employee_ID,Department,Monthly_Salary,AVG(Monthly_Salary)
OVER(PARTITION BY Department
) AS Department_Avg_Salary
FROM employee;