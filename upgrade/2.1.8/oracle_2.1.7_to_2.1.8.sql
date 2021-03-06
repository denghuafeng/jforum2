CREATE INDEX idx_banlist_email ON jforum_banlist(banlist_email);
CREATE INDEX idx_posts_moderate ON jforum_posts(need_moderate);
CREATE INDEX idx_posts_time ON jforum_posts(post_time);
ALTER TABLE jforum_topics ADD topic_moved_id INT DEFAULT 0;
CREATE INDEX idx_topics_moved ON jforum_topics(topic_moved_id);
ALTER TABLE jforum_users ALTER COLUMN rank_id SET DEFAULT 0;
ALTER TABLE jforum_sessions MODIFY session_ip VARCHAR2(15);
ALTER TABLE jforum_privmsgs MODIFY privmsgs_ip VARCHAR2(15);
CREATE INDEX idx_vd_topic ON jforum_vote_desc(topic_id);
CREATE INDEX idx_vr_vote ON jforum_vote_results(vote_id);
CREATE INDEX idx_vv_vote ON jforum_vote_voters(vote_id);
CREATE INDEX idx_vv_user ON jforum_vote_voters(vote_user_id);
CREATE INDEX idx_extensions_ext ON jforum_extensions(extension);

DROP TABLE jforum_search_words;
DROP TABLE jforum_search_wordmatch;
DROP TABLE jforum_search_results;
DROP TABLE jforum_search_topics;

CREATE SEQUENCE jforum_moderation_log_seq 
	INCREMENT BY 1
	START WITH 1 MAXVALUE 2.0E9 MINVALUE 1 NOCYCLE
	CACHE 200 ORDER;

CREATE TABLE jforum_moderation_log (
	log_id NUMBER(10) NOT NULL,
	user_id NUMBER(10) NOT NULL,
	log_description BLOB NOT NULL,
	log_original_message BLOB,
	log_date DATE NOT NULL,
	log_type NUMBER(1) DEFAULT 0,
	post_id NUMBER(10),
	topic_id NUMBER(10),
	post_user_id NUMBER(10),
	PRIMARY KEY(log_id)
);

CREATE INDEX idx_ml_user ON jforum_moderation_log(user_id);
CREATE INDEX idx_ml_post_user ON jforum_moderation_log(post_user_id);

UPDATE jforum_forums SET forum_topics = (SELECT COUNT(*) FROM jforum_topics t WHERE t.forum_id = jforum_forums.forum_id AND moderated = 0);