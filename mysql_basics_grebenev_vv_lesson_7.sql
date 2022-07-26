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
VALUES ('moscow', '������'), ('irkutsk', '�������'),
('novgorod', '��������'), ('kazan', '������'), ('omsk', '����');


SELECT id AS '����',
(SELECT name FROM cities WHERE label = flight.fly_from) AS '������',
(SELECT name FROM cities WHERE label = flight.fly_to) AS '����'
FROM flight;