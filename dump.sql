BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS `users` (
	`id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	`login`	TEXT,
	`passwrd`	TEXT,
	`userrole`	TEXT,
	`doctor_id`	INTEGER UNIQUE
);
INSERT INTO `users` VALUES (1,'admin','qwerty','admin',2);
INSERT INTO `users` VALUES (2,'Сивенко','123','user',3);
INSERT INTO `users` VALUES (3,'Корелина','456','user',1);
INSERT INTO `users` VALUES (7,'super1','123','user',0);
INSERT INTO `users` VALUES (8,'77','797','787',5);
CREATE TABLE IF NOT EXISTS `test` (
	`id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	`txt`	TEXT
);
INSERT INTO `test` VALUES (1,'12359');
INSERT INTO `test` VALUES (2,'fsdfsdfsdf');
CREATE TABLE IF NOT EXISTS `results` (
	`id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	`action_id`	INTEGER,
	`level1`	INTEGER,
	`level2`	INTEGER,
	`level3`	INTEGER,
	`questiontext`	TEXT,
	`answertext`	TEXT,
	`points`	INTEGER,
	`comment`	TEXT,
	FOREIGN KEY(`action_id`) REFERENCES `actions`
);
INSERT INTO `results` VALUES (1,23,1,0,0,'Критерии качества по условиям оказания медицинской помощи.',NULL,NULL,NULL);
INSERT INTO `results` VALUES (2,23,1,1,0,'Ведение медицинской документации - медицинской карты пациента, получающего медицинскую помощь в амбулаторных условиях',NULL,NULL,NULL);
INSERT INTO `results` VALUES (3,23,1,1,1,'Карта заполняется на каждое посещение пациента, записи в амбулаторной карте производятся на русском языке, аккуратно, без сокращений, все необходимые в карте исправления осуществляются незамедлительно, подтверждаются подписью врача, заполняющего карту. Допускается запись наименований лекарственных препаратов на латинском языке, а также сокращенные названия противотуберкулезных препаратов, предусмотренные приказом МЗ РФ №951
Н - изониазид
R - рифампицин ',NULL,NULL,NULL);
INSERT INTO `results` VALUES (4,23,1,1,2,'Заполнение всех разделов, предусмотренных медицинской картой (должно быть проконтролировано лечащим врачом)',NULL,NULL,NULL);
INSERT INTO `results` VALUES (5,23,1,1,3,'Наличие информированного добровольного согласия на медицинское вмешательство (с подписью пациента, датой заполнения, подписью и расшифровкой подписи врача)',NULL,NULL,NULL);
INSERT INTO `results` VALUES (6,23,1,1,4,'Наличие согласия на обработку персональных данных (с подписью пациента, датой заполнения, подписью и расшифровкой подписи врача)',NULL,NULL,NULL);
INSERT INTO `results` VALUES (7,23,1,2,0,'первичный прием пациента',NULL,NULL,NULL);
INSERT INTO `results` VALUES (8,44,1,0,0,'Критерии качества по условиям оказания медицинской помощи.',NULL,NULL,NULL);
INSERT INTO `results` VALUES (9,44,1,1,0,'Ведение медицинской документации - медицинской карты пациента, получающего медицинскую помощь в амбулаторных условиях',NULL,NULL,NULL);
INSERT INTO `results` VALUES (10,44,1,1,1,'Карта заполняется на каждое посещение пациента, записи в амбулаторной карте производятся на русском языке, аккуратно, без сокращений, все необходимые в карте исправления осуществляются незамедлительно, подтверждаются подписью врача, заполняющего карту. Допускается запись наименований лекарственных препаратов на латинском языке, а также сокращенные названия противотуберкулезных препаратов, предусмотренные приказом МЗ РФ №951
Н - изониазид
R - рифампицин ',NULL,NULL,NULL);
INSERT INTO `results` VALUES (11,44,1,1,2,'Заполнение всех разделов, предусмотренных медицинской картой (должно быть проконтролировано лечащим врачом)',NULL,NULL,NULL);
INSERT INTO `results` VALUES (12,44,1,1,3,'Наличие информированного добровольного согласия на медицинское вмешательство (с подписью пациента, датой заполнения, подписью и расшифровкой подписи врача)',NULL,NULL,NULL);
INSERT INTO `results` VALUES (13,44,1,1,4,'Наличие согласия на обработку персональных данных (с подписью пациента, датой заполнения, подписью и расшифровкой подписи врача)',NULL,NULL,NULL);
INSERT INTO `results` VALUES (14,44,1,2,0,'первичный прием пациента',NULL,NULL,NULL);
INSERT INTO `results` VALUES (15,45,1,0,0,'Критерии качества по условиям оказания медицинской помощи.',NULL,NULL,NULL);
INSERT INTO `results` VALUES (16,45,1,1,0,'Ведение медицинской документации - медицинской карты пациента, получающего медицинскую помощь в амбулаторных условиях',NULL,NULL,NULL);
INSERT INTO `results` VALUES (17,45,1,1,1,'Карта заполняется на каждое посещение пациента, записи в амбулаторной карте производятся на русском языке, аккуратно, без сокращений, все необходимые в карте исправления осуществляются незамедлительно, подтверждаются подписью врача, заполняющего карту. Допускается запись наименований лекарственных препаратов на латинском языке, а также сокращенные названия противотуберкулезных препаратов, предусмотренные приказом МЗ РФ №951
Н - изониазид
R - рифампицин ',NULL,NULL,NULL);
INSERT INTO `results` VALUES (18,45,1,1,2,'Заполнение всех разделов, предусмотренных медицинской картой (должно быть проконтролировано лечащим врачом)',NULL,NULL,NULL);
INSERT INTO `results` VALUES (19,45,1,1,3,'Наличие информированного добровольного согласия на медицинское вмешательство (с подписью пациента, датой заполнения, подписью и расшифровкой подписи врача)',NULL,NULL,NULL);
INSERT INTO `results` VALUES (20,45,1,1,4,'Наличие согласия на обработку персональных данных (с подписью пациента, датой заполнения, подписью и расшифровкой подписи врача)',NULL,NULL,NULL);
INSERT INTO `results` VALUES (21,45,1,2,0,'первичный прием пациента',NULL,NULL,NULL);
CREATE TABLE IF NOT EXISTS `questions` (
	`id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	`level1`	INTEGER,
	`level2`	INTEGER,
	`level3`	INTEGER,
	`questionorder`	INTEGER,
	`questiontext`	TEXT
);
INSERT INTO `questions` VALUES (1,1,1,0,0,'Ведение медицинской документации - медицинской карты пациента, получающего медицинскую помощь в амбулаторных условиях');
INSERT INTO `questions` VALUES (2,1,1,1,0,'Карта заполняется на каждое посещение пациента, записи в амбулаторной карте производятся на русском языке, аккуратно, без сокращений, все необходимые в карте исправления осуществляются незамедлительно, подтверждаются подписью врача, заполняющего карту. Допускается запись наименований лекарственных препаратов на латинском языке, а также сокращенные названия противотуберкулезных препаратов, предусмотренные приказом МЗ РФ №951
Н - изониазид
R - рифампицин ');
INSERT INTO `questions` VALUES (3,1,1,2,0,'Заполнение всех разделов, предусмотренных медицинской картой (должно быть проконтролировано лечащим врачом)');
INSERT INTO `questions` VALUES (4,1,1,3,0,'Наличие информированного добровольного согласия на медицинское вмешательство (с подписью пациента, датой заполнения, подписью и расшифровкой подписи врача)');
INSERT INTO `questions` VALUES (5,1,1,4,0,'Наличие согласия на обработку персональных данных (с подписью пациента, датой заполнения, подписью и расшифровкой подписи врача)');
INSERT INTO `questions` VALUES (6,1,2,0,0,'первичный прием пациента');
INSERT INTO `questions` VALUES (7,1,0,0,0,'Критерии качества по условиям оказания медицинской помощи.');
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
	`answertype`	INTEGER,
	`answerorder`	INTEGER,
	`question_id`	INTEGER,
	`answertext`	TEXT,
	`points`	INTEGER,
	FOREIGN KEY(`question_id`) REFERENCES `questions`
);
INSERT INTO `answers` VALUES (1,NULL,0,2,'Да',1);
INSERT INTO `answers` VALUES (2,NULL,0,2,'Нет',0);
CREATE TABLE IF NOT EXISTS `actions` (
	`id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	`actiondate`	TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	`user_id`	INTEGER,
	`doc_id`	INTEGER,
	`medcardnum`	TEXT,
	`enddate`	TIMESTAMP,
	FOREIGN KEY(`user_id`) REFERENCES `users`,
	FOREIGN KEY(`doc_id`) REFERENCES `doctors`
);
INSERT INTO `actions` VALUES (1,'2017-12-25 18:51:28',1,1,'6',NULL);
INSERT INTO `actions` VALUES (2,'2017-12-25 19:03:42',1,2,'выавыа',NULL);
INSERT INTO `actions` VALUES (3,'2017-12-25 19:07:37',1,1,'defds',NULL);
INSERT INTO `actions` VALUES (4,'2017-12-25 19:11:23',1,1,'dsf',NULL);
INSERT INTO `actions` VALUES (5,'2017-12-25 19:12:22',1,1,'sgfgfdg',NULL);
INSERT INTO `actions` VALUES (6,'2017-12-25 19:32:31',1,1,'123',NULL);
INSERT INTO `actions` VALUES (7,'2017-12-25 19:37:18',1,1,'dsfds',NULL);
INSERT INTO `actions` VALUES (8,'2017-12-25 19:37:43',1,1,'sdfsdf',NULL);
INSERT INTO `actions` VALUES (9,'2017-12-25 19:38:37',1,1,'sdfsdf',NULL);
INSERT INTO `actions` VALUES (10,'2017-12-25 19:38:42',1,2,'sdfsdfsdfdsf',NULL);
INSERT INTO `actions` VALUES (11,'2017-12-25 19:38:52',1,1,'sdfsdfsdfdsfdf',NULL);
INSERT INTO `actions` VALUES (12,'2017-12-25 19:39:49',1,1,'sdfds',NULL);
INSERT INTO `actions` VALUES (13,'2017-12-25 19:39:58',1,1,'sdfds',NULL);
INSERT INTO `actions` VALUES (14,'2017-12-25 19:40:36',1,1,'dsfds',NULL);
INSERT INTO `actions` VALUES (15,'2017-12-25 19:41:46',1,1,'dfd',NULL);
INSERT INTO `actions` VALUES (16,'2017-12-25 19:41:50',1,1,'dfd',NULL);
INSERT INTO `actions` VALUES (17,'2017-12-25 19:47:43',1,1,'46',NULL);
INSERT INTO `actions` VALUES (18,'2017-12-25 19:48:34',1,1,'dsf',NULL);
INSERT INTO `actions` VALUES (19,'2017-12-25 19:49:18',1,2,'sdfds',NULL);
INSERT INTO `actions` VALUES (20,'2017-12-25 19:49:21',1,1,'sdfds',NULL);
INSERT INTO `actions` VALUES (21,'2017-12-25 19:49:21',1,1,'sdfds',NULL);
INSERT INTO `actions` VALUES (22,'2017-12-25 19:50:58',1,2,'324324',NULL);
INSERT INTO `actions` VALUES (23,'2017-12-25 19:50:59',1,2,'324324',NULL);
INSERT INTO `actions` VALUES (24,'2017-12-25 19:51:01',1,2,'324324sdfds',NULL);
INSERT INTO `actions` VALUES (25,'2017-12-25 19:51:04',1,1,'324324sdfds',NULL);
INSERT INTO `actions` VALUES (26,'2017-12-25 19:51:07',1,1,'324324sdfdssdfsd',NULL);
INSERT INTO `actions` VALUES (27,'2017-12-25 20:42:10',1,1,'dsf',NULL);
INSERT INTO `actions` VALUES (28,'2017-12-25 20:47:58',1,1,'sdfdsfds',NULL);
INSERT INTO `actions` VALUES (29,'2017-12-25 20:47:58',1,1,'sdfdsfds',NULL);
INSERT INTO `actions` VALUES (30,'2017-12-25 20:47:59',1,1,'sdfdsfds',NULL);
INSERT INTO `actions` VALUES (31,'2017-12-25 21:36:02',1,1,'уцкуцк',NULL);
INSERT INTO `actions` VALUES (32,'2017-12-25 22:01:43',1,2,'555',NULL);
INSERT INTO `actions` VALUES (33,'2017-12-26 17:08:18',1,1,'1',NULL);
INSERT INTO `actions` VALUES (34,'2017-12-26 17:08:22',1,1,'1',NULL);
INSERT INTO `actions` VALUES (35,'2017-12-26 17:14:03',1,2,'6',NULL);
INSERT INTO `actions` VALUES (36,'2017-12-26 17:15:56',1,2,'9',NULL);
INSERT INTO `actions` VALUES (37,'2017-12-26 18:29:36',1,1,'1',NULL);
INSERT INTO `actions` VALUES (38,'2017-12-26 18:29:44',1,1,'12',NULL);
INSERT INTO `actions` VALUES (39,'2017-12-26 18:31:30',1,1,'1',NULL);
INSERT INTO `actions` VALUES (40,'2017-12-26 18:33:18',1,1,'0',NULL);
INSERT INTO `actions` VALUES (41,'2017-12-26 18:34:43',1,1,'33',NULL);
INSERT INTO `actions` VALUES (42,'2017-12-26 18:49:06',1,1,'1111',NULL);
INSERT INTO `actions` VALUES (43,'2017-12-26 18:49:18',1,1,'1111',NULL);
INSERT INTO `actions` VALUES (44,'2017-12-26 18:57:32',1,1,'123',NULL);
INSERT INTO `actions` VALUES (45,'2017-12-26 18:58:21',1,2,'435435',NULL);
CREATE UNIQUE INDEX IF NOT EXISTS `users_id_idx` ON `users` (
	`id`
);
COMMIT;
