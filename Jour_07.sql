-- JOUR 7/50

-- Création de la table employees

DROP TABLE IF EXISTS employees;

CREATE TABLE employees(
	emp_id INT,
	name VARCHAR(100),
	departement VARCHAR(50),
	salary DECIMAL(10, 2)
);


-- Insertion de nouveaux enregistrements pour simuler les doublons  

INSERT INTO employees
VALUES
	(1, 'John Doe', 'Finance', 60000.00),
	(2, 'Jane Smith', 'Finance', 65000.00), 
	(2, 'Jane Smith', 'Finance', 65000.00),   -- Doublon
	(9, 'Lisa Anderson', 'Sales', 63000.00),
	(9, 'Lisa Anderson', 'Sales', 63000.00),  -- Doublon
	(9, 'Lisa Anderson', 'Sales', 63000.00),  -- Doublon
	(10, 'Kevin Martinez', 'Sales', 61000.00);


-- QUESTIONS:
-- -------------------------------------------------------------------------------------------------------+
--  Identifier les doublons dans la tables employees                                                      |
-- -------------------------------------------------------------------------------------------------------+


-- Approche 1: Pour une exploration rapide 

SELECT 
	emp_id,
	name,
	COUNT(emp_id) AS nb_doublon
FROM employees
GROUP BY emp_id, name
HAVING count(emp_id) > 1;


-- Approche 2 : Utilisation d'une fonction de fenêtrage pour obtenir plus de détails  

WITH doublon_table AS
(
	SELECT 
	*,
	ROW_NUMBER() OVER(PARTITION BY emp_id, name ) nb_doublon
	FROM employees
)
SELECT * 
FROM doublon_table 
WHERE nb_doublon > 1;


-- -------------------------------------------------------------------------------------------------------+
--  Identifier les détails de l'employé apparaîsant  plus de deux fois                                    |
-- -------------------------------------------------------------------------------------------------------+


WITH doublon_table AS
(
SELECT 
	*,
	ROW_NUMBER() OVER(PARTITION BY emp_id, name ) nb_doublon
FROM employees
)
SELECT * 
FROM doublon_table 
WHERE nb_doublon > 2; -- Il Suffit de changer le nombre de doublon dans notre filtre












