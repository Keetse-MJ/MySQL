USE retail_sales_project;

#Business Task 1: Understand the sales data

#1. Show all sales records.

SELECT*
FROM sales;

#2. Show only the customer, product and amount for every sale.

SELECT customer,product,amount
FROM sales;

#3. Find all sales made in Pretoria.

SELECT*
FROM sales
WHERE city ='Pretoria';

#4. Find all sales where the amount was greater than R5,000.

SELECT*
FROM sales
WHERE amount > 5000;

#5 Find all customers who purchased a Laptop.

SELECT customer 
FROM sales
WHERE product="Laptop";

#6. Show all the different cities represented in the dataset.

SELECT DISTINCT city
FROM sales;

#7. Show all the different products sold.

SELECT  DISTINCT product
FROM sales;

#8. Find all products whose name contains the word "Phone".

SELECT product
FROM sales
WHERE product LIKE '%Phone%';

#9. Find all sales between R2,000 and R6,000.

SELECT*
FROM sales
WHERE amount BETWEEN 2000 AND 6000;

#10. Display the 5 highest-value sales.

SELECT*
FROM sales
ORDER BY amount DESC
LIMIT 5;

