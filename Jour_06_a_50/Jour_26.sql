-- JOUR 26/50

-- Création de la table et insertion des données
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    department VARCHAR(100),
    salary DECIMAL(10, 2),
    manager_id INT
);

INSERT INTO employees (employee_id, employee_name, department, salary, manager_id)
VALUES
    (1, 'John Doe', 'HR', 50000.00, NULL),
    (2, 'Jane Smith', 'HR', 55000.00, 1),
    (3, 'Michael Johnson', 'HR', 60000.00, 1),
    (4, 'Emily Davis', 'IT', 60000.00, NULL),
    (5, 'David Brown', 'IT', 65000.00, 4),
    (6, 'Sarah Wilson', 'Finance', 70000.00, NULL),
    (7, 'Robert Taylor', 'Finance', 75000.00, 6),
    (8, 'Jennifer Martinez', 'Finance', 80000.00, 6);

-- QUESTIONS:
-- +------------------------------------------------------------------------------------+
-- | Identifier les employés dont le salaire est supérieur à celui de leur manager.     |
-- +------------------------------------------------------------------------------------+


SELECT 
	e1.*,
	e2.employee_name AS manager_name,
	e2.salary AS manager_salary
FROM employees e1
JOIN employees e2 ON e1.manager_id = e2.employee_id
	             AND e1.salary > e2.salary;



-- QUESTIONS:
-- +------------------------------------------------------------------------------------+
-- | Trouver tous les employés dont le salaire est supérieur au salaire moyen.          |
-- +------------------------------------------------------------------------------------+

SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);


--