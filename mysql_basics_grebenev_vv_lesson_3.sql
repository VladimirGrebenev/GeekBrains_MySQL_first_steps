CREATE TABLE IF NOT EXISTS  posts (
	id SERIAL PRIMARY KEY,
	post_auther BIGINT UNSIGNED,
	post_text TEXT NOT NULL,
	post_media_id BIGINT UNSIGNED,
	is_posted BOOLEAN DEFAULT TRUE,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	post_like_num BIGINT UNSIGNED DEFAULT NULL,
	FOREIGN KEY (user_id) REFERENCES users (id)
);

CREATE TABLE IF NOT EXISTS post_comments (
	post_id BIGINT UNSIGNED NOT NULL,
	user_id BIGINT UNSIGNED NOT NULL,
	post_comment TEXT NOT NULL,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (post_id, user_id),
	FOREIGN KEY (post_id) REFERENCES post (id),
	FOREIGN KEY (user_id) REFERENCES users (id)
);

CREATE TABLE IF NOT EXISTS post_likes (
	post_id BIGINT UNSIGNED NOT NULL,
	user_id BIGINT UNSIGNED NOT NULL,
	is_like BOOLEAN DEFAULT FALSE,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (post_id, user_id),
	FOREIGN KEY (post_id) REFERENCES post (id),
	FOREIGN KEY (user_id) REFERENCES users (id)	
);