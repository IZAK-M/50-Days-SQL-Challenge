-- JOUR 12/50

-- Création des tables
DROP TABLE IF EXISTS employees;
CREATE TABLE employees(
	id INT PRIMARY KEY,
	name VARCHAR(15)
);

DROP TABLE IF EXISTS employee_uni;
CREATE TABLE employee_uni(
	id INT PRIMARY KEY,
	unique_id INT
);


-- Insertion des données:

INSERT INTO employees (id, name) 
VALUES
    (1, 'Alice'),
    (7, 'Bob'),
    (11, 'Meir'),
    (90, 'Winston'),
    (3, 'Jonathan');

INSERT INTO employee_uni (id, unique_id) VALUES
    (3, 1),
    (11, 2),
    (90, 3);



-- QUESTIONS:
-- +----------------------------------------------------------------------------------------------------------------------------+
-- | Afficher l’identifiant unique de chaque utilisateur. Si un utilisateur n’a pas d’identifiant unique, remplacer par NULL.   |                                  |
-- | Retourner le nom de l’employé et son identifiant unique.                                                                   |
-- +----------------------------------------------------------------------------------------------------------------------------+

SELECT 
	e.name,
	u.unique_id
FROM employees e
LEFT JOIN employee_uni u ON e.id = u.id

-- Remplacer les valeurs nulles par 0 pour l'employé qui n'a pas d'identifiant unique.

SELECT 
	e.name,
	COALESCE(u.unique_id, 0) AS unique_id
FROM employees e
LEFT JOIN employee_uni u ON e.id = u.id;