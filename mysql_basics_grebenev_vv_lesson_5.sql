UPDATE users 
SET created_at = now();

ALTER TABLE users ADD COLUMN string_date VARCHAR(16);

UPDATE users
SET string_date = '20.10.2017 8:10';

ALTER TABLE users ADD COLUMN correct_format_date DATETIME;

UPDATE users
SET correct_format_date = STR_TO_DATE(string_date, '%d.%m.%Y %h:%i');

INSERT INTO storehouses_products (id, storehouse_id, product_id, value)
VALUES (1, 2, 1, 0),
	(2, 2, 1, 2500),
	(3, 2, 1, 0),
	(4, 2, 1, 30),
	(5, 2, 1, 500),
	(6, 2, 1, 1);

SELECT * FROM storehouses_products sp ORDER BY value = 0 ASC, value  ASC;

SELECT * FROM users WHERE monthname(birthday_at) IN ('may', 'august');

SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD (id, 5, 1, 2);

SELECT AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW())) FROM users;

SELECT dayname(STR_TO_DATE(
			concat(YEAR(now()), '-', MONTH(birthday_at), '-', DAY(birthday_at)), '%Y-%m-%d')) AS in_this_year,
			count(*) AS cnt
FROM users GROUP BY in_this_year;

SELECT EXP(sum(LN(value))) FROM tab;