-- JOUR 17/50

-- Créations des tables customers et purchases 

DROP TABLE IF EXISTS customers;
CREATE TABLE customers(
	customer_id INT PRIMARY KEY,
	customer_name VARCHAR(50)
);

DROP TABLE IF EXISTS purchases;
CREATE TABLE purchases (
	purchase_id INT PRIMARY KEY,
	customer_id INT,
	product_category VARCHAR(50),
	FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Insertions des données

INSERT INTO customers(customer_id, customer_name)
VALUES
    (1, 'Alice'),
    (2, 'Bob'),
    (3, 'Charlie'),
    (4, 'David'),
    (5, 'Emma');


INSERT INTO purchases
VALUES
    (101, 1, 'Electronics'),
    (102, 1, 'Books'),
    (103, 1, 'Clothing'),
    (104, 1, 'Electronics'),
    (105, 2, 'Clothing'),
    (106, 1, 'Beauty'),
    (107, 3, 'Electronics'),
    (108, 3, 'Books'),
    (109, 4, 'Books'),
    (110, 4, 'Clothing'),
    (111, 4, 'Beauty'),
    (112, 5, 'Electronics'),
    (113, 5, 'Books');

-- QUESTIONS:
-- +------------------------------------------------------------------------------------------------------------------+
-- | Rédige une requête SQL pour trouver les clients ayant effectué des achats dans toutes les catégories de produits.|
-- | La requête doit retourner le customer_id et le customer_name de ces clients.                                     |
-- +------------------------------------------------------------------------------------------------------------------+


-- Approche 1:

WITH client_categories AS
(
SELECT 
	customer_id,
	COUNT(DISTINCT product_category) AS nb_category
FROM purchases
GROUP BY customer_id
)
SELECT 
	cc.customer_id,
	cu.customer_name
FROM client_categories  cc
JOIN customers cu ON cc.customer_id = cu.customer_id
WHERE nb_category = (SELECT COUNT(DISTINCT product_category) FROM purchases);



-- Approche 2:

SELECT 
    c.customer_id,
    c.customer_name,
    COUNT(DISTINCT p.product_category)
FROM customers  c
JOIN purchases  p ON p.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING  COUNT(DISTINCT p.product_category) = (SELECT COUNT(DISTINCT product_category)
                                              FROM purchases);
											  
-- +------------------------------------------------------------------------------------------------------------------+
-- |Rédige une requête SQL pour identifier les clients qui n'ont effectué aucun achat dans les catégories Électronique|
-- +------------------------------------------------------------------------------------------------------------------+

SELECT *
FROM customers 
WHERE customer_id NOT IN (SELECT DISTINCT customer_id
                          FROM purchases
                          WHERE product_category = 'Electronics');

