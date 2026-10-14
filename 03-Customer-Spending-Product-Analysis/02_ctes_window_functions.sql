USE customer_order_project;


#USING CTEs

# 1. The sales manager wants to identify the top 3 customers by total spending. Return the customer's name and their total spending.

WITH highest_spending_customer AS
(
  SELECT customer_name,SUM(amount) AS total_spending
  FROM customers
  JOIN orders
	ON customers.customer_id = orders.customer_id
  GROUP BY customer_name 
  ORDER BY 2 DESC
  LIMIT 3
)
SELECT*
FROM  highest_spending_customer
;


#2. A sales manager wants to see each customer's total spending along with their spending rank, from highest spender to lowest spender.
    # Return: customer_name, total_spending, spending_rank.Use a CTE and a window function.
    
WITH customer_spending AS
(
  SELECT customer_name,SUM(amount) AS total_spending
  FROM customers
  JOIN orders
	ON customers.customer_id = orders.customer_id
  GROUP BY customer_name 
),
spending_ranking AS
(
  SELECT customer_name,total_spending ,DENSE_RANK()OVER(ORDER BY total_spending  DESC) as spending_rank
  FROM customer_spending
)
SELECT  *
FROM  spending_ranking; 


#3. The sales manager wants to identify the highest-value order made by each customer. Return: customer_name , order_id , amount
# If a customer has multiple orders, return only their highest-value order.Write the SQL query.

WITH getting_customer_amount AS
(
	SELECT   customer_name,c.customer_id,MAX(amount) AS amount
	FROM  customers c
	JOIN orders o
		ON  c.customer_id =o.customer_id
	GROUP BY customer_name,c.customer_id

) ,
get_order_details AS
(
	SELECT*  
	FROM orders
)
, highest_value_order  AS
( 
	SELECT  gc.customer_name,go.order_id,gc.amount
    FROM getting_customer_amount gc
    JOIN get_order_details go
		ON gc.customer_id = go.customer_id
	WHERE go.amount = gc.amount

)
SELECT*
FROM highest_value_order;


#4. A sales manager wants to compare each customer's order amount with their previous order.Return:customer_name,order_id,amount,previous_order_amount.
# The previous order should be determined by order_id for each customer.Write the SQL query.

WITH customer_order AS (
						SELECT customer_name,order_id,amount,LAG(amount)OVER(PARTITION BY customer_name ORDER BY order_id ) previous_order_amount
						FROM customers c
						JOIN orders o
							ON c.customer_id =o.customer_id
                        )
SELECT*
FROM customer_order;



#5. The sales manager wants to identify customers whose latest order amount is greater than their previous order amount.
# Return: customer_name,order_id, amount,previous_order_amount.Use the order sequence based on order_id.

WITH customer_order AS(
SELECT customer_name,order_id,amount
FROM customers c
JOIN orders o
	ON c.customer_id=o.customer_id
),
previous_order_details AS(
SELECT customer_name,order_id,amount,LAG(amount)OVER(PARTITION BY customer_name ORDER BY order_id) previous_order_amount
FROM customer_order

),
latest_order AS(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY customer_name
ORDER BY order_id DESC
) AS row_num
    FROM previous_order_details
)
SELECT customer_name, order_id, amount, previous_order_amount
FROM latest_order
WHERE row_num = 1
  AND amount > previous_order_amount;

#6.The sales manager wants to see the running total of spending for each customer, ordered by order_id.
# Return:customer_name ,order_id,amount, running_total,The running total should restart from 0 for each customer.

WITH customer_running_total AS 
				(
					SELECT customer_name,order_id,amount,SUM(amount)OVER(PARTITION BY customer_name ORDER BY order_id) AS running_total
					FROM customers c
					JOIN orders o
						ON 	c.customer_id=o.customer_id
				)
SELECT*
FROM customer_running_total;

#7. The sales manager wants to identify the top 2 highest-value orders for each customer.
# Return:customer_name,order_id,amount,order_rank.If a customer has more than 2 orders, return only their top 2 orders by amount.

WITH customer_order AS
(
SELECT customer_name,order_id,amount
FROM customers c
JOIN orders o
	ON c.customer_id=o.customer_id
),
order_ranking AS 
(
SELECT customer_name,order_id,amount,DENSE_RANK()OVER(PARTITION BY customer_name ORDER BY amount DESC) order_rank,
ROW_NUMBER()OVER(PARTITION BY customer_name ORDER BY amount DESC ,order_id) AS row_num
FROM customer_order

)

SELECT*
FROM order_ranking
WHERE row_num <3;
;

#8. The sales manager wants to identify customers whose spending increased from one order to the next on every order after their first order.
#Return:customer_name.Only return customers for whom every order after their first order was greater than the previous order
/*
WITH first_order AS(
#get first order
SELECT customer_name,order_id,amount,ROW_NUMBER()OVER(PARTITION BY customer_name) AS row_num
FROM customers c
JOIN orders o
	ON c.customer_id =o.customer_id
),*/
WITH
previous_order AS(
#get the previous + next
SELECT customer_name,order_id,amount,
LAG(amount)OVER(PARTITION BY customer_name ORDER BY order_id) previous_order_amount 
FROM customers c
JOIN orders o
	ON c.customer_id =o.customer_id

),
checking_increase AS
(
 SELECT*,
 CASE 
	        WHEN previous_order_amount IS NULL THEN NULL
            WHEN amount > previous_order_amount THEN 1
            ELSE 0
        END AS increased
 FROM previous_order
)

SELECT customer_name
FROM checking_increase
GROUP BY customer_name
HAVING SUM(
    CASE WHEN increased = 0 THEN 1 ELSE 0 END
) = 0
;


#9. The sales manager wants to identify customers whose average order amount is higher than the overall average order amount.
# Return: customer_name ,average_order_amount.Requirements:Calculate each customer's average order amount.
#Compare each customer's average against the overall average order amount across all orders.
#Only return customers whose average is greater than the overall average.Use a CTE and a subquery or aggregation.

  				
WITH CustomerAverageAmount AS
(
 # customer average amount
  SELECT customer_name,AVG(amount) AS customer_average
  FROM customers c
  JOIN orders o
	   ON c.customer_id = o.customer_id
GROUP BY customer_name
HAVING  customer_average > ( 
							  SELECT AVG(amount)
                              FROM orders
							
                            )
)
SELECT*
FROM CustomerAverageAmount;


#10.The sales manager wants to identify customers who have made at least 3 orders and whose total spending is greater than R15,000.
# Return:customer_name,total_spending,number_of_orders.Requirements:Calculate each customer's total spending.
#Count the number of orders for each customer.Only return customers with at least 3 orders.
#Only return customers whose total spending is greater than R15,000.Use a CTE.

WITH customer_Average AS(
#get customers who made 3 or more order
SELECT customer_name,SUM(amount) total_spending,COUNT(product) number_of_orders
FROM customers c
JOIN orders o
	ON c.customer_id=o.customer_id
GROUP BY customer_name
HAVING number_of_orders >2 AND total_spending > 15000
)
SELECT*
FROM customer_Average;

