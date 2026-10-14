
CREATE TABLE `layoffs_staging` (
  `company` text,
  `location` text,
  `total_laid_off` text,
  `date` text,
  `percentage_laid_off` text,
  `industry` text,
  `source` text,
  `stage` text,
  `funds_raised` int DEFAULT NULL,
  `country` text,
  `date_added` text,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO layoffs_staging
SELECT*,row_number()OVER(PARTITION BY company,location,total_laid_off,date,percentage_laid_off,industry,source,stage,funds_raised,country,date_added) AS row_num
FROM layoffs;

SELECT*
FROM layoffs_staging;

# It will help us check the data type of the field 
#I have founf that some of the data types are wrong they need to be fixed
DESC layoffs_staging;

# find the number of rows 
SELECT COUNT(*) number_of_rows
FROM layoffs_staging;


#checking if field or column

# no company value was found empty or null
SELECT company
FROM layoffs_staging
WHERE company ="" OR company IS NULL ;


SELECT COUNT(*) AS missing_company
FROM layoffs_staging
WHERE company IS NULL
   OR TRIM(company) = '';

#  no location value was found empty or null
SELECT location
FROM layoffs_staging
WHERE location ="" OR location IS NULL ;

SELECT COUNT(*) AS missing_location
FROM layoffs_staging
WHERE location IS NULL
   OR TRIM(location) = '';

# Results:  1375 values of total_laid_off found empty or null
SELECT total_laid_off
FROM layoffs_staging
WHERE total_laid_off ="" OR total_laid_off IS NULL ;

SELECT COUNT(*) AS missing_total_laid_off
FROM layoffs_staging
WHERE total_laid_off IS NULL
   OR TRIM(total_laid_off) = '';

#No  date value(s) was found empty or null
SELECT date
FROM layoffs_staging
WHERE date ="" OR date IS NULL ;

SELECT COUNT(*) AS missing_date
FROM layoffs_staging
WHERE date IS NULL
   OR TRIM(date) = '';
   
#Results:  1501 values of percentage_laid_off found empty or null
SELECT percentage_laid_off
FROM layoffs_staging
WHERE percentage_laid_off ="" OR percentage_laid_off IS NULL ;

SELECT COUNT(*) AS missing_percentage_laid_off
FROM layoffs_staging
WHERE percentage_laid_off IS NULL
   OR TRIM(percentage_laid_off) = '';
   

#Results:  1 value of industry  was  found empty or null
SELECT industry
FROM layoffs_staging
WHERE industry ="" OR industry IS NULL ;

SELECT COUNT(*) AS missing_industry
FROM layoffs_staging
WHERE industry IS NULL
   OR TRIM(industry) = '';

# Results: 3 values of source were found empty or null
SELECT source
FROM layoffs_staging
WHERE source ="" OR source IS NULL ;

SELECT COUNT(*) AS missing_source
FROM layoffs_staging
WHERE source IS NULL
   OR TRIM(source) = '';
   

# Results: 1 value of stage was found empty or null 
SELECT stage
FROM layoffs_staging
WHERE stage ="" OR stage IS NULL ;

SELECT COUNT(*) AS missing_stage
FROM layoffs_staging
WHERE stage IS NULL
   OR TRIM(stage) = '';
   

#No value  was null or empty 
SELECT funds_raised
FROM layoffs_staging
WHERE  funds_raised IS NULL ;

SELECT COUNT(*) AS missing_funds_raised
FROM layoffs_staging
WHERE funds_raised IS NULL
   ;

#  Results: 1 value of country was found empty or null  
SELECT country
FROM layoffs_staging
WHERE country ="" OR country IS NULL ;

SELECT COUNT(*) AS missing_country
FROM layoffs_staging
WHERE country IS NULL
   OR TRIM(country) = '';
   
#Results: no value of date_added was found empty or null
SELECT date_added
FROM layoffs_staging
WHERE date_added ="" OR date_added IS NULL ;

SELECT COUNT(*) AS missing_date_added
FROM layoffs_staging
WHERE date_added IS NULL
   OR TRIM(date_added) = '';

# checking for company naming .For example:have Automatic,Automation Anywhere,Automattic
# and all are found in same location meaning it might be the same thing and like Babylon and Babylon Health but that need to be investigated further.
SELECT DISTINCT company ,location
FROM layoffs_staging;

# Investigate the industry  cause some of the industry might mean one thing or fall under one thing
SELECT DISTINCT industry
FROM layoffs_staging
ORDER BY industry;

#There's no spelling errors or stage that might mean same thing
SELECT DISTINCT stage
FROM layoffs_staging;

# Just checking if no mispelling of country example having country Ireland and misspelled one Irelan
SELECT  DISTINCT country
FROM layoffs_staging;

#Investigate if there is whitespace before or after company naming or punctuation mark
#Results: 15 results returned
#company: 10 values appear to have leading or trailing spaces.
SELECT DISTINCT company
FROM layoffs_staging
WHERE company != TRIM(company) OR
company REGEXP '^[[:punct:]]|[[:punct:]]$';
;

#Investigate if there is whitespace before or after location naming or punctuation mark
#Results : 139 results returned 
#All location found ends with "."
SELECT DISTINCT location
FROM layoffs_staging
WHERE location != TRIM(location)OR
 location REGEXP '^[[:punct:]]|[[:punct:]]$'
;
#139 results returned.This appears to be a consistent pattern; but I need to investigate further"
SELECT DISTINCT location
FROM layoffs_staging
WHERE location REGEXP '[.]$'
ORDER BY location;

#Investigate if there is whitespace before or after location naming or punctuation marks
#Results : no  results returned 

SELECT industry
FROM layoffs_staging
WHERE industry != TRIM(industry)
OR industry REGEXP '^[[:punct:]]|[[:punct:]]$';
;

#Investigate if there is whitespace before or after source naming or punctuation marks
#Results : 1717  results returned 
#source: 2 distinct values appear to have leading or trailing spaces.
SELECT DISTINCT source
FROM layoffs_staging
WHERE source != TRIM(source)
OR source REGEXP '^[[:punct:]]|[[:punct:]]$';

#Investigate if there is whitespace before or after country naming or punctuation marks
#Results : no  results returned 

SELECT DISTINCT country
FROM layoffs_staging
WHERE country != TRIM(country)
OR country REGEXP '^[[:punct:]]|[[:punct:]]$' ;


# check the maximum ,minimum,average,sum for total_laid_off
#currently total_laid_off is text soo that needs to be fixed since the calculation below might be incorrect
SELECT MIN(total_laid_off) minimum_total_laid_off,
	   MAX(total_laid_off)  maximum_total_laid_off,
	   AVG(total_laid_off) average_total_laid_off,
	   SUM(total_laid_off) sum_of_total_laid_off
FROM layoffs_staging
WHERE total_laid_off !="" AND total_laid_off IS NOT NULL;

# check the maximum ,minimum,average,sum for percentage_laid_off
#currently percentage_laid_off  is text soo that needs to be fixed since the calculation below might be incorrect

SELECT MIN(percentage_laid_off) minimum_per_laid_off,
	   MAX(percentage_laid_off) maximum_per_laid_off,
       AVG(percentage_laid_off) average_per_laid_off,
       SUM(percentage_laid_off) sum_per_laid_off
FROM layoffs_staging
WHERE percentage_laid_off != "" AND percentage_laid_off IS NOT NULL
;

# check the maximum ,minimum,average,sum for funds_raised

SELECT MIN(funds_raised) minimum_funds_raised,
	   MAX(funds_raised) maximum_funds_raised,
       AVG(funds_raised) average_funds_raised,
       SUM(funds_raised) sum_funds_raised
FROM layoffs_staging
WHERE funds_raised != "" AND funds_raised IS NOT NULL
;


#check for duplicates
#No duplicates found 
SELECT*
FROM layoffs_staging
WHERE row_num > 1;



SELECT*
FROM layoffs_staging;

