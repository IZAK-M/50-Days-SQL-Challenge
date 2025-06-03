-- Jour 8/50

-- Création des tables products et sales

DROP TABLE IF EXISTS products;
CREATE TABLE products(
	product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2)
);


DROP TABLE IF EXISTS sales;
CREATE TABLE sales(
	sales_id SERIAL PRIMARY KEY,
	product_id INT,
	sale_date DATE,
	quantity INT, 
	FOREIGN KEY (product_id) REFERENCES products(product_id)
);


-- Insertion des données

INSERT INTO products (product_name, category, price)
VALUES
	('Product A', 'Category 1', 10.00),
	('Product B', 'Category 2', 15.00),
	('Product C', 'Category 1', 20.00),
	('Product D', 'Category 3', 25.00);

INSERT INTO sales (product_id, sale_date, quantity) 
VALUES
	(1, '2023-09-15', 5),
	(2, '2023-10-20', 3),
	(1, '2024-01-05', 2),
	(3, '2024-02-10', 4),
	(4, '2023-12-03', 1);


-- QUESTIONS:
-- ------------------------------------------------------------------------------------------------------------+
--  Trouver tous les produits qui n'ont pas été vendus au cours des six derniers mois. (ref date : 2024-04-04) |
--  Renvoyez l'identifiant du produit, le nom, la catégorie et le prix.                                        |
-- ------------------------------------------------------------------------------------------------------------+


SELECT 
	p.* 
FROM products p
LEFT JOIN sales s ON p.product_id = s.product_id
WHERE 
	s.sale_date IS NULL
	OR 
	s.sale_date < DATE('2024-04-04')- INTERVAL '6 months';

-- -------------------------------------------------------------------------------------------------------------------+
-- Remarque : La vente du produit A sur les 6 derniers mois devrait entraîner l'exclusion des ID hors de l'intervalle.| 
-- Par conséquent, les ventes hors de l'intervalle ne devraient pas être prises en compte.                            |
-- La question du challenge semble mal formulée et le dataset non pertinent.                                          |
-- -------------------------------------------------------------------------------------------------------------------+

-- Néanmoins, cela nous a permis de mettre en pratique la notion d'intervalle.


-- Q2 : Sélectionner tous les produits qui n'ont pas été vendus pendant l'année 2024 :


WITH sales_2024 AS
(
SELECT * 
FROM sales
WHERE EXTRACT(YEAR FROM sale_date) = 2024
)
SELECT P.* 
FROM products p 
LEFT JOIN sales_2024 s ON p.product_id = s.product_id
WHERE s.product_id IS NULL;

-- ALTERNATIVE :

SELECT * 
FROM products 
WHERE product_id NOT IN (SELECT product_id 
						 FROM sales 
						 WHERE EXTRACT(YEAR FROM sale_date) = 2024 );
