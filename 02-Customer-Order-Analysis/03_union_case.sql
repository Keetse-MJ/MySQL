USE customer_order_project;

#Q1. Use UNION to display the names of customers who live in Pretoria or Johannesburg.

SELECT customer_name
FROM customers
WHERE city="Pretoria"
UNION
SELECT customer_name
FROM customers
WHERE city="Johannesburg";

#Q2. Use UNION to display the names of customers who live in Pretoria or Midrand.

SELECT customer_name
FROM customers
WHERE city="Pretoria"
UNION
SELECT customer_name
FROM customers
WHERE city="Midrand";

#Q3. Use UNION to display the names of customers who live in Johannesburg or Soweto.


SELECT customer_name
FROM customers
WHERE city="Johannesburg"
UNION
SELECT customer_name
FROM customers
WHERE city="Soweto";


#Q4. Use UNION to create one list containing customers who live in Pretoria and customers who live in Centurion.


SELECT customer_name
FROM customers
WHERE city="Pretoria"
UNION
SELECT customer_name
FROM customers
WHERE city="Centurion";

#Q5. Use UNION to display a single list of customer names from Pretoria and Johannesburg, with no duplicate names.

SELECT   customer_name
FROM customers
WHERE city="Pretoria"
UNION
SELECT   customer_name
FROM customers
WHERE city="Johannesburg";


#Q6. Display the product and amount for every order. Use CASE to classify the amount: 5,000 or more → 'High' Below 5,000 → 'Low'

SELECT product,amount,
CASE 
	WHEN amount>=5000 THEN 'High'
    WHEN amount<5000 THEN 'Low'
    END AS classification
FROM orders
;

#Q7. Display the product and quantity for every order. Use CASE to classify the quantity:3 or more → 'Large Order' Below 3 → 'Small Order'

SELECT product,quantity,
CASE 
	WHEN quantity >=3 THEN 'Large Order'
    WHEN quantity <3 THEN 'Small Order'
    END AS classification
FROM orders;

#Q8. Display the customer name, product and amount. Use CASE to classify the amount: 8,000 or more → 'Very High' 5,000 or more → 'High' Below 5,000 → 'Low'


SELECT customer_name,product,amount,
CASE 
	WHEN amount >= 8000 THEN 'Very High'
    WHEN amount >=5000 THEN 'High'
    WHEN amount < 5000 THEN "Low"
    END AS classification
FROM customers c
JOIN orders o
	ON c.customer_id = o.customer_id;

#Q9. Display the product, category and amount. Use CASE to classify the product category:Electronics → 'Electronic Product' Accessories → 'Accessory Product'

SELECT product,category,amount,
CASE
	WHEN category="Electronics" THEN "Electronic Product"
    WHEN category="Accessories" THEN "Accessory Product"
    END AS classification
FROM orders;


#Q10. Display the customer name, product and amount. Use CASE to create a spending label:8,000 or more → 'Premium' 4,000–7,999 → 'Standard' Below 4,000 → 'Budget'

SELECT customer_name,product,amount,
CASE 
	 WHEN amount >=8000 THEN "Premium"
     WHEN amount BETWEEN 4000 AND 7999 THEN "Standard"
      WHEN amount < 4000 THEN "Budget"
     END AS spending_label
FROM customers c
JOIN orders o
	ON c.customer_id=o.customer_id;



