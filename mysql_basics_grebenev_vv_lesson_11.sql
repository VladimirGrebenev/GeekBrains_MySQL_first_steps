/*� ���� ������ shop � sample ������������ ���� � �� �� �������,
 *  ������� ���� ������. ����������� ������ id = 1 �� �������
 *  shop.users � ������� sample.users. ����������� ����������. */ 

START TRANSACTION;

INSERT INTO sample.users (id, name)
SELECT id, name
FROM shop.users
WHERE id = 1;

COMMIT;

/*�������� �������������, ������� ������� �������� name ��������
������� �� ������� products � ��������������� �������� ��������
 name �� ������� catalogs.*/

CREATE OR REPLACE VIEW catalog_list AS
SELECT p.name AS product, c.name AS category 
FROM shop.products p 
JOIN shop.catalogs c ON p.catalog_id = c.id;

SELECT * FROM catalog_list;

/*�������� �������� ������� hello(), ������� ����� ����������
 *  �����������, � ����������� �� �������� ������� �����.
� 6:00 �� 12:00 ������� ������ ���������� ����� "������ ����", 
� 12:00 �� 18:00 ������� ������ ���������� ����� "������ ����",
 � 18:00 �� 00:00 � "������ �����", � 00:00 �� 6:00 � "������ ����".*/

DROP FUNCTION IF EXISTS hello;

DELIMITER //

CREATE FUNCTION hello()
RETURNS text DETERMINISTIC
BEGIN
	DECLARE time_to_hello TEXT;
	SET time_to_hello = (SELECT CURTIME());
	
	IF time_to_hello >= '06:00:00' AND time_to_hello < '12:00:00'
	THEN 
		RETURN '������ ����';
	ELSEIF time_to_hello >= '12:00:00' AND time_to_hello < '18:00:00'
		THEN RETURN '������ ����';
	ELSEIF time_to_hello >= '18:00:00' AND time_to_hello < '00:00:00'
		THEN RETURN '������ �����';
	ELSE 
		RETURN '������ ����';
	END IF; 
END //

DELIMITER ;

SELECT hello();


/*� ������� products ���� ��� ��������� ����: name � ���������
 *  ������ � description � ��� ���������. ��������� �����������
 *  ����� ����� ��� ���� �� ���. ��������, ����� ��� ���� ���������
 *  �������������� �������� NULL �����������. ��������� ��������,
 *  ��������� ����, ����� ���� �� ���� ����� ��� ��� ���� ����
 *  ���������. ��� ������� ��������� ����� NULL-�������� ����������
 *  �������� ��������. */

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








