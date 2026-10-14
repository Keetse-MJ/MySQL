# Layoffs Data Cleaning and Exploratory Data Analysis

## Project Overview
This project uses MySQL to clean and analyse company layoffs data. The goal is to prepare the dataset for analysis and identify trends across companies, industries, countries, and time.

## Tools Used
- MySQL
- SQL

## Dataset
The dataset was provided in CSV format and imported into MySQL for analysis.

- **Database:** `layoffs_db`
- **Original table:** `layoffs`
- **Staging table:** `layoffs_staging`

The original table was preserved, while a staging table was used for data cleaning and preparation.

## Project Workflow

### 1. Initial Data Exploration
- Inspected the dataset structure and data types.
- Checked for missing values and distinct values.
- Identified potential data quality issues.

### 2. Data Cleaning
- Created a staging table to preserve the original data.
- Checked for duplicate records.
- Removed unwanted whitespace.
- Handled blank and missing values.
- Converted columns to appropriate data types, including dates and numeric values.
- Verified the cleaned data.

### 3. Exploratory Data Analysis (EDA)
- Identified companies with the highest recorded layoffs.
- Compared layoffs across industries and countries.
- Analysed yearly and monthly layoff trends.
- Examined layoffs by company stage.
- Investigated funds raised and layoff records.
- Used Common Table Expressions (CTEs) and window functions to rank companies and calculate rolling monthly totals.

## SQL Concepts Practised
- SELECT, WHERE, DISTINCT and ORDER BY
- GROUP BY and HAVING
- Aggregate functions: SUM(), AVG(), MAX() and COUNT()
- Date functions
- Common Table Expressions (CTEs)
- DENSE_RANK()
- Window functions and rolling totals
- Data type conversion and data quality checks

## Project Files
- `layoffs.csv` — Original dataset, if redistribution is permitted
- `01_initial_eda.sql` — Initial data exploration
- `02_data_cleaning.sql` — Staging table creation and data cleaning
- `03_final_eda.sql` — Final exploratory data analysis

## Key Learning Outcomes
- Practised cleaning a real-world dataset using MySQL.
- Learned to preserve original data while working with a staging table.
- Applied SQL aggregations to investigate layoff patterns.
- Used CTEs and window functions for advanced analysis.
- Improved my ability to prepare data for analysis and interpret results.

## Conclusion
This project demonstrates my ability to use SQL for data cleaning and exploratory data analysis. It forms part of my portfolio as I work towards an entry-level Data Analyst role.
