SELECT id, name 
FROM users
WHERE id IN (SELECT user_id FROM orders);

SELECT p.name, c.name
FROM products AS p JOIN catalogs AS c 
ON p.catalog_id = c.id;

CREATE TABLE flight (
	id SERIAL PRIMARY KEY,
	fly_from VARCHAR(150),
	fly_to VARCHAR(150)	
);

CREATE TABLE cities (
	label VARCHAR(150),
	name VARCHAR(150)
);

INSERT INTO flight (fly_from, fly_to)
VALUES ('moscow', 'omsk'), ('novgorod', 'kazan'),
('omsk', 'irkutsk'), ('moscow', 'kazan');

INSERT INTO cities (label, name)
VALUES ('moscow', 'Москва'), ('irkutsk', 'Иркутск'),
('novgorod', 'Новгород'), ('kazan', 'Казань'), ('omsk', 'Омск');


SELECT id AS 'рейс',
(SELECT name FROM cities WHERE label = flight.fly_from) AS 'откуда',
(SELECT name FROM cities WHERE label = flight.fly_to) AS 'куда'
FROM flight;