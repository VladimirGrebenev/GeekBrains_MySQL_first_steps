-- КУРСОВОЙ ПРОЕКТ ПО MYSQL СТУДЕНТА GEEKBRAINS - ГРЕБЕНЕВА ВЛАДИМИРА

-- ОПИСАНИЕ БАЗЫ ДАННЫХ И РЕШАЕМЫХ ЕЮ ЗАДАЧ
/* Всемирная база данных пердателей. Создана для всестороннего анализа пердательства
 * с целью предотвратить подобные случаи в будущем, а также с целью анализа отношения
 * к разным типам предательства в обществе. */

-- СОЗДАНИЕ БАЗЫ ДАННЫХ
-- сброс и создание базы
DROP DATABASE IF EXISTS world_traitors_base;
CREATE DATABASE IF NOT EXISTS world_traitors_base;

-- использование базы
USE world_traitors_base;

-- создание и сброс таблицы предателей
DROP TABLE IF EXISTS traitors;
CREATE TABLE IF NOT EXISTS traitors(
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	firstname VARCHAR(150) NOT NULL,
	lastname VARCHAR(150) NOT NULL,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP	
);

-- создание и сброс таблицы городов 
DROP TABLE IF EXISTS city;
CREATE TABLE IF NOT EXISTS city(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	city_name VARCHAR(50) NOT NULL UNIQUE
);

-- создание и сброс таблицы стран
DROP TABLE IF EXISTS country;
CREATE TABLE IF NOT EXISTS country(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	country_name VARCHAR(50) NOT NULL UNIQUE
);

-- создание и сброс таблицы профессий предателей
DROP TABLE IF EXISTS profession;
CREATE TABLE IF NOT EXISTS profession(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(50) NOT NULL UNIQUE
);

-- создание и сброс таблицы типов предательств
DROP TABLE IF EXISTS traitor_types;
CREATE TABLE IF NOT EXISTS traitor_types(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(50) NOT NULL UNIQUE
);

-- создание и сброс таблицы профайлов предателей
DROP TABLE IF EXISTS profiles;
CREATE TABLE IF NOT EXISTS profiles(
	traitor_id BIGINT UNSIGNED PRIMARY KEY,
	photo_id BIGINT UNSIGNED DEFAULT NULL,
	gender ENUM('f', 'm') NOT NULL,
	birthday DATE NOT NULL,
	deathday DATE DEFAULT NULL,
	born_city_id INT UNSIGNED NOT NULL,
	born_country_id INT UNSIGNED NOT NULL,
	country_working_in INT UNSIGNED NOT NULL,
	profession INT UNSIGNED NOT NULL,	
	type_of_traitor INT UNSIGNED NOT NULL,
	FOREIGN KEY (traitor_id) REFERENCES traitors (id),
	FOREIGN KEY (born_city_id) REFERENCES city (id),
	FOREIGN KEY (born_country_id) REFERENCES country (id),
	FOREIGN KEY (country_working_in) REFERENCES country (id),
	FOREIGN KEY (profession) REFERENCES profession (id),
	FOREIGN KEY (type_of_traitor) REFERENCES traitor_types (id)
);

-- создание и сброс таблицы типов медиа доказательств
DROP TABLE IF EXISTS proof_media_types;
CREATE TABLE IF NOT EXISTS proof_media_types(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(50) NOT NULL UNIQUE
);

-- создание и сброс таблицы медиа доказательств
DROP TABLE IF EXISTS proof_media;
CREATE TABLE IF NOT EXISTS proof_media(
	id SERIAL PRIMARY KEY,
	traitor_id BIGINT UNSIGNED NOT NULL,
	media_types_id INT UNSIGNED NOT NULL,
	file_name VARCHAR(255) COMMENT '/files/folder/img.png',
	files_size BIGINT UNSIGNED, 
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (media_types_id) REFERENCES proof_media_types (id),
	FOREIGN KEY (traitor_id) REFERENCES traitors (id)
);

-- создание и сброс таблицы описания предательства 
DROP TABLE IF EXISTS betrayals;
CREATE TABLE IF NOT EXISTS betrayals(
	id SERIAL PRIMARY KEY,
	traitor_id BIGINT UNSIGNED NOT NULL,
	description_of_betrayal TEXT NOT NULL,
	date_of_betrayal DATETIME NOT NULL,
	FOREIGN KEY (traitor_id) REFERENCES traitors (id)
);

-- создание и сброс таблицы пользователей базы данных
DROP TABLE IF EXISTS users;
CREATE TABLE IF NOT EXISTS users(
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	firstname VARCHAR(150) NOT NULL,
	lastname VARCHAR(150) NOT NULL,
	email VARCHAR(150) NOT NULL UNIQUE,
	phone CHAR(11) NOT NULL,
	password_hash CHAR(65) DEFAULT NULL,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP	
);

-- создание и сброс таблицы проклятий предателей пользователями (рейтинг отношения)
DROP TABLE IF EXISTS betrayals_damnation;
CREATE TABLE IF NOT EXISTS betrayals_damnation(
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	betrayals_id BIGINT UNSIGNED NOT NULL,
	user_id BIGINT UNSIGNED NOT NULL,
	damnation_type TINYINT(1) DEFAULT '1',
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (user_id) REFERENCES users (id),
	FOREIGN KEY (betrayals_id) REFERENCES betrayals (id)
);

-- НАПОЛНЕНИЕ БАЗЫ ДАННЫХ
-- наполнение таблицы предателей
INSERT INTO traitors (id, firstname, lastname, created_at) VALUES
	(DEFAULT, 'Иуда', 'Искариот', DEFAULT),
	(DEFAULT, 'Марк Юний', 'Брут', DEFAULT),
	(DEFAULT, 'Андрей Андреевич', 'Власов', DEFAULT),	
	(DEFAULT, 'Адольф Георгиевич', 'Толкачёв', DEFAULT),
	(DEFAULT, 'Олег Данилович', 'Калугин', DEFAULT),
	(DEFAULT, 'Олег Антонович', 'Гордиевский', DEFAULT),
	(DEFAULT, 'Аркадий Николаевич', 'Шевченко', DEFAULT),
	(DEFAULT, 'Михаил Сергеевич', 'Горбачёв', DEFAULT),
	(DEFAULT, 'Борис Николаевич', 'Ельцин', DEFAULT),
	(DEFAULT, 'Андрей Вадимович', 'Макаревич', DEFAULT);

-- наполнение таблицы профессий
INSERT INTO profession (id, name) VALUES
	(1, 'казначей'),
	(2, 'политик'),
	(3, 'военный'),
	(4, 'инженер'),
	(5, 'дипломат'),
	(6, 'музыкант');

-- наполнение таблицы стран
INSERT INTO country (id, country_name) VALUES
	(1, 'Римская империя'),
	(2, 'СССР'),
	(3, 'Россия'),
	(4, 'Российская Империя'),
	(5, 'Македония'),
	(6, 'Иудея');

-- наполнение таблицы типов предателеств
INSERT INTO traitor_types VALUES 
	(1, 'за деньги'),
	(2, 'за власть'),
	(3, 'за жизнь'),
	(4, 'тщеславие');

-- наполнение таблицы городов
INSERT INTO city (id, city_name) VALUES 
	(1, 'Кариот'),
	(2, 'Иерусалим'),
	(3, 'Рим'),
	(4, 'Филипп'),
	(5, 'Ломакино'),
	(6, 'Ленинград'),
	(7, 'Москва'),
	(8, 'Привольное'),
	(9, 'Бутка'),
	(10, 'Актюбинск'),
	(11, 'Горловка');	

-- наполнение таблицы профайлов предателей
INSERT INTO profiles (traitor_id, photo_id, gender, birthday, deathday, born_city_id , born_country_id, country_working_in,
			profession, type_of_traitor) VALUES 
	(1, 1, 'm', '0000-04-01', '0033-04-04', 1, 6, 1, 1, 1),
	(2, 2, 'm', '0085-12-01', '0042-10-23', 3, 1, 1, 2, 2),
	(3, 3, 'm', '1901-09-14', '1946-08-01', 5, 1, 2, 3, 3),
	(4, 4, 'm', '1927-01-06', '1986-09-24', 10, 2, 2, 4, 1),
	(5, 5, 'm', '1934-09-06', NULL, 6, 2, 2, 3, 1),
	(6, 6, 'm', '1938-10-10', NULL, 7, 2, 2, 3, 1),
	(7, 7, 'm', '1930-10-11', '1998-02-28', 11, 2, 2, 5, 1),
	(8, 8, 'm', '1931-03-02', NULL, 8, 2, 2, 2, 4),
	(9, 9, 'm', '1931-02-01', '2007-04-23', 9, 2, 2, 2, 2),
	(10, 10, 'm', '1953-12-11', NULL, 7, 2, 3, 6, 1);

-- наполнение таблицы типов медиа доказательств
INSERT INTO proof_media_types (id, name) VALUES
	(1, 'видео'),
	(2, 'документ'),
	(3, 'ссылка');

-- наполнение таблицы медиа доказательств
INSERT INTO proof_media (id, traitor_id, media_types_id, file_name, files_size, created_at) VALUES
	(DEFAULT, 1, 2, '/files/folder/1.pdf', 20, DEFAULT),
	(DEFAULT, 2, 2, '/files/folder/2.pdf', 20, DEFAULT),
	(DEFAULT, 3, 3, '/files/folder/3.mov', 20, DEFAULT),
	(DEFAULT, 4, 3, '/files/folder/4.mov', 20, DEFAULT),
	(DEFAULT, 5, 3, '/files/folder/5.mov', 20, DEFAULT),
	(DEFAULT, 6, 3, '/files/folder/6.mov', 20, DEFAULT),
	(DEFAULT, 7, 3, '/files/folder/7.mov', 20, DEFAULT),
	(DEFAULT, 8, 3, '/files/folder/8.mov', 20, DEFAULT),
	(DEFAULT, 9, 3, '/files/folder/9.mov', 20, DEFAULT),
	(DEFAULT, 10, 3, '/files/folder/10.mov', 20, DEFAULT);
	
-- наполнение таблицы описания сути предательств
INSERT INTO betrayals (id, traitor_id, description_of_betrayal, date_of_betrayal) VALUES
	(DEFAULT, 1, 'текст с описанием предательства 1', '0033-04-02'),
	(DEFAULT, 2, 'текст с описанием предательства 2', '0044-03-15'),
	(DEFAULT, 3, 'текст с описанием предательства 3', '1942-07-11'),
	(DEFAULT, 4, 'текст с описанием предательства 4', '1979-01-01'),
	(DEFAULT, 5, 'текст с описанием предательства 5', '1990-04-14'),
	(DEFAULT, 6, 'текст с описанием предательства 6', '1974-01-01'),
	(DEFAULT, 7, 'текст с описанием предательства 7', '1973-01-01'),
	(DEFAULT, 8, 'текст с описанием предательства 8', '1991-08-30'),
	(DEFAULT, 9, 'текст с описанием предательства 9', '1991-12-26'),
	(DEFAULT, 10, 'текст с описанием предательства 10', '2022-02-23');


-- наполнение таблицы пользователей базы
INSERT INTO `users` VALUES (1,'Guadalupe','Nitzsche','greenfelder.antwan@example.org','89213456678','d6f684fe75bdff654841d18f34c9acd6d3b05233','2011-12-04 16:57:02'),(2,'Elmira','Bayer','xjacobs@example.org','89214507878','501a9b34edb153894128f6255ff3ef6bf0d3f4db','1990-01-20 18:48:26'),(3,'D\'angelo','Cruickshank','linwood.medhurst@example.org','89214567878','3273c607f8dfbc808adaa5493b7439ba08c3f43e','1994-09-04 15:21:06'),(4,'Princess','Runolfsson','huel.nash@example.org','89213455643','21444980cef626302f7ae9a507971889c9daac1d','1987-08-27 19:05:04'),(5,'Ethan','Legros','mhickle@example.org','89219567878','4dd91825495d2233602c0b0af6ff8b113b1844d9','1993-01-08 23:58:41'),(6,'Freda','Sporer','devyn70@example.net','89213457870','3df01bfd0a99988ca0383a49481e523226d4adca','1997-11-10 19:45:09'),(7,'Bonnie','Prosacco','hester.marvin@example.com','89213332222','10db70a3dcce2a22dd8eabdc7342260c91ff1749','1982-09-30 14:12:03'),(8,'Sierra','Bruen','aprosacco@example.net','89212222334','99fbaa12eecf0e10bf372dbf9cf7f98267b6636e','2004-01-28 04:41:46'),(9,'Trudie','Heller','hjohnston@example.net','89213336675','33b1681186add7816a701f570615c9d0aae215ab','1999-06-10 12:49:14'),(10,'Shaylee','Sawayn','pagac.clarissa@example.org','89212233456','b1771cc64742c38ec18ac67a4e61597b05cc9e20','1973-12-14 01:24:44'),(11,'Demarco','Eichmann','lakin.ethel@example.org','89233388787','f7f50eddf4d112d2d858510211128b8e0de60f84','2006-02-22 14:32:06');

-- наполнение таблицы проклятий пользователями предателей, рейтинг отношения общества
INSERT INTO betrayals_damnation (betrayals_id, user_id, damnation_type) VALUES
	(1,1,1), (2,1,1), (3,1,1), (4,1,1), (5,1,1), (6,1,1), (7,1,1), (8,1,1), (9,1,1), (10,1,1),
	(1,2,1), (2,2,1), (3,2,1), (4,2,1), (5,2,1), (6,2,1), (7,2,1), (8,2,1), (9,2,1), (10,2,1),
	(4,3,1), (5,3,1), (6,3,1), (7,3,1), (8,3,1), (9,3,1), (10,3,1),
	(1,4,1), (2,4,1), (3,4,1), (4,4,1), (5,4,1), (6,4,1), (7,4,1), 
	(1,5,1), (2,5,1), (3,5,1), (8,5,1), (9,5,1), (10,5,1),
	(1,6,1), (10,6,1),
	(8,7,1), (9,7,1), (10,7,1),
	(9,8,1), (10,8,1),
	(8,9,1), (9,9,1), (10,9,1),
	(10,10,1);
