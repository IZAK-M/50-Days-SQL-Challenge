-- JOUR 21/50

-- Création de la table products:

DROP TABLE IF EXISTS products;
CREATE TABLE products(
	product_id INT PRIMARY KEY,
	product_name VARCHAR(15),
	price DECIMAL(10, 2),
	quantity_sold INT
);

-- Insertion des donneés:
INSERT INTO products(product_id, product_name, price, quantity_sold)
VALUES
    (1, 'iPhone', 899.00, 600),
    (2, 'iMac', 1299.00, 150),
    (3, 'MacBook Pro', 1499.00, 500),
    (4, 'AirPods', 499.00, 800),
    (5, 'Accessories', 199.00, 300);

-- QUESTIONS:
-- +---------------------------------------------------------------------------------------+
-- |Calculer la contribution en pourcentage de chaque produit au chiffre d'affaires total, | 
-- |en arrondissant le résultat à deux décimales.                                          |
-- +---------------------------------------------------------------------------------------+

-- Approche 1:

SELECT
	*,
	price * quantity_sold AS item_revenue,
	ROUND(price * quantity_sold / (SELECT SUM(price * quantity_sold) FROM products) * 100, 2) AS pourcentage_contribution
FROM products;


-- Approche 2

WITH revenue_table AS
(
SELECT 
	*,
	price * quantity_sold AS item_revenue,
	SUM(price * quantity_sold) OVER() AS total_revenue
FROM products
)
SELECT 
	*,
	ROUND((item_revenue * 100) / total_revenue, 2) AS pourcentage_contribution
FROM revenue_table;


-- Détermine quelle est la contribution du MacBook Pro et de l’iPhone au chiffre d’affaires total.


SELECT
	*,
	price * quantity_sold AS item_revenue,
	ROUND(price * quantity_sold / (SELECT SUM(price * quantity_sold) FROM products) * 100, 2) AS pourcentage_contribution
FROM products
WHERE product_name IN ('iPhone', 'MacBook Pro' );
