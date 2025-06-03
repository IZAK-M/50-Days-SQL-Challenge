-- JOUR 9/50

-- Création des tables customers et purchases :

DROP TABLE IF EXISTS customers;
CREATE TABLE customers(
	customer_id INT,
	customer_name VARCHAR(50)
);

DROP TABLE IF EXISTS purchases;
CREATE TABLE purchases(
	purchase_id INT,
	customer_id INT,
	product_name VARCHAR(50),
	purchase_date DATE
);

-- Insertion des données:

INSERT INTO customers(customer_id, customer_name)
VALUES
	 (1, 'John'),
	 (2, 'Emma'),
	 (3, 'Michael'),
	 (4, 'Ben'),
	 (5, 'John');

INSERT INTO purchases
VALUES
	 (100, 1, 'iPhone', '2024-01-01'),
	 (101, 1, 'MacBook', '2024-01-20'),	
	 (102, 1, 'Airpods', '2024-03-10'),
	 (103, 2, 'iPad', '2024-03-05'),
	 (104, 2, 'iPhone', '2024-03-15'),
	 (105, 3, 'MacBook', '2024-03-20'),
 	 (106, 3, 'Airpods', '2024-03-25'),
 	 (107, 4, 'iPhone', '2024-03-22'),	
 	 (108, 4, 'Airpods', '2024-03-29'),
 	 (110, 5, 'Airpods', '2024-02-29'),
	 (109, 5, 'iPhone', '2024-03-22');


-- QUESTIONS:
-- ------------------------------------------------------------------------------------------------------------+
--  Écris une requête SQL pour trouver les clients qui ont acheté des Airpods après avoir acheté un iPhone.    |
-- ------------------------------------------------------------------------------------------------------------+


-- Réponse:

SELECT DISTINCT c.* 
FROM customers c 
LEFT JOIN purchases p1 ON c.customer_id = p1.customer_id
LEFT JOIN purchases p2 ON c.customer_id = p2.customer_id
WHERE 
	p1.product_name = 'iPhone'
	AND
	p2.product_name = 'Airpods'
	AND
	p1.purchase_date < p2.purchase_date


-- QUESTIONS:
-- ------------------------------------------------------------------------------------------------------------+
--  Déterminez le pourcentage de chances qu'un client ayant acheté un MacBook achète des AirPods.              |
-- ------------------------------------------------------------------------------------------------------------+

-- Réponse:

SELECT 
	CONCAT(ROUND((COUNT(p1.customer_id) / COUNT(p1.customer_id))*100, 2) ,' %') AS pourcentage
FROM purchases p1
LEFT JOIN purchases p2 ON p1.customer_id = p2.customer_id
WHERE p1.product_name = 'MacBook'
  AND p2.product_name = 'Airpods';





