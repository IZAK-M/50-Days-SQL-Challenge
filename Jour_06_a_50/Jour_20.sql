-- JOUR 20/50

-- Création de la table products

DROP TABLE IF EXISTS products;
CREATE TABLE products(
		product_id INT,
		product_name VARCHAR(15),
		supplier_name VARCHAR(15)
);

-- Insertion des données:

INSERT INTO products
VALUES
    (1, 'Product 1', 'Supplier A'),
    (1, 'Product 1', 'Supplier B'),
    (3, 'Product 3', 'Supplier A'),
    (3, 'Product 3', 'Supplier A'),
    (5, 'Product 5', 'Supplier A'),
    (5, 'Product 5', 'Supplier B'),
    (7, 'Product 7', 'Supplier C'),
    (8, 'Product 8', 'Supplier A'),
    (7, 'Product 7', 'Supplier B'),
    (7, 'Product 7', 'Supplier A'),
    (9, 'Product 9', 'Supplier B'),
    (9, 'Product 9', 'Supplier C'),
    (10, 'Product 10', 'Supplier C'),
    (11, 'Product 11', 'Supplier C'),
    (10, 'Product 10', 'Supplier A');

-- QUESTIONS:
-- +---------------------------------------------------------------------------------------+
-- |Rédige une requête pour trouver les produits vendus à la fois par le Fournisseur A et  |
-- |le Fournisseur B, en excluant les produits vendus par un seul de ces deux fournisseurs.|
-- +---------------------------------------------------------------------------------------+

-- Approche 1:

SELECT * 
FROM products p1
JOIN products p2 ON p1.product_id = p2.product_id
WHERE 
	p1.supplier_name = 'Supplier A' 
	AND
	p2.supplier_name = 'Supplier B';

-- Approche 2:

SELECT 
	product_id,
	product_name,
	COUNT(DISTINCT supplier_name) AS nb_vendeur
FROM products
WHERE supplier_name IN ('Supplier A', 'Supplier B')
GROUP BY 
	product_id,
	product_name
HAVING COUNT(DISTINCT supplier_name) = 2;


-- QUESTIONS:
-- +-------------------------------------------------------------------------------------------------------------+
-- |Trouver les produits vendus par le Fournisseur C et le Fournisseur B, mais pas vendus par le Fournisseur A.  |
-- +-------------------------------------------------------------------------------------------------------------+

-- Approche 1:

SELECT * 
FROM products p1
JOIN products p2 ON p1.product_id = p2.product_id
WHERE 
	p1.supplier_name = 'Supplier C' 
	AND
	p2.supplier_name = 'Supplier B'
	AND
	p1.product_id NOT IN (SELECT DISTINCT product_id FROM products WHERE supplier_name = 'Supplier A');

-- Approche 2:

SELECT 
	product_id,
	product_name,
	COUNT(DISTINCT supplier_name) AS nb_vendeur
FROM products
WHERE 
	supplier_name IN ('Supplier C', 'Supplier B')
	AND
	product_id NOT IN (SELECT DISTINCT product_id FROM products WHERE supplier_name = 'Supplier A')
GROUP BY 
	product_id,
	product_name
HAVING COUNT(DISTINCT supplier_name) = 2;

