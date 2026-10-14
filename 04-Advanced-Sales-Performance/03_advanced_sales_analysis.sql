USE sales_performance_project;

#1. The sales manager wants to identify the top 2 salespeople in each month based on total monthly sales. 
# Return the month, salesperson, total sales and rank.

WITH getMonth AS
(
SELECT SUBSTRING(sale_date,6,2) AS sales_month,salesperson,amount
FROM sales
),getTotalSales AS
(
 SELECT*,SUM(amount)OVER(PARTITION BY salesperson ,sales_month) AS total_sales
 FROM getMonth
),rank_sales AS
(
SELECT DISTINCT salesperson,sales_month,amount,total_sales, DENSE_RANK()OVER( PARTITION BY  sales_month ORDER BY total_sales DESC) AS ranking
FROM getTotalSales
)

SELECT  DISTINCT sales_month,salesperson,total_sales,ranking 
FROM rank_sales
WHERE ranking < 3
;


#2. Identify the salesperson with the highest total sales in each product category. Return the category, salesperson and total sales.


# get total sales
WITH getTotsalSales AS
(
  SELECT salesperson ,product,category,amount,SUM(amount)OVER(PARTITION BY salesperson,category) AS total_sales
  FROM sales
)
,getHighestSale AS
(
	SELECT*,MAX(total_sales) OVER(PARTITION BY category) highest_sale
	FROM getTotsalSales
)

SELECT  DISTINCT  category, salesperson ,total_sales
FROM getHighestSale
WHERE total_sales =highest_sale ;



#3. For each salesperson, calculate their total sales and compare it with the average total sales of all salespeople.
#  Return the salesperson, total sales and the difference from the average.


WITH getTotalSales AS
(
 SELECT  DISTINCT salesperson,SUM(amount)OVER(PARTITION BY salesperson) AS total_sales 
 FROM sales
)
,get_average_total_sales AS 
(
 SELECT *,AVG(total_sales) OVER()AS  average_total_sales
 FROM getTotalSales
)
SELECT salesperson,total_sales,average_total_sales,(total_sales - average_total_sales) difference
FROM get_average_total_sales;


#4. Identify salespeople whose total sales are above the average salesperson's total sales.

WITH getTotalSales AS
(
 SELECT  DISTINCT salesperson,SUM(amount)OVER(PARTITION BY salesperson) AS total_sales 
 FROM sales
)
,get_average_total_sales AS 
(
 SELECT *,AVG(total_sales) OVER()AS  average_total_sales
 FROM getTotalSales
)
SELECT salesperson,total_sales,average_total_sales
FROM get_average_total_sales
WHERE total_sales > average_total_sales;



#5. The manager wants to see each salesperson's total sales, their rank, and the percentage of the company's total sales they generated.

WITH getTotalSales AS
(
 SELECT  DISTINCT salesperson,SUM(amount)OVER(PARTITION BY salesperson) AS total_sales 
 FROM sales
),getRanking AS
(
  SELECT*,RANK()OVER(ORDER BY total_sales DESC) AS sales_rank
  FROM getTotalSales
),overallTotalSales AS
(
  SELECT*,SUM(total_sales) OVER() overall_total
  FROM getRanking
)

SELECT salesperson,total_sales,sales_rank,(FORMAT(((total_sales/overall_total)*100),1)) AS percentage
FROM overallTotalSales;



#6. For each salesperson, calculate their total sales for each month and show the change
# in their monthly sales compared with the previous month.


WITH getMonth AS
(
SELECT  SUBSTRING(sale_date,6,2) AS sales_month,salesperson,amount
FROM sales
),getTotalSales AS
(
 SELECT DISTINCT salesperson,sales_month,SUM(amount)OVER(PARTITION BY salesperson ,sales_month) AS total_sales
 FROM getMonth
)
,getPreviousTotalSales AS
( 
  SELECT*,LAG(total_sales)OVER(PARTITION BY salesperson ORDER BY sales_month ) AS previousTotalSale
  FROM getTotalSales
)


SELECT salesperson,sales_month,total_sales ,(total_sales-previousTotalSale) AS sale_change
FROM getPreviousTotalSales
;


#7. Identify the salesperson whose monthly sales increased for the greatest number of months compared with the previous month.


WITH getMonth AS
(
SELECT  SUBSTRING(sale_date,6,2) AS sales_month,salesperson,amount
FROM sales
),getTotalSales AS
(
 SELECT DISTINCT salesperson,sales_month,SUM(amount)OVER(PARTITION BY salesperson ,sales_month) AS total_sales
 FROM getMonth
),
getPreviousSale AS
(
  SELECT*,LAG(total_sales)OVER(PARTITION BY salesperson ORDER BY sales_month) AS previousAmount
  FROM getTotalSales
)
,getSalesCount AS
(
  SELECT* ,CASE 
				WHEN total_sales > previousAmount THEN  1
                WHEN total_sales < previousAmount THEN  0
                END AS salescount
  FROM getPreviousSale
)
,sumOfSalesCount AS
(
 SELECT*,SUM(salescount) OVER(PARTITION BY salesperson )  AS sumOfSalesIncrease
 FROM getSalesCount
)
,getResults AS
(
  SELECT*
  FROM sumOfSalesCount
  WHERE sumOfSalesIncrease= (
								SELECT MAX(sumOfSalesIncrease)
                                FROM sumOfSalesCount)
)
SELECT DISTINCT salesperson,sumOfSalesIncrease AS number_of_increase
FROM getResults;


#8. For each product category, identify the salesperson who generated the highest average sale amount.

WITH getTotalSales AS(
SELECT  salesperson,category,amount,AVG(amount) OVER(PARTITION BY salesperson,category) AS average_sales
FROM sales
),gethighestaverage AS
(
 SELECT *,	MAX(average_sales)OVER(PARTITION BY category) AS highest_sale_average
 FROM getTotalSales

 )

SELECT DISTINCT category,salesperson
FROM gethighestaverage
 WHERE average_sales = highest_sale_average;
 
 
 #9. Identify salespeople whose highest individual sale is greater than the average individual sale amount across the entire company

WITH get_highest_sale AS (
#get highest sale
SELECT  DISTINCT salesperson,MAX(amount)OVER(PARTITION BY salesperson) AS highest_sale
FROM sales
),
#get average individual sale
get_average_individual AS (
SELECT  DISTINCT salesperson,AVG(amount)OVER() AS average_individual
FROM sales
)

SELECT ga.salesperson,average_individual,highest_sale
FROM get_average_individual ga
JOIN get_highest_sale gh
WHERE ga.salesperson=gh.salesperson AND highest_sale > average_individual;



#10. The manager wants a monthly performance summary showing each month, the salesperson with the highest total sales that month,
# their total sales, and the percentage of that month's sales they contributed.

WITH getMonth AS
(
SELECT SUBSTRING(sale_date,6,2) AS sales_month,salesperson,amount
FROM sales
),
getTotalSales AS 
(
  SELECT*,SUM(amount)OVER(PARTITION BY salesperson,sales_month) AS total_sales
  FROM getMonth
)
,getHighestTotal AS
(
  SELECT*,MAX(total_sales)OVER(PARTITION BY sales_month)  AS highest_total_sales
  FROM getTotalSales
),getMonthTotalsales AS
(
  SELECT*,SUM(amount)OVER(PARTITION BY sales_month) AS monthly_total
  FROM getHighestTotal
)
,getPercentage AS
(
 SELECT*,FORMAT(((total_sales/monthly_total)*100),1) AS percentage
 FROM  getMonthTotalsales
)

SELECT  DISTINCT sales_month,salesperson,total_sales,percentage
FROM getPercentage
WHERE total_sales = highest_total_sales
;




























