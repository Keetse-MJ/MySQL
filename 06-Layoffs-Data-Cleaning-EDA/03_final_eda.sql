
SELECT*
FROM  layoffs_staging;

-- check the data type if are correct
DESC layoffs_staging;

-- check for unique companies
SELECT DISTINCT company
FROM layoffs_staging;

-- Top 10 companies with the highest total number of total_laid_off

SELECT company ,SUM(total_laid_off) total_num_of_total_laid_off
FROM layoffs_staging
GROUP BY company
ORDER BY 2 DESC
LIMIT 10;


-- Top 10 industry with the highest total number of total_laid_off

SELECT industry ,SUM(total_laid_off) total_num_of_total_laid_off
FROM layoffs_staging
GROUP BY industry
ORDER BY 2 DESC
LIMIT 10;


-- Top 10 country with the highest total number of total_laid_off

SELECT country ,SUM(total_laid_off) total_num_of_total_laid_off
FROM layoffs_staging
GROUP BY country
ORDER BY 2 DESC
LIMIT 10;


-- total number of employees laid off each year, ordered from the year with the highest total layoffs to the lowest.

SELECT YEAR(`date`) AS year ,SUM(total_laid_off) total_num_of_total_laid_off
FROM layoffs_staging
GROUP BY 1
ORDER BY 2 DESC;


-- total number of employees laid off each month, showing both the year and month, and order the results chronologically from oldest to newest.

SELECT SUBSTRING(`date`,1,7) as month
,SUM(total_laid_off) total_num_of_total_laid_off
FROM layoffs_staging
GROUP BY 1 
ORDER BY 1 ;


-- top 10 company stages with the highest total number of employees laid off, ordered from highest to lowest.

SELECT stage ,SUM(total_laid_off) total_num_of_total_laid_off
FROM layoffs_staging
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
;

-- companies where percentage_laid_off is 100%

SELECT company,industry,country,date,
SUM(total_laid_off) total_num_of_total_laid_off
FROM layoffs_staging
WHERE percentage_laid_off = 1
GROUP BY company,industry,country,date
;

-- top 10 companies with the highest funds raised.

SELECT company, SUM(funds_raised) total_funds_raised
FROM layoffs_staging 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;


-- average number of employees laid off for each industry, showing the industry and average, and ordering the results from highest to lowest.
-- Return the top 10 industries.

SELECT AVG(total_laid_off) employees_laid_off ,industry
FROM layoffs_staging 
GROUP BY 2
ORDER BY 1 DESC
LIMIT 10;


-- top 10 companies with the highest number of layoff records.

SELECT company , COUNT(*) highest_number_of_layoff
FROM layoffs_staging
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;


-- top 10 companies with the highest single-record total_laid_off value.

SELECT company ,MAX(total_laid_off) AS highest_total_laid
FROM layoffs_staging
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10 ;


-- companies that appear in at least 5 records ,with the companies having the most records first.

SELECT company ,COUNT(*) records
FROM layoffs_staging
GROUP BY 1
HAVING records >= 5
ORDER BY 2 DESC;


-- the industry and its average number of employees laid off.
-- industries must have  an average above 500, and sort the results from highest to lowest average.


SELECT industry,AVG(total_laid_off) AS average_num_employee_laid_off
FROM layoffs_staging
GROUP BY industry
HAVING average_num_employee_laid_off > 500 
ORDER BY 2 DESC;

-- total number of layoff records for each company stage, but include only stages with at least 20 records
-- Ordered from highest to Lowest

SELECT stage,COUNT(*) total_number_layoff_records
FROM layoffs_staging
GROUP BY stage
HAVING total_number_layoff_records >= 20
ORDER BY 2 DESC;


-- highest single-record number of employees laid off FOR EACH country
-- Ordered from highest to Lowest
-- Include only countries where the highest recorded layoff was greater than 1,000 employees.


SELECT country,MAX(total_laid_off) highest_employee_laid_off
FROM layoffs_staging
GROUP BY country
HAVING highest_employee_laid_off >1000
ORDER BY 2 DESC;


-- the total number of employees laid off for each year, but include only years where the total number of layoffs exceeded 10,000. 
-- Display the year and total layoffs, ordered  from oldest to newest.

SELECT YEAR(`date`) year ,SUM(total_laid_off) total_number_employees_laid_off
FROM layoffs_staging
GROUP BY 1
HAVING total_number_employees_laid_off > 10000
ORDER BY 1 ;


-- number of distinct companies in each industry.
-- Showing only industries with at least 10 distinct companies, 
-- and sort the results from the highest number of companies to the lowest.

SELECT  industry,COUNT(DISTINCT company) AS companies
FROM layoffs_staging
GROUP BY industry
HAVING companies >=10
ORDER BY companies DESC
;

-- number of distinct industries in each country. 
-- showing  only countries with at least 5 distinct industries, and sort the results from the highest number of industries to the lowest.

SELECT 
country,COUNT(DISTINCT industry) AS number_of_industries
FROM layoffs_staging
GROUP BY country
HAVING number_of_industries >=5
ORDER BY 2 DESC
;

-- Total_laid_off of company each year and display top three companies for each year .

WITH getYears AS
 (
	SELECT company,YEAR(date)years,SUM(total_laid_off)sum_of_total_laid_off
	FROM layoffs_staging
	GROUP BY 1,2
),
getYearSummary AS 
(
    SELECT company, years, sum_of_total_laid_off, 
    DENSE_RANK() OVER (PARTITION BY years ORDER BY sum_of_total_laid_off DESC) AS ranking
    FROM getYears
)

SELECT*
FROM getYearSummary
WHERE ranking  <=3 
ORDER BY years ASC, sum_of_total_laid_off DESC;

-- Rolling total layoffs per month


WITH monthsDetails AS
(
	SELECT SUBSTRING(`date`,1,7) as MonthYear,SUM(total_laid_off) AS total_laid_off
	FROM layoffs_staging 
	GROUP BY 1
)
SELECT MonthYear,SUM(total_laid_off) OVER(ORDER BY MonthYear)as rolling_total_laid_off
FROM monthsDetails
ORDER BY MonthYear asc
;



SELECT*
FROM layoffs_staging;

