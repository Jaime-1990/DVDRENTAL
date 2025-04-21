--query 1: title 5 primeros
SELECT f.title
FROM film AS f
ORDER BY f,title ASC
LIMIT 5

--query 2: used INNER JOIN, 
SELECT c.customer_id, c.first_name, p.amount, p.payment_date
FROM customer AS c
INNER JOIN payment AS p USING(customer_id)
ORDER BY p.payment_date DESC

--query 3: left join, 
SELECT f.film_id, f.title, i.inventory_id
FROM film AS f
LEFT JOIN inventory AS i ON f.fiml_id = i.film_id
ORDER BY f.title AS 

--query 4: used joinUse LEFT JOIN with a WHERE clause to identify films that have no inventory records,  
SELECT f.film_id, f.title, i.inventory_id
FROM film AS f
LEFT JOIN inventory AS i ON f.film_id = i.film_id
WHERE inventory_id IS NULL
ORDER BY f.title ASC;

--query 5:Use the RIGHT JOIN clause to retrieve all rows from the film table that may or may not 
SELECT f.film_id, f.title, i.inventory_id
FROM inventory AS i
LEFT JOIN film AS f ON f.film_id = i.film_id
ORDER BY f.title ASC 

--query 6: Use a RIGHT JOIN clause with a WHERE clause to retrieve the films that have no 
SELECT f.film_id, f.title, i.inventory_id
FROM inventory AS i
RIGHT JOIN film AS f USING (film_id)
WHERE i.inventory_id IS NULL 
ORDER BY f.film_id ASC;

--query 7:  Find all pairs of films that have the same length,'INNER JOIN'
SELECT f1.title AS film1, f2.title AS film2, f1.length
FROM film f1
INNER JOIN film f2 ON f1.length = f2.length
WHERE f1.film_id > f2.film_id
ORDER BY f1.length, f1.title, f2.title;

--query 8:Use a FULL OUTER JOIN to retrieve all employee names and department names, 
SELECT 
    staff.first_name || ' ' || staff.last_name AS employee_name, 
    store.store_id AS department_id
FROM staff
FULL OUTER JOIN store ON staff.store_id = store.store_id
ORDER BY employee_name, department_id;


--query 9:Use a FULL OUTER JOIN with a WHERE clause to identify departments that have no 
--employees assigned. 
SELECT store.store_id AS department_id, store.manager_staff_id 
FROM store
FULL OUTER JOIN staff ON store.store_id = staff.store_id
WHERE staff.staff_id IS NULL
ORDER BY store.store_id;

--consulta:
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public'

--query 10:Use a FULL OUTER JOIN with a WHERE clause to find employees who are not assigned to 
--any department.
SELECT s.staff_id, s.first_name, s.last_name
FROM staff s
FULL OUTER JOIN store st ON s.staff_id = st.manager_staff_id
WHERE st.store_id IS NULL;

-- QUERY 11. Use a NATURAL JOIN to automatically join the products and categories tables based on 
-- columns with identical names 
SELECT *
FROM film
NATURAL JOIN language;

--QUERY 12.Use GROUP BY to retrieve distinct customer IDs from the payment table, effectively 
--listing all customers who have made payments 
SELECT customer_id
FROM payment
GROUP BY customer_id
ORDER BY customer_id ASC;

--QUERY 13. Use GROUP BY with the SUM() function to calculate the total payment amounts made by 
--each customer. Results include customer_id and the summed amount, ordered by 
--customer_id.  
SELECT customer_id, SUM(amount) AS total_payments
FROM payment
GROUP BY customer_id
ORDER BY customer_id;

--QUERY 14: Use GROUP BY with ORDER BY to sort customers by their total payment amounts in 
-- descending order. This query helps identify top-spending customers.  
SELECT customer_id, SUM(amount) AS total_payments
FROM payment
GROUP BY customer_id
ORDER BY total_payments DESC;

--QUERY 15.Use GROUP BY with a JOIN to display customer full names (concatenated first and last 
--names) and their total payment amounts. Results are sorted by payment amount in 
--descending order.  
SELECT c.customer_id, c.first_name || ' ' || c.last_name AS full_name, SUM(p.amount) AS total_payments
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, full_name
ORDER BY total_payments DESC;

--QUERY 16: Use GROUP BY with COUNT() to calculate how many payments each staff member has 
--processed. Results show staff_id and their payment count. 
SELECT staff_id, COUNT(*) AS payment_count
FROM payment
GROUP BY staff_id;

-- QUERY 17.Use GROUP BY on multiple columns to analyze payment amounts by unique staff
-- customer combinations. 
SELECT customer_id, staff_id, SUM(amount) AS total_payments
FROM payment
GROUP BY customer_id, staff_id
ORDER BY customer_id;


--QUERY 18. Use GROUP BY with date functions to calculate daily payment totals 
SELECT DATE(payment_date) AS payment_day, 
       SUM(amount) AS daily_total,
       COUNT(*) AS transaction_count
FROM payment
GROUP BY payment_day
ORDER BY payment_day DESC;

--QUERY 19.. Use GROUP BY with the SUM() function to calculate total payments per customer, then 
--apply a HAVING clause to filter only customers who have spent more than $200. Results 
--are sorted by total amount in descending order to show top spenders first.  
SELECT customer_id, SUM(amount) AS total_payments
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 200
ORDER BY total_payments DESC;

-- QUERY 20.  Use GROUP BY with COUNT() to calculate the number of customers per store, then apply 
--a HAVING clause to identify only stores with more than 300 customers. This helps locate 
--high-volume store locations.
SELECT store_id, COUNT(*) AS customer_count
FROM customer
GROUP BY store_id
HAVING COUNT(*) > 300;