# DATA CLEANING PROCESS

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

#1.REMOVE DUPLICATES  

-- Results: 0 rows returned.
-- No exact duplicate records were identified using row_num.
-- Therefore, no duplicate records needed to be removed.

SELECT*
FROM layoffs_staging
WHERE row_num > 1;

#2. STANDARDIZE DATA

#2.1
-- Investigate company names that may refer to the same company.
-- Some names appear similar, but there is insufficient evidence to confirm that they refer to the same company.
-- Therefore, the names will remain unchanged unless further reliable information becomes available.

SELECT DISTINCT company ,location
FROM layoffs_staging
ORDER BY  company;

#2.2
-- Investigate industry names that may mean one thing but written different 
-- Because of insufficient  information available they will be no change in industry names
SELECT DISTINCT industry
FROM layoffs_staging
ORDER BY industry;

# 2.3
-- company: 10 values appear to have leading or trailing spaces.
SELECT DISTINCT company
FROM layoffs_staging
WHERE company != TRIM(company) OR
company REGEXP '^[[:punct:]]|[[:punct:]]$';
;

-- after doing investigation found out that 10 values that has whitespaces and whitespaces needs to be removed

UPDATE layoffs_staging
SET company = TRIM(company)
WHERE company != TRIM(company);

-- After doing investigation found that 5 has special characters/punctuation marks 
-- and then found there's no need to change them cause that might be part of naming and also the was not enough proof


# 2.4
-- Investigation they were 139 rows returned that ends with "."
-- After investigation and finding that there's insufficient proof 
-- to show that data has causes inconsistency soo  will leave everything as is it 
SELECT DISTINCT location
FROM layoffs_staging
WHERE location REGEXP '[.]$'
ORDER BY location;

#2.5

SELECT DISTINCT source
FROM layoffs_staging
WHERE source != TRIM(source)
;

-- After investigation found that they are 2 source values appear to have leading or trailing whitespaces soo that needs to be cleaned

UPDATE layoffs_staging
SET source =TRIM(source)
WHERE source != TRIM(source);

-- I also investigated and found that 1717 source values ends with / 
-- and that is insufficient evidence that can make decision to make changes to  the data 
SELECT DISTINCT source
FROM layoffs_staging
WHERE  source REGEXP '^[[:punct:]]|[[:punct:]]$';


# 2.6 Changing  column(s) data types 

 UPDATE layoffs_staging
 SET `date` = STR_TO_DATE(`date`,'%m/%d/%Y');
 ALTER TABLE layoffs_staging
 MODIFY `date` DATE;
 
 UPDATE layoffs_staging
 SET date_added = STR_TO_DATE(`date_added`,'%m/%d/%Y');
 ALTER TABLE layoffs_staging
 MODIFY date_added  DATE;


 UPDATE layoffs_staging
SET percentage_laid_off = NULL
WHERE percentage_laid_off ='' OR  TRIM(percentage_laid_off)='';

UPDATE layoffs_staging
SET percentage_laid_off = CONVERT(percentage_laid_off,DECIMAL(10,2))
WHERE percentage_laid_off IS NOT NULL;

ALTER TABLE layoffs_staging
MODIFY COLUMN percentage_laid_off DECIMAL(10,2);


UPDATE layoffs_staging
SET total_laid_off = NULL
WHERE total_laid_off='' OR TRIM(total_laid_off)='';

UPDATE layoffs_staging
SET total_laid_off = CONVERT(total_laid_off ,DECIMAL(10,1))
WHERE total_laid_ofF IS NOT NULL;

ALTER TABLE layoffS_staging
MODIFY COLUMN total_laid_off DECIMAL (10,1);

ALTER TABLE layoffS_staging
MODIFY COLUMN total_laid_off INT ;


DESC  layoffs_staging;


#3. NULL OR BLANK VALUES 

######
-- Finding no company value found that is null or blank
SELECT COUNT(*) AS missing_company
FROM layoffs_staging
WHERE company IS NULL
   OR TRIM(company) = '';
   
#####
-- Finding :no location value found that is null or blank
SELECT COUNT(*) AS missing_location
FROM layoffs_staging
WHERE location IS NULL
   OR TRIM(location) = '';
   
   
#####
-- Finding : They are 1375 records of total_laid_off that are null and that needs to be investigated
SELECT COUNT(*) AS missing_total_laid_off
FROM layoffs_staging
WHERE total_laid_off IS NULL;
-- Based on investigation it showed that the is no enough information that help us decide or find value of the total_laid_off 
-- In conclusion nothing is going to be changed 
SELECT*
FROM layoffs_staging
;

######
-- Finding : none of date value was found  NULL
SELECT COUNT(*) AS missing_date
FROM layoffs_staging
WHERE date IS NULL ;

######
-- Finding : They are 1501 records of percentage_laid_off that are NULL and that needs to be investigated 
SELECT COUNT(*) AS missing_percentage_laid_off
FROM layoffs_staging
WHERE percentage_laid_off IS NULL
;
-- After investigation found that there's no enough information that will help determine value of percentage_laid_off that are currently NULL
-- Therefore  with that insufficient information  will leave the NULL values as it is 
SELECT company,location ,percentage_laid_off,total_laid_off
FROM  layoffs_staging
;


#######
-- Finding : They is 1 record of industry that was found null or empty
SELECT COUNT(*) AS missing_industry
FROM layoffs_staging
WHERE industry IS NULL
   OR TRIM(industry) = '';

-- The industry that is empty  is for  the company Appsmith,location:SF Bay Area
SELECT DISTINCT company,location,industry
FROM layoffs_staging
WHERE industry IS NULL OR TRIM(industry) = ''
;
-- After investigation found out that there's no enough invidence that will help determine value of the industry
SELECT*
FROM layoffs_staging;
;

#######

-- Finding : They are 3 records of source that are  EMPTY and that needs to be investigated 

SELECT COUNT(*) AS missing_source
FROM layoffs_staging
WHERE source IS NULL
   OR TRIM(source) = '';
   
SELECT *
FROM layoffs_staging
WHERE source IS NULL
   OR TRIM(source) = '';
-- Afetr doing investigation and found there's no enough information that can help us determine source
-- In conclusion will leave the value as empty like it is
SELECT *
FROM layoffs_staging
;


########

-- Finding : They is 1 records of stage that was found null or empty

SELECT COUNT(*) AS missing_stage
FROM layoffs_staging
WHERE stage IS NULL
   OR TRIM(stage) = '';

-- The company that the stage is empty is Zapp and Location is London,Non-US.
SELECT company,location ,stage
FROM layoffs_staging
WHERE stage IS NULL
   OR TRIM(stage) = '';

-- After some investigation I found that companies that have same company name, location name they also have the same stage name
SELECT company,location ,stage
FROM layoffs_staging;

-- have to check  how many record the Zapp company has soo that might help us get the stage value
-- And the was a record of Zapp company found and the stage is Series B 
SELECT company,location ,stage
FROM layoffs_staging
WHERE company="Zapp";

SELECT DISTINCT  stage
FROM layoffs_staging
WHERE  stage !="" AND company = 'Zapp'
;


UPDATE layoffs_staging
SET stage =(
			SELECT stage
            FROM (
                   SELECT DISTINCT  stage
					FROM layoffs_staging
					WHERE  stage !="" AND company = 'Zapp'
				) AS agg_table
           )
WHERE company = 'Zapp';



-- check if the update worked
SELECT COUNT(*) AS missing_stage
FROM layoffs_staging
WHERE stage IS NULL
   OR TRIM(stage) = '';
#And the details have been updated successfully
SELECT*
FROM layoffs_staging
WHERE company ="Zapp";



###########

-- Finding no funds_raised value was found null 
SELECT COUNT(*) AS missing_funds_raised
FROM layoffs_staging
WHERE funds_raised IS NULL;


#########

-- Finding no date_added  value was found NULL
SELECT COUNT(*) AS missing_date_added
FROM layoffs_staging
WHERE date_added IS NULL
  ;

#######
-- Finding : They is 1 record of country that was found null or empty
SELECT COUNT(*) AS missing_country
FROM layoffs_staging
WHERE country IS NULL
   OR TRIM(country) = '';

-- The country that is empty it has location of 'Montreal, Non-U.S.'
SELECT*
FROM layoffs_staging
WHERE country IS NULL 
OR TRIM(country) = '';

-- I did investigation and found that the same location also have the same country

SELECT location,country
FROM layoffs_staging
ORDER BY location;

SELECT DISTINCT location,country
FROM layoffs_staging
WHERE location = 'Montreal, Non-U.S.';

-- Based on investigation then we have to update the empty country and give it a value

UPDATE layoffs_staging
SET country = (   SELECT country
				  FROM (
					SELECT DISTINCT country
					FROM layoffs_staging
					WHERE location = 'Montreal, Non-U.S.' AND country !=""
                    ) AS temp
                    )
WHERE location = 'Montreal, Non-U.S.'
;



# check if the update was successful
SELECT COUNT(*) AS missing_country
FROM layoffs_staging
WHERE country IS NULL
   OR TRIM(country) = '';
   

SELECT location,country
FROM layoffs_staging
WHERE location = 'Montreal, Non-U.S.'; 
   


#4. REMOVE COLUMN OR ROW THAT ARE NOT NECESSARY

-- The row_num column is not necessary since wanted to use it to determine the duplicates

ALTER TABLE layoffs_staging
DROP COLUMN row_num;


DESC  layoffs_staging;
SELECT*
FROM  layoffs_staging
;

