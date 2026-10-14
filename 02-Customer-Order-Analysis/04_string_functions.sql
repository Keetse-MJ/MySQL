USE customer_order_project;

#1. Display all customer names in uppercase.

SELECT UPPER(customer_name) AS customer_name
FROM customers;

#2. Display all customer email addresses in lowercase

SELECT LOWER(email) AS email_addresses
FROM customers;

#3. Display:customer name ,the length of each customer's name Call the calculated column name_length.

SELECT customer_name,LENGTH(customer_name) AS name_length
FROM customers;

#4. Display the customer's name and city together in one column.The format should be: Thabo - Johannesburg Sarah - Pretoria .Call the column customer_location.

SELECT CONCAT(customer_name,' - ',city) AS customer_location
FROM customers;


#5. Display the first 3 characters of every customer name.Call the column first_three_characters.

SELECT SUBSTRING(customer_name,1,3) AS first_three_characters
FROM customers;

#6. Display all customer emails, but replace: @email.com with:@gmail.com

SELECT REPLACE(email,'@email.com','@gmail.com') AS customer_email
FROM customers;

#7. Display: customer name ,the position of the letter 'a' in the customer's name. Call the column a_position.

SELECT customer_name,LOCATE('a',customer_name) AS a_position 
FROM customers;

#8. Display the customer's name and city together in one column, but make the entire result uppercase.Example: THABO - JOHANNESBURG SARAH - PRETORIA .Call the column customer_info.

SELECT UPPER(CONCAT(customer_name,' - ',city)) AS customer_info
FROM customers;

#9. Display the customer name and email for customers whose name contains the letter 'a'.Use a string function to help identify them.

SELECT customer_name,email
FROM customers
WHERE LOCATE('a',customer_name);

#10. Display: customer name,email,customer name in uppercase,email in lowercase,length of the customer name.Call the calculated columns:upper_name,lower_email,name_length

SELECT customer_name,email,UPPER(customer_name)  AS upper_name ,LOWER(email) AS lower_email,LENGTH(customer_name) AS name_length
FROM customers;

