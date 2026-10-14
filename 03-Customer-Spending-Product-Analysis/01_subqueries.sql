USE customer_order_project;


#1. Find the orders where the amount is greater than the average order amount.

SELECT *
FROM orders 
WHERE amount  > (
                SELECT AVG(amount)
                FROM orders
              );

#2. Find the customers whose total spending is greater than R10,000.

SELECT  customer_name,total_spending
FROM(
SELECT customer_name,SUM(amount) AS total_spending
FROM customers
JOIN orders
	ON customers.customer_id =orders.customer_id
GROUP BY customer_name
HAVING total_spending >10000 ) AS agg_table ;

#3. Find the customer(s) who made the highest-value order.

SELECT customer_name
FROM customers c
JOIN orders o
	ON c.customer_id =o.customer_id
WHERE o.amount= (
                  SELECT MAX(amount)
                   FROM orders
                 );

#4. Find all orders where the amount is greater than the amount of order 104.

# get all orders
SELECT*
FROM orders
WHERE amount > (
                 # get amount for the order 104
                 SELECT amount
                 FROM orders
				 WHERE order_id =104
				 #result for query amount= 2400.00
				);


#5. Find customers who have placed more orders than customer Sarah.

SELECT customer_name
FROM  customers c
JOIN orders o
	ON o.customer_id = c.customer_id
GROUP BY customer_name
HAVING COUNT(amount) > (
						   # get Sarah orders
					SELECT COUNT(amount) num_of_orders
					FROM orders o
					JOIN customers c
					ON o.customer_id = c.customer_id
					WHERE customer_name = "Sarah"
					# result = 4
					)
;

#6. Find the product(s) whose total sales amount is greater than the average product sales amount.

SELECT product, SUM(amount) AS total_sales_amount
FROM orders
GROUP BY product
HAVING SUM(amount) > (
    SELECT AVG(total_sales_amount)
    FROM (
        SELECT product, SUM(amount) AS total_sales_amount
        FROM orders
        GROUP BY product
    ) AS product_totals
);


#7.Find the customer(s) who have spent the most money in total.

SELECT customer_name,SUM(amount) AS "total_amount_spent"
FROM customers c
JOIN orders o
	ON c.customer_id =o.customer_id
GROUP BY customer_name
HAVING total_amount_spent = (
                             SELECT MAX(total_amount)
                              FROM (
									 SELECT customer_name, SUM(amount) AS "total_amount"
                                    FROM customers c
									JOIN orders o
									ON c.customer_id =o.customer_id
									GROUP BY customer_name
                                     ) AS agg_table
                             );

#8. Find all orders made by customers from Pretoria.

SELECT *
FROM orders o
WHERE o.customer_id IN(
						SELECT customer_id
                        FROM customers
                        WHERE city ="Pretoria"
				    );


#9. Find customers who have placed at least one order with an amount greater than R8,000.

SELECT customer_name
FROM 
	( 
       SELECT customer_name,COUNT(product) AS "number_of_order"
       FROM customers c
       JOIN orders o
		    ON c.customer_id =o.customer_id
		WHERE amount > 8000
		GROUP BY customer_name
		HAVING number_of_order > 0 
      
      ) AS agg_table;




#10. Find the customer(s) whose total spending is greater than the average customer spending.

SELECT customer_name,SUM(amount) AS total_spending
FROM customers
JOIN orders
	ON customers.customer_id=orders.customer_id
GROUP BY customer_name
HAVING  total_spending >(
						SELECT AVG(total_spending)
                        FROM (SELECT customer_name,SUM(amount) AS total_spending
                              FROM customers
                               JOIN orders
	                          ON customers.customer_id=orders.customer_id
                            GROUP BY customer_name ) AS agg_table
                        );












