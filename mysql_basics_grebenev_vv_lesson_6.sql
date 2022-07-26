SELECT from_user_id, count(from_user_id) AS cnt FROM messages
WHERE to_user_id = 2 GROUP BY from_user_id
HAVING cnt > 0 LIMIT 1;

-- #1 вычисляем пользователя чаще всего писавшего пользователю с id=2
SELECT (SELECT concat(firstname,' ', lastname) FROM users WHERE id = from_user_id) AS max_messages_user,
count(from_user_id) AS cnt FROM messages
WHERE to_user_id = 2 GROUP BY from_user_id ORDER BY cnt DESC LIMIT 1;

-- #2 Подсчитать общее количество лайков, которые получили пользователи младше 10 лет.
SELECT count(like_type) AS likes_cnt 
FROM posts_likes
WHERE like_type = 1 AND user_id IN (
	SELECT user_id FROM profiles
	WHERE TIMESTAMPDIFF(YEAR, birthday, NOW()) < 10);

-- #3 Определить кто больше поставил лайков (всего): мужчины или женщины.
SELECT (SELECT CASE gender WHEN 'f' THEN 'female' WHEN 'm' THEN 'male' WHEN 'x' THEN 'not defined'END
	FROM profiles WHERE user_id = posts_likes.user_id) AS gender_put_more_likes,
	count(user_id) AS cnt
FROM posts_likes
WHERE like_type =1 AND user_id NOT IN (SELECT user_id FROM profiles WHERE gender ='x')
GROUP BY (SELECT gender FROM profiles WHERE user_id = posts_likes.user_id)
ORDER BY cnt DESC LIMIT 1;

