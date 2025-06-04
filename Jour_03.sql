-- jour 3/50:

-- Étape 1 : Création de la table products;
DROP TABLE IF EXISTS products;
CREATE TABLE products(
	product_id INT PRIMARY KEY,
	product_name VARCHAR(50),
	category VARCHAR(50),
	quantity_sold INT
);

-- Étape 2 : Insertion des données dans notre table 
INSERT INTO products(product_id, product_name, category, quantity_sold)
     VALUES
		   (1, 'Samsung Galaxy S20', 'Electronics', 100),
		   (2, 'Apple iPhone 12 Pro', 'Electronics', 150),
		   (3, 'Sony PlayStation 5', 'Electronics', 80),
		   (4, 'Nike Air Max 270', 'Clothing', 200),
		   (5, 'Adidas Ultraboost 20', 'Clothing', 200),
		   (6, 'Levis Mens 501 Jeans', 'Clothing', 90),
		   (7, 'Instant Pot Duo 7-in-1', 'Home & Kitchen', 180),
		   (8, 'Keurig K-Classic Coffee Maker', 'Home & Kitchen', 130),
		   (9, 'iRobot Roomba 675 Robot Vacuum', 'Home & Kitchen', 130),
		   (10, 'Breville Compact Smart Oven', 'Home & Kitchen', 90),
		   (11, 'Dyson V11 Animal Cordless Vacuum', 'Home & Kitchen', 90);

-- QUESTIONS:
-- ----------------------------------------------------------------------------------------+
-- Écrire une requête SQL pour trouver les produits les plus vendus dans chaque catégorie. |
-- ----------------------------------------------------------------------------------------+

WITH rang_table AS
(
SELECT 
	*,
	DENSE_RANK() OVER(PARTITION BY category ORDER BY quantity_sold DESC) AS rang
FROM products
)
SELECT *
FROM rang_table
WHERE rang = 1;


-- QUESTIONS BIS:
-- ----------------------------------------------------------------------------------------+
-- Écrire une requête SQL pour trouver les produits les moins vendus dans chaque catégorie |
-- ----------------------------------------------------------------------------------------+


WITH rang_table AS
(
SELECT 
	*,
	DENSE_RANK() OVER(PARTITION BY category ORDER BY quantity_sold ASC) AS rang -- Il suffit d'inverser l'ordre ici. 
FROM products
)
SELECT *
FROM rang_table
WHERE rang = 1;

-- 





		   