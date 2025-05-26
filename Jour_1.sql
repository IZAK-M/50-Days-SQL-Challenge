-- JOUR 1/50

-- Création de la table employees

DROP TABLE IF EXISTS employees;
CREATE TABLE employees(
	employee_id SERIAL PRIMARY KEY,
	name VARCHAR(100),
	departement VARCHAR(50),
	salary DECIMAL(10, 2)
);

-- Insertion des données dans la table employees

INSERT INTO employees (name, departement, salary) 
VALUES 
	  ('John Doe', 'Engineering', 63000),
	  ('Jane Smith', 'Engineering', 55000),
	  ('Michael Johnson', 'Engineering', 64000),
	  ('Emily Davis', 'Marketing', 58000),
	  ('Chris Brown', 'Marketing', 56000),
	  ('Emma Wilson', 'Marketing', 59000),
	  ('Alex Lee', 'Sales', 58000),
	  ('Sarah Adams', 'Sales', 58000),
	  ('Ryan Clark', 'Sales', 61000);

-- Vérifions si les données ont été chargées correctement
SELECT * FROM employees;


-- ---------------
-- QUESTION :
-- ---------------
-- Écrire la requête SQL pour trouver le deuxième salaire le plus élevé
-- ---------------

-- Approche 1 : Pas la meilleure, car si plusieurs personnes ont le même salaire, certaines seront ignorées

SELECT * 
FROM employees
ORDER BY salary DESC
LIMIT 1 OFFSET 1;


-- Ajout d'une nouvelle ligne pour illustrer la limite de l'approche 1 :

INSERT INTO employees
VALUES
(11, 'zara', 'it', 63000);

-- Relancez l'approche 1 : Que constatez-vous ? 
-- ------------------------------------------------------------
-- Maintenant, passez à l'approche 2 et constatez la différence 
-- ------------------------------------------------------------


-- Approche 2 : Utilisation d'une fonction fenêtre dans une sous-requête

SELECT *
FROM
(	SELECT *,
 	DENSE_RANK() OVER(ORDER BY salary DESC) AS rang
	FROM employees)
WHERE rang = 2;

-- Même logique, mais avec une CTE:

WITH rang_table AS 
(
SELECT 
	*,
	DENSE_RANK() OVER(ORDER BY salary DESC) AS rang
FROM employees
)
SELECT * FROM rang_table WHERE rang = 2;

-- ---------------
-- QUESTION 1-BIS:
-- ---------------
-- Obtenez les coordonnées de l'employé ayant le deuxième salaire le plus élevé dans chaque département.
-- ---------------

-- Approche 1:

WITH rang_table_2 AS 
(
SELECT 
	*,
	DENSE_RANK() OVER(PARTITION BY departement ORDER BY salary DESC) AS rang
FROM employees
)
SELECT * FROM rang_table_2 WHERE rang = 2;








