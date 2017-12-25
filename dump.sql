BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS `users` (
	`id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	`login`	TEXT,
	`password`	TEXT,
	`role`	TEXT
);
INSERT INTO `users` VALUES (1,'admin','qwerty','admin');
INSERT INTO `users` VALUES (2,'user','123','user');
CREATE TABLE IF NOT EXISTS `results` (
	`id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	`action_id`	INTEGER,
	`level1`	INTEGER,
	`level2`	INTEGER,
	`level3`	INTEGER,
	`questiontext`	TEXT,
	`answertext`	TEXT,
	`points`	INTEGER,
	FOREIGN KEY(`action_id`) REFERENCES `actions`
);
CREATE TABLE IF NOT EXISTS `questions` (
	`id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	`level1`	INTEGER,
	`level2`	INTEGER,
	`level3`	INTEGER,
	`questionorder`	INTEGER,
	`questiontext`	TEXT
);
INSERT INTO `questions` VALUES (1,2,1,0,0,'Ведение медицинской документации - медицинской карты пациента, получающего медицинскую помощь в амбулаторных условиях');
INSERT INTO `questions` VALUES (2,2,1,1,0,'Карта заполняется на каждое посещение пациента, записи в амбулаторной карте производятся на русском языке, аккуратно, без сокращений, все необходимые в карте исправления осуществляются незамедлительно, подтверждаются подписью врача, заполняющего карту. Допускается запись наименований лекарственных препаратов на латинском языке, а также сокращенные названия противотуберкулезных препаратов, предусмотренные приказом МЗ РФ №951
Н - изониазид
R - рифампицин ');
INSERT INTO `questions` VALUES (3,2,1,2,0,'Заполнение всех разделов, предусмотренных медицинской картой (должно быть проконтролировано лечащим врачом)');
INSERT INTO `questions` VALUES (4,2,1,3,0,'Наличие информированного добровольного согласия на медицинское вмешательство (с подписью пациента, датой заполнения, подписью и расшифровкой подписи врача)');
INSERT INTO `questions` VALUES (5,2,1,4,0,'Наличие согласия на обработку персональных данных (с подписью пациента, датой заполнения, подписью и расшифровкой подписи врача)');
INSERT INTO `questions` VALUES (6,2,2,0,0,'первичный прием пациента');
INSERT INTO `questions` VALUES (7,2,0,0,0,'Критерии качества по условиям оказания медицинской помощи.');
CREATE TABLE IF NOT EXISTS `doctors` (
	`id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	`surname`	TEXT,
	`name`	TEXT,
	`patronymic`	TEXT,
	`fullname`	TEXT,
	`post`	TEXT
);
INSERT INTO `doctors` VALUES (1,'Корелина','Ольга','Николаевна','Корелина Ольга Николаевна','врач-фтизиатр');
INSERT INTO `doctors` VALUES (2,'Сивенко','Елена','Алексеевна','Сивенко Елена Алексеевна','врач-фтизиатр');
CREATE TABLE IF NOT EXISTS `answers` (
	`id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	`answerorder`	INTEGER,
	`question_id`	INTEGER,
	`answertext`	TEXT,
	`points`	INTEGER,
	FOREIGN KEY(`question_id`) REFERENCES `questions`
);
CREATE TABLE IF NOT EXISTS `actions` (
	`id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	`actiondate`	TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	`user_id`	INTEGER,
	`doc_id`	INTEGER,
	`medcardnum`	VARCHAR ( 256 ),
	FOREIGN KEY(`doc_id`) REFERENCES `doctors`,
	FOREIGN KEY(`user_id`) REFERENCES `users`
);
CREATE UNIQUE INDEX IF NOT EXISTS `users_id_idx` ON `users` (
	`id`
);
COMMIT;
