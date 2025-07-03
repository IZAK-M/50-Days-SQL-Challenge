-- JOUR 28/50

-- Rétuliser la table "walmart_eu" créer le jour 27 pour répondre a cette question:

-- QUESTIONS:
-- +-----------------------------------------------------------------+
-- |Trouver le produit le plus vendu pour chaque client              |
-- |Retrouner customerid, description, et le nombre total d'achats   |
-- +-----------------------------------------------------------------+

WITH classement AS
(
SELECT 
	customerid,
	description,
	COUNT(*) AS achat_total,
	DENSE_RANK() OVER(PARTITION BY customerid ORDER BY COUNT(*) DESC)  AS rang
FROM walmart_eu
GROUP BY customerid, description
)
SELECT *
FROM classement
WHERE rang = 1;

-- QUESTIONS:
-- +------------------------------------------------------------------+
-- |Trouver le produit le plus vendu par pays                         |
-- |Retrouner le nom du pays, description, et le nombre total de vente|
-- +------------------------------------------------------------------+

WITH classement_pays AS
(
SELECT 
	country,
	description,
	COUNT(description) AS achat_total,
	DENSE_RANK() OVER(PARTITION BY country ORDER BY COUNT(description) DESC)  AS rang
FROM walmart_eu
GROUP BY country, description
)
SELECT *
FROM classement_pays
WHERE rang = 1;


-- 
