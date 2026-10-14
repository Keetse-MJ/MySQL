USE customer_order_project;


#1. Display the customer name, product, and amount for every order.

SELECT c.customer_name, o.product,o.amount
FROM customers c
JOIN orders o
	ON c.customer_id=o.customer_id;

#2. Display the customer name, city, and product for all orders made by customers from Pretoria.

SELECT c.customer_name,c.city,o.product
FROM customers c
JOIN orders o
		ON c.customer_id=o.customer_id
WHERE city ="Pretoria";

#3. Display:customer name ,product ,amount for orders where the amount is greater than 5,000.


SELECT c.customer_name, o.product,o.amount
FROM customers c
JOIN orders o
	ON c.customer_id=o.customer_id
WHERE amount >5000;

#4. Display:customer name,city,product,quantity for every order.

SELECT c.customer_name,c.city,o.product,o.quantity
FROM customers c
JOIN orders o
		ON c.customer_id=o.customer_id
;

#5. Display: customer name ,order date for orders made in February 2026.

SELECT c.customer_name,o.order_date
FROM customers c
JOIN orders o
		ON c.customer_id=o.customer_id
WHERE SUBSTRING(order_date,1,7)="2026-02"
;

#6. Display:customer name,total amount spent for each customer.

SELECT c.customer_name,SUM(amount) AS total_amount_spent
FROM customers c
JOIN orders o
		ON c.customer_id=o.customer_id
GROUP BY c.customer_name
;

#7. Display:customer name,number of orders for each customer.

SELECT c.customer_name,COUNT(o.product) AS number_of_orders
FROM customers c
JOIN orders o
		ON c.customer_id=o.customer_id
GROUP BY c.customer_name;

#8. Display:customer name,product,amount for orders where the product is Laptop.

SELECT c.customer_name,o.product,o.amount
FROM customers c
JOIN orders o
		ON c.customer_id=o.customer_id
WHERE product ="Laptop";


#9. Display:customer name,city,total spending but only show customers whose total spending is greater than 10,000. 

SELECT c.customer_name,c.city,SUM(amount) AS total_spending
FROM customers c
JOIN orders o
		ON c.customer_id=o.customer_id
GROUP BY c.customer_name,c.city
HAVING total_spending > 10000;

#10. Display:customer name,product,amount and sort the results from highest amount to lowest amount.

SELECT c.customer_name,product,amount
FROM customers c
JOIN orders o
		ON c.customer_id=o.customer_id
ORDER BY amount DESC;


SELECT*
FROM customers;

SELECT* 
FROM orders;