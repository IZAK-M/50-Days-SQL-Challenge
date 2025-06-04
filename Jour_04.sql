-- jour 4/50:

-- Étape 1 : Création de la table orders_q4;
DROP TABLE IF EXISTS orders_q4;
CREATE TABLE orders_q4(
	category VARCHAR(20),
	product VARCHAR(20),
	user_id INT,
	spend INT,
	transaction_date DATE
);

-- Étape 2 : Insertion des données dans notre table 
INSERT INTO orders_q4 
VALUES
	  ('appliance','refrigerator',165,246.00,'2021/12/26'),
	  ('appliance','refrigerator',123,299.99,'2022/03/02'),
	  ('appliance','washingmachine',123,219.80,'2022/03/02'),
	  ('electronics','vacuum',178,152.00,'2022/04/05'),
	  ('electronics','wirelessheadset',156,	249.90,'2022/07/08'),
	  ('electronics','TV',145,189.00,'2022/07/15'),
	  ('Television','TV',165,129.00,'2022/07/15'),
	  ('Television','TV',163,129.00,'2022/07/15'),
	  ('Television','TV',141,129.00,'2022/07/15'),
	  ('toys','Ben10',145,189.00,'2022/07/15'),
	  ('toys','Ben10',145,189.00,'2022/07/15'),
	  ('toys','yoyo',165,129.00,'2022/07/15'),
	  ('toys','yoyo',163,129.00,'2022/07/15'),
	  ('toys','yoyo',141,129.00,'2022/07/15'),
	  ('toys','yoyo',145,189.00,'2022/07/15'),
	  ('electronics','vacuum',145,189.00,'2022/07/15');
	  
-- QUESTIONS:
-- -------------------------------------------------------------------------------------------------------+
-- Trouver les 2 meilleurs produits dans les 2 meilleures catégories en fonction du montant des dépenses. |
-- -------------------------------------------------------------------------------------------------------+

-- Ma Solution:
-- ------------

WITH best_categories AS
(
SELECT 
	category,
	SUM(spend),
	DENSE_RANK() OVER(ORDER BY SUM(spend) DESC ) AS categorie_rang
FROM orders_q4
GROUP BY category
), product_table AS
(
SELECT 
	category,
	product,
	SUM(spend) AS total_spend_product,
	DENSE_RANK() OVER(PARTITION BY category ORDER BY SUM(spend) DESC) AS best_product
FROM orders_q4
WHERE category IN (SELECT category FROM best_categories WHERE categorie_rang <= 2)
GROUP BY category,
	     product
)
SELECT 
	category, 
	product,
	total_spend_product
FROM product_table
WHERE best_product <= 2;



-- Solution du Challenge :
-- -----------------------

WITH ranked_category
AS
(
	SELECT
		category,
		total_spend_category
	FROM 
	(	SELECT 
			category,
			SUM(spend) as total_spend_category,
			DENSE_RANK() OVER( ORDER BY SUM(spend) DESC) drn
		FROM orders_q4
		GROUP BY category
	) as subquery
	WHERE drn <= 2
)
SELECT
	category,
	product,
	total_spend_by_product
FROM (	
		SELECT 
			o.category,
			o.product,
			SUM(o.spend) as total_spend_by_product,
			DENSE_RANK() OVER(PARTITION BY o.category ORDER BY SUM(o.spend) DESC ) as pdrn
		FROM orders_q4 as o
		JOIN ranked_category as rc
		ON rc.category = o.category	
		GROUP BY o.category, o.product
) subquery2
WHERE pdrn <= 2;
