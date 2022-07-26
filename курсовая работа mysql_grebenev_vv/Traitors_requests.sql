-- СКРИПТЫ ХАРАКТЕРНЫХ ВЫБОРОК
-- выборка c join предателей с ранжированием по количеству проклятий
SELECT
	t.id, CONCAT(t.firstname,' ', t.lastname) AS 'Предатель',
	count(*) AS damn,
	p.birthday AS 'дата рождения',	
	b.date_of_betrayal AS 'дата предательства'	
FROM traitors t
JOIN profiles p ON t.id = p.traitor_id 
JOIN betrayals b ON t.id = b.traitor_id  
JOIN betrayals_damnation bd ON bd.betrayals_id = b.id 
WHERE bd.damnation_type = 1
GROUP BY t.id 
ORDER BY damn DESC;

-- выборка с вложенными таблицами профессий с ранжированием по количеству проклятий
SELECT
	COUNT(*) AS damn,
	CASE (p.profession) 
		WHEN 1 THEN 'казначей'
		WHEN 2 THEN 'политик'
		WHEN 3 THEN 'военный'
		WHEN 4 THEN 'инженер'
		WHEN 5 THEN 'дипломат'
		ELSE 'музыкант'
	END AS 'профессия'	
FROM profiles p
JOIN betrayals_damnation bd ON bd.betrayals_id = 
	(SELECT b.id FROM betrayals b WHERE b.traitor_id = 
		(SELECT t.id  FROM traitors t WHERE t.id = p.traitor_id))
GROUP BY p.profession 
ORDER BY damn DESC;

-- выборка количества предателей в каждой профессии
SELECT
	COUNT(*) AS 'total_traitors',
	CASE (p.profession) 
		WHEN 1 THEN 'казначей'
		WHEN 2 THEN 'политик'
		WHEN 3 THEN 'военный'
		WHEN 4 THEN 'инженер'
		WHEN 5 THEN 'дипломат'
		ELSE 'музыкант'
	END AS 'профессия'	
FROM profiles p
GROUP BY p.profession 
ORDER BY total_traitors DESC;

-- выборка с объединением и вложенной таблицей по типу предательства с ранжированием по количеству проклятий
SELECT 
	COUNT(*) AS damn,
	(SELECT name FROM traitor_types tt WHERE tt.id = p.type_of_traitor) AS 'kind of betrayal'
FROM profiles p
JOIN traitors t ON p.traitor_id = t.id 
JOIN betrayals b ON b.traitor_id = t.id 
JOIN betrayals_damnation bd ON  bd.betrayals_id = b.id 
WHERE bd.damnation_type = 1
GROUP BY p.type_of_traitor;

-- СКРИПТЫ ПРЕДСТАВЛЕНИЙ
-- представление предателей
CREATE OR REPLACE VIEW traitors_list AS
SELECT
	t.id, CONCAT(t.firstname,' ', t.lastname) AS 'Предатель',
	count(*) AS damn,
	CASE (p.gender)
		WHEN 'm' THEN 'мужчина'
		ELSE 'женщина'
	END AS 'пол',
	p.birthday AS 'дата рождения', 
	CONCAT(
		(SELECT city_name  FROM city ct WHERE ct.id = p.born_city_id), ' ',
		(SELECT country_name FROM country c WHERE c.id = p.born_country_id)) AS 'место рождения', 
	((SELECT country_name FROM country c WHERE c.id = p.country_working_in)) AS 'страна основного дохода',	
	CASE (p.profession) 
		WHEN 1 THEN 'казначей'
		WHEN 2 THEN 'политик'
		WHEN 3 THEN 'военный'
		WHEN 4 THEN 'инженер'
		WHEN 5 THEN 'дипломат'
		ELSE 'музыкант'
	END AS 'профессия', 
	(SELECT name FROM traitor_types tt WHERE tt.id = p.type_of_traitor) AS 'тип предательства',
	b.description_of_betrayal AS 'суть предательства',
	b.date_of_betrayal AS 'дата предательства'	
FROM traitors t
JOIN profiles p ON t.id = p.traitor_id 
JOIN betrayals b ON t.id = b.traitor_id  
JOIN betrayals_damnation bd ON bd.betrayals_id = b.id 
WHERE bd.damnation_type = 1
GROUP BY t.id 
ORDER BY damn DESC;

SELECT * FROM traitors_list;

-- представление предателей CCСР
CREATE OR REPLACE VIEW ussr_traitors_list AS
SELECT
	t.id, CONCAT(t.firstname,' ', t.lastname) AS 'Предатель',
	count(*) AS damn,	
	p.birthday AS 'дата рождения', 
	CONCAT(
		(SELECT city_name  FROM city ct WHERE ct.id = p.born_city_id), ' ',
		(SELECT country_name FROM country c WHERE c.id = p.born_country_id)) AS 'место рождения',
	CASE (p.profession) 
		WHEN 1 THEN 'казначей'
		WHEN 2 THEN 'политик'
		WHEN 3 THEN 'военный'
		WHEN 4 THEN 'инженер'
		WHEN 5 THEN 'дипломат'
		ELSE 'музыкант'
	END AS 'профессия', 
	(SELECT name FROM traitor_types tt WHERE tt.id = p.type_of_traitor) AS 'тип предательства',
	b.date_of_betrayal AS 'дата предательства'	
FROM traitors t
JOIN profiles p ON t.id = p.traitor_id 
JOIN betrayals b ON t.id = b.traitor_id  
JOIN betrayals_damnation bd ON bd.betrayals_id = b.id 
WHERE bd.damnation_type = 1 AND p.country_working_in = 2
GROUP BY t.id 
ORDER BY damn DESC;

SELECT * FROM ussr_traitors_list;

-- СКРИПТЫ ХРАНИМЫХ ПРОЦЕДУР
-- хранимая процедура IN - досье предателя;
DROP PROCEDURE IF EXISTS sp_traitor_dossier;
DELIMITER //
CREATE PROCEDURE sp_traitor_dossier (IN for_traitor_id BIGINT UNSIGNED)
BEGIN	
	SELECT
		t.id, CONCAT(t.firstname,' ', t.lastname) AS 'Предатель',
		count(*) AS damn,
		CASE (p.gender)
			WHEN 'm' THEN 'мужчина'
			ELSE 'женщина'
		END AS 'пол',
		p.birthday AS 'дата рождения', 
		CONCAT(
			(SELECT city_name  FROM city ct WHERE ct.id = p.born_city_id), ' ',
			(SELECT country_name FROM country c WHERE c.id = p.born_country_id)) AS 'место рождения', 
		((SELECT country_name FROM country c WHERE c.id = p.country_working_in)) AS 'страна основного дохода',	
		CASE (p.profession) 
			WHEN 1 THEN 'казначей'
			WHEN 2 THEN 'политик'
			WHEN 3 THEN 'военный'
			WHEN 4 THEN 'инженер'
			WHEN 5 THEN 'дипломат'
			ELSE 'музыкант'
		END AS 'профессия', 
		(SELECT name FROM traitor_types tt WHERE tt.id = p.type_of_traitor) AS 'тип предательства',
		b.description_of_betrayal AS 'суть предательства',
		b.date_of_betrayal AS 'дата предательства'	
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

-- хранимая процедура OUT - максимальный рейтинг проклятия;
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

-- ТРИГГЕРЫ И ИХ ПРОВЕРКИ
-- триггер создания даты предательства
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
VALUES (12, 10, 'бла бла', '3224-10-10');

-- триггер обновления даты предательства
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