-- JOUR 2/50

-- Création de la table orders et returns

DROP TABLE IF EXISTS orders;

CREATE TABLE orders(
	order_id INT PRIMARY KEY,
	order_date DATE,
	total_amount DECIMAL(10, 2)
);

DROP TABLE IF EXISTS returns;

CREATE TABLE returns(
	return_id INT PRIMARY KEY,
	order_id INT,
	FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- Insertion des données dans les table :

INSERT INTO orders (order_id, order_date, total_amount) 
VALUES
	  (1, '2023-01-15', 150.50),
	  (2, '2023-02-20', 200.75),
	  (3, '2023-02-28', 300.25),
	  (4, '2023-03-10', 180.00),
	  (5, '2023-04-05', 250.80);

INSERT INTO Returns (return_id, order_id) 
VALUES
	  (101, 2),
	  (102, 4),
	  (103, 5),
	  (104, 1),
      (105, 3);



-- Vérifions si les données ont été chargées correctement
SELECT * FROM orders;	
SELECT * FROM returns;


-- ----------
-- QUESTION :
-- -------------------------------------------------------------------------------------
-- Écris une requête SQL pour calculer le nombre total de commandes retournées par mois.
-- -------------------------------------------------------------------------------------

-- RÉPONSES:

-- Approche 1:

SELECT 
	EXTRACT(MONTH FROM o.order_date) AS Mois,
	count(return_id) AS total_retour
FROM orders o
LEFT JOIN returns r ON o.order_id = r.order_id
GROUP BY EXTRACT(MONTH FROM o.order_date) 
ORDER BY Mois;

-- Approche 1 améliorée : Ici, j'ajoute une colonne nom pour rendre ma sortie plus lisible.
SELECT 
	EXTRACT(MONTH FROM o.order_date) AS Mois,
	TO_CHAR(o.order_date, 'Month') AS nom,
	count(return_id) AS total_retour
FROM orders o
LEFT JOIN returns r ON o.order_id = r.order_id
GROUP BY EXTRACT(MONTH FROM o.order_date) , 
		 TO_CHAR(o.order_date, 'Month')
ORDER BY Mois;

-- #################################################################################################################################
-- # Remarque : Étant donné le faible volume de données dans nos tables, nous pourrions nous baser uniquement sur la table orders, #
-- # puisque toutes les commandes ont été retournées.                                                                              #
-- # Cependant, gardez à l'esprit qu'il s'agit ici de tables d'exemple. Dans la réalité, les données seront bien plus diversifiées.#
-- #################################################################################################################################
--------------------







