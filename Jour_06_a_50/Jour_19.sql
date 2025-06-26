-- JOUR 19/50

-- Création de la table employees:

DROP TABLE IF EXISTS employees;
CREATE TABLE employees(
	employee_id SERIAL PRIMARY KEY,
	employee_name VARCHAR(25),
	departement VARCHAR(10),
	salary DECIMAL(10, 2)
);

-- Insertions des données:

INSERT INTO employees(employee_name, departement, salary)
VALUES
    ('John Doe', 'HR', 50000.00),
    ('Jane Smith', 'HR', 55000.00),
    ('Michael Johnson', 'HR', 60000.00),
    ('Emily Davis', 'IT', 60000.00),
    ('David Brown', 'IT', 65000.00),
    ('Sarah Wilson', 'Finance', 70000.00),
    ('Robert Taylor', 'Finance', 75000.00),
    ('Jennifer Martinez', 'Finance', 80000.00);


-- QUESTIONS:
-- +-----------------------------------------------------------------------------------+
-- |Rédige une requête SQL pour trouver les informations des employés dont le salaire  |
-- |est supérieur au salaire moyen de l'ensemble de l'entreprise.                      |
-- +-----------------------------------------------------------------------------------+

-- Approche 1:

SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- Approche 2:

SELECT *
FROM
(
	SELECT 
		*,
		ROUND(AVG(salary) OVER(), 2) AS avg_salary
	FROM employees
)
WHERE salary > avg_salary;


-- QUESTIONS 2:
-- +-----------------------------------------------------------------------------------+
-- |Rédige une requête SQL pour calculer le salaire moyen des employés dans chaque     |
-- |département, ainsi que le nombre total d’employés dans chaque département.         |
-- +-----------------------------------------------------------------------------------+

SELECT 
	departement,
	COUNT(employee_id),
	ROUND(AVG(salary), 2) AS avg_salary
FROM employees
GROUP BY departement;


