
USE retail_sales_project;

#1. Show the total revenue for each city, with the highest-revenue city first.

SELECT city,SUM(amount)AS  'total_revenue'
FROM sales
GROUP BY city
ORDER BY total_revenue DESC;

#2. Show the number of sales transactions for each product, with the product having the most transactions first.

SELECT product,COUNT(product) AS 'number_of_sales_transactions'
FROM sales
GROUP BY product
ORDER BY  number_of_sales_transactions DESC;

#3. Find the top 2 customers based on the number of purchases they made.

SELECT customer,COUNT(product) AS  number_of_purchases
FROM sales
GROUP BY customer
ORDER BY number_of_purchases DESC
LIMIT 2;



#4. Show the average sale amount for each city, from highest to lowest.

SELECT city,AVG(amount) AS 'average_sale_amount'
FROM sales
GROUP BY city
ORDER BY average_sale_amount DESC;


#5. Find the products where the total quantity sold is greater than 5.

SELECT product,SUM(quantity) AS 'total_quantity'
FROM sales
GROUP BY  product 
HAVING total_quantity >5
;

#6. Show all sales made in Pretoria or Johannesburg where the amount was greater than R5,000.

SELECT*
FROM sales
WHERE (city='Pretoria' 
OR  city='Johannesburg') 
AND amount > 5000;

#7. Find all customers whose names contain the letter "e", and show each customer only once.

SELECT  DISTINCT customer
FROM sales
WHERE customer LIKE '%e%';

#8. Show the 3 lowest individual sales, including the customer, product, city and amount.

SELECT customer,product,city,amount 
FROM sales
ORDER BY amount 
LIMIT 3;


#9. Show each product and its total revenue, but only include products with total revenue between R5,000 and R20,000.

SELECT product,SUM(amount) AS 'total_revenue'
FROM sales
GROUP BY product
HAVING total_revenue BETWEEN 5000 AND 20000;

#10. Show the top 3 cities based on the number of sales transactions.

SELECT city,COUNT(product) AS 'number_of_sales_transactions'
FROM sales
GROUP BY city
ORDER BY number_of_sales_transactions DESC
LIMIT 3;

select*
from sales;