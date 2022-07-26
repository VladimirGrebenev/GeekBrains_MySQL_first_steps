/*Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека,
 * который больше всех общался с выбранным пользователем Demarco Eichmann 11 (написал ему сообщений).
 */ 

SELECT 
	u.id , u.firstname, u.lastname , count(*) AS messages 
FROM
	users u
JOIN 
	messages m
ON 
	(m.from_user_id = u.id OR m.to_user_id = u.id)
WHERE (m.to_user_id  = 11 OR m.from_user_id = 11) AND u.id != 11 
GROUP BY u.id , u.firstname ,  u.lastname 
ORDER BY messages DESC LIMIT 1;

/*Подсчитать общее количество лайков, которые получили пользователи младше 10 лет.*/

SELECT count(*) AS total_likes 
FROM posts_likes pl 
JOIN profiles p  
ON p.user_id  = pl.user_id 
WHERE pl.like_type = 1 AND TIMESTAMPDIFF(YEAR, p.birthday , now()) < 10;

/*Определить кто больше поставил лайков (всего): мужчины или женщины.*/

SELECT
	count(*) AS likes,
	CASE (p.gender)
 		WHEN 'f' THEN 'famale'
 		WHEN 'm' THEN 'male'
 		ELSE 'not defined'
	END AS gender
FROM posts_likes pl  
JOIN profiles p 
ON p.user_id = pl.user_id 
WHERE pl.like_type = 1 AND p.gender != 'x'
GROUP BY p.gender 
ORDER BY likes DESC LIMIT 1;





