-- JOUR 6/50

-- Étape 1 : Création des tables customers et orders

DROP TABLE IF EXISTS customers;
CREATE TABLE customers(
	customer_id INT,
	name VARCHAR(100),
	email VARCHAR(100)
);

DROP TABLE IF EXISTS orders_q6;
CREATE TABLE orders_q6(
	order_id INT,
	customer_id INT,
	order_date DATE,
	amount DECIMAL(10, 2)
);

-- Étape 2 : Insertion des données :

INSERT INTO customers (customer_id, name, email) 
VALUES
	  (1, 'John Doe', 'john@example.com'),
	  (2, 'Jane Smith', 'jane@example.com'),
	  (3, 'Alice Johnson', 'alice@example.com'),
	  (4, 'Sam B', 'sb@example.com'),
	  (5, 'John Smith', 'j@example.com');

-- 

INSERT INTO orders_q6 (order_id, customer_id, order_date, amount) 
VALUES
	  (1, 1, '2024-03-05', 50.00),
	  (2, 2, '2024-03-10', 75.00),
	  (5, 4, '2024-04-02', 45.00),
	  (5, 2, '2024-04-02', 45.00),
	  (3, 4, '2024-04-15', 100.00),
	  (4, 1, '2024-04-01', 60.00),
	  (5, 5, '2024-04-02', 45.00);


-- QUESTIONS:
-- -------------------------------------------------------------------------------------------------------+
-- Trouver les clients qui n'ont effectué aucun achat au cours du dernier mois, en supposant que          |
-- la date d'aujourd'hui soit le 2 avril 2024.                                                            |
-- -------------------------------------------------------------------------------------------------------+

-- Ma Solution:
-- ------------

WITH last_month_customers AS
(
SELECT 
	c.customer_id
FROM customers c
LEFT JOIN orders_q6 o ON c.customer_id = o.customer_id
WHERE
	 EXTRACT (MONTH FROM order_date) = EXTRACT (MONTH FROM DATE('2024-04-02'))-1
)
SELECT * 
FROM customers
WHERE customer_id NOT IN (SELECT customer_id FROM last_month_customers);


-- -------------------------------------------------------------------------------------------------------+
-- Trouver les clients qui ont effectué des achats ce mois-ci et aussi le mois dernier                    |
-- en supposant que la date d'aujourd'hui soit le 2 avril 2024.                                           |
-- -------------------------------------------------------------------------------------------------------+

WITH last_month_client AS
(
SELECT c.customer_id
FROM customers c
LEFT JOIN orders_q6 o ON c.customer_id = o.customer_id
WHERE
	EXTRACT (MONTH FROM order_date) = EXTRACT (MONTH FROM DATE('2024-04-02'))-1
)
SELECT 
	c.customer_id,
	c.name,
	c.email
FROM customers c
LEFT JOIN orders_q6 o ON c.customer_id = o.customer_id
WHERE 
	EXTRACT (MONTH FROM order_date) = EXTRACT (MONTH FROM DATE('2024-04-02'))
	AND 
	c.customer_id IN (SELECT * FROM last_month_client);
	 
