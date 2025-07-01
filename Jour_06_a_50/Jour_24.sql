-- JOUR 24/50

-- Crétion de la table et insertion des données

DROP TABLE IF EXISTS orders;
CREATE TABLE orders(
	id INT,
	cust_id INT,
	order_date DATE,
	order_details VARCHAR(15),
	total_order_cost INT
);

INSERT INTO orders
VALUES
	(1, 7, '2019-03-04', 'Coat', 100),
	(2, 7, '2019-03-01', 'Shoes', 80),
	(3, 3, '2019-03-07', 'Skirt', 30),
	(4, 7, '2019-02-01', 'Coat', 25),
	(5, 7, '2019-03-10', 'Shoes', 80),
	(6, 1, '2019-02-01', 'Boats', 100),
	(7, 2, '2019-01-11', 'Shirts', 60),
	(8, 1, '2019-03-11', 'Slipper', 20),
	(9, 15, '2019-03-01', 'Jeans', 80),
	(10, 15, '2019-03-09', 'Shirts', 50),
	(11, 5, '2019-02-01', 'Shoes', 80),
	(12, 12, '2019-01-11', 'Shirts', 60),
	(13, 1, '2019-03-11', 'Slipper', 20),
	(14, 4, '2019-02-01', 'Shoes', 80),
	(15, 4, '2019-01-11', 'Shirts', 60),
	(16, 3, '2019-04-19', 'Shirts', 50),
	(17, 7, '2019-04-19', 'Suit', 150),
	(18, 15, '2019-04-19', 'Skirt', 30),
	(19, 15, '2019-04-20', 'Dresses', 200),
	(20, 12, '2019-01-11', 'Coat', 125),
	(21, 7, '2019-04-01', 'Suit', 50),
	(22, 3, '2019-04-02', 'Skirt', 30),
	(23, 4, '2019-04-03', 'Dresses', 50),
	(24, 2, '2019-04-04', 'Coat', 25),
	(25, 7, '2019-04-19', 'Coat', 125);

-- QUESTIONS:
-- +---------------------------------------------------------------------------------+
-- |Calcule le chiffre d'affaires total généré par chaque client en mars 2019.       |
-- |Inclure uniquement les clients actifs durant le mois de mars 2019.               |
-- |La sortie doit contenir le chiffre d'affaires ainsi que l’identifiant du client, |
-- |et les résultats doivent être triés par chiffre d'affaires décroissant.          |
-- +---------------------------------------------------------------------------------+


-- Approche 1:

SELECT 
	cust_id,
	SUM(total_order_cost) AS total_rev_mars
FROM orders
WHERE  EXTRACT(MONTH FROM order_date) = 3
GROUP BY cust_id
ORDER BY total_rev_mars DESC;

-- Alternative

SELECT 
    cust_id,
    SUM(total_order_cost) AS total_rev_mars
FROM orders
WHERE order_date BETWEEN '2019-03-01' AND '2019-03-31'
GROUP BY cust_id
ORDER BY total_rev_mars DESC;

-- QUESTIONS 2:
-- +------------------------------------------------------------------------------------+
-- |Rédige une requête pour trouver les clients ayant effectué des achats à la fois     |
-- |en mars et en avril 2019,ainsi que leur chiffre d'affaires total sur ces deux mois. |
-- +------------------------------------------------------------------------------------+

WITH achats AS
(
SELECT 
	cust_id,
	EXTRACT(MONTH FROM order_date) AS mois,
	SUM(total_order_cost) AS montant_total
FROM orders
WHERE order_date >= '2019-03-01' 
  AND order_date < '2019-05-01'
GROUP BY cust_id, EXTRACT(MONTH FROM order_date)
),
clients_mars AS
(
SELECT DISTINCT cust_id FROM orders WHERE EXTRACT(MONTH FROM order_date) = 3
),
clients_avril AS
(
SELECT DISTINCT cust_id FROM orders WHERE EXTRACT(MONTH FROM order_date) = 4
),
client_cibles AS
(
SELECT cm.cust_id
FROM clients_mars cm
JOIN clients_avril ca ON cm.cust_id = ca.cust_id
)
SELECT 
	a.cust_id,
	SUM(a.montant_total) AS ca_mars_avril
FROM achats a
JOIN client_cibles cc ON a.cust_id = cc.cust_id
GROUP BY a.cust_id;


-- 