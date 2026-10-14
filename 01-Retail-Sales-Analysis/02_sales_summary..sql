
#Task 2 — Sales Summary

#1. Show the total amount of sales for each city.

SELECT city,SUM(amount) AS total_amount_of_sales
FROM sales
GROUP BY city
;

#2. Show the total amount of sales for each product.

SELECT product,SUM(amount) AS total_amount_of_sales
FROM sales
GROUP BY product
;

#3. Show the total quantity sold for each product.

SELECT product ,SUM(quantity)  AS 'total_quantity'
FROM sales
GROUP BY  product;

#4. Show the number of sales transactions for each city.

SELECT city,COUNT(amount) AS number_of_sales_transactions 
FROM sales
GROUP BY city
;


#5. Show the average sale amount for each product.

SELECT product,AVG(amount) AS average_sale_amount
FROM sales
GROUP BY product
;

#6. Show the cities that generated more than R15,000 in total sales.

SELECT city,SUM(amount) AS 'total_sales'
FROM sales
GROUP BY city
HAVING total_sales> 15000
;

#7. Show the products that generated more than R10,000 in total sales.

SELECT product,SUM(amount) AS 'total_sales'
FROM sales
GROUP BY  product
HAVING total_sales > 10000
;

#8. Show the products ordered by their total sales, from highest to lowest.

SELECT product,SUM(amount) 'total_sales'
FROM sales
GROUP BY product
ORDER BY total_sales DESC
;

#9. Show the top 3 customers based on their total spending.

SELECT customer,SUM(amount) AS total_spending
FROM sales
GROUP BY customer
ORDER BY total_spending DESC
LIMIT 3
;

#10. Show the categories ordered by total sales, from highest to lowest.

SELECT category,SUM(amount) AS total_sales
FROM sales
GROUP BY category
ORDER BY total_sales DESC
;



SELECT *
FROM sales
;


