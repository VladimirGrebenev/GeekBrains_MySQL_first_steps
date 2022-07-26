/*В базе данных shop и sample присутствуют одни и те же таблицы,
 *  учебной базы данных. Переместите запись id = 1 из таблицы
 *  shop.users в таблицу sample.users. Используйте транзакции. */ 

START TRANSACTION;

INSERT INTO sample.users (id, name)
SELECT id, name
FROM shop.users
WHERE id = 1;

COMMIT;

/*Создайте представление, которое выводит название name товарной
позиции из таблицы products и соответствующее название каталога
 name из таблицы catalogs.*/

CREATE OR REPLACE VIEW catalog_list AS
SELECT p.name AS product, c.name AS category 
FROM shop.products p 
JOIN shop.catalogs c ON p.catalog_id = c.id;

SELECT * FROM catalog_list;

/*Создайте хранимую функцию hello(), которая будет возвращать
 *  приветствие, в зависимости от текущего времени суток.
С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
 с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".*/

DROP FUNCTION IF EXISTS hello;

DELIMITER //

CREATE FUNCTION hello()
RETURNS text DETERMINISTIC
BEGIN
	DECLARE time_to_hello TEXT;
	SET time_to_hello = (SELECT CURTIME());
	
	IF time_to_hello >= '06:00:00' AND time_to_hello < '12:00:00'
	THEN 
		RETURN 'Доброе утро';
	ELSEIF time_to_hello >= '12:00:00' AND time_to_hello < '18:00:00'
		THEN RETURN 'Добрый день';
	ELSEIF time_to_hello >= '18:00:00' AND time_to_hello < '00:00:00'
		THEN RETURN 'Добрый вечер';
	ELSE 
		RETURN 'Доброй ночи';
	END IF; 
END //

DELIMITER ;

SELECT hello();


/*В таблице products есть два текстовых поля: name с названием
 *  товара и description с его описанием. Допустимо присутствие
 *  обоих полей или одно из них. Ситуация, когда оба поля принимают
 *  неопределенное значение NULL неприемлема. Используя триггеры,
 *  добейтесь того, чтобы одно из этих полей или оба поля были
 *  заполнены. При попытке присвоить полям NULL-значение необходимо
 *  отменить операцию. */

DROP TRIGGER IF EXISTS check_product_describe_insert;

DELIMITER //

CREATE TRIGGER check_product_describe_insert BEFORE INSERT ON products
FOR EACH ROW 
BEGIN 
	IF NEW.name is NULL AND NEW.description is NULL	THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insert Canceled. You must insert data to name or description';
	END IF;
END//

DELIMITER ;

INSERT INTO products (name, description)
VALUES (null, null);

DROP TRIGGER IF EXISTS check_product_describe_update;

DELIMITER //

CREATE TRIGGER check_product_describe_update BEFORE UPDATE ON products
FOR EACH ROW 
BEGIN 
	IF NEW.name is NULL AND NEW.description is NULL	THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Update Canceled. You must insert data to name or description';
	END IF;
END//

DELIMITER ;

UPDATE products SET name = NULL WHERE id = 11;








