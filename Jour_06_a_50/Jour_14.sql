-- JOUR 14/50

-- Créations des tables: 

DROP TABLE IF EXISTS customers;
CREATE TABLE customers(
	customer_id INT PRIMARY KEY,
	customer_name VARCHAR(100),
	customer_email VARCHAR(100)
);

DROP TABLE IF EXISTS orders;
CREATE TABLE orders(
	order_id INT PRIMARY KEY,
	customer_id INT,
	order_date DATE,
	order_amount DECIMAL(10, 2),
	FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Insertions des données:
INSERT INTO customers (customer_id, customer_name, customer_email)
VALUES
	(1, 'John Doe', 'john@example.com'),
	(2, 'Jane Smith', 'jane@example.com'),
	(3, 'Alice Johnson', 'alice@example.com'),
	(4, 'Bob Brown', 'bob@example.com');

INSERT INTO orders (order_id, customer_id, order_date, order_amount)
VALUES
	(1, 1, '2024-01-03', 50.00),
	(2, 2, '2024-01-05', 75.00),
	(3, 1, '2024-01-10', 25.00),
	(4, 3, '2024-01-15', 60.00),
	(5, 2, '2024-01-20', 50.00),
	(6, 1, '2024-02-01', 100.00),
	(7, 2, '2024-02-05', 25.00),
	(8, 3, '2024-02-10', 90.00),
	(9, 1, '2024-02-15', 50.00),
	(10, 2, '2024-02-20', 75.00);




-- QUESTIONS:
-- +----------------------------------------------------------------------------------------------+
-- | Trouvez les deux clients ayant dépensé le plus d'argent sur l'ensemble de leurs commandes.   |
-- | Retournez leur nom, leur email et le montant total dépensé.                                  |
-- +----------------------------------------------------------------------------------------------+

-- Approche 1:

SELECT 
	c.customer_name,
	c.customer_email,
	SUM(o.order_amount) AS total_depense
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY 
	c.customer_name,
	c.customer_email
ORDER BY total_depense DESC 
LIMIT 2;

-- Approche 2:

WITH total_spend AS
(
SELECT
	customer_id,
	SUM(order_amount) AS total_depense
FROM orders
GROUP BY customer_id
)
SELECT 
	c.customer_name,
	c.customer_email,
	t.total_depense
FROM total_spend t
JOIN customers c ON t.customer_id = c.customer_id
ORDER BY total_depense DESC
LIMIT 2;


-- Découvrez les détails des clients avec le nombre total de commandes et le montant total dépensé.

SELECT 
	DISTINCT o.customer_id,
	c.customer_name,
	c.customer_email,
	COUNT(o.order_id) OVER( PARTITION BY o.customer_id ) AS nb_commande,
	SUM(o.order_amount) OVER( PARTITION BY o.customer_id) AS total_depense
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
ORDER BY total_depense DESC;


