-- JOUR 16/50

-- Création de la table et insertion des données 

DROP TABLE IF EXISTS employees;
CREATE TABLE employees(
	id INT PRIMARY KEY,
	name VARCHAR(15),
	departement VARCHAR(15),
	manager_id INT
);


INSERT INTO employees(id, name, departement, manager_id)
VALUES
	(101, 'John', 'A', NULL),
	(102, 'Dan', 'A', 101),
	(103, 'James', 'A', 101),
	(104, 'Amy', 'A', 101),
	(105, 'Anne', 'A', 101),
	(106, 'Ron', 'B', 101),
	(107, 'Michael', 'C', NULL),
	(108, 'Sarah', 'C', 107),
	(109, 'Emily', 'C', 107),
	(110, 'Brian', 'C', 107);


-- QUESTIONS:
-- +------------------------------------------------------------------------------------------------------+
-- | Trouver les noms des managers ayant au moins cinq subordonnées directs. Assure toi qu'aucun          |
-- | employé n'est son propre manager. Retrouner uniquement les noms des managers répondant aux critères  |
-- +------------------------------------------------------------------------------------------------------+

-- Approche 1:

WITH cte as
(
SELECT
	manager_id
FROM employees
GROUP BY manager_id
HAVING COUNT(manager_id) >= 5
)
SELECT *
FROM employees
WHERE id IN (SELECT manager_id FROM cte);

-- Approche 2:

SELECT
	e2.id,
	e2.name AS manager_name,
	COUNT(e1.manager_id)
FROM employees e1
JOIN employees e2 ON e1.manager_id = e2.id
GROUP BY 
	e2.id,
	e2.name
HAVING COUNT(e1.manager_id) >= 5;



