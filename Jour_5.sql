-- JOUR 5/50

-- Étape 1 : Création de la table employees

DROP TABLE IF EXISTS employees;
CREATE TABLE employees(
	employee_id INT PRIMARY KEY,
	name VARCHAR(50),
	departement VARCHAR(50),
	salary DECIMAL(10 ,2),
	hire_date DATE
);

-- Étape 2 : Insertion des données dans notre table
INSERT INTO employees (employee_id, name, departement, salary, hire_date)
     VALUES
	       (101, 'John Smith', 'Sales', 60000.00, '2022-01-15'),
           (102, 'Jane Doe', 'Marketing', 55000.00, '2022-02-20'),
		   (103, 'Michael Johnson', 'Finance', 70000.00, '2021-12-10'),
		   (104, 'Emily Brown', 'Sales', 62000.00, '2022-03-05'),
		   (106, 'Sam Brown', 'IT', 62000.00, '2022-03-05'),	
		   (105, 'Chris Wilson', 'Marketing', 58000.00, '2022-01-30');

-- QUESTIONS:
-- -------------------------------------------------------------------------------------------------------+
-- Écrivez une requête SQL pour extraire le troisième salaire le plus élevé de la table Employés          |
-- -------------------------------------------------------------------------------------------------------+

-- Ma Solution:
-- ------------

SELECT 
	salary AS "Troisième salaire le plus élevé"
FROM
    (SELECT 
    	*,
    	DENSE_RANK() OVER(ORDER BY salary DESC) AS rang
    FROM employees
	)
WHERE rang = 3;



-- -------------------------------------------------------------------------------------------------------+
-- Trouver les détails de l'employé qui a le salaire le plus élevé dans chaque département                |
-- -------------------------------------------------------------------------------------------------------+

WITH classement AS
(
SELECT *,
	DENSE_RANK() OVER(PARTITION BY departement ORDER BY salary DESC) rang
FROM employees
)
SELECT * 
FROM classement 
WHERE rang = 1;
