USE customer_order_project;


#1. Display all customers and their orders.Show: customer name, product, amount

SELECT customer_name,product,amount
FROM customers c
LEFT JOIN orders o
ON  c.customer_id=o.customer_id;

#2. Display all customers, including customers who have no orders.Show:customer name,city,product

SELECT customer_name,city,product
FROM customers c
LEFT JOIN orders o
ON  c.customer_id=o.customer_id;

#3. Display all customers and their order amounts, but only show orders where the amount is greater than 5,000.

SELECT customer_name,amount
FROM customers c
LEFT JOIN orders o
ON  c.customer_id=o.customer_id
AND amount > 5000;

#4. Display all customers and the number of orders they have made.Show:customer name,number of orders,Customers with no orders must also appear.

SELECT customer_name,COUNT(product) number_of_orders
FROM customers c
LEFT JOIN orders o
	ON c.customer_id=o.customer_id
GROUP BY  customer_name;

#5. Display all customers and their total spending.Show:customer name,total spending,Customers with no orders must also appear


SELECT customer_name,SUM(amount) total_spending
FROM customers c
LEFT JOIN orders o
	ON c.customer_id=o.customer_id
GROUP BY  customer_name;


#6. Display:customer name,city,product,category.amount for every order.

SELECT customer_name,city,product,category,amount
FROM customers c
JOIN orders o
	ON c.customer_id=o.customer_id;


#7. Display customers from Pretoria who bought a Laptop.Show: customer name,city,product,amount

SELECT customer_name,city,product,amount
FROM customers c
JOIN orders o
	ON c.customer_id=o.customer_id
WHERE city='Pretoria' AND product="Laptop" ;


#8. Display all orders made by customers from Johannesburg or Midrand.Show:customer name,city,product,amount

SELECT customer_name,city,product,amount
FROM customers c
JOIN orders o
	ON c.customer_id=o.customer_id
WHERE city='Johannesburg' OR city='Midrand' ;


#9. Display each customer's:name,city,total number of orders,total amount spent

SELECT customer_name,city,COUNT(amount) total_number_of_orders,SUM(amount) total_amount_spent
FROM customers c
JOIN orders o
	ON c.customer_id=o.customer_id
GROUP BY customer_name,city ;

#10. Display customers who have made more than one order.Show:customer name,number of orders,total spending

SELECT customer_name,city,COUNT(amount) total_number_of_orders,SUM(amount) total_amount_spent
FROM customers c
JOIN orders o
	ON c.customer_id=o.customer_id
GROUP BY customer_name,city 
HAVING total_number_of_orders >1 ;






