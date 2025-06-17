-- JOUR 13/50

-- Création de la table et insertion des données:

DROP TABLE IF EXISTS employees;
CREATE TABLE employees(
	emp_id INT PRIMARY KEY,
	name VARCHAR(25),
	manager_id INT,
	FOREIGN KEY (manager_id) REFERENCES employees(emp_id)
);

INSERT INTO employees (emp_id, name, manager_id) 
VALUES
	(1, 'John Doe', NULL),        -- John Doe is not a manager
	(2, 'Jane Smith', 1),          -- Jane Smith's manager is John Doe
	(3, 'Alice Johnson', 1),       -- Alice Johnson's manager is John Doe
	(4, 'Bob Brown', 3),           -- Bob Brown's manager is Alice Johnson
	(5, 'Emily White', NULL),      -- Emily White is not a manager
	(6, 'Michael Lee', 3),         -- Michael Lee's manager is Alice Johnson
	(7, 'David Clark', NULL),      -- David Clark is not a manager
	(8, 'Sarah Davis', 2),         -- Sarah Davis's manager is Jane Smith
	(9, 'Kevin Wilson', 2),        -- Kevin Wilson's manager is Jane Smith
	(10, 'Laura Martinez', 4);     -- Laura Martinez's manager is Bob Brown

-- QUESTIONS:
-- +----------------------------------------------------------------------------------------------------------------------------------------------+
-- | Écrire une requête SQL pour récupérer les détails de tous les employés ainsi que les noms de leurs managers en se basant sur l'ID du manager.|
-- +----------------------------------------------------------------------------------------------------------------------------------------------+

SELECT 
	e1.*,
	COALESCE (e2.name, 'Manager') AS manager_name
FROM employees e1
LEFT JOIN employees e2 ON e1.manager_id = e2.emp_id;

-- Trouver tous les managers  

SELECT *
FROM employees e1
WHERE manager_id IS NULL;