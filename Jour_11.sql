-- JOUR 11/50

-- Création des tables orders et returns

DROP TABLE IF EXISTS orders;
CREATE TABLE orders(
	order_id VARCHAR(10),
	customer_id varchar(10),
	order_date DATE,
	product_id VARCHAR(10),
	quantity INT	
);

DROP TABLE IF EXISTS returns;
CREATE TABLE returns(
	return_id VARCHAR(10),
	order_id VARCHAR(10)
);

-- Insertion des données :

INSERT INTO orders
VALUES
    ('1001', 'C001', '2023-01-15', 'P001', 4),
    ('1002', 'C001', '2023-02-20', 'P002', 3),
    ('1003', 'C002', '2023-03-10', 'P003', 8),
    ('1004', 'C003', '2023-04-05', 'P004', 2),
    ('1005', 'C004', '2023-05-20', 'P005', 3),
    ('1006', 'C002', '2023-06-15', 'P001', 6),
    ('1007', 'C003', '2023-07-20', 'P002', 1),
    ('1008', 'C004', '2023-08-10', 'P003', 2),
    ('1009', 'C005', '2023-09-05', 'P002', 3),
    ('1010', 'C001', '2023-10-20', 'P002', 1);

INSERT INTO returns
VALUES
    ('R001', '1001'),
    ('R002', '1002'),
    ('R003', '1005'),
    ('R004', '1008'),
    ('R005', '1007');

-- QUESTIONS:
-- +------------------------------------------------------------------------------------------------------------------------------------+
-- | Identifier les clients qui ont fait un retour en fonction de l'historique de leurs commandes.                                      |
-- | Classer les clients dans la catégorie « Retour » s'ils ont effectué plus d'un retour, sinn  comme «nouveaux» dans le cas contraire.|
-- +------------------------------------------------------------------------------------------------------------------------------------+

-- Réponse:


SELECT 
	o.customer_id,
	COUNT(o.order_id) AS nb_achat,
	COUNT(r.return_id) AS nb_retour,
	CASE
		WHEN COUNT(r.return_id) > 1 THEN 'Retour' 
		ELSE 'Nouveaux' 
	END AS categorie
FROM orders o
LEFT JOIN returns r ON o.order_id = r.order_id
WHERE return_id IS NOT NULL
GROUP BY o.customer_id;






/*

Tâche :

Classer les produits en trois catégories en fonction de la quantité vendue :
« Faible demande » : Quantité vendue inférieure ou égale à 5.
« Demande moyenne » : Quantité vendue comprise entre 6 et 10 (inclus).
« Forte demande » : Quantité vendue supérieure à 10.
Résultat attendu :

ID du produit, Quantité vendue, Catégorie de demande
*/


SELECT 
	product_id,
	SUM(quantity) AS total_vendu,
	CASE
		WHEN SUM(quantity) <= 5 THEN 'Faible demande'
		WHEN SUM(quantity) BETWEEN 6 AND 10 THEN 'Demande moyenne'
		WHEN SUM(quantity) > 10 THEN 'Forte demande'
	END AS categorie
FROM orders
GROUP BY product_id;
