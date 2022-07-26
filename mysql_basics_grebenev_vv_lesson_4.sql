INSERT INTO users (id, firstname, lastname, email, phone, password_hash, created_at) VALUES
	(DEFAULT, 'Владимир', 'Гребенев', 'grebenev-81@mail.ru', '89834578640', NULL, DEFAULT),
	(DEFAULT, 'Иван', 'Иванов', 'ivanov@mail.ru', '8800200600', NULL, DEFAULT),
	(DEFAULT, 'Ван', 'Сиванов', 'sivanov@mail.ru', '8800200601', NULL, DEFAULT),
	(DEFAULT, 'Тиван', 'Гванов', 'gvanov@mail.ru', '8800200602', NULL, DEFAULT),
	(DEFAULT, 'Пиван', 'Пванов', 'pvanov@mail.ru', '8800200603', NULL, DEFAULT),
	(DEFAULT, 'Миван', 'Миванов', 'mivanov@mail.ru', '8800200604', NULL, DEFAULT),
	(DEFAULT, 'Виван', 'Ванов', 'vanov@mail.ru', '8800200605', NULL, DEFAULT),
	(DEFAULT, 'Ниван', 'Нов', 'nov@mail.ru', '8800200606', NULL, DEFAULT),
	(DEFAULT, 'Иван', 'Зов', 'zov@mail.ru', '8800200607', NULL, DEFAULT),
	(DEFAULT, 'Ливан', 'Лов', 'lov@mail.ru', '8800200608', NULL, DEFAULT);
	
INSERT INTO profiles (user_id ,gender, birthday) VALUES
	(3, 'm', '1981-03-18'),
	(4, 'm', '1981-03-18'),
	(5, 'm', '1981-03-18'),
	(6, 'm', '1981-03-18'),
	(7, 'm', '1981-03-18'),
	(8, 'm', '1981-03-18'),
	(9, 'm', '1981-03-18'),
	(10, 'm', '2018-03-18'),
	(11, 'm', '1981-03-18'),
	(12, 'm', '1981-03-18');

INSERT INTO messages (from_user_id, to_user_id, txt, is_delivered) VALUES
	(3, 4, 'Привет, Иван', 1),
	(4, 3, 'Привет, Вован', 1),
	(4, 3, 'Как жизнь, Вован?', 1),
	(3, 4, 'Всё хорошо, Иван.', 1),
	(4, 3, 'Чем занимаешься?', 1),
	(3, 4, 'Домашку делаю по SQL', 1),
	(3, 5, 'Привет, Ван', 0),
	(4, 5, 'Привет, Ван', 0),
	(4, 5, 'Привет, Вааааан', 0),
	(4, 5, 'Ну и ладно', 0);

INSERT INTO media_types (name) VALUES
	('видео'),
	('qr-code'),
	('coin'),
	('cover'),
	('stiker'),
	('gift'),
	('clip'),
	('app');

INSERT INTO media (user_id, media_types_id, file_name, files_size) VALUES
	(3, 1, 'ava3.jpg', 30),
	(4, 1, 'ava4.jpg', 30),
	(5, 1, 'ava5.jpg', 30),
	(6, 1, 'ava6.jpg', 30),
	(7, 1, 'ava7.jpg', 30),
	(8, 1, 'ava8.jpg', 30),
	(9, 1, 'ava9.jpg', 30),
	(10, 1, 'ava10.jpg', 30),
	(1, 1, 'ava1.jpg', 30),
	(2, 1, 'ava2.jpg', 30);

INSERT  INTO friend_requests (from_user_id , to_user_id, accepted) VALUES
	(3, 1, 0),
	(3, 2, 0),
	(3, 3, 0),
	(3, 4, 1),
	(3, 5, 0),
	(3, 6, 0),
	(3, 7, 0),
	(3, 8, 0),
	(3, 9, 0),
	(3, 10, 0);

INSERT INTO communities (name, description, admin_id) VALUES
	('cats and rabbits', 'about milk and carrot', 2),
	('born to be free', 'about freedom', 3),
	('die hard 3', 'bruce wain is cool', 4),
	('kindzadza', 'gravitsapa', 3),
	('kindzadza2', 'gravitsapa', 4),
	('kindzadza3', 'gravitsapa', 5),
	('kindzadza4', 'gravitsapa', 6),
	('kindzadza5', 'gravitsapa', 7),
	('kindzadza8', 'gravitsapa', 8);

INSERT INTO communities_users (community_id, user_id) VALUES
	(1, 3),
	(4, 2),
	(6, 4),
	(4, 5),
	(6, 6),
	(4, 7),
	(6, 8),
	(4, 9),
	(6, 10);

SELECT DISTINCT firstname FROM users ORDER BY firstname;

ALTER TABLE profiles ADD COLUMN is_active BOOLEAN DEFAULT TRUE;	

UPDATE profiles 
SET is_active = 0 
WHERE (YEAR(CURRENT_DATE) - YEAR(birthday)) < 18;

SELECT * FROM messages WHERE created_at > current_timestamp();

DELETE FROM messages WHERE created_at > current_timestamp(); 

/* тема курсовой "всемирная база данных предателей" начиная с Иуды,
 *  Брута и заканчивая Олегом Калугин, Олегом Гордиевским и Сноуденом. */  

	
	
