-- JOUR 18/50

-- Création de la table et insertion des données

DROP TABLE IF EXISTS hotel_bookings;
CREATE TABLE hotel_bookings(
	booking_id SERIAL PRIMARY KEY,
	booking_date DATE,
	hotel_name VARCHAR(10),
	total_guests INT,
	total_nights INT,
	total_price DECIMAL(10, 2)
);

INSERT INTO hotel_bookings(booking_date, hotel_name, total_guests, total_nights, total_price)
VALUES
	('2023-01-05', 'Hotel A', 2, 3, 300.00),
    ('2023-02-10', 'Hotel B', 3, 5, 600.00),
    ('2023-03-15', 'Hotel A', 4, 2, 400.00),
    ('2023-04-20', 'Hotel B', 2, 4, 500.00),
    ('2023-05-25', 'Hotel A', 3, 3, 450.00),
    ('2023-06-30', 'Hotel B', 5, 2, 350.00),
    ('2023-07-05', 'Hotel A', 2, 5, 550.00),
    ('2023-08-10', 'Hotel B', 3, 3, 450.00),
    ('2023-09-15', 'Hotel A', 4, 4, 500.00),
    ('2023-10-20', 'Hotel B', 2, 3, 300.00),
    ('2023-11-25', 'Hotel A', 3, 2, 350.00),
    ('2023-12-30', 'Hotel B', 5, 4, 600.00),
    ('2022-01-05', 'Hotel A', 2, 3, 300.00),
    ('2022-02-10', 'Hotel B', 3, 5, 600.00),
    ('2022-03-15', 'Hotel A', 4, 2, 400.00),
    ('2022-04-20', 'Hotel B', 2, 4, 500.00),
    ('2022-05-25', 'Hotel A', 3, 3, 450.00),
    ('2022-06-30', 'Hotel B', 5, 2, 350.00),
    ('2022-07-05', 'Hotel A', 2, 5, 550.00),
    ('2022-08-10', 'Hotel B', 3, 3, 450.00),
    ('2022-09-15', 'Hotel A', 4, 4, 500.00),
    ('2022-10-20', 'Hotel B', 2, 3, 300.00),
    ('2022-11-25', 'Hotel A', 3, 2, 350.00),
    ('2022-12-30', 'Hotel B', 5, 4, 600.00);


-- QUESTIONS:
-- +-----------------------------------------------------------------------------------+
-- |Rédige une requête SQL pour déterminer, pour chaque hôtel, les mois de meilleures .|
-- |performances en fonction du chiffre d'affaires (revenue).                          |
-- +-----------------------------------------------------------------------------------+

-- Si je veux tout voir:

SELECT
	hotel_name,
	EXTRACT(YEAR FROM booking_date) AS annee,
	EXTRACT(MONTH FROM booking_date) AS mois,
	TO_CHAR(booking_date, 'Month'),
	SUM( total_price) AS revenue,
	DENSE_RANK () OVER(PARTITION BY EXTRACT (YEAR FROM booking_date), hotel_name ORDER BY SUM( total_price) DESC ) AS rang
FROM hotel_bookings
GROUP BY  1, 2, 3, 4;

-- Si je veux voir uniquement le meillleur mois

WITH classement AS
(
SELECT
	hotel_name,
	EXTRACT(YEAR FROM booking_date) AS annee,
	EXTRACT(MONTH FROM booking_date) AS mois,
	TO_CHAR(booking_date, 'Month'),
	SUM( total_price) AS revenue,
	DENSE_RANK () OVER(PARTITION BY EXTRACT (YEAR FROM booking_date), hotel_name ORDER BY SUM( total_price) DESC ) AS rang
FROM hotel_bookings
GROUP BY  1, 2, 3, 4
)
SELECT *
FROM classement 
WHERE rang = 1;