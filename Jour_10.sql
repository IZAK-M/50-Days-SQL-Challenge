-- JOUR 10/50

-- Création de la table employee

DROP TABLE IF EXISTS employees;
CREATE TABLE employees(
	employee_id INT PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	departement VARCHAR(50),
	salary NUMERIC(10, 2)
);

-- Insertion des données :

INSERT INTO employees
VALUES 
	 (1, 'John', 'Doe', 'Finance', 75000.00),
	 (2, 'Jane', 'Smith', 'HR', 60000.00),
	 (3, 'Michael', 'Johnson', 'IT', 45000.00),
	 (4, 'Emily', 'Brown', 'Marketing', 55000.00),
	 (5, 'David', 'Williams', 'Finance', 80000.00),
	 (6, 'Sarah', 'Jones', 'HR', 48000.00),
	 (7, 'Chris', 'Taylor', 'IT', 72000.00),
	 (8, 'Jessica', 'Wilson', 'Marketing', 49000.00);

-- QUESTIONS:
-- ------------------------------------------------------------------------------------------------------------+
--  Rédigez une requête SQL pour classer les employés en trois catégories en fonction de leur salaire :        |
-- « Élevé » - Salaire supérieur à 70 000                                                                      |
-- « Moyen » - Salaire compris entre 50 000 et 70 000 $ (inclus)                                               |
-- « Faible » - Salaire inférieur à 50 000                                                                     |
-- Votre requête doit renvoyer l'identifiant de l'employé, son prénom, son nom, son département, son salaire,  |
-- ainsi qu'une nouvelle colonne, SalaryCategory, indiquant la catégorie de salaire.                           |
-- ------------------------------------------------------------------------------------------------------------+

-- Réponse: 

SELECT 
	*,
	CASE
		WHEN salary > 70000 THEN 'Élevé'
		WHEN salary BETWEEN 50000 AND 70000 THEN 'Moyen'
		WHEN salary < 50000 THEN 'Faible'
	END AS salary_category
FROM employees;

-- QUESTIONS:
-- ----------------------------------------------------------------------+
--  Déterminer le nombre d'employés pour chaque catégorie de salaire     |
-- ----------------------------------------------------------------------+

-- Réponse:

WITH category_table AS
(
SELECT 
	*,
	CASE
		WHEN salary > 70000 THEN 'Élevé'
		WHEN salary BETWEEN 50000 AND 70000 THEN 'Moyen'
		WHEN salary < 50000 THEN 'Faible'
	END AS salary_category
FROM employees
)
SELECT
	salary_category,
	COUNT(*) AS nb_employe
FROM category_table
GROUP BY salary_category;

-- ALTERNATIVE:
SELECT 
	COUNT(CASE WHEN salary > 70000 THEN 1 END) AS "Élevé",
	COUNT(CASE WHEN salary BETWEEN 50000 AND 70000 THEN 1 END) AS "Moyen",
	COUNT(CASE WHEN salary < 50000  THEN 1 END) AS "Faible"
FROM employees;
