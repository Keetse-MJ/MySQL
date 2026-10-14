USE sales_performance_project;

#1. The sales manager wants to see each salesperson's sales amount and the sales amount from their previous sale. 
 #   Return the salesperson, sale date, current amount and previous amount.
 
 SELECT  salesperson,sale_date,amount,LAG(amount)OVER(PARTITION BY salesperson ORDER BY sale_date) previous_amount
FROM sales
;

#2. Calculate the difference between each sale and the salesperson's previous sale.
 
WITH CTE AS(
 SELECT  salesperson,amount,
 LAG(amount)OVER(PARTITION BY salesperson ORDER BY sale_date) previous_amount
 FROM sales
 )
 SELECT *,(amount-previous_amount) AS difference
 FROM CTE
 ;
 
 
 #3. Identify sales where the salesperson's current sale amount was higher than their previous sale.

WITH CTE AS(
 SELECT  *,
 LAG(amount)OVER(PARTITION BY salesperson ORDER BY sale_date) previous_amount
 FROM sales
 )
 SELECT *
 FROM CTE
 WHERE amount > previous_amount
 ;
 
 #4. Identify sales where the salesperson's current sale amount was lower than their previous sale

WITH CTE AS(
 SELECT  *,
 LAG(amount)OVER(PARTITION BY salesperson ORDER BY sale_date) previous_amount
 FROM sales
 )
 SELECT *
 FROM CTE
 WHERE amount < previous_amount
 ;
 
 # 5. The manager wants to see each salesperson's current sale and their next sale amount. Use LEAD() to return the next sale amount

 SELECT  salesperson,amount,
 LEAD(amount)OVER(PARTITION BY salesperson ORDER BY sale_date) next_sale_amount
 FROM sales;
 
 
# 6. Calculate the difference between each salesperson's current sale and their next sale.

WITH sales_difference  AS(
 SELECT  salesperson,amount,
 LEAD(amount)OVER(PARTITION BY salesperson ORDER BY sale_date) next_amount
 FROM sales
 )
 SELECT *,(next_amount-amount) AS difference
 FROM sales_difference
 ;
 
 
# 7. Identify the salesperson whose sales increased on their most recent sale compared with their previous sale.


WITH countingRows AS
(
SELECT salesperson,sale_date,amount,COUNT(amount)OVER(PARTITION BY salesperson ) AS counting
FROM sales

)
,getLatestSale AS
(
  SELECT *,ROW_NUMBER()OVER(PARTITION BY salesperson ORDER BY sale_date) AS row_num
  FROM countingRows
), 
getPreviousAmount AS
(
	SELECT *,LAG(amount) OVER(PARTITION BY salesperson ORDER BY sale_date) AS previous_amount
    FROM getLatestSale
),
getLatestAmount AS
(
 SELECT*
 FROM getPreviousAmount
 WHERE counting=row_num
)

SELECT salesperson,amount,previous_amount
 FROM getLatestAmount
 WHERE amount > previous_amount;


#8. For each salesperson, identify their highest-value sale and show the previous sale amount before that sale.

WITH getHighestSale AS (
					SELECT salesperson ,sale_date,amount ,MAX(amount)OVER(PARTITION BY salesperson) highest_value
					FROM sales
),
getPreviousSaleAmount AS
(
 SELECT *,LAG(amount)OVER(PARTITION BY salesperson ORDER BY sale_date) AS previous_sale
 FROM getHighestSale
)
SElECT salesperson,amount,previous_sale
FROM getPreviousSaleAmount
WHERE amount = highest_value;



#9. The manager wants to identify salespeople whose latest sale amount is greater than their first sale amount.
#get first sale


 
WITH countingRows AS
(
SELECT salesperson,sale_date,amount,COUNT(amount)OVER(PARTITION BY salesperson ) AS counting
FROM sales

)
,getLatestSale AS
(
  SELECT *,ROW_NUMBER()OVER(PARTITION BY salesperson ORDER BY sale_date) AS row_num
  FROM countingRows
),#GET LATEST AMOUNT
getLatestAmount AS
(
  SELECT *
  FROM getLatestSale
  WHERE counting=row_num
)#GET FIRST AMOUNT
, getFirstAmount AS
(
 SELECT *
  FROM getLatestSale
  WHERE row_num=1
),
getResults AS
(
 SELECT gl.salesperson,gl.amount AS latest_amount ,gf.amount AS first_amount
 FROM getLatestAmount gl
 JOIN getFirstAmount gf
	 ON gl.salesperson = gf.salesperson
WHERE gl.amount > gf.amount
)

SELECT*
FROM getResults;



#10. For each salesperson, calculate their sales growth from their first sale to their latest sale.
 
WITH countingRows AS
(
SELECT salesperson,sale_date,amount,COUNT(amount)OVER(PARTITION BY salesperson ) AS counting
FROM sales

)
,getLatestSale AS
(
  SELECT *,ROW_NUMBER()OVER(PARTITION BY salesperson ORDER BY sale_date) AS row_num
  FROM countingRows
),#GET LATEST AMOUNT
getLatestAmount AS
(
  SELECT *
  FROM getLatestSale
  WHERE counting=row_num
)#GET FIRST AMOUNT
, getFirstAmount AS
(
 SELECT *
  FROM getLatestSale
  WHERE row_num=1
),
getResults AS
(
 SELECT gl.salesperson,gl.amount AS latest_amount ,gf.amount AS first_amount ,(gl.amount - gf.amount) AS sales_growth
 FROM getLatestAmount gl
 JOIN getFirstAmount gf
	 ON gl.salesperson = gf.salesperson

)

SELECT*
FROM getResults;