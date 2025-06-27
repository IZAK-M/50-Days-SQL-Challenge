-- JOUR 22/50

-- Création de la table delivery:

DROP TABLE IF EXISTS delivery;
CREATE TABLE delivery(
	delivery_id SERIAL PRIMARY KEY,
	customer_id INT,
	order_date DATE,
	customer_pref_delivery_date DATE
);

-- Insertion des données:
INSERT INTO delivery(customer_id, order_date, customer_pref_delivery_date)
VALUES
	(1, '2019-08-01', '2019-08-02'),
	(2, '2019-08-02', '2019-08-02'),
	(1, '2019-08-11', '2019-08-12'),
	(3, '2019-08-24', '2019-08-24'),
	(3, '2019-08-21', '2019-08-22'),
	(2, '2019-08-11', '2019-08-13'),
	(4, '2019-08-09', '2019-08-09'),
	(5, '2019-08-09', '2019-08-10'),
	(4, '2019-08-10', '2019-08-12'),
	(6, '2019-08-09', '2019-08-11'),
	(7, '2019-08-12', '2019-08-13'),
	(8, '2019-08-13', '2019-08-13'),
	(9, '2019-08-11', '2019-08-12'); 
/*
  Si la date de livraison préférée d’un client est la même que la date de commande, 
  alors la commande est dite "immédiate" ; sinon, elle est dite "planifiée".
+---------------------------------------------------------------------------------------------+
| Écris une solution pour calculer le pourcentage de commandes immédiates parmi les premières |
| commandes de tous les clients, arrondi à deux décimales.                                    |
+---------------------------------------------------------------------------------------------+
*/
-- Approche 1:

WITH first_cmd AS
(
SELECT 
	DISTINCT ON (customer_id)*
FROM delivery
ORDER BY customer_id, order_date
)
SELECT
	ROUND(COUNT(CASE WHEN order_date = customer_pref_delivery_date THEN 1 END)* 100::numeric / COUNT(*)::numeric, 2) AS pct_cmd_immediate
FROM first_cmd;

-- Approche 2:

SELECT 
   ROUND(SUM(CASE WHEN order_date = cpdd THEN 1 ELSE 0 END::numeric)/COUNT(*)::numeric * 100, 2) as imd_del_percentage
FROM
    (
    SELECT
        DISTINCT ON(customer_id)
        customer_id,
        order_date,
        customer_pref_delivery_date as cpdd
    FROM Delivery
    ORDER BY customer_id, order_date
);

-- +--------------------------------------------------------------------------------------------+
-- |Déterminer le pourcentage de commandes où les clients ont choisi la livraison le lendemain, |
-- |parmi les premières commandes de chaque client.                                             |
-- +--------------------------------------------------------------------------------------------+

WITH first_cmd AS
(
SELECT 
	DISTINCT ON (customer_id)*
FROM delivery
ORDER BY customer_id, order_date
)
SELECT
	ROUND(COUNT(CASE WHEN order_date + 1 = customer_pref_delivery_date THEN 1 END)* 100::numeric / COUNT(*)::numeric, 2) AS pct_cmd_immediate
FROM first_cmd;

