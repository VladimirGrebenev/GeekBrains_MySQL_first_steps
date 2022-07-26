-- MySQL dump 10.13  Distrib 8.0.29, for Win64 (x86_64)
--
-- Host: localhost    Database: world_traitors_base
-- ------------------------------------------------------
-- Server version	8.0.29

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `betrayals`
--

DROP TABLE IF EXISTS `betrayals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `betrayals` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `traitor_id` bigint unsigned NOT NULL,
  `description_of_betrayal` text NOT NULL,
  `date_of_betrayal` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `traitor_id` (`traitor_id`),
  CONSTRAINT `betrayals_ibfk_1` FOREIGN KEY (`traitor_id`) REFERENCES `traitors` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `betrayals`
--

LOCK TABLES `betrayals` WRITE;
/*!40000 ALTER TABLE `betrayals` DISABLE KEYS */;
INSERT INTO `betrayals` VALUES (1,1,'текст с описанием предательства 1','0033-04-02 00:00:00'),(2,2,'текст с описанием предательства 2','0044-03-15 00:00:00'),(3,3,'текст с описанием предательства 3','1942-07-11 00:00:00'),(4,4,'текст с описанием предательства 4','1979-01-01 00:00:00'),(5,5,'текст с описанием предательства 5','1990-04-14 00:00:00'),(6,6,'текст с описанием предательства 6','1974-01-01 00:00:00'),(7,7,'текст с описанием предательства 7','1973-01-01 00:00:00'),(8,8,'текст с описанием предательства 8','1991-08-30 00:00:00'),(9,9,'текст с описанием предательства 9','1991-12-26 00:00:00'),(10,10,'текст с описанием предательства 10','2022-02-23 00:00:00');
/*!40000 ALTER TABLE `betrayals` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_date_of_betrayal_before_insert` BEFORE INSERT ON `betrayals` FOR EACH ROW BEGIN 
	IF NEW.date_of_betrayal >= CURRENT_DATE() THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =  'Insert Canceled. The day of betrayal has not yet come!';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_date_of_betrayal_before_update` BEFORE UPDATE ON `betrayals` FOR EACH ROW BEGIN 
	IF NEW.date_of_betrayal >= CURRENT_DATE() THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT =  'Update Canceled. The day of betrayal has not yet come!';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `betrayals_damnation`
--

DROP TABLE IF EXISTS `betrayals_damnation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `betrayals_damnation` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `betrayals_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `damnation_type` tinyint(1) DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `betrayals_id` (`betrayals_id`),
  CONSTRAINT `betrayals_damnation_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `betrayals_damnation_ibfk_2` FOREIGN KEY (`betrayals_id`) REFERENCES `betrayals` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `betrayals_damnation`
--

LOCK TABLES `betrayals_damnation` WRITE;
/*!40000 ALTER TABLE `betrayals_damnation` DISABLE KEYS */;
INSERT INTO `betrayals_damnation` VALUES (1,1,1,1,'2022-07-11 11:36:03'),(2,2,1,1,'2022-07-11 11:36:03'),(3,3,1,1,'2022-07-11 11:36:03'),(4,4,1,1,'2022-07-11 11:36:03'),(5,5,1,1,'2022-07-11 11:36:03'),(6,6,1,1,'2022-07-11 11:36:03'),(7,7,1,1,'2022-07-11 11:36:03'),(8,8,1,1,'2022-07-11 11:36:03'),(9,9,1,1,'2022-07-11 11:36:03'),(10,10,1,1,'2022-07-11 11:36:03'),(11,1,2,1,'2022-07-11 11:36:03'),(12,2,2,1,'2022-07-11 11:36:03'),(13,3,2,1,'2022-07-11 11:36:03'),(14,4,2,1,'2022-07-11 11:36:03'),(15,5,2,1,'2022-07-11 11:36:03'),(16,6,2,1,'2022-07-11 11:36:03'),(17,7,2,1,'2022-07-11 11:36:03'),(18,8,2,1,'2022-07-11 11:36:03'),(19,9,2,1,'2022-07-11 11:36:03'),(20,10,2,1,'2022-07-11 11:36:03'),(21,4,3,1,'2022-07-11 11:36:03'),(22,5,3,1,'2022-07-11 11:36:03'),(23,6,3,1,'2022-07-11 11:36:03'),(24,7,3,1,'2022-07-11 11:36:03'),(25,8,3,1,'2022-07-11 11:36:03'),(26,9,3,1,'2022-07-11 11:36:03'),(27,10,3,1,'2022-07-11 11:36:03'),(28,1,4,1,'2022-07-11 11:36:03'),(29,2,4,1,'2022-07-11 11:36:03'),(30,3,4,1,'2022-07-11 11:36:03'),(31,4,4,1,'2022-07-11 11:36:03'),(32,5,4,1,'2022-07-11 11:36:03'),(33,6,4,1,'2022-07-11 11:36:03'),(34,7,4,1,'2022-07-11 11:36:03'),(35,1,5,1,'2022-07-11 11:36:03'),(36,2,5,1,'2022-07-11 11:36:03'),(37,3,5,1,'2022-07-11 11:36:03'),(38,8,5,1,'2022-07-11 11:36:03'),(39,9,5,1,'2022-07-11 11:36:03'),(40,10,5,1,'2022-07-11 11:36:03'),(41,1,6,1,'2022-07-11 11:36:03'),(42,10,6,1,'2022-07-11 11:36:03'),(43,8,7,1,'2022-07-11 11:36:03'),(44,9,7,1,'2022-07-11 11:36:03'),(45,10,7,1,'2022-07-11 11:36:03'),(46,9,8,1,'2022-07-11 11:36:03'),(47,10,8,1,'2022-07-11 11:36:03'),(48,8,9,1,'2022-07-11 11:36:03'),(49,9,9,1,'2022-07-11 11:36:03'),(50,10,9,1,'2022-07-11 11:36:03'),(51,10,10,1,'2022-07-11 11:36:03');
/*!40000 ALTER TABLE `betrayals_damnation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `city` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `city_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `city_name` (`city_name`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city`
--

LOCK TABLES `city` WRITE;
/*!40000 ALTER TABLE `city` DISABLE KEYS */;
INSERT INTO `city` VALUES (10,'Актюбинск'),(9,'Бутка'),(11,'Горловка'),(2,'Иерусалим'),(1,'Кариот'),(6,'Ленинград'),(5,'Ломакино'),(7,'Москва'),(8,'Привольное'),(3,'Рим'),(4,'Филипп');
/*!40000 ALTER TABLE `city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `country` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `country_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `country_name` (`country_name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` VALUES (6,'Иудея'),(5,'Македония'),(1,'Римская империя'),(4,'Российская Империя'),(3,'Россия'),(2,'СССР');
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profession`
--

DROP TABLE IF EXISTS `profession`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profession` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profession`
--

LOCK TABLES `profession` WRITE;
/*!40000 ALTER TABLE `profession` DISABLE KEYS */;
INSERT INTO `profession` VALUES (3,'военный'),(5,'дипломат'),(4,'инженер'),(1,'казначей'),(6,'музыкант'),(2,'политик');
/*!40000 ALTER TABLE `profession` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profiles` (
  `traitor_id` bigint unsigned NOT NULL,
  `photo_id` bigint unsigned DEFAULT NULL,
  `gender` enum('f','m') NOT NULL,
  `birthday` date NOT NULL,
  `deathday` date DEFAULT NULL,
  `born_city_id` int unsigned NOT NULL,
  `born_country_id` int unsigned NOT NULL,
  `country_working_in` int unsigned NOT NULL,
  `profession` int unsigned NOT NULL,
  `type_of_traitor` int unsigned NOT NULL,
  PRIMARY KEY (`traitor_id`),
  KEY `born_city_id` (`born_city_id`),
  KEY `born_country_id` (`born_country_id`),
  KEY `country_working_in` (`country_working_in`),
  KEY `profession` (`profession`),
  KEY `type_of_traitor` (`type_of_traitor`),
  CONSTRAINT `profiles_ibfk_1` FOREIGN KEY (`traitor_id`) REFERENCES `traitors` (`id`),
  CONSTRAINT `profiles_ibfk_2` FOREIGN KEY (`born_city_id`) REFERENCES `city` (`id`),
  CONSTRAINT `profiles_ibfk_3` FOREIGN KEY (`born_country_id`) REFERENCES `country` (`id`),
  CONSTRAINT `profiles_ibfk_4` FOREIGN KEY (`country_working_in`) REFERENCES `country` (`id`),
  CONSTRAINT `profiles_ibfk_5` FOREIGN KEY (`profession`) REFERENCES `profession` (`id`),
  CONSTRAINT `profiles_ibfk_6` FOREIGN KEY (`type_of_traitor`) REFERENCES `traitor_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT INTO `profiles` VALUES (1,1,'m','0000-04-01','0033-04-04',1,6,1,1,1),(2,2,'m','0085-12-01','0042-10-23',3,1,1,2,2),(3,3,'m','1901-09-14','1946-08-01',5,1,2,3,3),(4,4,'m','1927-01-06','1986-09-24',10,2,2,4,1),(5,5,'m','1934-09-06',NULL,6,2,2,3,1),(6,6,'m','1938-10-10',NULL,7,2,2,3,1),(7,7,'m','1930-10-11','1998-02-28',11,2,2,5,1),(8,8,'m','1931-03-02',NULL,8,2,2,2,4),(9,9,'m','1931-02-01','2007-04-23',9,2,2,2,2),(10,10,'m','1953-12-11',NULL,7,2,3,6,1);
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proof_media`
--

DROP TABLE IF EXISTS `proof_media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proof_media` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `traitor_id` bigint unsigned NOT NULL,
  `media_types_id` int unsigned NOT NULL,
  `file_name` varchar(255) DEFAULT NULL COMMENT '/files/folder/img.png',
  `files_size` bigint unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `media_types_id` (`media_types_id`),
  KEY `traitor_id` (`traitor_id`),
  CONSTRAINT `proof_media_ibfk_1` FOREIGN KEY (`media_types_id`) REFERENCES `proof_media_types` (`id`),
  CONSTRAINT `proof_media_ibfk_2` FOREIGN KEY (`traitor_id`) REFERENCES `traitors` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proof_media`
--

LOCK TABLES `proof_media` WRITE;
/*!40000 ALTER TABLE `proof_media` DISABLE KEYS */;
INSERT INTO `proof_media` VALUES (1,1,2,'/files/folder/1.pdf',20,'2022-07-11 11:36:02'),(2,2,2,'/files/folder/2.pdf',20,'2022-07-11 11:36:02'),(3,3,3,'/files/folder/3.mov',20,'2022-07-11 11:36:02'),(4,4,3,'/files/folder/4.mov',20,'2022-07-11 11:36:02'),(5,5,3,'/files/folder/5.mov',20,'2022-07-11 11:36:02'),(6,6,3,'/files/folder/6.mov',20,'2022-07-11 11:36:02'),(7,7,3,'/files/folder/7.mov',20,'2022-07-11 11:36:02'),(8,8,3,'/files/folder/8.mov',20,'2022-07-11 11:36:02'),(9,9,3,'/files/folder/9.mov',20,'2022-07-11 11:36:02'),(10,10,3,'/files/folder/10.mov',20,'2022-07-11 11:36:02');
/*!40000 ALTER TABLE `proof_media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proof_media_types`
--

DROP TABLE IF EXISTS `proof_media_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proof_media_types` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proof_media_types`
--

LOCK TABLES `proof_media_types` WRITE;
/*!40000 ALTER TABLE `proof_media_types` DISABLE KEYS */;
INSERT INTO `proof_media_types` VALUES (1,'видео'),(2,'документ'),(3,'ссылка');
/*!40000 ALTER TABLE `proof_media_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `traitor_types`
--

DROP TABLE IF EXISTS `traitor_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `traitor_types` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `traitor_types`
--

LOCK TABLES `traitor_types` WRITE;
/*!40000 ALTER TABLE `traitor_types` DISABLE KEYS */;
INSERT INTO `traitor_types` VALUES (2,'за власть'),(1,'за деньги'),(3,'за жизнь'),(4,'тщеславие');
/*!40000 ALTER TABLE `traitor_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `traitors`
--

DROP TABLE IF EXISTS `traitors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `traitors` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(150) NOT NULL,
  `lastname` varchar(150) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `traitors`
--

LOCK TABLES `traitors` WRITE;
/*!40000 ALTER TABLE `traitors` DISABLE KEYS */;
INSERT INTO `traitors` VALUES (1,'Иуда','Искариот','2022-07-11 11:36:02'),(2,'Марк Юний','Брут','2022-07-11 11:36:02'),(3,'Андрей Андреевич','Власов','2022-07-11 11:36:02'),(4,'Адольф Георгиевич','Толкачёв','2022-07-11 11:36:02'),(5,'Олег Данилович','Калугин','2022-07-11 11:36:02'),(6,'Олег Антонович','Гордиевский','2022-07-11 11:36:02'),(7,'Аркадий Николаевич','Шевченко','2022-07-11 11:36:02'),(8,'Михаил Сергеевич','Горбачёв','2022-07-11 11:36:02'),(9,'Борис Николаевич','Ельцин','2022-07-11 11:36:02'),(10,'Андрей Вадимович','Макаревич','2022-07-11 11:36:02');
/*!40000 ALTER TABLE `traitors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `traitors_list`
--

DROP TABLE IF EXISTS `traitors_list`;
/*!50001 DROP VIEW IF EXISTS `traitors_list`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `traitors_list` AS SELECT 
 1 AS `id`,
 1 AS `Предатель`,
 1 AS `damn`,
 1 AS `пол`,
 1 AS `дата рождения`,
 1 AS `место рождения`,
 1 AS `страна основного дохода`,
 1 AS `профессия`,
 1 AS `тип предательства`,
 1 AS `суть предательства`,
 1 AS `дата предательства`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(150) NOT NULL,
  `lastname` varchar(150) NOT NULL,
  `email` varchar(150) NOT NULL,
  `phone` char(11) NOT NULL,
  `password_hash` char(65) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Guadalupe','Nitzsche','greenfelder.antwan@example.org','89213456678','d6f684fe75bdff654841d18f34c9acd6d3b05233','2011-12-04 16:57:02'),(2,'Elmira','Bayer','xjacobs@example.org','89214507878','501a9b34edb153894128f6255ff3ef6bf0d3f4db','1990-01-20 18:48:26'),(3,'D\'angelo','Cruickshank','linwood.medhurst@example.org','89214567878','3273c607f8dfbc808adaa5493b7439ba08c3f43e','1994-09-04 15:21:06'),(4,'Princess','Runolfsson','huel.nash@example.org','89213455643','21444980cef626302f7ae9a507971889c9daac1d','1987-08-27 19:05:04'),(5,'Ethan','Legros','mhickle@example.org','89219567878','4dd91825495d2233602c0b0af6ff8b113b1844d9','1993-01-08 23:58:41'),(6,'Freda','Sporer','devyn70@example.net','89213457870','3df01bfd0a99988ca0383a49481e523226d4adca','1997-11-10 19:45:09'),(7,'Bonnie','Prosacco','hester.marvin@example.com','89213332222','10db70a3dcce2a22dd8eabdc7342260c91ff1749','1982-09-30 14:12:03'),(8,'Sierra','Bruen','aprosacco@example.net','89212222334','99fbaa12eecf0e10bf372dbf9cf7f98267b6636e','2004-01-28 04:41:46'),(9,'Trudie','Heller','hjohnston@example.net','89213336675','33b1681186add7816a701f570615c9d0aae215ab','1999-06-10 12:49:14'),(10,'Shaylee','Sawayn','pagac.clarissa@example.org','89212233456','b1771cc64742c38ec18ac67a4e61597b05cc9e20','1973-12-14 01:24:44'),(11,'Demarco','Eichmann','lakin.ethel@example.org','89233388787','f7f50eddf4d112d2d858510211128b8e0de60f84','2006-02-22 14:32:06');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `ussr_traitors_list`
--

DROP TABLE IF EXISTS `ussr_traitors_list`;
/*!50001 DROP VIEW IF EXISTS `ussr_traitors_list`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `ussr_traitors_list` AS SELECT 
 1 AS `id`,
 1 AS `Предатель`,
 1 AS `damn`,
 1 AS `дата рождения`,
 1 AS `место рождения`,
 1 AS `профессия`,
 1 AS `тип предательства`,
 1 AS `дата предательства`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `traitors_list`
--

/*!50001 DROP VIEW IF EXISTS `traitors_list`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `traitors_list` AS select `t`.`id` AS `id`,concat(`t`.`firstname`,' ',`t`.`lastname`) AS `Предатель`,count(0) AS `damn`,(case `p`.`gender` when 'm' then 'мужчина' else 'женщина' end) AS `пол`,`p`.`birthday` AS `дата рождения`,concat((select `ct`.`city_name` from `city` `ct` where (`ct`.`id` = `p`.`born_city_id`)),' ',(select `c`.`country_name` from `country` `c` where (`c`.`id` = `p`.`born_country_id`))) AS `место рождения`,(select `c`.`country_name` from `country` `c` where (`c`.`id` = `p`.`country_working_in`)) AS `страна основного дохода`,(case `p`.`profession` when 1 then 'казначей' when 2 then 'политик' when 3 then 'военный' when 4 then 'инженер' when 5 then 'дипломат' else 'музыкант' end) AS `профессия`,(select `tt`.`name` from `traitor_types` `tt` where (`tt`.`id` = `p`.`type_of_traitor`)) AS `тип предательства`,`b`.`description_of_betrayal` AS `суть предательства`,`b`.`date_of_betrayal` AS `дата предательства` from (((`traitors` `t` join `profiles` `p` on((`t`.`id` = `p`.`traitor_id`))) join `betrayals` `b` on((`t`.`id` = `b`.`traitor_id`))) join `betrayals_damnation` `bd` on((`bd`.`betrayals_id` = `b`.`id`))) where (`bd`.`damnation_type` = 1) group by `t`.`id` order by `damn` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `ussr_traitors_list`
--

/*!50001 DROP VIEW IF EXISTS `ussr_traitors_list`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `ussr_traitors_list` AS select `t`.`id` AS `id`,concat(`t`.`firstname`,' ',`t`.`lastname`) AS `Предатель`,count(0) AS `damn`,`p`.`birthday` AS `дата рождения`,concat((select `ct`.`city_name` from `city` `ct` where (`ct`.`id` = `p`.`born_city_id`)),' ',(select `c`.`country_name` from `country` `c` where (`c`.`id` = `p`.`born_country_id`))) AS `место рождения`,(case `p`.`profession` when 1 then 'казначей' when 2 then 'политик' when 3 then 'военный' when 4 then 'инженер' when 5 then 'дипломат' else 'музыкант' end) AS `профессия`,(select `tt`.`name` from `traitor_types` `tt` where (`tt`.`id` = `p`.`type_of_traitor`)) AS `тип предательства`,`b`.`date_of_betrayal` AS `дата предательства` from (((`traitors` `t` join `profiles` `p` on((`t`.`id` = `p`.`traitor_id`))) join `betrayals` `b` on((`t`.`id` = `b`.`traitor_id`))) join `betrayals_damnation` `bd` on((`bd`.`betrayals_id` = `b`.`id`))) where ((`bd`.`damnation_type` = 1) and (`p`.`country_working_in` = 2)) group by `t`.`id` order by `damn` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-07-12 21:52:15
