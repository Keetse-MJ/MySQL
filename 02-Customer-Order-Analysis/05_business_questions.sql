USE customer_order_project;

#1. Display the customer name and their total spending.

SELECT customer_name,SUM(amount) AS total_spending
FROM customers c
JOIN  orders o
	ON  c.customer_id =o.customer_id
GROUP BY customer_name;

#2. Display the customer name and number of orders they have made.


SELECT customer_name,COUNT(product) AS number_of_orders
FROM customers c
JOIN  orders o
	ON  c.customer_id =o.customer_id
GROUP BY customer_name;


#3. Display customers whose total spending is greater than 10,000. Show: customer name ,total spending

SELECT customer_name,SUM(amount) AS total_spending
FROM customers c
JOIN  orders o
	ON  c.customer_id =o.customer_id
GROUP BY customer_name
HAVING total_spending > 10000;

#4. Display the top 3 customers by total spending, from highest to lowest.Show: customer name ,total spending


SELECT customer_name,SUM(amount) AS total_spending
FROM customers c
JOIN  orders o
	ON  c.customer_id =o.customer_id
GROUP BY customer_name
ORDER BY total_spending DESc
LIMIT 3;

#5. Display all customers, including customers who have not made any orders.Show:customer name,city,product

SELECT customer_name,city,product
FROM customers c
 LEFT JOIN  orders o
	ON  c.customer_id =o.customer_id
;
#6. Display the customer name, product and amount for orders where the amount is greater than 5,000.

SELECT customer_name,product,amount
FROM customers c
JOIN  orders o
	ON  c.customer_id =o.customer_id
WHERE amount > 5000;

#7. Display the customer name and total spending, and classify each customer as:Premium → spending ≥ 15,000 ,Standard → spending ≥ 8,000,Budget → spending < 8,000

SELECT customer_name,SUM(amount) AS total_spending,
CASE
	WHEN SUM(amount)>= 15000 THEN  "Premium"
    WHEN SUM(amount)>= 8000 THEN  "Standard"
    WHEN SUM(amount) < 8000 THEN  "Budget"
    END AS classification
FROM customers c
JOIN  orders o
	ON  c.customer_id =o.customer_id
GROUP BY customer_name
;

#8. Display customers from Pretoria or Johannesburg who have made an order.Show:customer name,city,product

SELECT customer_name,city,product
FROM customers c
JOIN  orders o
	ON  c.customer_id =o.customer_id
WHERE  city="Pretoria" OR city="Johannesburg";

#9. Display the customer name and email, but make the customer name uppercase.Only display customers whose name contains the letter a.

SELECT UPPER(customer_name) AS customer_name,email
FROM customers c
WHERE  customer_name LIKE '%a%';


#10. Create a customer spending report showing:customer name,city,number of orders,total spending,spending classification,
#Use these classifications:Premium → total spending ≥ 15,000 ,Standard → total spending ≥ 8,000 , Budget → total spending < 8,000
#Important: Include customers who have no orders as well.
SELECT customer_name,city,COUNT(product) AS number_of_orders,SUM(amount) total_spending,
CASE
	WHEN SUM(amount)>= 15000 THEN  "Premium"
    WHEN SUM(amount)>= 8000 THEN  "Standard"
    WHEN SUM(amount) < 8000 OR COUNT(product) =0 THEN  "Budget"

	END AS classification
FROM customers c
LEFT JOIN orders o
	ON 	c.customer_id =o.customer_id
GROUP BY customer_name,city
    ;












