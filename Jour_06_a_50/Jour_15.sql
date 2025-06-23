-- JOUR 15/50

-- Création de la Table et insertion des données :

DROP TABLE IF EXISTS orders;
CREATE TABLE orders(
	order_id SERIAL PRIMARY KEY,
	order_date DATE,
	product_id INT,
	quantity INT,
	price DECIMAL(10, 2)
);

-- Insertion des donées 
INSERT INTO orders (order_date, product_id, quantity, price)
VALUES
    ('2024-04-01', 1, 10, 50.00),
    ('2024-04-02', 2, 8, 40.00),
    ('2024-04-03', 3, 15, 30.00),
    ('2024-04-04', 4, 12, 25.00),
    ('2024-04-05', 5, 5, 60.00),
    ('2024-04-06', 6, 20, 20.00),
    ('2024-04-07', 7, 18, 35.00),
    ('2024-04-08', 8, 14, 45.00),
    ('2024-04-09', 1, 10, 50.00),
    ('2024-04-10', 2, 8, 40.00),
	('2024-03-01', 1, 12, 50.00),
    ('2024-03-02', 2, 10, 40.00),
    ('2024-03-03', 3, 18, 30.00),
    ('2024-03-04', 4, 14, 25.00),
    ('2024-03-05', 5, 7, 60.00),
    ('2024-03-06', 6, 22, 20.00),
    ('2024-03-07', 7, 20, 35.00),
    ('2024-03-08', 8, 16, 45.00),
    ('2024-03-09', 1, 12, 50.00),
    ('2024-03-10', 2, 10, 40.00),
	('2024-02-01', 1, 15, 50.00),
    ('2024-02-02', 2, 12, 40.00),
    ('2024-02-03', 3, 20, 30.00),
    ('2024-02-04', 4, 16, 25.00),
    ('2024-02-05', 5, 9, 60.00),
    ('2024-02-06', 6, 25, 20.00),
    ('2024-02-07', 7, 22, 35.00),
    ('2024-02-08', 8, 18, 45.00),
    ('2024-02-09', 1, 15, 50.00),
    ('2024-02-10', 2, 12, 40.00);

-- Vérification 

SELECT *
FROM orders;


-- QUESTIONS:
-- +----------------------------------------------------------------------------------------------------------------------------+
-- | Récupérer les détails des produits dont le chiffre d'affaires a diminué par rapport au mois précédent.                     |
-- | Affichez l'identifiant du produit, la quantité vendue, et le chiffre d'affaires pour le mois en cours et le mois précédent.|
-- | Avec mois en cours = AVRIL donc 4
-- +----------------------------------------------------------------------------------------------------------------------------+

WITH rev_mois_courant AS 
(
    SELECT
        product_id,
        SUM(quantity) AS qte_mois_courant,
        SUM(price * quantity) AS rev_mois_courant
    FROM orders
    WHERE EXTRACT(MONTH FROM order_date) = 4
    GROUP BY product_id
),
rev_mois_precedent AS 
(
    SELECT
        product_id,
        SUM(quantity) AS qte_mois_precedent,
        SUM(price * quantity) AS rev_mois_precedent
    FROM orders
    WHERE EXTRACT(MONTH FROM order_date) = 4 - 1
    GROUP BY product_id
)
SELECT
    rmc.product_id,
    rmc.qte_mois_courant,
    rmp.qte_mois_precedent,
    rmc.rev_mois_courant,
    rmp.rev_mois_precedent
FROM rev_mois_courant AS rmc
JOIN rev_mois_precedent AS rmp
    ON rmc.product_id = rmp.product_id
WHERE rmc.rev_mois_courant < rmp.rev_mois_precedent;

-- +--------------------------------------------------------------------------------------------------------+
-- |Tâche : Écrire une requête SQL pour identifier les produits dont le chiffre d'affaires total a diminué  |
-- |de plus de 10 % entre le mois précédent et le mois actuel.                                              |
-- +--------------------------------------------------------------------------------------------------------+

WITH rev_mois_courant AS 
(
    SELECT
        product_id,
        SUM(quantity) AS qte_mois_courant,
        SUM(price * quantity) AS rev_mois_courant
    FROM orders
    WHERE EXTRACT(MONTH FROM order_date) = 4
    GROUP BY product_id
),
rev_mois_precedent AS 
(
    SELECT
        product_id,
        SUM(quantity) AS qte_mois_precedent,
        SUM(price * quantity) AS rev_mois_precedent
    FROM orders
    WHERE EXTRACT(MONTH FROM order_date) = 4 - 1
    GROUP BY product_id
)
SELECT
    rmc.product_id,
    rmc.qte_mois_courant,
    rmp.qte_mois_precedent,
    rmc.rev_mois_courant,
    rmp.rev_mois_precedent,
	rmp.rev_mois_precedent - (rmp.rev_mois_precedent * 0.1) AS "mois precedent -10 %"
FROM rev_mois_courant AS rmc
JOIN rev_mois_precedent AS rmp
    ON rmc.product_id = rmp.product_id
WHERE 
	rmc.rev_mois_courant < rmp.rev_mois_precedent
	AND
	rmc.rev_mois_courant < rmp.rev_mois_precedent - (rmp.rev_mois_precedent * 0.1);

	

	