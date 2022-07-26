-- ������� ����������� �������
-- ������� c join ���������� � ������������� �� ���������� ���������
SELECT
	t.id, CONCAT(t.firstname,' ', t.lastname) AS '���������',
	count(*) AS damn,
	p.birthday AS '���� ��������',	
	b.date_of_betrayal AS '���� �������������'	
FROM traitors t
JOIN profiles p ON t.id = p.traitor_id 
JOIN betrayals b ON t.id = b.traitor_id  
JOIN betrayals_damnation bd ON bd.betrayals_id = b.id 
WHERE bd.damnation_type = 1
GROUP BY t.id 
ORDER BY damn DESC;

-- ������� � ���������� ��������� ��������� � ������������� �� ���������� ���������
SELECT
	COUNT(*) AS damn,
	CASE (p.profession) 
		WHEN 1 THEN '��������'
		WHEN 2 THEN '�������'
		WHEN 3 THEN '�������'
		WHEN 4 THEN '�������'
		WHEN 5 THEN '��������'
		ELSE '��������'
	END AS '���������'	
FROM profiles p
JOIN betrayals_damnation bd ON bd.betrayals_id = 
	(SELECT b.id FROM betrayals b WHERE b.traitor_id = 
		(SELECT t.id  FROM traitors t WHERE t.id = p.traitor_id))
GROUP BY p.profession 
ORDER BY damn DESC;

-- ������� ���������� ���������� � ������ ���������
SELECT
	COUNT(*) AS 'total_traitors',
	CASE (p.profession) 
		WHEN 1 THEN '��������'
		WHEN 2 THEN '�������'
		WHEN 3 THEN '�������'
		WHEN 4 THEN '�������'
		WHEN 5 THEN '��������'
		ELSE '��������'
	END AS '���������'	
FROM profiles p
GROUP BY p.profession 
ORDER BY total_traitors DESC;

-- ������� � ������������ � ��������� �������� �� ���� ������������� � ������������� �� ���������� ���������
SELECT 
	COUNT(*) AS damn,
	(SELECT name FROM traitor_types tt WHERE tt.id = p.type_of_traitor) AS 'kind of betrayal'
FROM profiles p
JOIN traitors t ON p.traitor_id = t.id 
JOIN betrayals b ON b.traitor_id = t.id 
JOIN betrayals_damnation bd ON  bd.betrayals_id = b.id 
WHERE bd.damnation_type = 1
GROUP BY p.type_of_traitor;

-- ������� �������������
-- ������������� ����������
CREATE OR REPLACE VIEW traitors_list AS
SELECT
	t.id, CONCAT(t.firstname,' ', t.lastname) AS '���������',
	count(*) AS damn,
	CASE (p.gender)
		WHEN 'm' THEN '�������'
		ELSE '�������'
	END AS '���',
	p.birthday AS '���� ��������', 
	CONCAT(
		(SELECT city_name  FROM city ct WHERE ct.id = p.born_city_id), ' ',
		(SELECT country_name FROM country c WHERE c.id = p.born_country_id)) AS '����� ��������', 
	((SELECT country_name FROM country c WHERE c.id = p.country_working_in)) AS '������ ��������� ������',	
	CASE (p.profession) 
		WHEN 1 THEN '��������'
		WHEN 2 THEN '�������'
		WHEN 3 THEN '�������'
		WHEN 4 THEN '�������'
		WHEN 5 THEN '��������'
		ELSE '��������'
	END AS '���������', 
	(SELECT name FROM traitor_types tt WHERE tt.id = p.type_of_traitor) AS '��� �������������',
	b.description_of_betrayal AS '���� �������������',
	b.date_of_betrayal AS '���� �������������'	
FROM traitors t
JOIN profiles p ON t.id = p.traitor_id 
JOIN betrayals b ON t.id = b.traitor_id  
JOIN betrayals_damnation bd ON bd.betrayals_id = b.id 
WHERE bd.damnation_type = 1
GROUP BY t.id 
ORDER BY damn DESC;

SELECT * FROM traitors_list;

-- ������������� ���������� CC��
CREATE OR REPLACE VIEW ussr_traitors_list AS
SELECT
	t.id, CONCAT(t.firstname,' ', t.lastname) AS '���������',
	count(*) AS damn,	
	p.birthday AS '���� ��������', 
	CONCAT(
		(SELECT city_name  FROM city ct WHERE ct.id = p.born_city_id), ' ',
		(SELECT country_name FROM country c WHERE c.id = p.born_country_id)) AS '����� ��������',
	CASE (p.profession) 
		WHEN 1 THEN '��������'
		WHEN 2 THEN '�������'
		WHEN 3 THEN '�������'
		WHEN 4 THEN '�������'
		WHEN 5 THEN '��������'
		ELSE '��������'
	END AS '���������', 
	(SELECT name FROM traitor_types tt WHERE tt.id = p.type_of_traitor) AS '��� �������������',
	b.date_of_betrayal AS '���� �������������'	
FROM traitors t
JOIN profiles p ON t.id = p.traitor_id 
JOIN betrayals b ON t.id = b.traitor_id  
JOIN betrayals_damnation bd ON bd.betrayals_id = b.id 
WHERE bd.damnation_type = 1 AND p.country_working_in = 2
GROUP BY t.id 
ORDER BY damn DESC;

SELECT * FROM ussr_traitors_list;

-- ������� �������� ��������
-- �������� ��������� IN - ����� ���������;
DROP PROCEDURE IF EXISTS sp_traitor_dossier;
DELIMITER //
CREATE PROCEDURE sp_traitor_dossier (IN for_traitor_id BIGINT UNSIGNED)
BEGIN	
	SELECT
		t.id, CONCAT(t.firstname,' ', t.lastname) AS '���������',
		count(*) AS damn,
		CASE (p.gender)
			WHEN 'm' THEN '�������'
			ELSE '�������'
		END AS '���',
		p.birthday AS '���� ��������', 
		CONCAT(
			(SELECT city_name  FROM city ct WHERE ct.id = p.born_city_id), ' ',
			(SELECT country_name FROM country c WHERE c.id = p.born_country_id)) AS '����� ��������', 
		((SELECT country_name FROM country c WHERE c.id = p.country_working_in)) AS '������ ��������� ������',	
		CASE (p.profession) 
			WHEN 1 THEN '��������'
			WHEN 2 THEN '�������'
			WHEN 3 THEN '�������'
			WHEN 4 THEN '�������'
			WHEN 5 THEN '��������'
			ELSE '��������'
		END AS '���������', 
		(SELECT name FROM traitor_types tt WHERE tt.id = p.type_of_traitor) AS '��� �������������',
		b.description_of_betrayal AS '���� �������������',
		b.date_of_betrayal AS '���� �������������'	
	FROM traitors t
	JOIN profiles p ON t.id = p.traitor_id 
	JOIN betrayals b ON t.id = b.traitor_id  
	JOIN betrayals_damnation bd ON bd.betrayals_id = b.id 
	WHERE bd.damnation_type = 1 AND t.id = for_traitor_id
	GROUP BY t.id 
	ORDER BY damn DESC;	
END//
DELIMITER ;

CALL sp_traitor_dossier(9);

-- �������� ��������� OUT - ������������ ������� ���������;
DROP PROCEDURE IF EXISTS sp_max_damn_out;
DELIMITER //
CREATE PROCEDURE sp_max_damn_out(OUT max_damn INT)
	BEGIN
		SELECT count(*) AS damn INTO max_damn
		FROM betrayals_damnation bd 
		GROUP BY betrayals_id
		ORDER BY damn DESC
		LIMIT 1;
	END//
DELIMITER ;

CALL sp_max_damn_out(@max_dam);
SELECT @max_dam;

-- �������� � �� ��������
-- ������� �������� ���� �������������
DROP TRIGGER IF EXISTS check_date_of_betrayal_before_insert;
DELIMITER //
CREATE TRIGGER check_date_of_betrayal_before_insert BEFORE INSERT ON betrayals 
FOR EACH ROW 
BEGIN 
	IF NEW.date_of_betrayal >= CURRENT_DATE() THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =  'Insert Canceled. The day of betrayal has not yet come!';
	END IF;
END//
DELIMITER ;

INSERT INTO betrayals (id, traitor_id, description_of_betrayal, date_of_betrayal)
VALUES (12, 10, '��� ���', '3224-10-10');

-- ������� ���������� ���� �������������
DROP TRIGGER IF EXISTS check_date_of_betrayal_before_update;
DELIMITER //
CREATE TRIGGER check_date_of_betrayal_before_update BEFORE UPDATE ON betrayals 
FOR EACH ROW 
BEGIN 
	IF NEW.date_of_betrayal >= CURRENT_DATE() THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =  'Update Canceled. The day of betrayal has not yet come!';
	END IF;
END//
DELIMITER ;

UPDATE betrayals SET date_of_betrayal = '2999-10-01' WHERE id = 1;