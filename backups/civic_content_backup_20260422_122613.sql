/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.14-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: 127.0.0.1    Database: civic_platform
-- ------------------------------------------------------
-- Server version	12.2.2-MariaDB-ubu2404

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `event` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `current_participants` int(11) NOT NULL,
  `date` datetime(6) NOT NULL,
  `description` text DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `max_capacity` int(11) NOT NULL,
  `organizer_id` bigint(20) NOT NULL,
  `status` enum('UPCOMING','ONGOING','COMPLETED','CANCELLED') NOT NULL,
  `title` varchar(255) NOT NULL,
  `type` enum('VISITE','FORMATION','DISTRIBUTION','COLLECTE') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES
(1,'2026-04-22 10:24:38.523312',0,'2026-04-08 11:26:00.000000','ss','sds',100,4,'ONGOING','ss','VISITE'),
(2,'2026-04-22 10:29:06.903692',7,'2026-04-27 11:28:00.000000','Solidarity food distribution for families in need, community kitchen support, leftover food waste reduction, and fridge restock. Volunteers for Ramadan/iftar support are welcome on Saturday.','Bab Bhar, Tunis',80,6,'ONGOING','Weekend Food Distribution & Community Fridge Restock - Tunis','DISTRIBUTION'),
(3,'2026-04-22 10:42:12.000000',1,'2026-04-25 10:42:12.000000','Solidarity food distribution and community fridge restock. Focus on leftover food waste reduction, Ramadan/iftar support, and weekend volunteers.','Bab Bhar, Tunis',120,106,'UPCOMING','CLI Seeded: Food Rescue Weekend - Tunis','DISTRIBUTION'),
(4,'2026-04-16 10:57:02.000000',1,'2026-05-18 10:00:00.000000','Active community event in Tunis focused on ramadan iftar and local solidarity. Includes weekend volunteer slots, local partner coordination, and measurable social impact tracking.','Tunis',124,107,'UPCOMING','[TN26E1-001] School Supplies & Meals Outreach - Tunis','DISTRIBUTION'),
(5,'2026-04-20 10:57:02.000000',0,'2026-05-16 10:00:00.000000','Active community event in Nabeul focused on ramadan iftar and local solidarity. Includes weekend volunteer slots, local partner coordination, and measurable social impact tracking.','Nabeul',200,117,'UPCOMING','[TN26E1-002] Community Health Awareness Caravan - Nabeul','VISITE'),
(6,'2026-04-16 10:57:02.000000',0,'2026-06-01 10:00:00.000000','Active community event in Ben Arous focused on community volunteering and logistics support. Includes weekend volunteer slots, local partner coordination, and measurable social impact tracking.','Ben Arous',85,107,'ONGOING','[TN26E1-003] School Supplies & Meals Outreach - Ben Arous','VISITE'),
(7,'2026-04-19 10:57:02.000000',1,'2026-05-07 10:00:00.000000','Active community event in Kairouan focused on ramadan iftar and local solidarity. Includes weekend volunteer slots, local partner coordination, and measurable social impact tracking.','Kairouan',113,113,'UPCOMING','[TN26E1-004] Ramadan Solidarity Kitchen - Kairouan','VISITE'),
(8,'2026-04-14 10:57:02.000000',0,'2026-05-12 10:00:00.000000','Active community event in Gafsa focused on youth employability and digital readiness. Includes weekend volunteer slots, local partner coordination, and measurable social impact tracking.','Gafsa',238,113,'UPCOMING','[TN26E1-005] Digital Skills Bootcamp for Youth - Gafsa','FORMATION'),
(9,'2026-04-19 10:57:02.000000',0,'2026-05-23 10:00:00.000000','Active community event in Medenine focused on food solidarity and family support. Includes weekend volunteer slots, local partner coordination, and measurable social impact tracking.','Medenine',109,6,'ONGOING','[TN26E1-006] Inclusive Civic Participation Lab - Medenine','VISITE'),
(10,'2026-04-15 10:57:02.000000',0,'2026-05-26 10:00:00.000000','Active community event in Sfax focused on food solidarity and family support. Includes weekend volunteer slots, local partner coordination, and measurable social impact tracking.','Sfax',115,117,'UPCOMING','[TN26E1-007] Digital Skills Bootcamp for Youth - Sfax','DISTRIBUTION'),
(11,'2026-04-13 10:57:02.000000',0,'2026-05-06 10:00:00.000000','Active community event in Gafsa focused on youth employability and digital readiness. Includes weekend volunteer slots, local partner coordination, and measurable social impact tracking.','Gafsa',251,117,'UPCOMING','[TN26E1-008] School Supplies & Meals Outreach - Gafsa','VISITE'),
(12,'2026-04-11 10:57:02.000000',0,'2026-05-06 10:00:00.000000','Active community event in Kairouan focused on ramadan iftar and local solidarity. Includes weekend volunteer slots, local partner coordination, and measurable social impact tracking.','Kairouan',148,113,'ONGOING','[TN26E1-009] Women Artisan Market Support - Kairouan','DISTRIBUTION'),
(13,'2026-04-20 10:57:02.000000',0,'2026-05-01 10:00:00.000000','Active community event in Ariana focused on youth employability and digital readiness. Includes weekend volunteer slots, local partner coordination, and measurable social impact tracking.','Ariana',167,109,'UPCOMING','[TN26E1-010] Local Market Recovery Forum - Ariana','DISTRIBUTION'),
(14,'2026-04-17 10:57:02.000000',0,'2026-05-10 10:00:00.000000','Active community event in Manouba focused on coastal cleanup and environment awareness. Includes weekend volunteer slots, local partner coordination, and measurable social impact tracking.','Manouba',232,106,'UPCOMING','[TN26E1-011] Local Market Recovery Forum - Manouba','COLLECTE'),
(15,'2026-04-13 10:57:02.000000',0,'2026-04-29 10:00:00.000000','Active community event in Bizerte focused on community volunteering and logistics support. Includes weekend volunteer slots, local partner coordination, and measurable social impact tracking.','Bizerte',161,113,'ONGOING','[TN26E1-012] Ramadan Solidarity Kitchen - Bizerte','COLLECTE'),
(16,'2026-04-14 10:57:02.000000',0,'2026-06-01 10:00:00.000000','Active community event in Gabes focused on technology mentoring and coding basics. Includes weekend volunteer slots, local partner coordination, and measurable social impact tracking.','Gabes',87,106,'UPCOMING','[TN26E1-013] Digital Skills Bootcamp for Youth - Gabes','VISITE'),
(17,'2026-04-14 10:57:02.000000',0,'2026-05-04 10:00:00.000000','Active community event in Nabeul focused on community volunteering and logistics support. Includes weekend volunteer slots, local partner coordination, and measurable social impact tracking.','Nabeul',230,106,'UPCOMING','[TN26E1-014] Eco-Coastal Volunteer Day - Nabeul','VISITE'),
(18,'2026-04-10 10:57:02.000000',0,'2026-05-16 10:00:00.000000','Active community event in Ben Arous focused on coastal cleanup and environment awareness. Includes weekend volunteer slots, local partner coordination, and measurable social impact tracking.','Ben Arous',253,6,'ONGOING','[TN26E1-015] Eco-Coastal Volunteer Day - Ben Arous','FORMATION'),
(19,'2026-04-17 10:57:02.000000',1,'2026-05-16 10:00:00.000000','Active community event in Manouba focused on technology mentoring and coding basics. Includes weekend volunteer slots, local partner coordination, and measurable social impact tracking.','Manouba',274,6,'UPCOMING','[TN26E1-016] Ramadan Solidarity Kitchen - Manouba','DISTRIBUTION'),
(20,'2026-04-20 10:57:02.000000',0,'2026-05-17 10:00:00.000000','Active community event in Manouba focused on ramadan iftar and local solidarity. Includes weekend volunteer slots, local partner coordination, and measurable social impact tracking.','Manouba',166,107,'UPCOMING','[TN26E1-017] Women Artisan Market Support - Manouba','FORMATION'),
(21,'2026-04-21 10:57:02.000000',0,'2026-06-06 10:00:00.000000','Active community event in Jendouba focused on youth employability and digital readiness. Includes weekend volunteer slots, local partner coordination, and measurable social impact tracking.','Jendouba',167,6,'ONGOING','[TN26E1-018] Urban Composting Workshop - Jendouba','VISITE'),
(22,'2026-04-19 10:57:02.000000',1,'2026-05-15 10:00:00.000000','Active community event in Sfax focused on technology mentoring and coding basics. Includes weekend volunteer slots, local partner coordination, and measurable social impact tracking.','Sfax',195,107,'UPCOMING','[TN26E1-019] Local Market Recovery Forum - Sfax','COLLECTE'),
(23,'2026-04-11 10:57:02.000000',1,'2026-05-09 10:00:00.000000','Active community event in Zaghouan focused on ramadan iftar and local solidarity. Includes weekend volunteer slots, local partner coordination, and measurable social impact tracking.','Zaghouan',224,113,'UPCOMING','[TN26E1-020] Ramadan Solidarity Kitchen - Zaghouan','COLLECTE');
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`civic_user`@`%`*/ /*!50003 TRIGGER trg_event_bi_enforce_participants
BEFORE INSERT ON event
FOR EACH ROW
BEGIN
    SET NEW.current_participants = 0;
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
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`civic_user`@`%`*/ /*!50003 TRIGGER trg_event_bu_enforce_participants
BEFORE UPDATE ON event
FOR EACH ROW
BEGIN
    SET NEW.current_participants = (
        SELECT COUNT(*)
        FROM event_participant ep
        WHERE ep.event_id = OLD.id
          AND ep.status IN ('REGISTERED', 'CHECKED_IN')
    );
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
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`civic_user`@`%`*/ /*!50003 TRIGGER trg_event_au
AFTER UPDATE ON event
FOR EACH ROW
BEGIN
    IF NEW.status <> OLD.status THEN
        CALL sp_recalc_event_participants(NEW.id);
        CALL sp_recalc_users_for_event(NEW.id);
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `event_participant`
--

DROP TABLE IF EXISTS `event_participant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_participant` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `checked_in_at` datetime(6) DEFAULT NULL,
  `completed_at` datetime(6) DEFAULT NULL,
  `registered_at` datetime(6) NOT NULL,
  `status` enum('REGISTERED','CHECKED_IN','COMPLETED','CANCELLED','NO_SHOW') NOT NULL,
  `event_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK1kliqx2417x7x9yeqmdrskmu6` (`event_id`,`user_id`),
  KEY `FKhwcglexuoexhrbe9728pn6jqb` (`user_id`),
  CONSTRAINT `FK5hxneasi6gucfdlc8690c1ngc` FOREIGN KEY (`event_id`) REFERENCES `event` (`id`),
  CONSTRAINT `FKhwcglexuoexhrbe9728pn6jqb` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_participant`
--

LOCK TABLES `event_participant` WRITE;
/*!40000 ALTER TABLE `event_participant` DISABLE KEYS */;
INSERT INTO `event_participant` VALUES
(1,'2026-02-21 10:39:29.000000',NULL,'2026-02-20 10:39:29.000000','CHECKED_IN',2,107),
(2,'2026-03-03 10:39:29.000000',NULL,'2026-03-02 10:39:29.000000','CHECKED_IN',2,109),
(3,'2026-03-13 10:39:29.000000',NULL,'2026-03-12 10:39:29.000000','CHECKED_IN',2,111),
(4,'2026-03-18 10:39:29.000000',NULL,'2026-03-17 10:39:29.000000','CHECKED_IN',2,113),
(5,'2026-03-23 10:39:29.000000',NULL,'2026-03-22 10:39:29.000000','CHECKED_IN',2,114),
(6,'2026-03-28 10:39:29.000000',NULL,'2026-03-27 10:39:29.000000','CHECKED_IN',2,116),
(7,'2026-04-02 10:39:29.000000',NULL,'2026-04-01 10:39:29.000000','CHECKED_IN',2,117),
(8,NULL,NULL,'2026-04-22 10:43:48.305746','REGISTERED',3,5),
(9,NULL,NULL,'2026-04-22 11:00:51.102641','REGISTERED',4,5),
(10,NULL,NULL,'2026-04-22 11:01:16.853430','REGISTERED',7,5),
(12,NULL,NULL,'2026-04-22 11:01:37.411603','REGISTERED',19,5),
(13,NULL,NULL,'2026-04-22 11:01:47.138140','REGISTERED',23,5),
(14,NULL,NULL,'2026-04-22 11:01:56.958220','REGISTERED',22,5);
/*!40000 ALTER TABLE `event_participant` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`civic_user`@`%`*/ /*!50003 TRIGGER trg_event_participant_ai
AFTER INSERT ON event_participant
FOR EACH ROW
BEGIN
    CALL sp_recalc_event_participants(NEW.event_id);
    CALL sp_recalc_user_engagement(NEW.user_id);
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
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`civic_user`@`%`*/ /*!50003 TRIGGER trg_event_participant_au
AFTER UPDATE ON event_participant
FOR EACH ROW
BEGIN
    CALL sp_recalc_event_participants(OLD.event_id);
    CALL sp_recalc_user_engagement(OLD.user_id);
    IF NEW.event_id <> OLD.event_id THEN
        CALL sp_recalc_event_participants(NEW.event_id);
    END IF;
    IF NEW.user_id <> OLD.user_id THEN
        CALL sp_recalc_user_engagement(NEW.user_id);
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
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`civic_user`@`%`*/ /*!50003 TRIGGER trg_event_participant_ad
AFTER DELETE ON event_participant
FOR EACH ROW
BEGIN
    CALL sp_recalc_event_participants(OLD.event_id);
    CALL sp_recalc_user_engagement(OLD.user_id);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `event_citizen_invitations`
--

DROP TABLE IF EXISTS `event_citizen_invitations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_citizen_invitations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `composite_rate` double DEFAULT NULL,
  `feature_breakdown_json` text DEFAULT NULL,
  `invitation_tier` enum('PRIORITY_IMMEDIATE','STANDARD_INVITE','NURTURE_ALTERNATIVE') DEFAULT NULL,
  `invitation_token` varchar(255) NOT NULL,
  `invited_at` datetime(6) DEFAULT NULL,
  `match_score` double NOT NULL,
  `priority_followup` bit(1) NOT NULL,
  `responded_at` datetime(6) DEFAULT NULL,
  `status` varchar(32) NOT NULL,
  `citizen_id` bigint(20) NOT NULL,
  `event_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_eci_event_citizen` (`event_id`,`citizen_id`),
  UNIQUE KEY `uk_eci_token` (`invitation_token`),
  KEY `FKc14exoldpp1r78h6i5ny4bx2d` (`citizen_id`),
  CONSTRAINT `FK9hk50kc2cciv8v9wgoyig9c03` FOREIGN KEY (`event_id`) REFERENCES `event` (`id`),
  CONSTRAINT `FKc14exoldpp1r78h6i5ny4bx2d` FOREIGN KEY (`citizen_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_citizen_invitations`
--

LOCK TABLES `event_citizen_invitations` WRITE;
/*!40000 ALTER TABLE `event_citizen_invitations` DISABLE KEYS */;
INSERT INTO `event_citizen_invitations` VALUES
(1,1.9230769230769231,'{\"badgeEngagement\":0.0,\"pastEventParticipation\":0.0,\"communityFunding\":0.0,\"roleEngagement\":5.0,\"platformRecency\":0.0,\"donorCompatibility\":0.0,\"locationAlignment\":0.0,\"interestTopicAlignment\":0.0,\"eventInterestEngagement\":0.0,\"distributionParticipation\":0.0,\"foodSolidarityTopicFit\":0.0,\"ambassadorScope\":0.0,\"checkInReliability\":0.0,\"recipeCommentEngagement\":0.0,\"solidarityCampaignEngagement\":0.0,\"testimonialVoice\":0.0,\"weekendAvailabilityFit\":0.0,\"rawTotal\":5.0,\"compositeRate\":1.92}','NURTURE_ALTERNATIVE','82bbb7ed-e64d-49c1-9294-2b434cc77794','2026-04-22 10:24:38.637262',5,'\0',NULL,'INVITED',1,1),
(2,1.9230769230769231,'{\"badgeEngagement\":0.0,\"pastEventParticipation\":0.0,\"communityFunding\":0.0,\"roleEngagement\":5.0,\"platformRecency\":0.0,\"donorCompatibility\":0.0,\"locationAlignment\":0.0,\"interestTopicAlignment\":0.0,\"eventInterestEngagement\":0.0,\"distributionParticipation\":0.0,\"foodSolidarityTopicFit\":0.0,\"ambassadorScope\":0.0,\"checkInReliability\":0.0,\"recipeCommentEngagement\":0.0,\"solidarityCampaignEngagement\":0.0,\"testimonialVoice\":0.0,\"weekendAvailabilityFit\":0.0,\"rawTotal\":5.0,\"compositeRate\":1.92}','NURTURE_ALTERNATIVE','4d4ce25c-755d-435d-9910-70dd718bf291','2026-04-22 10:24:38.637262',5,'\0',NULL,'INVITED',2,1),
(3,1.9230769230769231,'{\"badgeEngagement\":0.0,\"pastEventParticipation\":0.0,\"communityFunding\":0.0,\"roleEngagement\":5.0,\"platformRecency\":0.0,\"donorCompatibility\":0.0,\"locationAlignment\":0.0,\"interestTopicAlignment\":0.0,\"eventInterestEngagement\":0.0,\"distributionParticipation\":0.0,\"foodSolidarityTopicFit\":0.0,\"ambassadorScope\":0.0,\"checkInReliability\":0.0,\"recipeCommentEngagement\":0.0,\"solidarityCampaignEngagement\":0.0,\"testimonialVoice\":0.0,\"weekendAvailabilityFit\":0.0,\"rawTotal\":5.0,\"compositeRate\":1.92}','NURTURE_ALTERNATIVE','788753ab-1db8-418f-8a5f-13d7e23a8203','2026-04-22 10:24:38.637262',5,'\0','2026-04-22 10:31:22.638971','DECLINED',5,1),
(7,7.6923076923076925,'{\"badgeEngagement\":0.0,\"pastEventParticipation\":0.0,\"communityFunding\":0.0,\"roleEngagement\":5.0,\"platformRecency\":0.0,\"donorCompatibility\":0.0,\"locationAlignment\":15.0,\"interestTopicAlignment\":0.0,\"eventInterestEngagement\":0.0,\"distributionParticipation\":0.0,\"foodSolidarityTopicFit\":0.0,\"ambassadorScope\":0.0,\"checkInReliability\":0.0,\"recipeCommentEngagement\":0.0,\"solidarityCampaignEngagement\":0.0,\"testimonialVoice\":0.0,\"weekendAvailabilityFit\":0.0,\"rawTotal\":20.0,\"compositeRate\":7.69}','NURTURE_ALTERNATIVE','8d42ac88-4ff8-4312-8ef6-3670e1537e2c','2026-04-22 10:35:14.365880',20,'\0','2026-04-22 10:46:41.337122','ACCEPTED',5,2),
(8,1.9230769230769231,'{\"badgeEngagement\":0.0,\"pastEventParticipation\":0.0,\"communityFunding\":0.0,\"roleEngagement\":5.0,\"platformRecency\":0.0,\"donorCompatibility\":0.0,\"locationAlignment\":0.0,\"interestTopicAlignment\":0.0,\"eventInterestEngagement\":0.0,\"distributionParticipation\":0.0,\"foodSolidarityTopicFit\":0.0,\"ambassadorScope\":0.0,\"checkInReliability\":0.0,\"recipeCommentEngagement\":0.0,\"solidarityCampaignEngagement\":0.0,\"testimonialVoice\":0.0,\"weekendAvailabilityFit\":0.0,\"rawTotal\":5.0,\"compositeRate\":1.92}','NURTURE_ALTERNATIVE','cae3b239-04ca-4d7a-b2a7-8eafc843ddbc','2026-04-22 10:35:14.365880',5,'\0',NULL,'INVITED',1,2),
(9,1.9230769230769231,'{\"badgeEngagement\":0.0,\"pastEventParticipation\":0.0,\"communityFunding\":0.0,\"roleEngagement\":5.0,\"platformRecency\":0.0,\"donorCompatibility\":0.0,\"locationAlignment\":0.0,\"interestTopicAlignment\":0.0,\"eventInterestEngagement\":0.0,\"distributionParticipation\":0.0,\"foodSolidarityTopicFit\":0.0,\"ambassadorScope\":0.0,\"checkInReliability\":0.0,\"recipeCommentEngagement\":0.0,\"solidarityCampaignEngagement\":0.0,\"testimonialVoice\":0.0,\"weekendAvailabilityFit\":0.0,\"rawTotal\":5.0,\"compositeRate\":1.92}','NURTURE_ALTERNATIVE','13b92ac6-6f9d-4560-bba7-c9a7ae6711ff','2026-04-22 10:35:14.365880',5,'\0',NULL,'INVITED',2,2);
/*!40000 ALTER TABLE `event_citizen_invitations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campaign`
--

DROP TABLE IF EXISTS `campaign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `campaign` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `current_kg` int(11) DEFAULT NULL,
  `current_meals` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `goal_amount` decimal(15,2) DEFAULT NULL,
  `goal_kg` int(11) DEFAULT NULL,
  `goal_meals` int(11) DEFAULT NULL,
  `hashtag` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `needed_amount` decimal(15,2) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `status` enum('DRAFT','ACTIVE','COMPLETED','CANCELLED') NOT NULL,
  `type` enum('FOOD_COLLECTION','FUNDRAISING','VOLUNTEER','AWARENESS') NOT NULL,
  `created_by_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKnqnqry7aj7bu3pvwvpgvpq7bk` (`created_by_id`),
  CONSTRAINT `FKnqnqry7aj7bu3pvwvpgvpq7bk` FOREIGN KEY (`created_by_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaign`
--

LOCK TABLES `campaign` WRITE;
/*!40000 ALTER TABLE `campaign` DISABLE KEYS */;
INSERT INTO `campaign` VALUES
(1,'2026-03-07 10:50:03.000000',2215,12039,'Kairouan Civic Network leads a Tunisia-focused campaign in Siliana to improve local food security and community resilience. This initiative addresses date palm irrigation renewal through volunteers, municipal partnerships, and neighborhood action.','2026-09-13',155364.00,2815,15300,'#Tunisia#Siliana#Date','[TN26B1-C001] Date Palm Irrigation Renewal - Siliana',33114.08,'2026-05-27','ACTIVE','FOOD_COLLECTION',117),
(2,'2026-02-19 10:50:03.000000',6201,7422,'Kairouan Civic Network leads a Tunisia-focused campaign in Bizerte to improve local food security and community resilience. This initiative addresses flood resilience kits through volunteers, municipal partnerships, and neighborhood action.','2026-07-13',289856.00,11416,13664,'#Tunisia#Bizerte#Flood','[TN26B1-C002] Flood Resilience Kits - Bizerte',132416.58,'2026-05-16','ACTIVE','FUNDRAISING',113),
(3,'2026-03-18 10:50:03.000000',3077,4736,'Croissant-Rouge Tunisien leads a Tunisia-focused campaign in Ariana to improve local food security and community resilience. This initiative addresses food waste reduction through volunteers, municipal partnerships, and neighborhood action.','2026-05-04',206326.00,3557,5474,'#Tunisia#Ariana#Food','[TN26B1-C003] Food Waste Reduction - Ariana',27824.11,'2026-02-19','ACTIVE','FOOD_COLLECTION',106),
(4,'2026-01-03 10:50:03.000000',1343,6467,'Gabes Future Makers leads a Tunisia-focused campaign in Beja to improve local food security and community resilience. This initiative addresses flood resilience kits through volunteers, municipal partnerships, and neighborhood action.','2026-10-28',280759.00,1900,9148,'#Tunisia#Beja#Flood','[TN26B1-C004] Flood Resilience Kits - Beja',82296.89,'2026-07-10','ACTIVE','FOOD_COLLECTION',117),
(5,'2026-01-27 10:50:03.000000',6621,3413,'Sfax Initiative Citoyenne leads a Tunisia-focused campaign in Mahdia to improve local food security and community resilience. This initiative addresses women artisan empowerment through volunteers, municipal partnerships, and neighborhood action.','2026-04-09',129233.00,6621,3413,'#Tunisia#Mahdia#Women','[TN26B1-C005] Women Artisan Empowerment - Mahdia',0.00,'2026-02-21','COMPLETED','FUNDRAISING',109),
(6,'2026-01-12 10:50:03.000000',2403,7794,'Kairouan Civic Network leads a Tunisia-focused campaign in Tataouine to improve local food security and community resilience. This initiative addresses women artisan empowerment through volunteers, municipal partnerships, and neighborhood action.','2026-06-20',51560.00,3838,12450,'#Tunisia#Tataouine#Women','[TN26B1-C006] Women Artisan Empowerment - Tataouine',19280.60,'2026-04-06','ACTIVE','VOLUNTEER',113),
(7,'2026-01-17 10:50:03.000000',4995,1338,'Croissant-Rouge Tunisien leads a Tunisia-focused campaign in Siliana to improve local food security and community resilience. This initiative addresses food waste reduction through volunteers, municipal partnerships, and neighborhood action.','2026-07-02',228626.00,10705,2867,'#Tunisia#Siliana#Food','[TN26B1-C007] Food Waste Reduction - Siliana',121949.07,'2026-04-18','ACTIVE','FUNDRAISING',106),
(8,'2026-03-21 10:50:03.000000',1206,6817,'Sousse Impact Hub leads a Tunisia-focused campaign in Medenine to improve local food security and community resilience. This initiative addresses flood resilience kits through volunteers, municipal partnerships, and neighborhood action.','2026-12-03',243536.00,3087,17443,'#Tunisia#Medenine#Flood','[TN26B1-C008] Flood Resilience Kits - Medenine',148363.91,'2026-08-05','ACTIVE','AWARENESS',117),
(9,'2026-02-11 10:50:03.000000',4323,6435,'Kairouan Civic Network leads a Tunisia-focused campaign in Zaghouan to improve local food security and community resilience. This initiative addresses school meal solidarity through volunteers, municipal partnerships, and neighborhood action.','2026-05-01',42758.00,6866,10221,'#Tunisia#Zaghouan#School','[TN26B1-C009] School Meal Solidarity - Zaghouan',15838.84,'2026-04-04','ACTIVE','FUNDRAISING',6),
(10,'2026-03-26 10:50:03.000000',1532,3820,'Croissant-Rouge Tunisien leads a Tunisia-focused campaign in Gafsa to improve local food security and community resilience. This initiative addresses community fridge restock through volunteers, municipal partnerships, and neighborhood action.','2026-07-19',179750.00,6795,16945,'#Tunisia#Gafsa#Community','[TN26B1-C010] Community Fridge Restock - Gafsa',139229.35,'2026-03-22','ACTIVE','FOOD_COLLECTION',109),
(11,'2026-02-09 10:50:03.000000',3482,15880,'Kairouan Civic Network leads a Tunisia-focused campaign in Jendouba to improve local food security and community resilience. This initiative addresses rural water access through volunteers, municipal partnerships, and neighborhood action.','2026-04-20',135235.00,3482,15880,'#Tunisia#Jendouba#Rural','[TN26B1-C011] Rural Water Access - Jendouba',0.00,'2026-02-27','COMPLETED','FUNDRAISING',109),
(12,'2026-02-11 10:50:03.000000',1236,7196,'Bizerte Blue Community leads a Tunisia-focused campaign in Jendouba to improve local food security and community resilience. This initiative addresses women artisan empowerment through volunteers, municipal partnerships, and neighborhood action.','2026-06-28',235381.00,2200,12811,'#Tunisia#Jendouba#Women','[TN26B1-C012] Women Artisan Empowerment - Jendouba',103158.90,'2026-06-02','ACTIVE','FUNDRAISING',117),
(13,'2026-04-08 10:50:03.000000',3424,17604,'Bizerte Blue Community leads a Tunisia-focused campaign in Sidi Bouzid to improve local food security and community resilience. This initiative addresses rural water access through volunteers, municipal partnerships, and neighborhood action.','2026-07-02',145206.00,3424,17604,'#Tunisia#SidiBouzid#Rural','[TN26B1-C013] Rural Water Access - Sidi Bouzid',0.00,'2026-05-05','COMPLETED','VOLUNTEER',109),
(14,'2026-04-14 10:50:03.000000',1195,7708,'Association Nesria leads a Tunisia-focused campaign in Gafsa to improve local food security and community resilience. This initiative addresses inclusive mobility access through volunteers, municipal partnerships, and neighborhood action.','2026-10-24',348451.00,1912,12336,'#Tunisia#Gafsa#Inclusive','[TN26B1-C014] Inclusive Mobility Access - Gafsa',130730.15,'2026-07-08','ACTIVE','FUNDRAISING',6),
(15,'2025-12-31 10:50:03.000000',7945,14600,'Association Amal leads a Tunisia-focused campaign in Tozeur to improve local food security and community resilience. This initiative addresses medical caravan logistics through volunteers, municipal partnerships, and neighborhood action.','2026-05-21',243764.00,9546,17542,'#Tunisia#Tozeur#Medical','[TN26B1-C015] Medical Caravan Logistics - Tozeur',40876.79,'2026-04-16','ACTIVE','VOLUNTEER',117),
(16,'2026-02-04 10:50:03.000000',5246,2186,'Association Amal leads a Tunisia-focused campaign in Sidi Bouzid to improve local food security and community resilience. This initiative addresses date palm irrigation renewal through volunteers, municipal partnerships, and neighborhood action.','2026-08-13',53387.00,5699,2375,'#Tunisia#SidiBouzid#Date','[TN26B1-C016] Date Palm Irrigation Renewal - Sidi Bouzid',4246.39,'2026-06-28','ACTIVE','FOOD_COLLECTION',6),
(17,'2025-12-28 10:50:03.000000',10217,10245,'Nabeul Green Steps leads a Tunisia-focused campaign in Gafsa to improve local food security and community resilience. This initiative addresses inclusive mobility access through volunteers, municipal partnerships, and neighborhood action.','2026-09-14',200505.00,10217,10245,'#Tunisia#Gafsa#Inclusive','[TN26B1-C017] Inclusive Mobility Access - Gafsa',0.00,'2026-06-21','COMPLETED','VOLUNTEER',107),
(18,'2025-12-29 10:50:03.000000',3297,13691,'Nabeul Green Steps leads a Tunisia-focused campaign in Tataouine to improve local food security and community resilience. This initiative addresses community fridge restock through volunteers, municipal partnerships, and neighborhood action.','2026-05-18',260762.00,3297,13691,'#Tunisia#Tataouine#Community','[TN26B1-C018] Community Fridge Restock - Tataouine',0.00,'2026-02-13','COMPLETED','AWARENESS',106),
(19,'2026-03-31 10:50:03.000000',3624,4941,'Association Nesria leads a Tunisia-focused campaign in Nabeul to improve local food security and community resilience. This initiative addresses school meal solidarity through volunteers, municipal partnerships, and neighborhood action.','2026-02-25',67608.00,6027,8217,'#Tunisia#Nabeul#School','[TN26B1-C019] School Meal Solidarity - Nabeul',26950.61,'2026-02-02','CANCELLED','VOLUNTEER',106),
(20,'2026-01-20 10:50:03.000000',3236,4037,'Association Amal leads a Tunisia-focused campaign in Kairouan to improve local food security and community resilience. This initiative addresses medical caravan logistics through volunteers, municipal partnerships, and neighborhood action.','2026-05-01',300437.00,8310,10367,'#Tunisia#Kairouan#Medical','[TN26B1-C020] Medical Caravan Logistics - Kairouan',183452.90,'2026-02-15','ACTIVE','VOLUNTEER',117),
(21,'2026-02-11 10:50:03.000000',4927,6277,'Nabeul Green Steps leads a Tunisia-focused campaign in Kebili to improve local food security and community resilience. This initiative addresses women artisan empowerment through volunteers, municipal partnerships, and neighborhood action.','2026-05-27',337848.00,5573,7100,'#Tunisia#Kebili#Women','[TN26B1-C021] Women Artisan Empowerment - Kebili',39138.73,'2026-03-18','ACTIVE','FUNDRAISING',113),
(22,'2026-01-24 10:50:03.000000',740,4490,'Association Nesria leads a Tunisia-focused campaign in Sfax to improve local food security and community resilience. This initiative addresses food waste reduction through volunteers, municipal partnerships, and neighborhood action.','2026-04-16',165369.00,2674,16221,'#Tunisia#Sfax#Food','[TN26B1-C022] Food Waste Reduction - Sfax',119594.70,'2026-01-12','CANCELLED','VOLUNTEER',107),
(23,'2026-03-01 10:50:03.000000',4016,3301,'Sfax Initiative Citoyenne leads a Tunisia-focused campaign in Le Kef to improve local food security and community resilience. This initiative addresses community fridge restock through volunteers, municipal partnerships, and neighborhood action.','2026-08-16',205866.00,4016,3301,'#Tunisia#LeKef#Community','[TN26B1-C023] Community Fridge Restock - Le Kef',0.00,'2026-07-16','COMPLETED','AWARENESS',106),
(24,'2026-02-16 10:50:03.000000',3115,6715,'Association Amal leads a Tunisia-focused campaign in Siliana to improve local food security and community resilience. This initiative addresses flood resilience kits through volunteers, municipal partnerships, and neighborhood action.','2026-02-19',94566.00,4065,8761,'#Tunisia#Siliana#Flood','[TN26B1-C024] Flood Resilience Kits - Siliana',22089.36,'2026-01-15','CANCELLED','VOLUNTEER',107),
(25,'2026-03-27 10:50:03.000000',10969,7196,'Gabes Future Makers leads a Tunisia-focused campaign in Tozeur to improve local food security and community resilience. This initiative addresses digital skills for youth through volunteers, municipal partnerships, and neighborhood action.','2026-07-13',157696.00,10969,7196,'#Tunisia#Tozeur#Digital','[TN26B1-C025] Digital Skills for Youth - Tozeur',0.00,'2026-05-27','COMPLETED','VOLUNTEER',117),
(26,'2026-01-30 10:50:03.000000',5805,7030,'Kairouan Civic Network leads a Tunisia-focused campaign in Kairouan to improve local food security and community resilience. This initiative addresses food waste reduction through volunteers, municipal partnerships, and neighborhood action.','2026-09-15',298283.00,9315,11280,'#Tunisia#Kairouan#Food','[TN26B1-C026] Food Waste Reduction - Kairouan',112380.91,'2026-07-18','ACTIVE','VOLUNTEER',106),
(27,'2026-02-06 10:50:03.000000',1190,7693,'Sousse Impact Hub leads a Tunisia-focused campaign in Sidi Bouzid to improve local food security and community resilience. This initiative addresses community fridge restock through volunteers, municipal partnerships, and neighborhood action.','2026-07-13',264066.00,2071,13382,'#Tunisia#SidiBouzid#Community','[TN26B1-C027] Community Fridge Restock - Sidi Bouzid',112270.18,'2026-04-22','ACTIVE','VOLUNTEER',113),
(28,'2026-04-04 10:50:03.000000',8730,16413,'Bizerte Blue Community leads a Tunisia-focused campaign in Monastir to improve local food security and community resilience. This initiative addresses inclusive mobility access through volunteers, municipal partnerships, and neighborhood action.','2026-05-27',116115.00,8730,16413,'#Tunisia#Monastir#Inclusive','[TN26B1-C028] Inclusive Mobility Access - Monastir',0.00,'2026-02-08','COMPLETED','VOLUNTEER',109),
(29,'2026-04-09 10:50:03.000000',1330,7279,'Association Nesria leads a Tunisia-focused campaign in Sidi Bouzid to improve local food security and community resilience. This initiative addresses date palm irrigation renewal through volunteers, municipal partnerships, and neighborhood action.','2026-10-06',275738.00,1903,10418,'#Tunisia#SidiBouzid#Date','[TN26B1-C029] Date Palm Irrigation Renewal - Sidi Bouzid',83072.44,'2026-07-20','ACTIVE','FOOD_COLLECTION',109),
(30,'2026-02-16 10:50:03.000000',1543,1340,'Sousse Impact Hub leads a Tunisia-focused campaign in Medenine to improve local food security and community resilience. This initiative addresses date palm irrigation renewal through volunteers, municipal partnerships, and neighborhood action.','2026-10-05',78487.00,2761,2397,'#Tunisia#Medenine#Date','[TN26B1-C030] Date Palm Irrigation Renewal - Medenine',34623.69,'2026-07-13','ACTIVE','AWARENESS',109),
(31,'2026-03-09 10:50:03.000000',3694,9235,'Kairouan Civic Network leads a Tunisia-focused campaign in Zaghouan to improve local food security and community resilience. This initiative addresses women artisan empowerment through volunteers, municipal partnerships, and neighborhood action.','2026-08-05',90587.00,4808,12020,'#Tunisia#Zaghouan#Women','[TN26B1-C031] Women Artisan Empowerment - Zaghouan',20992.38,'2026-05-19','ACTIVE','AWARENESS',113),
(32,'2026-02-21 10:50:03.000000',5461,7501,'Sfax Initiative Citoyenne leads a Tunisia-focused campaign in Gafsa to improve local food security and community resilience. This initiative addresses local market recovery through volunteers, municipal partnerships, and neighborhood action.','2026-05-10',83141.00,5461,7501,'#Tunisia#Gafsa#Local','[TN26B1-C032] Local Market Recovery - Gafsa',0.00,'2026-02-13','COMPLETED','FUNDRAISING',6),
(33,'2025-12-25 10:50:03.000000',3561,5927,'Sfax Initiative Citoyenne leads a Tunisia-focused campaign in Kairouan to improve local food security and community resilience. This initiative addresses fishermen safety training through volunteers, municipal partnerships, and neighborhood action.','2026-10-03',339984.00,9942,16548,'#Tunisia#Kairouan#Fishermen','[TN26B1-C033] Fishermen Safety Training - Kairouan',218210.67,'2026-06-22','ACTIVE','FOOD_COLLECTION',109),
(34,'2026-01-28 10:50:03.000000',1319,3261,'Kairouan Civic Network leads a Tunisia-focused campaign in Ben Arous to improve local food security and community resilience. This initiative addresses digital skills for youth through volunteers, municipal partnerships, and neighborhood action.','2026-04-01',202858.00,4451,11004,'#Tunisia#BenArous#Digital','[TN26B1-C034] Digital Skills for Youth - Ben Arous',142750.38,'2026-01-29','CANCELLED','FOOD_COLLECTION',107),
(35,'2026-04-12 10:50:03.000000',8217,13205,'Bizerte Blue Community leads a Tunisia-focused campaign in Bizerte to improve local food security and community resilience. This initiative addresses fishermen safety training through volunteers, municipal partnerships, and neighborhood action.','2026-06-13',80302.00,8217,13205,'#Tunisia#Bizerte#Fishermen','[TN26B1-C035] Fishermen Safety Training - Bizerte',0.00,'2026-03-04','COMPLETED','FOOD_COLLECTION',106),
(36,'2026-03-12 10:50:03.000000',3521,11637,'Sfax Initiative Citoyenne leads a Tunisia-focused campaign in Ben Arous to improve local food security and community resilience. This initiative addresses food waste reduction through volunteers, municipal partnerships, and neighborhood action.','2026-04-23',86192.00,3521,11637,'#Tunisia#BenArous#Food','[TN26B1-C036] Food Waste Reduction - Ben Arous',0.00,'2026-03-12','COMPLETED','FUNDRAISING',6),
(37,'2026-02-25 10:50:03.000000',3152,4067,'Association Nesria leads a Tunisia-focused campaign in Manouba to improve local food security and community resilience. This initiative addresses school meal solidarity through volunteers, municipal partnerships, and neighborhood action.','2026-05-22',214221.00,6209,8012,'#Tunisia#Manouba#School','[TN26B1-C037] School Meal Solidarity - Manouba',105487.60,'2026-03-03','ACTIVE','AWARENESS',113),
(38,'2026-03-19 10:50:03.000000',6696,9909,'Gabes Future Makers leads a Tunisia-focused campaign in Ben Arous to improve local food security and community resilience. This initiative addresses digital skills for youth through volunteers, municipal partnerships, and neighborhood action.','2026-11-18',231792.00,9998,14795,'#Tunisia#BenArous#Digital','[TN26B1-C038] Digital Skills for Youth - Ben Arous',76545.07,'2026-07-24','ACTIVE','VOLUNTEER',113),
(39,'2026-02-02 10:50:03.000000',3027,6357,'Nabeul Green Steps leads a Tunisia-focused campaign in Sfax to improve local food security and community resilience. This initiative addresses medical caravan logistics through volunteers, municipal partnerships, and neighborhood action.','2026-07-17',124505.00,8341,17519,'#Tunisia#Sfax#Medical','[TN26B1-C039] Medical Caravan Logistics - Sfax',79326.59,'2026-05-24','ACTIVE','FUNDRAISING',106),
(40,'2026-02-20 10:50:03.000000',7237,13977,'Gabes Future Makers leads a Tunisia-focused campaign in Medenine to improve local food security and community resilience. This initiative addresses school meal solidarity through volunteers, municipal partnerships, and neighborhood action.','2026-09-27',267004.00,8220,15875,'#Tunisia#Medenine#School','[TN26B1-C040] School Meal Solidarity - Medenine',31914.82,'2026-07-06','ACTIVE','FUNDRAISING',109),
(41,'2026-03-22 10:50:03.000000',2055,9851,'Croissant-Rouge Tunisien leads a Tunisia-focused campaign in Ben Arous to improve local food security and community resilience. This initiative addresses flood resilience kits through volunteers, municipal partnerships, and neighborhood action.','2026-09-26',49906.00,2055,9851,'#Tunisia#BenArous#Flood','[TN26B1-C041] Flood Resilience Kits - Ben Arous',0.00,'2026-08-07','COMPLETED','VOLUNTEER',6),
(42,'2026-01-09 10:50:03.000000',8756,7110,'Sousse Impact Hub leads a Tunisia-focused campaign in Siliana to improve local food security and community resilience. This initiative addresses digital skills for youth through volunteers, municipal partnerships, and neighborhood action.','2026-10-02',81994.00,11856,9627,'#Tunisia#Siliana#Digital','[TN26B1-C042] Digital Skills for Youth - Siliana',21437.90,'2026-06-13','ACTIVE','FOOD_COLLECTION',117),
(43,'2026-01-27 10:50:03.000000',4733,5752,'Sousse Impact Hub leads a Tunisia-focused campaign in Le Kef to improve local food security and community resilience. This initiative addresses coastal cleanup through volunteers, municipal partnerships, and neighborhood action.','2026-09-21',346071.00,6937,8431,'#Tunisia#LeKef#Coastal','[TN26B1-C043] Coastal Cleanup - Le Kef',109960.48,'2026-07-09','ACTIVE','VOLUNTEER',109),
(44,'2026-02-12 10:50:03.000000',1092,2662,'Carthage Solidaire leads a Tunisia-focused campaign in Siliana to improve local food security and community resilience. This initiative addresses inclusive mobility access through volunteers, municipal partnerships, and neighborhood action.','2026-08-11',171395.00,2354,5739,'#Tunisia#Siliana#Inclusive','[TN26B1-C044] Inclusive Mobility Access - Siliana',91890.18,'2026-07-21','ACTIVE','FUNDRAISING',117),
(45,'2026-04-11 10:50:03.000000',4038,10898,'Sfax Initiative Citoyenne leads a Tunisia-focused campaign in Gabes to improve local food security and community resilience. This initiative addresses inclusive mobility access through volunteers, municipal partnerships, and neighborhood action.','2026-04-30',130255.00,5016,13536,'#Tunisia#Gabes#Inclusive','[TN26B1-C045] Inclusive Mobility Access - Gabes',25387.85,'2026-01-02','ACTIVE','VOLUNTEER',113),
(46,'2026-01-06 10:50:03.000000',1622,6604,'Gabes Future Makers leads a Tunisia-focused campaign in Mahdia to improve local food security and community resilience. This initiative addresses inclusive mobility access through volunteers, municipal partnerships, and neighborhood action.','2026-03-06',259370.00,4240,17266,'#Tunisia#Mahdia#Inclusive','[TN26B1-C046] Inclusive Mobility Access - Mahdia',160163.43,'2026-01-15','CANCELLED','FUNDRAISING',113),
(47,'2026-01-25 10:50:03.000000',11565,4716,'Kairouan Civic Network leads a Tunisia-focused campaign in Ben Arous to improve local food security and community resilience. This initiative addresses digital skills for youth through volunteers, municipal partnerships, and neighborhood action.','2026-06-06',295908.00,11565,4716,'#Tunisia#BenArous#Digital','[TN26B1-C047] Digital Skills for Youth - Ben Arous',0.00,'2026-05-05','COMPLETED','AWARENESS',113),
(48,'2026-04-03 10:50:03.000000',3459,6164,'Association Nesria leads a Tunisia-focused campaign in Manouba to improve local food security and community resilience. This initiative addresses inclusive mobility access through volunteers, municipal partnerships, and neighborhood action.','2026-07-19',73147.00,5226,9314,'#Tunisia#Manouba#Inclusive','[TN26B1-C048] Inclusive Mobility Access - Manouba',24734.52,'2026-03-21','ACTIVE','FUNDRAISING',113),
(49,'2026-03-13 10:50:03.000000',1921,3493,'Bizerte Blue Community leads a Tunisia-focused campaign in Tozeur to improve local food security and community resilience. This initiative addresses digital skills for youth through volunteers, municipal partnerships, and neighborhood action.','2026-10-01',194710.00,7489,13619,'#Tunisia#Tozeur#Digital','[TN26B1-C049] Digital Skills for Youth - Tozeur',144767.50,'2026-08-04','ACTIVE','FOOD_COLLECTION',106),
(50,'2026-01-18 10:50:03.000000',3583,5418,'Croissant-Rouge Tunisien leads a Tunisia-focused campaign in Ariana to improve local food security and community resilience. This initiative addresses digital skills for youth through volunteers, municipal partnerships, and neighborhood action.','2026-06-13',230807.00,10732,16227,'#Tunisia#Ariana#Digital','[TN26B1-C050] Digital Skills for Youth - Ariana',153740.32,'2026-03-31','ACTIVE','VOLUNTEER',117),
(51,'2026-03-14 10:50:03.000000',2411,6711,'Association Amal leads a Tunisia-focused campaign in Sousse to improve local food security and community resilience. This initiative addresses local market recovery through volunteers, municipal partnerships, and neighborhood action.','2026-11-20',79115.00,5512,15342,'#Tunisia#Sousse#Local','[TN26B1-C051] Local Market Recovery - Sousse',44507.63,'2026-08-09','ACTIVE','AWARENESS',107),
(52,'2026-03-25 10:50:03.000000',2711,2668,'Association Nesria leads a Tunisia-focused campaign in Kebili to improve local food security and community resilience. This initiative addresses women artisan empowerment through volunteers, municipal partnerships, and neighborhood action.','2026-07-06',222784.00,6932,6822,'#Tunisia#Kebili#Women','[TN26B1-C052] Women Artisan Empowerment - Kebili',135667.69,'2026-03-27','ACTIVE','FUNDRAISING',109),
(53,'2026-01-15 10:50:03.000000',4709,5731,'Bizerte Blue Community leads a Tunisia-focused campaign in Tunis to improve local food security and community resilience. This initiative addresses women artisan empowerment through volunteers, municipal partnerships, and neighborhood action.','2026-07-05',265970.00,6754,8220,'#Tunisia#Tunis#Women','[TN26B1-C053] Women Artisan Empowerment - Tunis',80533.27,'2026-05-14','ACTIVE','VOLUNTEER',113),
(54,'2026-02-07 10:50:03.000000',2505,7093,'Association Nesria leads a Tunisia-focused campaign in Manouba to improve local food security and community resilience. This initiative addresses olive grove regeneration through volunteers, municipal partnerships, and neighborhood action.','2026-03-08',288011.00,4481,12689,'#Tunisia#Manouba#Olive','[TN26B1-C054] Olive Grove Regeneration - Manouba',127015.55,'2026-01-17','CANCELLED','AWARENESS',117),
(55,'2025-12-30 10:50:03.000000',3065,7940,'Sousse Impact Hub leads a Tunisia-focused campaign in Zaghouan to improve local food security and community resilience. This initiative addresses school meal solidarity through volunteers, municipal partnerships, and neighborhood action.','2026-05-03',268735.00,6503,16847,'#Tunisia#Zaghouan#School','[TN26B1-C055] School Meal Solidarity - Zaghouan',142086.43,'2026-03-12','ACTIVE','AWARENESS',109),
(56,'2026-02-08 10:50:03.000000',1406,3173,'Sousse Impact Hub leads a Tunisia-focused campaign in Tozeur to improve local food security and community resilience. This initiative addresses medical caravan logistics through volunteers, municipal partnerships, and neighborhood action.','2026-09-17',295656.00,6059,13669,'#Tunisia#Tozeur#Medical','[TN26B1-C056] Medical Caravan Logistics - Tozeur',227024.45,'2026-06-09','ACTIVE','VOLUNTEER',109),
(57,'2026-03-15 10:50:03.000000',3152,2997,'Sousse Impact Hub leads a Tunisia-focused campaign in Kebili to improve local food security and community resilience. This initiative addresses inclusive mobility access through volunteers, municipal partnerships, and neighborhood action.','2026-08-15',176023.00,8136,7735,'#Tunisia#Kebili#Inclusive','[TN26B1-C057] Inclusive Mobility Access - Kebili',107823.50,'2026-05-18','ACTIVE','VOLUNTEER',109),
(58,'2026-04-15 10:50:03.000000',7991,17131,'Gabes Future Makers leads a Tunisia-focused campaign in Sidi Bouzid to improve local food security and community resilience. This initiative addresses community fridge restock through volunteers, municipal partnerships, and neighborhood action.','2026-10-18',185014.00,7991,17131,'#Tunisia#SidiBouzid#Community','[TN26B1-C058] Community Fridge Restock - Sidi Bouzid',0.00,'2026-07-26','COMPLETED','FUNDRAISING',113),
(59,'2026-03-19 10:50:03.000000',4686,10960,'Association Amal leads a Tunisia-focused campaign in Gabes to improve local food security and community resilience. This initiative addresses date palm irrigation renewal through volunteers, municipal partnerships, and neighborhood action.','2026-03-14',82704.00,4686,10960,'#Tunisia#Gabes#Date','[TN26B1-C059] Date Palm Irrigation Renewal - Gabes',0.00,'2026-02-22','COMPLETED','AWARENESS',107),
(60,'2026-01-31 10:50:03.000000',577,5675,'Croissant-Rouge Tunisien leads a Tunisia-focused campaign in Gabes to improve local food security and community resilience. This initiative addresses flood resilience kits through volunteers, municipal partnerships, and neighborhood action.','2026-04-03',346520.00,1670,16436,'#Tunisia#Gabes#Flood','[TN26B1-C060] Flood Resilience Kits - Gabes',226866.73,'2026-01-18','CANCELLED','FOOD_COLLECTION',117),
(61,'2026-03-05 10:50:03.000000',2046,3252,'Association Nesria leads a Tunisia-focused campaign in Kasserine to improve local food security and community resilience. This initiative addresses digital skills for youth through volunteers, municipal partnerships, and neighborhood action.','2026-05-14',143251.00,6920,11002,'#Tunisia#Kasserine#Digital','[TN26B1-C061] Digital Skills for Youth - Kasserine',100906.07,'2026-02-22','ACTIVE','FOOD_COLLECTION',109),
(62,'2026-02-01 10:50:03.000000',2655,2655,'Association Nesria leads a Tunisia-focused campaign in Nabeul to improve local food security and community resilience. This initiative addresses date palm irrigation renewal through volunteers, municipal partnerships, and neighborhood action.','2026-08-13',148673.00,3956,3956,'#Tunisia#Nabeul#Date','[TN26B1-C062] Date Palm Irrigation Renewal - Nabeul',48882.69,'2026-06-13','ACTIVE','FUNDRAISING',6),
(63,'2026-01-12 10:50:03.000000',6927,5805,'Croissant-Rouge Tunisien leads a Tunisia-focused campaign in Siliana to improve local food security and community resilience. This initiative addresses olive grove regeneration through volunteers, municipal partnerships, and neighborhood action.','2026-09-02',284014.00,10519,8816,'#Tunisia#Siliana#Olive','[TN26B1-C063] Olive Grove Regeneration - Siliana',96990.50,'2026-08-03','ACTIVE','VOLUNTEER',109),
(64,'2026-03-03 10:50:03.000000',5911,4660,'Kairouan Civic Network leads a Tunisia-focused campaign in Nabeul to improve local food security and community resilience. This initiative addresses olive grove regeneration through volunteers, municipal partnerships, and neighborhood action.','2026-06-07',324736.00,5911,4660,'#Tunisia#Nabeul#Olive','[TN26B1-C064] Olive Grove Regeneration - Nabeul',0.00,'2026-02-27','COMPLETED','FUNDRAISING',6),
(65,'2026-04-06 10:50:03.000000',1052,1855,'Association Amal leads a Tunisia-focused campaign in Zaghouan to improve local food security and community resilience. This initiative addresses date palm irrigation renewal through volunteers, municipal partnerships, and neighborhood action.','2026-05-07',261807.00,3659,6448,'#Tunisia#Zaghouan#Date','[TN26B1-C065] Date Palm Irrigation Renewal - Zaghouan',186508.76,'2026-03-19','ACTIVE','AWARENESS',113),
(66,'2026-02-25 10:50:03.000000',529,1609,'Association Nesria leads a Tunisia-focused campaign in Gafsa to improve local food security and community resilience. This initiative addresses community fridge restock through volunteers, municipal partnerships, and neighborhood action.','2026-09-22',67053.00,2376,7226,'#Tunisia#Gafsa#Community','[TN26B1-C066] Community Fridge Restock - Gafsa',52123.61,'2026-07-30','ACTIVE','FUNDRAISING',107),
(67,'2026-02-18 10:50:03.000000',3172,5427,'Sousse Impact Hub leads a Tunisia-focused campaign in Tozeur to improve local food security and community resilience. This initiative addresses women artisan empowerment through volunteers, municipal partnerships, and neighborhood action.','2026-08-17',272978.00,3724,6372,'#Tunisia#Tozeur#Women','[TN26B1-C067] Women Artisan Empowerment - Tozeur',40497.62,'2026-04-27','ACTIVE','AWARENESS',106),
(68,'2026-02-27 10:50:03.000000',1240,3608,'Association Amal leads a Tunisia-focused campaign in Kasserine to improve local food security and community resilience. This initiative addresses olive grove regeneration through volunteers, municipal partnerships, and neighborhood action.','2026-06-01',346102.00,3556,10346,'#Tunisia#Kasserine#Olive','[TN26B1-C068] Olive Grove Regeneration - Kasserine',225411.19,'2026-05-12','ACTIVE','FUNDRAISING',106),
(69,'2026-01-16 10:50:03.000000',1178,6705,'Association Amal leads a Tunisia-focused campaign in Sousse to improve local food security and community resilience. This initiative addresses ramadan iftar support through volunteers, municipal partnerships, and neighborhood action.','2026-02-14',289621.00,2413,13734,'#Tunisia#Sousse#Ramadan','[TN26B1-C069] Ramadan Iftar Support - Sousse',148230.82,'2026-01-18','CANCELLED','VOLUNTEER',107),
(70,'2026-03-24 10:50:03.000000',10721,8846,'Croissant-Rouge Tunisien leads a Tunisia-focused campaign in Gafsa to improve local food security and community resilience. This initiative addresses date palm irrigation renewal through volunteers, municipal partnerships, and neighborhood action.','2026-10-21',182452.00,10721,8846,'#Tunisia#Gafsa#Date','[TN26B1-C070] Date Palm Irrigation Renewal - Gafsa',0.00,'2026-06-25','COMPLETED','FUNDRAISING',6),
(71,'2026-01-06 10:50:03.000000',2655,11568,'Nabeul Green Steps leads a Tunisia-focused campaign in Nabeul to improve local food security and community resilience. This initiative addresses ramadan iftar support through volunteers, municipal partnerships, and neighborhood action.','2026-09-02',316969.00,3292,14343,'#Tunisia#Nabeul#Ramadan','[TN26B1-C071] Ramadan Iftar Support - Nabeul',61335.71,'2026-06-24','ACTIVE','AWARENESS',106),
(72,'2026-04-16 10:50:03.000000',2199,2292,'Nabeul Green Steps leads a Tunisia-focused campaign in Kairouan to improve local food security and community resilience. This initiative addresses coastal cleanup through volunteers, municipal partnerships, and neighborhood action.','2026-07-14',79406.00,9622,10029,'#Tunisia#Kairouan#Coastal','[TN26B1-C072] Coastal Cleanup - Kairouan',61262.18,'2026-04-29','ACTIVE','VOLUNTEER',6),
(73,'2026-04-04 10:50:03.000000',3200,5551,'Association Nesria leads a Tunisia-focused campaign in Kebili to improve local food security and community resilience. This initiative addresses digital skills for youth through volunteers, municipal partnerships, and neighborhood action.','2026-07-23',63313.00,9486,16458,'#Tunisia#Kebili#Digital','[TN26B1-C073] Digital Skills for Youth - Kebili',41956.85,'2026-05-05','ACTIVE','VOLUNTEER',107),
(74,'2025-12-23 10:50:03.000000',1199,4089,'Sousse Impact Hub leads a Tunisia-focused campaign in Kebili to improve local food security and community resilience. This initiative addresses school meal solidarity through volunteers, municipal partnerships, and neighborhood action.','2026-04-28',40056.00,4520,15412,'#Tunisia#Kebili#School','[TN26B1-C074] School Meal Solidarity - Kebili',29428.63,'2026-04-06','ACTIVE','FUNDRAISING',117),
(75,'2026-02-12 10:50:03.000000',2819,5051,'Nabeul Green Steps leads a Tunisia-focused campaign in Sidi Bouzid to improve local food security and community resilience. This initiative addresses flood resilience kits through volunteers, municipal partnerships, and neighborhood action.','2026-05-30',334999.00,8809,15786,'#Tunisia#SidiBouzid#Flood','[TN26B1-C075] Flood Resilience Kits - Sidi Bouzid',227808.52,'2026-02-27','ACTIVE','VOLUNTEER',6),
(76,'2026-03-03 10:50:03.000000',3170,7906,'Kairouan Civic Network leads a Tunisia-focused campaign in Le Kef to improve local food security and community resilience. This initiative addresses flood resilience kits through volunteers, municipal partnerships, and neighborhood action.','2026-07-25',289127.00,5226,13032,'#Tunisia#LeKef#Flood','[TN26B1-C076] Flood Resilience Kits - Le Kef',113724.74,'2026-04-30','ACTIVE','AWARENESS',6),
(77,'2026-01-24 10:50:03.000000',4499,6878,'Gabes Future Makers leads a Tunisia-focused campaign in Mahdia to improve local food security and community resilience. This initiative addresses rural water access through volunteers, municipal partnerships, and neighborhood action.','2026-07-30',32818.00,5817,8894,'#Tunisia#Mahdia#Rural','[TN26B1-C077] Rural Water Access - Mahdia',7437.37,'2026-05-12','ACTIVE','FUNDRAISING',109),
(78,'2025-12-26 10:50:03.000000',4235,6749,'Kairouan Civic Network leads a Tunisia-focused campaign in Bizerte to improve local food security and community resilience. This initiative addresses date palm irrigation renewal through volunteers, municipal partnerships, and neighborhood action.','2026-03-18',25144.00,6125,9760,'#Tunisia#Bizerte#Date','[TN26B1-C078] Date Palm Irrigation Renewal - Bizerte',7757.37,'2026-02-26','CANCELLED','AWARENESS',117),
(79,'2026-03-04 10:50:03.000000',5455,6804,'Kairouan Civic Network leads a Tunisia-focused campaign in Ariana to improve local food security and community resilience. This initiative addresses rural water access through volunteers, municipal partnerships, and neighborhood action.','2026-09-16',48621.00,10389,12957,'#Tunisia#Ariana#Rural','[TN26B1-C079] Rural Water Access - Ariana',23090.25,'2026-07-09','ACTIVE','FUNDRAISING',117),
(80,'2026-02-17 10:50:03.000000',2128,1834,'Gabes Future Makers leads a Tunisia-focused campaign in Kebili to improve local food security and community resilience. This initiative addresses coastal cleanup through volunteers, municipal partnerships, and neighborhood action.','2026-06-08',128828.00,6218,5360,'#Tunisia#Kebili#Coastal','[TN26B1-C080] Coastal Cleanup - Kebili',84744.03,'2026-05-16','ACTIVE','AWARENESS',113),
(81,'2026-04-11 10:50:03.000000',8836,12897,'Nabeul Green Steps leads a Tunisia-focused campaign in Sidi Bouzid to improve local food security and community resilience. This initiative addresses ramadan iftar support through volunteers, municipal partnerships, and neighborhood action.','2026-09-05',127821.00,8836,12897,'#Tunisia#SidiBouzid#Ramadan','[TN26B1-C081] Ramadan Iftar Support - Sidi Bouzid',0.00,'2026-06-02','COMPLETED','FOOD_COLLECTION',6),
(82,'2026-04-16 10:50:03.000000',4107,3251,'Association Nesria leads a Tunisia-focused campaign in Gafsa to improve local food security and community resilience. This initiative addresses inclusive mobility access through volunteers, municipal partnerships, and neighborhood action.','2026-07-28',274674.00,11452,9064,'#Tunisia#Gafsa#Inclusive','[TN26B1-C082] Inclusive Mobility Access - Gafsa',176160.79,'2026-06-24','ACTIVE','FUNDRAISING',106),
(83,'2025-12-31 10:50:03.000000',7198,9531,'Croissant-Rouge Tunisien leads a Tunisia-focused campaign in Tataouine to improve local food security and community resilience. This initiative addresses fishermen safety training through volunteers, municipal partnerships, and neighborhood action.','2026-04-22',106316.00,7198,9531,'#Tunisia#Tataouine#Fishermen','[TN26B1-C083] Fishermen Safety Training - Tataouine',0.00,'2026-01-01','COMPLETED','FOOD_COLLECTION',113),
(84,'2025-12-28 10:50:03.000000',5061,11357,'Gabes Future Makers leads a Tunisia-focused campaign in Kebili to improve local food security and community resilience. This initiative addresses community fridge restock through volunteers, municipal partnerships, and neighborhood action.','2026-09-21',70464.00,5061,11357,'#Tunisia#Kebili#Community','[TN26B1-C084] Community Fridge Restock - Kebili',0.00,'2026-06-06','COMPLETED','VOLUNTEER',106),
(85,'2026-01-22 10:50:03.000000',3148,4038,'Association Nesria leads a Tunisia-focused campaign in Sfax to improve local food security and community resilience. This initiative addresses ramadan iftar support through volunteers, municipal partnerships, and neighborhood action.','2026-03-03',255963.00,6427,8243,'#Tunisia#Sfax#Ramadan','[TN26B1-C085] Ramadan Iftar Support - Sfax',130578.52,'2026-01-26','CANCELLED','VOLUNTEER',106),
(86,'2025-12-27 10:50:03.000000',6890,9400,'Association Nesria leads a Tunisia-focused campaign in Beja to improve local food security and community resilience. This initiative addresses fishermen safety training through volunteers, municipal partnerships, and neighborhood action.','2026-09-17',184532.00,11174,15246,'#Tunisia#Beja#Fishermen','[TN26B1-C086] Fishermen Safety Training - Beja',70752.60,'2026-07-10','ACTIVE','FUNDRAISING',107),
(87,'2026-01-29 10:50:03.000000',2327,2152,'Kairouan Civic Network leads a Tunisia-focused campaign in Nabeul to improve local food security and community resilience. This initiative addresses coastal cleanup through volunteers, municipal partnerships, and neighborhood action.','2026-10-02',256862.00,3834,3545,'#Tunisia#Nabeul#Coastal','[TN26B1-C087] Coastal Cleanup - Nabeul',100966.26,'2026-06-11','ACTIVE','FOOD_COLLECTION',107),
(88,'2026-01-24 10:50:03.000000',3183,3506,'Association Amal leads a Tunisia-focused campaign in Ariana to improve local food security and community resilience. This initiative addresses flood resilience kits through volunteers, municipal partnerships, and neighborhood action.','2026-08-14',243916.00,9403,10359,'#Tunisia#Ariana#Flood','[TN26B1-C088] Flood Resilience Kits - Ariana',161353.61,'2026-05-29','ACTIVE','FOOD_COLLECTION',107),
(89,'2026-01-17 10:50:03.000000',4996,6192,'Bizerte Blue Community leads a Tunisia-focused campaign in Tunis to improve local food security and community resilience. This initiative addresses women artisan empowerment through volunteers, municipal partnerships, and neighborhood action.','2026-02-26',240065.00,9461,11726,'#Tunisia#Tunis#Women','[TN26B1-C089] Women Artisan Empowerment - Tunis',113304.66,'2026-01-08','CANCELLED','FOOD_COLLECTION',117),
(90,'2026-03-12 10:50:03.000000',6382,8367,'Nabeul Green Steps leads a Tunisia-focused campaign in Le Kef to improve local food security and community resilience. This initiative addresses date palm irrigation renewal through volunteers, municipal partnerships, and neighborhood action.','2026-05-06',187708.00,11731,15380,'#Tunisia#LeKef#Date','[TN26B1-C090] Date Palm Irrigation Renewal - Le Kef',85589.00,'2026-04-14','ACTIVE','FOOD_COLLECTION',6),
(91,'2026-02-02 10:50:03.000000',2276,6334,'Sfax Initiative Citoyenne leads a Tunisia-focused campaign in Tunis to improve local food security and community resilience. This initiative addresses fishermen safety training through volunteers, municipal partnerships, and neighborhood action.','2026-08-17',191195.00,3322,9245,'#Tunisia#Tunis#Fishermen','[TN26B1-C091] Fishermen Safety Training - Tunis',60197.48,'2026-05-24','ACTIVE','AWARENESS',109),
(92,'2026-03-18 10:50:03.000000',8451,7291,'Croissant-Rouge Tunisien leads a Tunisia-focused campaign in Tunis to improve local food security and community resilience. This initiative addresses inclusive mobility access through volunteers, municipal partnerships, and neighborhood action.','2026-07-27',311146.00,8451,7291,'#Tunisia#Tunis#Inclusive','[TN26B1-C092] Inclusive Mobility Access - Tunis',0.00,'2026-05-16','COMPLETED','FOOD_COLLECTION',107),
(93,'2026-03-07 10:50:03.000000',1261,2911,'Croissant-Rouge Tunisien leads a Tunisia-focused campaign in Nabeul to improve local food security and community resilience. This initiative addresses rural water access through volunteers, municipal partnerships, and neighborhood action.','2026-07-05',323408.00,4861,11226,'#Tunisia#Nabeul#Rural','[TN26B1-C093] Rural Water Access - Nabeul',239545.00,'2026-05-30','ACTIVE','FOOD_COLLECTION',117),
(94,'2026-03-16 10:50:03.000000',6089,2187,'Sfax Initiative Citoyenne leads a Tunisia-focused campaign in Ariana to improve local food security and community resilience. This initiative addresses digital skills for youth through volunteers, municipal partnerships, and neighborhood action.','2026-04-04',114498.00,6089,2187,'#Tunisia#Ariana#Digital','[TN26B1-C094] Digital Skills for Youth - Ariana',0.00,'2026-03-03','COMPLETED','FOOD_COLLECTION',109),
(95,'2026-03-12 10:50:03.000000',2179,2672,'Kairouan Civic Network leads a Tunisia-focused campaign in Ben Arous to improve local food security and community resilience. This initiative addresses school meal solidarity through volunteers, municipal partnerships, and neighborhood action.','2026-11-29',311699.00,5103,6257,'#Tunisia#BenArous#School','[TN26B1-C095] School Meal Solidarity - Ben Arous',178586.63,'2026-08-05','ACTIVE','FUNDRAISING',106),
(96,'2026-02-28 10:50:03.000000',1036,3269,'Gabes Future Makers leads a Tunisia-focused campaign in Jendouba to improve local food security and community resilience. This initiative addresses olive grove regeneration through volunteers, municipal partnerships, and neighborhood action.','2026-03-13',326420.00,4535,14307,'#Tunisia#Jendouba#Olive','[TN26B1-C096] Olive Grove Regeneration - Jendouba',251843.47,'2026-01-12','CANCELLED','VOLUNTEER',109),
(97,'2026-03-26 10:50:03.000000',11562,17537,'Association Nesria leads a Tunisia-focused campaign in Le Kef to improve local food security and community resilience. This initiative addresses women artisan empowerment through volunteers, municipal partnerships, and neighborhood action.','2026-06-14',332577.00,11562,17537,'#Tunisia#LeKef#Women','[TN26B1-C097] Women Artisan Empowerment - Le Kef',0.00,'2026-03-11','COMPLETED','AWARENESS',117),
(98,'2026-03-26 10:50:03.000000',3477,4769,'Sfax Initiative Citoyenne leads a Tunisia-focused campaign in Siliana to improve local food security and community resilience. This initiative addresses coastal cleanup through volunteers, municipal partnerships, and neighborhood action.','2026-10-27',159989.00,10944,15009,'#Tunisia#Siliana#Coastal','[TN26B1-C098] Coastal Cleanup - Siliana',109153.18,'2026-07-14','ACTIVE','VOLUNTEER',106),
(99,'2026-03-02 10:50:03.000000',4394,4442,'Carthage Solidaire leads a Tunisia-focused campaign in Jendouba to improve local food security and community resilience. This initiative addresses school meal solidarity through volunteers, municipal partnerships, and neighborhood action.','2026-04-09',285182.00,8727,8821,'#Tunisia#Jendouba#School','[TN26B1-C099] School Meal Solidarity - Jendouba',141584.95,'2026-02-04','CANCELLED','FOOD_COLLECTION',117),
(100,'2026-04-16 10:50:03.000000',1372,6758,'Carthage Solidaire leads a Tunisia-focused campaign in Gafsa to improve local food security and community resilience. This initiative addresses digital skills for youth through volunteers, municipal partnerships, and neighborhood action.','2026-07-29',113038.00,2346,11557,'#Tunisia#Gafsa#Digital','[TN26B1-C100] Digital Skills for Youth - Gafsa',46940.98,'2026-07-03','ACTIVE','VOLUNTEER',113);
/*!40000 ALTER TABLE `campaign` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campaign_vote`
--

DROP TABLE IF EXISTS `campaign_vote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `campaign_vote` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `voted_at` datetime(6) NOT NULL,
  `campaign_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK28sdf3pko76ih8w7ni3dkvb9x` (`user_id`,`campaign_id`),
  KEY `FKcd2l9wml9k9s3tu78wcvg01ay` (`campaign_id`),
  CONSTRAINT `FK7uhx2sj9872utecimrho7cxk0` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FKcd2l9wml9k9s3tu78wcvg01ay` FOREIGN KEY (`campaign_id`) REFERENCES `campaign` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaign_vote`
--

LOCK TABLES `campaign_vote` WRITE;
/*!40000 ALTER TABLE `campaign_vote` DISABLE KEYS */;
/*!40000 ALTER TABLE `campaign_vote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `project` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `completion_date` date DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `current_amount` decimal(15,2) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `final_report` text DEFAULT NULL,
  `goal_amount` decimal(15,2) NOT NULL,
  `organizer_type` varchar(255) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `status` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `vote_count` int(11) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK8cadixeaqdma8nqr7sao1qy9a` (`created_by_id`),
  CONSTRAINT `FK8cadixeaqdma8nqr7sao1qy9a` FOREIGN KEY (`created_by_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project`
--

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` VALUES
(1,NULL,'2026-03-04 10:50:03.000000',0.00,'Carthage Solidaire proposes a high-impact project in Monastir centered on community fridge restock. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,116402.00,'AMBASSADOR_NETWORK','2026-04-26','SUBMITTED','[TN26B1-P001] Community Fridge Restock Infrastructure - Monastir',0,113),
(2,NULL,'2025-12-27 10:50:03.000000',0.00,'Gabes Future Makers proposes a high-impact project in Beja centered on medical caravan logistics. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,132824.00,'AMBASSADOR_NETWORK','2026-05-11','SUBMITTED','[TN26B1-P002] Medical Caravan Logistics Infrastructure - Beja',0,107),
(3,'2026-07-15','2026-03-22 10:50:03.000000',0.00,'Association Nesria proposes a high-impact project in Tataouine centered on coastal cleanup. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.','Milestones reached in Tataouine: procurement, beneficiary mapping, and impact verification completed.',160236.00,'AMBASSADOR_NETWORK','2026-01-23','COMPLETED','[TN26B1-P003] Coastal Cleanup Infrastructure - Tataouine',0,109),
(4,NULL,'2026-03-25 10:50:03.000000',0.00,'Kairouan Civic Network proposes a high-impact project in Bizerte centered on school meal solidarity. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,147939.00,'AMBASSADOR_NETWORK','2026-04-23','SUBMITTED','[TN26B1-P004] School Meal Solidarity Infrastructure - Bizerte',0,109),
(5,'2026-10-31','2026-04-04 10:50:03.000000',0.00,'Sfax Initiative Citoyenne proposes a high-impact project in Tozeur centered on date palm irrigation renewal. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.','Milestones reached in Tozeur: procurement, beneficiary mapping, and impact verification completed.',370884.00,'ASSOCIATION','2026-05-11','COMPLETED','[TN26B1-P005] Date Palm Irrigation Renewal Infrastructure - Tozeur',0,106),
(6,NULL,'2026-01-27 10:50:03.000000',0.00,'Carthage Solidaire proposes a high-impact project in Siliana centered on digital skills for youth. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,419773.00,'AMBASSADOR_NETWORK','2026-01-07','SUBMITTED','[TN26B1-P006] Digital Skills for Youth Infrastructure - Siliana',0,113),
(7,NULL,'2026-04-17 10:50:03.000000',0.00,'Nabeul Green Steps proposes a high-impact project in Bizerte centered on school meal solidarity. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,125569.00,'ASSOCIATION','2026-04-02','SUBMITTED','[TN26B1-P007] School Meal Solidarity Infrastructure - Bizerte',0,6),
(8,'2026-03-29','2026-04-18 10:50:03.000000',0.00,'Gabes Future Makers proposes a high-impact project in Zaghouan centered on fishermen safety training. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.','Milestones reached in Zaghouan: procurement, beneficiary mapping, and impact verification completed.',364283.00,'AMBASSADOR_NETWORK','2026-01-21','COMPLETED','[TN26B1-P008] Fishermen Safety Training Infrastructure - Zaghouan',0,109),
(9,NULL,'2026-01-16 10:50:03.000000',0.00,'Bizerte Blue Community proposes a high-impact project in Kebili centered on community fridge restock. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,324655.00,'AMBASSADOR_NETWORK','2026-07-07','SUBMITTED','[TN26B1-P009] Community Fridge Restock Infrastructure - Kebili',0,117),
(10,NULL,'2026-02-17 10:50:03.000000',0.00,'Gabes Future Makers proposes a high-impact project in Le Kef centered on community fridge restock. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,242435.00,'AMBASSADOR_NETWORK','2026-04-11','SUBMITTED','[TN26B1-P010] Community Fridge Restock Infrastructure - Le Kef',0,117),
(11,'2026-08-25','2026-03-09 10:50:03.000000',0.00,'Sfax Initiative Citoyenne proposes a high-impact project in Gafsa centered on ramadan iftar support. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.','Milestones reached in Gafsa: procurement, beneficiary mapping, and impact verification completed.',33784.00,'AMBASSADOR_NETWORK','2026-04-29','COMPLETED','[TN26B1-P011] Ramadan Iftar Support Infrastructure - Gafsa',0,113),
(12,'2026-06-30','2026-02-01 10:50:03.000000',0.00,'Nabeul Green Steps proposes a high-impact project in Nabeul centered on date palm irrigation renewal. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.','Milestones reached in Nabeul: procurement, beneficiary mapping, and impact verification completed.',253108.00,'ASSOCIATION','2026-03-03','COMPLETED','[TN26B1-P012] Date Palm Irrigation Renewal Infrastructure - Nabeul',0,106),
(13,NULL,'2026-02-22 10:50:03.000000',0.00,'Gabes Future Makers proposes a high-impact project in Ben Arous centered on fishermen safety training. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,61053.00,'AMBASSADOR_NETWORK','2026-05-02','SUBMITTED','[TN26B1-P013] Fishermen Safety Training Infrastructure - Ben Arous',0,109),
(14,NULL,'2025-12-28 10:50:03.000000',0.00,'Sousse Impact Hub proposes a high-impact project in Jendouba centered on women artisan empowerment. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,355929.00,'ASSOCIATION','2026-04-14','SUBMITTED','[TN26B1-P014] Women Artisan Empowerment Infrastructure - Jendouba',0,6),
(15,'2026-06-29','2026-01-14 10:50:03.000000',0.00,'Gabes Future Makers proposes a high-impact project in Sousse centered on digital skills for youth. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.','Milestones reached in Sousse: procurement, beneficiary mapping, and impact verification completed.',201211.00,'AMBASSADOR_NETWORK','2026-01-10','COMPLETED','[TN26B1-P015] Digital Skills for Youth Infrastructure - Sousse',0,107),
(16,NULL,'2025-12-25 10:50:03.000000',0.00,'Kairouan Civic Network proposes a high-impact project in Sidi Bouzid centered on women artisan empowerment. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,364764.00,'AMBASSADOR_NETWORK','2026-02-08','SUBMITTED','[TN26B1-P016] Women Artisan Empowerment Infrastructure - Sidi Bouzid',0,107),
(17,NULL,'2026-04-10 10:50:03.000000',0.00,'Carthage Solidaire proposes a high-impact project in Gafsa centered on fishermen safety training. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,289978.00,'AMBASSADOR_NETWORK','2026-06-03','SUBMITTED','[TN26B1-P017] Fishermen Safety Training Infrastructure - Gafsa',0,107),
(18,NULL,'2026-04-11 10:50:03.000000',0.00,'Sousse Impact Hub proposes a high-impact project in Manouba centered on ramadan iftar support. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,359805.00,'AMBASSADOR_NETWORK','2026-03-30','SUBMITTED','[TN26B1-P018] Ramadan Iftar Support Infrastructure - Manouba',1,107),
(19,NULL,'2026-01-29 10:50:03.000000',0.00,'Gabes Future Makers proposes a high-impact project in Le Kef centered on flood resilience kits. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,60282.00,'ASSOCIATION','2026-07-15','SUBMITTED','[TN26B1-P019] Flood Resilience Kits Infrastructure - Le Kef',0,106),
(20,NULL,'2026-03-20 10:50:03.000000',0.00,'Association Amal proposes a high-impact project in Sfax centered on flood resilience kits. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,86372.00,'ASSOCIATION','2026-06-07','SUBMITTED','[TN26B1-P020] Flood Resilience Kits Infrastructure - Sfax',0,6),
(21,NULL,'2026-03-17 10:50:03.000000',0.00,'Bizerte Blue Community proposes a high-impact project in Bizerte centered on date palm irrigation renewal. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,142516.00,'AMBASSADOR_NETWORK','2026-06-12','SUBMITTED','[TN26B1-P021] Date Palm Irrigation Renewal Infrastructure - Bizerte',0,117),
(22,NULL,'2026-04-02 10:50:03.000000',0.00,'Sousse Impact Hub proposes a high-impact project in Zaghouan centered on rural water access. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,73578.00,'AMBASSADOR_NETWORK','2026-07-06','SUBMITTED','[TN26B1-P022] Rural Water Access Infrastructure - Zaghouan',0,113),
(23,NULL,'2026-01-08 10:50:03.000000',0.00,'Sousse Impact Hub proposes a high-impact project in Kairouan centered on fishermen safety training. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,118205.00,'ASSOCIATION','2026-07-27','SUBMITTED','[TN26B1-P023] Fishermen Safety Training Infrastructure - Kairouan',0,6),
(24,NULL,'2026-04-19 10:50:03.000000',0.00,'Bizerte Blue Community proposes a high-impact project in Tunis centered on school meal solidarity. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,306092.00,'ASSOCIATION','2026-03-27','SUBMITTED','[TN26B1-P024] School Meal Solidarity Infrastructure - Tunis',0,106),
(25,NULL,'2026-01-29 10:50:03.000000',0.00,'Sfax Initiative Citoyenne proposes a high-impact project in Manouba centered on local market recovery. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,185438.00,'AMBASSADOR_NETWORK','2026-01-13','SUBMITTED','[TN26B1-P025] Local Market Recovery Infrastructure - Manouba',0,107),
(26,NULL,'2026-01-21 10:50:03.000000',0.00,'Croissant-Rouge Tunisien proposes a high-impact project in Gabes centered on school meal solidarity. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,358565.00,'AMBASSADOR_NETWORK','2026-08-02','SUBMITTED','[TN26B1-P026] School Meal Solidarity Infrastructure - Gabes',0,109),
(27,NULL,'2026-02-18 10:50:03.000000',0.00,'Association Nesria proposes a high-impact project in Kebili centered on school meal solidarity. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,287380.00,'AMBASSADOR_NETWORK','2026-05-19','SUBMITTED','[TN26B1-P027] School Meal Solidarity Infrastructure - Kebili',0,109),
(28,NULL,'2026-01-06 10:50:03.000000',0.00,'Kairouan Civic Network proposes a high-impact project in Ariana centered on food waste reduction. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,119834.00,'AMBASSADOR_NETWORK','2026-01-09','SUBMITTED','[TN26B1-P028] Food Waste Reduction Infrastructure - Ariana',0,109),
(29,'2027-01-05','2026-02-10 10:50:03.000000',0.00,'Association Nesria proposes a high-impact project in Tunis centered on medical caravan logistics. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.','Milestones reached in Tunis: procurement, beneficiary mapping, and impact verification completed.',205702.00,'AMBASSADOR_NETWORK','2026-08-06','COMPLETED','[TN26B1-P029] Medical Caravan Logistics Infrastructure - Tunis',0,109),
(30,NULL,'2026-01-17 10:50:03.000000',0.00,'Bizerte Blue Community proposes a high-impact project in Gafsa centered on rural water access. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,368563.00,'AMBASSADOR_NETWORK','2026-06-09','SUBMITTED','[TN26B1-P030] Rural Water Access Infrastructure - Gafsa',0,107),
(31,NULL,'2026-01-12 10:50:03.000000',0.00,'Carthage Solidaire proposes a high-impact project in Beja centered on olive grove regeneration. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,237295.00,'AMBASSADOR_NETWORK','2026-03-10','SUBMITTED','[TN26B1-P031] Olive Grove Regeneration Infrastructure - Beja',0,107),
(32,NULL,'2026-03-23 10:50:03.000000',0.00,'Croissant-Rouge Tunisien proposes a high-impact project in Beja centered on olive grove regeneration. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,398413.00,'AMBASSADOR_NETWORK','2026-06-25','SUBMITTED','[TN26B1-P032] Olive Grove Regeneration Infrastructure - Beja',0,107),
(33,NULL,'2026-01-07 10:50:03.000000',0.00,'Gabes Future Makers proposes a high-impact project in Sousse centered on school meal solidarity. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,235835.00,'ASSOCIATION','2026-06-13','SUBMITTED','[TN26B1-P033] School Meal Solidarity Infrastructure - Sousse',0,6),
(34,NULL,'2026-02-27 10:50:03.000000',0.00,'Bizerte Blue Community proposes a high-impact project in Kairouan centered on inclusive mobility access. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,140056.00,'AMBASSADOR_NETWORK','2026-06-17','SUBMITTED','[TN26B1-P034] Inclusive Mobility Access Infrastructure - Kairouan',0,113),
(35,'2026-07-09','2026-01-16 10:50:03.000000',0.00,'Association Amal proposes a high-impact project in Zaghouan centered on local market recovery. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.','Milestones reached in Zaghouan: procurement, beneficiary mapping, and impact verification completed.',177083.00,'AMBASSADOR_NETWORK','2026-04-24','COMPLETED','[TN26B1-P035] Local Market Recovery Infrastructure - Zaghouan',0,113),
(36,'2026-07-01','2026-01-21 10:50:03.000000',0.00,'Carthage Solidaire proposes a high-impact project in Sousse centered on fishermen safety training. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.','Milestones reached in Sousse: procurement, beneficiary mapping, and impact verification completed.',125316.00,'AMBASSADOR_NETWORK','2026-04-10','COMPLETED','[TN26B1-P036] Fishermen Safety Training Infrastructure - Sousse',0,109),
(37,NULL,'2026-02-12 10:50:03.000000',0.00,'Sousse Impact Hub proposes a high-impact project in Le Kef centered on school meal solidarity. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,414772.00,'ASSOCIATION','2026-04-30','SUBMITTED','[TN26B1-P037] School Meal Solidarity Infrastructure - Le Kef',0,6),
(38,NULL,'2026-03-14 10:50:03.000000',0.00,'Gabes Future Makers proposes a high-impact project in Ariana centered on food waste reduction. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,240698.00,'AMBASSADOR_NETWORK','2026-03-05','SUBMITTED','[TN26B1-P038] Food Waste Reduction Infrastructure - Ariana',0,117),
(39,NULL,'2026-02-17 10:50:03.000000',0.00,'Association Amal proposes a high-impact project in Sidi Bouzid centered on digital skills for youth. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,292700.00,'AMBASSADOR_NETWORK','2026-06-23','SUBMITTED','[TN26B1-P039] Digital Skills for Youth Infrastructure - Sidi Bouzid',0,107),
(40,'2027-01-25','2026-04-08 10:50:03.000000',0.00,'Sousse Impact Hub proposes a high-impact project in Monastir centered on ramadan iftar support. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.','Milestones reached in Monastir: procurement, beneficiary mapping, and impact verification completed.',387744.00,'AMBASSADOR_NETWORK','2026-07-15','COMPLETED','[TN26B1-P040] Ramadan Iftar Support Infrastructure - Monastir',0,107),
(41,NULL,'2025-12-30 10:50:03.000000',0.00,'Nabeul Green Steps proposes a high-impact project in Gafsa centered on coastal cleanup. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,296898.00,'ASSOCIATION','2026-05-05','SUBMITTED','[TN26B1-P041] Coastal Cleanup Infrastructure - Gafsa',0,106),
(42,NULL,'2026-04-10 10:50:03.000000',0.00,'Association Nesria proposes a high-impact project in Tozeur centered on fishermen safety training. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,250782.00,'ASSOCIATION','2026-03-14','SUBMITTED','[TN26B1-P042] Fishermen Safety Training Infrastructure - Tozeur',0,106),
(43,NULL,'2026-01-23 10:50:03.000000',0.00,'Bizerte Blue Community proposes a high-impact project in Le Kef centered on rural water access. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,121557.00,'AMBASSADOR_NETWORK','2026-05-22','SUBMITTED','[TN26B1-P043] Rural Water Access Infrastructure - Le Kef',0,109),
(44,NULL,'2026-01-21 10:50:03.000000',0.00,'Croissant-Rouge Tunisien proposes a high-impact project in Siliana centered on women artisan empowerment. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,129342.00,'AMBASSADOR_NETWORK','2026-03-29','SUBMITTED','[TN26B1-P044] Women Artisan Empowerment Infrastructure - Siliana',0,107),
(45,'2026-06-18','2026-01-27 10:50:03.000000',0.00,'Association Amal proposes a high-impact project in Manouba centered on coastal cleanup. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.','Milestones reached in Manouba: procurement, beneficiary mapping, and impact verification completed.',197970.00,'AMBASSADOR_NETWORK','2026-01-10','COMPLETED','[TN26B1-P045] Coastal Cleanup Infrastructure - Manouba',0,109),
(46,'2026-11-15','2026-02-20 10:50:03.000000',0.00,'Gabes Future Makers proposes a high-impact project in Siliana centered on fishermen safety training. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.','Milestones reached in Siliana: procurement, beneficiary mapping, and impact verification completed.',44980.00,'AMBASSADOR_NETWORK','2026-06-13','COMPLETED','[TN26B1-P046] Fishermen Safety Training Infrastructure - Siliana',0,109),
(47,NULL,'2026-01-01 10:50:03.000000',0.00,'Bizerte Blue Community proposes a high-impact project in Zaghouan centered on olive grove regeneration. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,234031.00,'AMBASSADOR_NETWORK','2026-07-21','SUBMITTED','[TN26B1-P047] Olive Grove Regeneration Infrastructure - Zaghouan',0,117),
(48,NULL,'2026-03-02 10:50:03.000000',0.00,'Kairouan Civic Network proposes a high-impact project in Mahdia centered on inclusive mobility access. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,263726.00,'ASSOCIATION','2026-02-03','SUBMITTED','[TN26B1-P048] Inclusive Mobility Access Infrastructure - Mahdia',0,106),
(49,NULL,'2026-03-07 10:50:03.000000',0.00,'Bizerte Blue Community proposes a high-impact project in Bizerte centered on coastal cleanup. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,222599.00,'AMBASSADOR_NETWORK','2026-05-31','SUBMITTED','[TN26B1-P049] Coastal Cleanup Infrastructure - Bizerte',0,107),
(50,'2026-12-16','2026-02-16 10:50:03.000000',0.00,'Sousse Impact Hub proposes a high-impact project in Ariana centered on community fridge restock. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.','Milestones reached in Ariana: procurement, beneficiary mapping, and impact verification completed.',71612.00,'AMBASSADOR_NETWORK','2026-06-23','COMPLETED','[TN26B1-P050] Community Fridge Restock Infrastructure - Ariana',0,113),
(51,NULL,'2026-03-19 10:50:03.000000',0.00,'Gabes Future Makers proposes a high-impact project in Kasserine centered on rural water access. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,323725.00,'AMBASSADOR_NETWORK','2026-07-01','SUBMITTED','[TN26B1-P051] Rural Water Access Infrastructure - Kasserine',0,109),
(52,NULL,'2026-03-09 10:50:03.000000',0.00,'Gabes Future Makers proposes a high-impact project in Beja centered on inclusive mobility access. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,65469.00,'AMBASSADOR_NETWORK','2026-01-09','SUBMITTED','[TN26B1-P052] Inclusive Mobility Access Infrastructure - Beja',0,107),
(53,NULL,'2025-12-28 10:50:03.000000',0.00,'Association Amal proposes a high-impact project in Ben Arous centered on digital skills for youth. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,325018.00,'AMBASSADOR_NETWORK','2026-01-13','SUBMITTED','[TN26B1-P053] Digital Skills for Youth Infrastructure - Ben Arous',0,109),
(54,NULL,'2026-01-18 10:50:03.000000',0.00,'Nabeul Green Steps proposes a high-impact project in Tozeur centered on flood resilience kits. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,200408.00,'AMBASSADOR_NETWORK','2026-02-09','SUBMITTED','[TN26B1-P054] Flood Resilience Kits Infrastructure - Tozeur',0,109),
(55,NULL,'2026-02-04 10:50:03.000000',0.00,'Gabes Future Makers proposes a high-impact project in Kasserine centered on community fridge restock. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,317823.00,'AMBASSADOR_NETWORK','2026-08-02','SUBMITTED','[TN26B1-P055] Community Fridge Restock Infrastructure - Kasserine',0,107),
(56,NULL,'2026-04-02 10:50:03.000000',0.00,'Croissant-Rouge Tunisien proposes a high-impact project in Siliana centered on local market recovery. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,366629.00,'AMBASSADOR_NETWORK','2026-08-08','SUBMITTED','[TN26B1-P056] Local Market Recovery Infrastructure - Siliana',0,107),
(57,NULL,'2026-01-17 10:50:03.000000',0.00,'Sfax Initiative Citoyenne proposes a high-impact project in Kebili centered on olive grove regeneration. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,151864.00,'ASSOCIATION','2026-02-06','SUBMITTED','[TN26B1-P057] Olive Grove Regeneration Infrastructure - Kebili',0,106),
(58,'2026-09-18','2026-01-07 10:50:03.000000',0.00,'Bizerte Blue Community proposes a high-impact project in Kebili centered on digital skills for youth. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.','Milestones reached in Kebili: procurement, beneficiary mapping, and impact verification completed.',168957.00,'AMBASSADOR_NETWORK','2026-06-28','COMPLETED','[TN26B1-P058] Digital Skills for Youth Infrastructure - Kebili',0,113),
(59,'2026-09-12','2026-01-31 10:50:03.000000',0.00,'Bizerte Blue Community proposes a high-impact project in Le Kef centered on fishermen safety training. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.','Milestones reached in Le Kef: procurement, beneficiary mapping, and impact verification completed.',293327.00,'AMBASSADOR_NETWORK','2026-03-09','COMPLETED','[TN26B1-P059] Fishermen Safety Training Infrastructure - Le Kef',0,117),
(60,NULL,'2026-03-17 10:50:03.000000',0.00,'Sfax Initiative Citoyenne proposes a high-impact project in Monastir centered on local market recovery. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,393044.00,'AMBASSADOR_NETWORK','2026-03-25','SUBMITTED','[TN26B1-P060] Local Market Recovery Infrastructure - Monastir',0,109),
(61,'2026-12-27','2026-03-28 10:50:03.000000',0.00,'Croissant-Rouge Tunisien proposes a high-impact project in Tozeur centered on inclusive mobility access. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.','Milestones reached in Tozeur: procurement, beneficiary mapping, and impact verification completed.',406311.00,'AMBASSADOR_NETWORK','2026-06-12','COMPLETED','[TN26B1-P061] Inclusive Mobility Access Infrastructure - Tozeur',0,117),
(62,NULL,'2025-12-29 10:50:03.000000',0.00,'Sfax Initiative Citoyenne proposes a high-impact project in Nabeul centered on local market recovery. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,80290.00,'AMBASSADOR_NETWORK','2026-05-18','SUBMITTED','[TN26B1-P062] Local Market Recovery Infrastructure - Nabeul',0,109),
(63,NULL,'2026-01-16 10:50:03.000000',0.00,'Association Nesria proposes a high-impact project in Gabes centered on ramadan iftar support. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,76948.00,'AMBASSADOR_NETWORK','2026-05-11','SUBMITTED','[TN26B1-P063] Ramadan Iftar Support Infrastructure - Gabes',0,113),
(64,NULL,'2025-12-29 10:50:03.000000',0.00,'Association Amal proposes a high-impact project in Tozeur centered on inclusive mobility access. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,225382.00,'AMBASSADOR_NETWORK','2026-04-07','SUBMITTED','[TN26B1-P064] Inclusive Mobility Access Infrastructure - Tozeur',0,117),
(65,'2026-05-26','2026-01-26 10:50:03.000000',0.00,'Sfax Initiative Citoyenne proposes a high-impact project in Ben Arous centered on medical caravan logistics. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.','Milestones reached in Ben Arous: procurement, beneficiary mapping, and impact verification completed.',369438.00,'AMBASSADOR_NETWORK','2026-02-27','COMPLETED','[TN26B1-P065] Medical Caravan Logistics Infrastructure - Ben Arous',0,109),
(66,NULL,'2026-02-02 10:50:03.000000',0.00,'Bizerte Blue Community proposes a high-impact project in Manouba centered on flood resilience kits. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,345454.00,'ASSOCIATION','2026-07-07','SUBMITTED','[TN26B1-P066] Flood Resilience Kits Infrastructure - Manouba',0,6),
(67,'2026-04-24','2025-12-23 10:50:03.000000',0.00,'Sfax Initiative Citoyenne proposes a high-impact project in Ben Arous centered on rural water access. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.','Milestones reached in Ben Arous: procurement, beneficiary mapping, and impact verification completed.',332374.00,'AMBASSADOR_NETWORK','2026-02-15','COMPLETED','[TN26B1-P067] Rural Water Access Infrastructure - Ben Arous',0,113),
(68,NULL,'2026-02-04 10:50:03.000000',0.00,'Sfax Initiative Citoyenne proposes a high-impact project in Sfax centered on date palm irrigation renewal. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,395079.00,'ASSOCIATION','2026-05-10','SUBMITTED','[TN26B1-P068] Date Palm Irrigation Renewal Infrastructure - Sfax',0,6),
(69,NULL,'2026-03-07 10:50:03.000000',0.00,'Bizerte Blue Community proposes a high-impact project in Gabes centered on coastal cleanup. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,66421.00,'AMBASSADOR_NETWORK','2026-04-13','SUBMITTED','[TN26B1-P069] Coastal Cleanup Infrastructure - Gabes',0,107),
(70,NULL,'2026-03-12 10:50:03.000000',0.00,'Association Amal proposes a high-impact project in Gabes centered on date palm irrigation renewal. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,297708.00,'AMBASSADOR_NETWORK','2026-04-03','SUBMITTED','[TN26B1-P070] Date Palm Irrigation Renewal Infrastructure - Gabes',0,109),
(71,NULL,'2026-01-19 10:50:03.000000',0.00,'Sousse Impact Hub proposes a high-impact project in Le Kef centered on community fridge restock. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,177571.00,'AMBASSADOR_NETWORK','2026-02-17','SUBMITTED','[TN26B1-P071] Community Fridge Restock Infrastructure - Le Kef',0,117),
(72,NULL,'2026-04-13 10:50:03.000000',0.00,'Kairouan Civic Network proposes a high-impact project in Mahdia centered on rural water access. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,334202.00,'ASSOCIATION','2026-01-13','SUBMITTED','[TN26B1-P072] Rural Water Access Infrastructure - Mahdia',0,106),
(73,NULL,'2026-02-12 10:50:03.000000',0.00,'Bizerte Blue Community proposes a high-impact project in Tozeur centered on date palm irrigation renewal. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,43109.00,'AMBASSADOR_NETWORK','2026-05-13','SUBMITTED','[TN26B1-P073] Date Palm Irrigation Renewal Infrastructure - Tozeur',0,113),
(74,NULL,'2026-02-04 10:50:03.000000',0.00,'Sousse Impact Hub proposes a high-impact project in Kairouan centered on medical caravan logistics. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,242222.00,'AMBASSADOR_NETWORK','2026-03-05','SUBMITTED','[TN26B1-P074] Medical Caravan Logistics Infrastructure - Kairouan',0,107),
(75,'2026-12-11','2026-01-24 10:50:03.000000',0.00,'Nabeul Green Steps proposes a high-impact project in Tunis centered on local market recovery. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.','Milestones reached in Tunis: procurement, beneficiary mapping, and impact verification completed.',62784.00,'AMBASSADOR_NETWORK','2026-06-25','COMPLETED','[TN26B1-P075] Local Market Recovery Infrastructure - Tunis',0,113),
(76,NULL,'2026-03-11 10:50:03.000000',0.00,'Kairouan Civic Network proposes a high-impact project in Manouba centered on inclusive mobility access. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,368388.00,'AMBASSADOR_NETWORK','2026-05-02','SUBMITTED','[TN26B1-P076] Inclusive Mobility Access Infrastructure - Manouba',0,107),
(77,NULL,'2026-01-16 10:50:03.000000',0.00,'Nabeul Green Steps proposes a high-impact project in Monastir centered on rural water access. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,293091.00,'AMBASSADOR_NETWORK','2026-03-15','SUBMITTED','[TN26B1-P077] Rural Water Access Infrastructure - Monastir',0,117),
(78,NULL,'2026-02-07 10:50:03.000000',0.00,'Association Nesria proposes a high-impact project in Le Kef centered on ramadan iftar support. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,51327.00,'AMBASSADOR_NETWORK','2026-03-03','SUBMITTED','[TN26B1-P078] Ramadan Iftar Support Infrastructure - Le Kef',0,107),
(79,NULL,'2026-01-16 10:50:03.000000',0.00,'Sfax Initiative Citoyenne proposes a high-impact project in Kebili centered on rural water access. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,338800.00,'ASSOCIATION','2026-03-27','SUBMITTED','[TN26B1-P079] Rural Water Access Infrastructure - Kebili',0,106),
(80,NULL,'2026-02-26 10:50:03.000000',0.00,'Sfax Initiative Citoyenne proposes a high-impact project in Beja centered on olive grove regeneration. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,369855.00,'AMBASSADOR_NETWORK','2026-06-02','SUBMITTED','[TN26B1-P080] Olive Grove Regeneration Infrastructure - Beja',0,107),
(81,NULL,'2025-12-30 10:50:03.000000',0.00,'Croissant-Rouge Tunisien proposes a high-impact project in Kebili centered on medical caravan logistics. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,204495.00,'AMBASSADOR_NETWORK','2026-04-22','SUBMITTED','[TN26B1-P081] Medical Caravan Logistics Infrastructure - Kebili',0,113),
(82,NULL,'2026-04-08 10:50:03.000000',0.00,'Association Nesria proposes a high-impact project in Monastir centered on flood resilience kits. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,246794.00,'AMBASSADOR_NETWORK','2026-07-20','SUBMITTED','[TN26B1-P082] Flood Resilience Kits Infrastructure - Monastir',0,117),
(83,'2026-07-02','2026-03-13 10:50:03.000000',0.00,'Association Amal proposes a high-impact project in Manouba centered on local market recovery. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.','Milestones reached in Manouba: procurement, beneficiary mapping, and impact verification completed.',86307.00,'ASSOCIATION','2026-02-05','COMPLETED','[TN26B1-P083] Local Market Recovery Infrastructure - Manouba',0,6),
(84,NULL,'2026-01-22 10:50:03.000000',0.00,'Association Nesria proposes a high-impact project in Jendouba centered on olive grove regeneration. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,166861.00,'AMBASSADOR_NETWORK','2026-04-07','SUBMITTED','[TN26B1-P084] Olive Grove Regeneration Infrastructure - Jendouba',0,109),
(85,NULL,'2026-01-24 10:50:03.000000',0.00,'Bizerte Blue Community proposes a high-impact project in Ben Arous centered on local market recovery. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,346880.00,'AMBASSADOR_NETWORK','2026-05-12','SUBMITTED','[TN26B1-P085] Local Market Recovery Infrastructure - Ben Arous',0,117),
(86,NULL,'2026-03-27 10:50:03.000000',0.00,'Gabes Future Makers proposes a high-impact project in Jendouba centered on flood resilience kits. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,55444.00,'AMBASSADOR_NETWORK','2026-06-01','SUBMITTED','[TN26B1-P086] Flood Resilience Kits Infrastructure - Jendouba',0,117),
(87,NULL,'2026-01-17 10:50:03.000000',0.00,'Association Amal proposes a high-impact project in Tozeur centered on fishermen safety training. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,160159.00,'AMBASSADOR_NETWORK','2026-03-06','SUBMITTED','[TN26B1-P087] Fishermen Safety Training Infrastructure - Tozeur',0,107),
(88,NULL,'2026-04-20 10:50:03.000000',0.00,'Association Amal proposes a high-impact project in Sousse centered on local market recovery. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,317387.00,'ASSOCIATION','2026-04-13','SUBMITTED','[TN26B1-P088] Local Market Recovery Infrastructure - Sousse',0,106),
(89,NULL,'2026-04-13 10:50:03.000000',0.00,'Association Amal proposes a high-impact project in Gabes centered on fishermen safety training. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,190920.00,'AMBASSADOR_NETWORK','2026-03-18','SUBMITTED','[TN26B1-P089] Fishermen Safety Training Infrastructure - Gabes',0,107),
(90,'2026-09-15','2026-01-15 10:50:03.000000',0.00,'Association Amal proposes a high-impact project in Monastir centered on coastal cleanup. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.','Milestones reached in Monastir: procurement, beneficiary mapping, and impact verification completed.',319771.00,'AMBASSADOR_NETWORK','2026-06-04','COMPLETED','[TN26B1-P090] Coastal Cleanup Infrastructure - Monastir',0,109),
(91,NULL,'2026-04-02 10:50:03.000000',0.00,'Carthage Solidaire proposes a high-impact project in Mahdia centered on date palm irrigation renewal. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,410982.00,'AMBASSADOR_NETWORK','2026-04-13','SUBMITTED','[TN26B1-P091] Date Palm Irrigation Renewal Infrastructure - Mahdia',0,109),
(92,'2026-07-17','2026-04-17 10:50:03.000000',0.00,'Carthage Solidaire proposes a high-impact project in Kebili centered on food waste reduction. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.','Milestones reached in Kebili: procurement, beneficiary mapping, and impact verification completed.',341512.00,'ASSOCIATION','2026-03-18','COMPLETED','[TN26B1-P092] Food Waste Reduction Infrastructure - Kebili',0,6),
(93,'2026-09-08','2026-03-08 10:50:03.000000',0.00,'Bizerte Blue Community proposes a high-impact project in Jendouba centered on local market recovery. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.','Milestones reached in Jendouba: procurement, beneficiary mapping, and impact verification completed.',401606.00,'AMBASSADOR_NETWORK','2026-04-20','COMPLETED','[TN26B1-P093] Local Market Recovery Infrastructure - Jendouba',0,113),
(94,'2026-08-02','2026-03-17 10:50:03.000000',0.00,'Carthage Solidaire proposes a high-impact project in Gafsa centered on fishermen safety training. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.','Milestones reached in Gafsa: procurement, beneficiary mapping, and impact verification completed.',30856.00,'ASSOCIATION','2026-05-01','COMPLETED','[TN26B1-P094] Fishermen Safety Training Infrastructure - Gafsa',0,106),
(95,NULL,'2026-01-24 10:50:03.000000',0.00,'Bizerte Blue Community proposes a high-impact project in Gabes centered on flood resilience kits. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,328370.00,'AMBASSADOR_NETWORK','2026-07-23','SUBMITTED','[TN26B1-P095] Flood Resilience Kits Infrastructure - Gabes',0,109),
(96,NULL,'2026-04-09 10:50:03.000000',0.00,'Sfax Initiative Citoyenne proposes a high-impact project in Nabeul centered on olive grove regeneration. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,99276.00,'AMBASSADOR_NETWORK','2026-04-28','SUBMITTED','[TN26B1-P096] Olive Grove Regeneration Infrastructure - Nabeul',0,117),
(97,'2026-11-17','2026-01-23 10:50:03.000000',25.00,'Bizerte Blue Community proposes a high-impact project in Sfax centered on ramadan iftar support. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.','Milestones reached in Sfax: procurement, beneficiary mapping, and impact verification completed.',151311.00,'AMBASSADOR_NETWORK','2026-07-01','COMPLETED','[TN26B1-P097] Ramadan Iftar Support Infrastructure - Sfax',1,113),
(98,'2026-09-16','2026-02-05 10:50:03.000000',0.00,'Gabes Future Makers proposes a high-impact project in Sousse centered on medical caravan logistics. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.','Milestones reached in Sousse: procurement, beneficiary mapping, and impact verification completed.',362101.00,'AMBASSADOR_NETWORK','2026-06-13','COMPLETED','[TN26B1-P098] Medical Caravan Logistics Infrastructure - Sousse',0,117),
(99,NULL,'2026-04-10 10:50:03.000000',0.00,'Croissant-Rouge Tunisien proposes a high-impact project in Gabes centered on digital skills for youth. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.',NULL,168176.00,'AMBASSADOR_NETWORK','2026-03-29','SUBMITTED','[TN26B1-P099] Digital Skills for Youth Infrastructure - Gabes',0,107),
(100,'2026-03-09','2026-01-17 10:50:03.000000',0.00,'Bizerte Blue Community proposes a high-impact project in Zaghouan centered on digital skills for youth. The project combines local partnerships, volunteer mobilization, and transparent impact tracking.','Milestones reached in Zaghouan: procurement, beneficiary mapping, and impact verification completed.',83938.00,'AMBASSADOR_NETWORK','2026-01-03','COMPLETED','[TN26B1-P100] Digital Skills for Youth Infrastructure - Zaghouan',0,113);
/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`civic_user`@`%`*/ /*!50003 TRIGGER trg_project_bi_enforce_rollups
BEFORE INSERT ON project
FOR EACH ROW
BEGIN
    SET NEW.current_amount = 0;
    SET NEW.vote_count = 0;
    IF NEW.completion_date IS NOT NULL THEN
        SET NEW.status = 'COMPLETED';
    ELSE
        SET NEW.status = 'SUBMITTED';
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
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`civic_user`@`%`*/ /*!50003 TRIGGER trg_project_bu_enforce_rollups
BEFORE UPDATE ON project
FOR EACH ROW
BEGIN
    DECLARE v_sum DECIMAL(15,2);
    DECLARE v_votes INT;

    SELECT COALESCE(SUM(amount), 0)
    INTO v_sum
    FROM project_funding
    WHERE project_id = OLD.id;

    SELECT COUNT(*)
    INTO v_votes
    FROM project_vote
    WHERE project_id = OLD.id;

    SET NEW.current_amount = v_sum;
    SET NEW.vote_count = v_votes;
    SET NEW.status = CASE
        WHEN NEW.completion_date IS NOT NULL THEN 'COMPLETED'
        WHEN v_sum >= COALESCE(NEW.goal_amount, 0) AND COALESCE(NEW.goal_amount, 0) > 0 THEN 'FULLY_FUNDED'
        ELSE 'SUBMITTED'
    END;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `project_funding`
--

DROP TABLE IF EXISTS `project_funding`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_funding` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `amount` decimal(15,2) NOT NULL,
  `fund_date` datetime(6) NOT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  `project_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK9l2tp6kpxf1us967h9092rsu3` (`project_id`),
  KEY `FKf64bnbumks8sqywqdpqy0dqo3` (`user_id`),
  CONSTRAINT `FK9l2tp6kpxf1us967h9092rsu3` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`),
  CONSTRAINT `FKf64bnbumks8sqywqdpqy0dqo3` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_funding`
--

LOCK TABLES `project_funding` WRITE;
/*!40000 ALTER TABLE `project_funding` DISABLE KEYS */;
INSERT INTO `project_funding` VALUES
(1,25.00,'2026-04-22 10:57:26.367121','CARD',97,5);
/*!40000 ALTER TABLE `project_funding` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`civic_user`@`%`*/ /*!50003 TRIGGER trg_project_funding_ai
AFTER INSERT ON project_funding
FOR EACH ROW
BEGIN
    CALL sp_recalc_project_metrics(NEW.project_id);
    CALL sp_recalc_user_engagement(NEW.user_id);
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
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`civic_user`@`%`*/ /*!50003 TRIGGER trg_project_funding_au
AFTER UPDATE ON project_funding
FOR EACH ROW
BEGIN
    CALL sp_recalc_project_metrics(OLD.project_id);
    CALL sp_recalc_user_engagement(OLD.user_id);
    IF NEW.project_id <> OLD.project_id THEN
        CALL sp_recalc_project_metrics(NEW.project_id);
    END IF;
    IF NEW.user_id <> OLD.user_id THEN
        CALL sp_recalc_user_engagement(NEW.user_id);
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
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`civic_user`@`%`*/ /*!50003 TRIGGER trg_project_funding_ad
AFTER DELETE ON project_funding
FOR EACH ROW
BEGIN
    CALL sp_recalc_project_metrics(OLD.project_id);
    CALL sp_recalc_user_engagement(OLD.user_id);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `project_vote`
--

DROP TABLE IF EXISTS `project_vote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_vote` (
  `project_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `voted_at` datetime(6) NOT NULL,
  PRIMARY KEY (`project_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_vote`
--

LOCK TABLES `project_vote` WRITE;
/*!40000 ALTER TABLE `project_vote` DISABLE KEYS */;
INSERT INTO `project_vote` VALUES
(18,5,'2026-04-22 10:57:01.457098'),
(97,5,'2026-04-22 10:57:04.076413');
/*!40000 ALTER TABLE `project_vote` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`civic_user`@`%`*/ /*!50003 TRIGGER trg_project_vote_ai
AFTER INSERT ON project_vote
FOR EACH ROW
BEGIN
    CALL sp_recalc_project_metrics(NEW.project_id);
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
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`civic_user`@`%`*/ /*!50003 TRIGGER trg_project_vote_au
AFTER UPDATE ON project_vote
FOR EACH ROW
BEGIN
    CALL sp_recalc_project_metrics(OLD.project_id);
    IF NEW.project_id <> OLD.project_id THEN
        CALL sp_recalc_project_metrics(NEW.project_id);
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
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`civic_user`@`%`*/ /*!50003 TRIGGER trg_project_vote_ad
AFTER DELETE ON project_vote
FOR EACH ROW
BEGIN
    CALL sp_recalc_project_metrics(OLD.project_id);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `post` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `content` text DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `creator` varchar(255) NOT NULL,
  `likes_count` int(11) NOT NULL,
  `status` enum('PENDING','ACCEPTED','REJECTED') NOT NULL,
  `type` enum('EVENT_ANNOUNCEMENT','TESTIMONIAL','STATUS','CAMPAIGN_ANNOUNCEMENT') NOT NULL,
  `campaign_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK6d2083rrd6ur1qi12qw9e0rj6` (`campaign_id`),
  CONSTRAINT `FK6d2083rrd6ur1qi12qw9e0rj6` FOREIGN KEY (`campaign_id`) REFERENCES `campaign` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES
(1,'[TN26B1-S001] Field update from Kasserine: Fishermen Safety Training initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2025-12-30 10:50:03.000000','match.amina.bensalah.10foodnexus.local',1,'ACCEPTED','TESTIMONIAL',NULL),
(2,'[TN26B1-S002] Field update from Sidi Bouzid: Women Artisan Empowerment initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-02-04 10:50:03.000000','match.youssef.gharbi.4foodnexus.local',0,'ACCEPTED','EVENT_ANNOUNCEMENT',NULL),
(3,'[TN26B1-S003] Field update from Ben Arous: Flood Resilience Kits initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-01-07 10:50:03.000000','match.hatem.trabelsi.7foodnexus.local',0,'ACCEPTED','TESTIMONIAL',NULL),
(4,'[TN26B1-S004] Field update from Tataouine: Rural Water Access initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-01-09 10:50:03.000000','match.nour.bahri.6foodnexus.local',0,'ACCEPTED','EVENT_ANNOUNCEMENT',NULL),
(5,'[TN26B1-S005] Field update from Mahdia: Coastal Cleanup initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-02-17 10:50:03.000000','match.youssef.gharbi.4foodnexus.local',0,'ACCEPTED','EVENT_ANNOUNCEMENT',NULL),
(6,'[TN26B1-S006] Field update from Bizerte: Women Artisan Empowerment initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-01-05 10:50:03.000000','match.amina.bensalah.10foodnexus.local',0,'ACCEPTED','EVENT_ANNOUNCEMENT',NULL),
(7,'[TN26B1-S007] Field update from Jendouba: Local Market Recovery initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-04-15 10:50:03.000000','match.amina.bensalah.10foodnexus.local',0,'ACCEPTED','STATUS',NULL),
(8,'[TN26B1-S008] Field update from Sidi Bouzid: Food Waste Reduction initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-02-03 10:50:03.000000','match.amina.bensalah.10foodnexus.local',0,'ACCEPTED','EVENT_ANNOUNCEMENT',NULL),
(9,'[TN26B1-S009] Field update from Nabeul: School Meal Solidarity initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-03-30 10:50:03.000000','match.amina.bensalah.0foodnexus.local',0,'ACCEPTED','TESTIMONIAL',NULL),
(10,'[TN26B1-S010] Field update from Manouba: Olive Grove Regeneration initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-02-09 10:50:03.000000','match.amina.bensalah.0foodnexus.local',0,'ACCEPTED','EVENT_ANNOUNCEMENT',NULL),
(11,'[TN26B1-S011] Field update from Le Kef: Olive Grove Regeneration initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-01-24 10:50:03.000000','croissantrouge.tn',0,'ACCEPTED','EVENT_ANNOUNCEMENT',NULL),
(12,'[TN26B1-S012] Field update from Gabes: Coastal Cleanup initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-01-23 10:50:03.000000','match.hatem.trabelsi.7foodnexus.local',0,'ACCEPTED','TESTIMONIAL',NULL),
(13,'[TN26B1-S013] Field update from Tozeur: Flood Resilience Kits initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-03-16 10:50:03.000000','match.amina.bensalah.0foodnexus.local',0,'ACCEPTED','CAMPAIGN_ANNOUNCEMENT',60),
(14,'[TN26B1-S014] Field update from Sousse: Digital Skills for Youth initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-01-04 10:50:03.000000','croissantrouge.tn',0,'ACCEPTED','EVENT_ANNOUNCEMENT',NULL),
(15,'[TN26B1-S015] Field update from Sfax: School Meal Solidarity initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-04-09 10:50:03.000000','match.youssef.gharbi.4foodnexus.local',0,'ACCEPTED','EVENT_ANNOUNCEMENT',NULL),
(16,'[TN26B1-S016] Field update from Mahdia: Medical Caravan Logistics initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-04-08 10:50:03.000000','croissantrouge.tn',0,'ACCEPTED','STATUS',NULL),
(17,'[TN26B1-S017] Field update from Siliana: Coastal Cleanup initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-03-14 10:50:03.000000','match.youssef.gharbi.4foodnexus.local',0,'ACCEPTED','CAMPAIGN_ANNOUNCEMENT',100),
(18,'[TN26B1-S018] Field update from Mahdia: Digital Skills for Youth initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2025-12-23 10:50:03.000000','match.nour.bahri.6foodnexus.local',0,'ACCEPTED','EVENT_ANNOUNCEMENT',NULL),
(19,'[TN26B1-S019] Field update from Sidi Bouzid: Date Palm Irrigation Renewal initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-01-02 10:50:03.000000','match.hatem.trabelsi.7foodnexus.local',0,'ACCEPTED','CAMPAIGN_ANNOUNCEMENT',79),
(20,'[TN26B1-S020] Field update from Tunis: Local Market Recovery initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-02-12 10:50:03.000000','match.hatem.trabelsi.7foodnexus.local',0,'ACCEPTED','CAMPAIGN_ANNOUNCEMENT',67),
(21,'[TN26B1-S021] Field update from Siliana: Olive Grove Regeneration initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-04-18 10:50:03.000000','match.youssef.gharbi.4foodnexus.local',0,'ACCEPTED','CAMPAIGN_ANNOUNCEMENT',10),
(22,'[TN26B1-S022] Field update from Gafsa: Fishermen Safety Training initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-01-27 10:50:03.000000','match.nour.bahri.6foodnexus.local',0,'ACCEPTED','EVENT_ANNOUNCEMENT',NULL),
(23,'[TN26B1-S023] Field update from Tunis: Women Artisan Empowerment initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-03-03 10:50:03.000000','match.youssef.gharbi.4foodnexus.local',0,'ACCEPTED','EVENT_ANNOUNCEMENT',NULL),
(24,'[TN26B1-S024] Field update from Medenine: Medical Caravan Logistics initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-02-28 10:50:03.000000','match.nour.bahri.6foodnexus.local',0,'ACCEPTED','EVENT_ANNOUNCEMENT',NULL),
(25,'[TN26B1-S025] Field update from Beja: Food Waste Reduction initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2025-12-26 10:50:03.000000','match.hatem.trabelsi.7foodnexus.local',0,'ACCEPTED','EVENT_ANNOUNCEMENT',NULL),
(26,'[TN26B1-S026] Field update from Ben Arous: Local Market Recovery initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-01-07 10:50:03.000000','match.nour.bahri.6foodnexus.local',0,'ACCEPTED','TESTIMONIAL',NULL),
(27,'[TN26B1-S027] Field update from Tataouine: Food Waste Reduction initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-01-06 10:50:03.000000','croissantrouge.tn',0,'ACCEPTED','TESTIMONIAL',NULL),
(28,'[TN26B1-S028] Field update from Monastir: School Meal Solidarity initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-03-04 10:50:03.000000','match.youssef.gharbi.4foodnexus.local',0,'ACCEPTED','EVENT_ANNOUNCEMENT',NULL),
(29,'[TN26B1-S029] Field update from Kasserine: School Meal Solidarity initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-03-14 10:50:03.000000','match.hatem.trabelsi.7foodnexus.local',0,'ACCEPTED','TESTIMONIAL',NULL),
(30,'[TN26B1-S030] Field update from Gafsa: Coastal Cleanup initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-03-12 10:50:03.000000','croissantrouge.tn',0,'ACCEPTED','TESTIMONIAL',NULL),
(31,'[TN26B1-S031] Field update from Ariana: Community Fridge Restock initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-04-13 10:50:03.000000','match.amina.bensalah.10foodnexus.local',0,'ACCEPTED','STATUS',NULL),
(32,'[TN26B1-S032] Field update from Sousse: Medical Caravan Logistics initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-02-23 10:50:03.000000','match.amina.bensalah.0foodnexus.local',0,'ACCEPTED','CAMPAIGN_ANNOUNCEMENT',71),
(33,'[TN26B1-S033] Field update from Siliana: Community Fridge Restock initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-02-11 10:50:03.000000','match.hatem.trabelsi.7foodnexus.local',0,'ACCEPTED','TESTIMONIAL',NULL),
(34,'[TN26B1-S034] Field update from Tozeur: Flood Resilience Kits initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2025-12-23 10:50:03.000000','croissantrouge.tn',0,'ACCEPTED','TESTIMONIAL',NULL),
(35,'[TN26B1-S035] Field update from Tataouine: Date Palm Irrigation Renewal initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-02-28 10:50:03.000000','match.nour.bahri.6foodnexus.local',0,'ACCEPTED','STATUS',NULL),
(36,'[TN26B1-S036] Field update from Gafsa: Olive Grove Regeneration initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-04-11 10:50:03.000000','match.amina.bensalah.10foodnexus.local',0,'ACCEPTED','CAMPAIGN_ANNOUNCEMENT',90),
(37,'[TN26B1-S037] Field update from Tunis: Community Fridge Restock initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-01-22 10:50:03.000000','match.nour.bahri.6foodnexus.local',0,'ACCEPTED','EVENT_ANNOUNCEMENT',NULL),
(38,'[TN26B1-S038] Field update from Mahdia: Coastal Cleanup initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-01-27 10:50:03.000000','match.amina.bensalah.10foodnexus.local',0,'ACCEPTED','CAMPAIGN_ANNOUNCEMENT',10),
(39,'[TN26B1-S039] Field update from Kasserine: Flood Resilience Kits initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-01-30 10:50:03.000000','match.nour.bahri.6foodnexus.local',0,'ACCEPTED','STATUS',NULL),
(40,'[TN26B1-S040] Field update from Kebili: Ramadan Iftar Support initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2025-12-28 10:50:03.000000','match.hatem.trabelsi.7foodnexus.local',0,'ACCEPTED','EVENT_ANNOUNCEMENT',NULL),
(41,'[TN26B1-S041] Field update from Monastir: Local Market Recovery initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-03-19 10:50:03.000000','match.hatem.trabelsi.7foodnexus.local',0,'ACCEPTED','EVENT_ANNOUNCEMENT',NULL),
(42,'[TN26B1-S042] Field update from Ariana: Flood Resilience Kits initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-01-25 10:50:03.000000','match.amina.bensalah.0foodnexus.local',0,'ACCEPTED','STATUS',NULL),
(43,'[TN26B1-S043] Field update from Ben Arous: Flood Resilience Kits initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-01-20 10:50:03.000000','match.amina.bensalah.10foodnexus.local',0,'ACCEPTED','STATUS',NULL),
(44,'[TN26B1-S044] Field update from Manouba: Community Fridge Restock initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-03-04 10:50:03.000000','match.amina.bensalah.10foodnexus.local',0,'ACCEPTED','TESTIMONIAL',NULL),
(45,'[TN26B1-S045] Field update from Bizerte: Community Fridge Restock initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-02-08 10:50:03.000000','match.nour.bahri.6foodnexus.local',0,'ACCEPTED','CAMPAIGN_ANNOUNCEMENT',93),
(46,'[TN26B1-S046] Field update from Mahdia: Community Fridge Restock initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-01-11 10:50:03.000000','match.amina.bensalah.0foodnexus.local',0,'ACCEPTED','STATUS',NULL),
(47,'[TN26B1-S047] Field update from Tunis: Ramadan Iftar Support initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-02-05 10:50:03.000000','match.amina.bensalah.10foodnexus.local',0,'ACCEPTED','CAMPAIGN_ANNOUNCEMENT',17),
(48,'[TN26B1-S048] Field update from Monastir: Community Fridge Restock initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2025-12-29 10:50:03.000000','match.youssef.gharbi.4foodnexus.local',0,'ACCEPTED','EVENT_ANNOUNCEMENT',NULL),
(49,'[TN26B1-S049] Field update from Le Kef: Rural Water Access initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-02-17 10:50:03.000000','match.amina.bensalah.10foodnexus.local',0,'ACCEPTED','TESTIMONIAL',NULL),
(50,'[TN26B1-S050] Field update from Tataouine: Date Palm Irrigation Renewal initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-02-14 10:50:03.000000','match.hatem.trabelsi.7foodnexus.local',0,'ACCEPTED','STATUS',NULL),
(51,'[TN26B1-S051] Field update from Manouba: Flood Resilience Kits initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-02-15 10:50:03.000000','match.youssef.gharbi.4foodnexus.local',0,'ACCEPTED','STATUS',NULL),
(52,'[TN26B1-S052] Field update from Monastir: Food Waste Reduction initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-03-21 10:50:03.000000','match.amina.bensalah.0foodnexus.local',0,'ACCEPTED','EVENT_ANNOUNCEMENT',NULL),
(53,'[TN26B1-S053] Field update from Sousse: Food Waste Reduction initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-04-21 10:50:03.000000','croissantrouge.tn',0,'ACCEPTED','EVENT_ANNOUNCEMENT',NULL),
(54,'[TN26B1-S054] Field update from Gafsa: Date Palm Irrigation Renewal initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-03-03 10:50:03.000000','match.hatem.trabelsi.7foodnexus.local',0,'ACCEPTED','STATUS',NULL),
(55,'[TN26B1-S055] Field update from Tunis: Rural Water Access initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-02-23 10:50:03.000000','croissantrouge.tn',0,'ACCEPTED','EVENT_ANNOUNCEMENT',NULL),
(56,'[TN26B1-S056] Field update from Tozeur: Community Fridge Restock initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-02-03 10:50:03.000000','match.hatem.trabelsi.7foodnexus.local',0,'ACCEPTED','STATUS',NULL),
(57,'[TN26B1-S057] Field update from Ben Arous: Food Waste Reduction initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-04-03 10:50:03.000000','match.youssef.gharbi.4foodnexus.local',0,'ACCEPTED','STATUS',NULL),
(58,'[TN26B1-S058] Field update from Monastir: Fishermen Safety Training initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-02-17 10:50:03.000000','match.youssef.gharbi.4foodnexus.local',0,'ACCEPTED','CAMPAIGN_ANNOUNCEMENT',88),
(59,'[TN26B1-S059] Field update from Kairouan: Inclusive Mobility Access initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-01-13 10:50:03.000000','match.amina.bensalah.10foodnexus.local',0,'ACCEPTED','STATUS',NULL),
(60,'[TN26B1-S060] Field update from Monastir: Inclusive Mobility Access initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-02-09 10:50:03.000000','match.hatem.trabelsi.7foodnexus.local',0,'ACCEPTED','TESTIMONIAL',NULL),
(61,'[TN26B1-S061] Field update from Beja: Local Market Recovery initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-01-20 10:50:03.000000','croissantrouge.tn',0,'ACCEPTED','EVENT_ANNOUNCEMENT',NULL),
(62,'[TN26B1-S062] Field update from Manouba: Flood Resilience Kits initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-01-13 10:50:03.000000','croissantrouge.tn',0,'ACCEPTED','CAMPAIGN_ANNOUNCEMENT',13),
(63,'[TN26B1-S063] Field update from Sfax: Community Fridge Restock initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-03-27 10:50:03.000000','match.amina.bensalah.10foodnexus.local',0,'ACCEPTED','STATUS',NULL),
(64,'[TN26B1-S064] Field update from Siliana: Ramadan Iftar Support initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-04-05 10:50:03.000000','match.amina.bensalah.10foodnexus.local',0,'ACCEPTED','CAMPAIGN_ANNOUNCEMENT',29),
(65,'[TN26B1-S065] Field update from Tataouine: Medical Caravan Logistics initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-01-11 10:50:03.000000','match.amina.bensalah.0foodnexus.local',0,'ACCEPTED','CAMPAIGN_ANNOUNCEMENT',94),
(66,'[TN26B1-S066] Field update from Beja: Date Palm Irrigation Renewal initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-02-01 10:50:03.000000','match.nour.bahri.6foodnexus.local',0,'ACCEPTED','CAMPAIGN_ANNOUNCEMENT',9),
(67,'[TN26B1-S067] Field update from Zaghouan: Food Waste Reduction initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-04-16 10:50:03.000000','match.youssef.gharbi.4foodnexus.local',0,'ACCEPTED','CAMPAIGN_ANNOUNCEMENT',70),
(68,'[TN26B1-S068] Field update from Ariana: Ramadan Iftar Support initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-01-10 10:50:03.000000','match.amina.bensalah.10foodnexus.local',0,'ACCEPTED','CAMPAIGN_ANNOUNCEMENT',15),
(69,'[TN26B1-S069] Field update from Tataouine: Community Fridge Restock initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-01-04 10:50:03.000000','match.hatem.trabelsi.7foodnexus.local',0,'ACCEPTED','CAMPAIGN_ANNOUNCEMENT',20),
(70,'[TN26B1-S070] Field update from Manouba: Medical Caravan Logistics initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-04-17 10:50:03.000000','match.hatem.trabelsi.7foodnexus.local',0,'ACCEPTED','STATUS',NULL),
(71,'[TN26B1-S071] Field update from Gafsa: Local Market Recovery initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-02-10 10:50:03.000000','match.youssef.gharbi.4foodnexus.local',0,'ACCEPTED','CAMPAIGN_ANNOUNCEMENT',81),
(72,'[TN26B1-S072] Field update from Sfax: Flood Resilience Kits initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-02-10 10:50:03.000000','match.amina.bensalah.10foodnexus.local',0,'ACCEPTED','EVENT_ANNOUNCEMENT',NULL),
(73,'[TN26B1-S073] Field update from Mahdia: Community Fridge Restock initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-03-30 10:50:03.000000','match.youssef.gharbi.4foodnexus.local',0,'ACCEPTED','CAMPAIGN_ANNOUNCEMENT',55),
(74,'[TN26B1-S074] Field update from Siliana: Rural Water Access initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-03-30 10:50:03.000000','match.amina.bensalah.10foodnexus.local',0,'ACCEPTED','CAMPAIGN_ANNOUNCEMENT',63),
(75,'[TN26B1-S075] Field update from Gabes: Coastal Cleanup initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-01-08 10:50:03.000000','match.hatem.trabelsi.7foodnexus.local',0,'ACCEPTED','EVENT_ANNOUNCEMENT',NULL),
(76,'[TN26B1-S076] Field update from Zaghouan: Local Market Recovery initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-01-26 10:50:03.000000','match.amina.bensalah.10foodnexus.local',0,'ACCEPTED','TESTIMONIAL',NULL),
(77,'[TN26B1-S077] Field update from Mahdia: Date Palm Irrigation Renewal initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-03-22 10:50:03.000000','match.amina.bensalah.10foodnexus.local',0,'ACCEPTED','TESTIMONIAL',NULL),
(78,'[TN26B1-S078] Field update from Siliana: Rural Water Access initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-03-24 10:50:03.000000','match.hatem.trabelsi.7foodnexus.local',0,'ACCEPTED','TESTIMONIAL',NULL),
(79,'[TN26B1-S079] Field update from Sfax: Date Palm Irrigation Renewal initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2025-12-27 10:50:03.000000','match.amina.bensalah.10foodnexus.local',0,'ACCEPTED','STATUS',NULL),
(80,'[TN26B1-S080] Field update from Monastir: Inclusive Mobility Access initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-04-09 10:50:03.000000','match.amina.bensalah.0foodnexus.local',0,'ACCEPTED','CAMPAIGN_ANNOUNCEMENT',4),
(81,'[TN26B1-S081] Field update from Sfax: Date Palm Irrigation Renewal initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-04-16 10:50:03.000000','match.nour.bahri.6foodnexus.local',0,'ACCEPTED','CAMPAIGN_ANNOUNCEMENT',85),
(82,'[TN26B1-S082] Field update from Tozeur: Flood Resilience Kits initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2025-12-24 10:50:03.000000','match.hatem.trabelsi.7foodnexus.local',0,'ACCEPTED','EVENT_ANNOUNCEMENT',NULL),
(83,'[TN26B1-S083] Field update from Tunis: Flood Resilience Kits initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-02-20 10:50:03.000000','match.amina.bensalah.10foodnexus.local',0,'ACCEPTED','STATUS',NULL),
(84,'[TN26B1-S084] Field update from Sousse: Fishermen Safety Training initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-04-04 10:50:03.000000','match.hatem.trabelsi.7foodnexus.local',0,'ACCEPTED','TESTIMONIAL',NULL),
(85,'[TN26B1-S085] Field update from Tataouine: Coastal Cleanup initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-01-12 10:50:03.000000','match.amina.bensalah.10foodnexus.local',0,'ACCEPTED','TESTIMONIAL',NULL),
(86,'[TN26B1-S086] Field update from Beja: Flood Resilience Kits initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-03-03 10:50:03.000000','match.nour.bahri.6foodnexus.local',0,'ACCEPTED','STATUS',NULL),
(87,'[TN26B1-S087] Field update from Ben Arous: Women Artisan Empowerment initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2025-12-24 10:50:03.000000','match.youssef.gharbi.4foodnexus.local',0,'ACCEPTED','EVENT_ANNOUNCEMENT',NULL),
(88,'[TN26B1-S088] Field update from Monastir: Community Fridge Restock initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-03-09 10:50:03.000000','match.hatem.trabelsi.7foodnexus.local',0,'ACCEPTED','STATUS',NULL),
(89,'[TN26B1-S089] Field update from Sidi Bouzid: Local Market Recovery initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-04-16 10:50:03.000000','match.amina.bensalah.10foodnexus.local',0,'ACCEPTED','CAMPAIGN_ANNOUNCEMENT',1),
(90,'[TN26B1-S090] Field update from Kasserine: Fishermen Safety Training initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-01-16 10:50:03.000000','match.youssef.gharbi.4foodnexus.local',0,'ACCEPTED','CAMPAIGN_ANNOUNCEMENT',32),
(91,'[TN26B1-S091] Field update from Sidi Bouzid: Digital Skills for Youth initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-04-20 10:50:03.000000','match.nour.bahri.6foodnexus.local',0,'ACCEPTED','TESTIMONIAL',NULL),
(92,'[TN26B1-S092] Field update from Bizerte: Olive Grove Regeneration initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-02-08 10:50:03.000000','match.nour.bahri.6foodnexus.local',0,'ACCEPTED','CAMPAIGN_ANNOUNCEMENT',10),
(93,'[TN26B1-S093] Field update from Nabeul: Ramadan Iftar Support initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-04-06 10:50:03.000000','match.amina.bensalah.0foodnexus.local',0,'ACCEPTED','STATUS',NULL),
(94,'[TN26B1-S094] Field update from Bizerte: Flood Resilience Kits initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2025-12-28 10:50:03.000000','match.amina.bensalah.0foodnexus.local',0,'ACCEPTED','STATUS',NULL),
(95,'[TN26B1-S095] Field update from Sfax: Inclusive Mobility Access initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-01-14 10:50:03.000000','croissantrouge.tn',0,'ACCEPTED','TESTIMONIAL',NULL),
(96,'[TN26B1-S096] Field update from Tunis: Community Fridge Restock initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-02-15 10:50:03.000000','match.amina.bensalah.10foodnexus.local',0,'ACCEPTED','TESTIMONIAL',NULL),
(97,'[TN26B1-S097] Field update from Sousse: Community Fridge Restock initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-01-18 10:50:03.000000','match.youssef.gharbi.4foodnexus.local',0,'ACCEPTED','EVENT_ANNOUNCEMENT',NULL),
(98,'[TN26B1-S098] Field update from Siliana: Community Fridge Restock initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-03-08 10:50:03.000000','match.amina.bensalah.0foodnexus.local',0,'ACCEPTED','STATUS',NULL),
(99,'[TN26B1-S099] Field update from Kairouan: Digital Skills for Youth initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-04-04 10:50:03.000000','match.amina.bensalah.0foodnexus.local',0,'ACCEPTED','TESTIMONIAL',NULL),
(100,'[TN26B1-S100] Field update from Ben Arous: Fishermen Safety Training initiative is progressing with local volunteers, municipal support, and beneficiary outreach. Next milestone focuses on measurable social impact in Tunisia.','2026-02-25 10:50:03.000000','match.amina.bensalah.0foodnexus.local',0,'ACCEPTED','STATUS',NULL);
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`civic_user`@`%`*/ /*!50003 TRIGGER trg_post_bi_enforce_likes
BEFORE INSERT ON post
FOR EACH ROW
BEGIN
    SET NEW.likes_count = 0;
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
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`civic_user`@`%`*/ /*!50003 TRIGGER trg_post_bu_enforce_likes
BEFORE UPDATE ON post
FOR EACH ROW
BEGIN
    SET NEW.likes_count = (
        SELECT COUNT(*)
        FROM like_entity l
        WHERE l.post_id = OLD.id
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `post_attachment`
--

DROP TABLE IF EXISTS `post_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_attachment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `filename` varchar(255) NOT NULL,
  `kind` enum('IMAGE','VIDEO') NOT NULL,
  `mime_type` varchar(128) DEFAULT NULL,
  `post_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKmof1y73w0oea4caub8rpkhlmi` (`post_id`),
  CONSTRAINT `FKmof1y73w0oea4caub8rpkhlmi` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_attachment`
--

LOCK TABLES `post_attachment` WRITE;
/*!40000 ALTER TABLE `post_attachment` DISABLE KEYS */;
/*!40000 ALTER TABLE `post_attachment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `content` text DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `author_id` bigint(20) NOT NULL,
  `post_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKh1gtv412u19wcbx22177xbkjp` (`author_id`),
  KEY `FKs1slvnkuemjsq2kj4h3vhx7i1` (`post_id`),
  CONSTRAINT `FKh1gtv412u19wcbx22177xbkjp` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FKs1slvnkuemjsq2kj4h3vhx7i1` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment_attachment`
--

DROP TABLE IF EXISTS `comment_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment_attachment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `filename` varchar(255) NOT NULL,
  `kind` enum('IMAGE','VIDEO') NOT NULL,
  `mime_type` varchar(128) DEFAULT NULL,
  `comment_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKkxd1qx8jyg0dyja1g40gb25jd` (`comment_id`),
  CONSTRAINT `FKkxd1qx8jyg0dyja1g40gb25jd` FOREIGN KEY (`comment_id`) REFERENCES `comment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment_attachment`
--

LOCK TABLES `comment_attachment` WRITE;
/*!40000 ALTER TABLE `comment_attachment` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment_attachment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `like_entity`
--

DROP TABLE IF EXISTS `like_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `like_entity` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `owner_id` bigint(20) NOT NULL,
  `post_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKb119jlv2421pdk5gh25rnpvnt` (`owner_id`,`post_id`),
  KEY `FKk6yto1o4cf6a6ro4phygokl9h` (`post_id`),
  CONSTRAINT `FKdvx3otedv0mwjstx9iyscxcfy` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FKk6yto1o4cf6a6ro4phygokl9h` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `like_entity`
--

LOCK TABLES `like_entity` WRITE;
/*!40000 ALTER TABLE `like_entity` DISABLE KEYS */;
INSERT INTO `like_entity` VALUES
(1,'2026-04-22 10:54:20.764096',5,1);
/*!40000 ALTER TABLE `like_entity` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`civic_user`@`%`*/ /*!50003 TRIGGER trg_like_entity_ai
AFTER INSERT ON like_entity
FOR EACH ROW
BEGIN
    CALL sp_recalc_post_likes(NEW.post_id);
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
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`civic_user`@`%`*/ /*!50003 TRIGGER trg_like_entity_au
AFTER UPDATE ON like_entity
FOR EACH ROW
BEGIN
    CALL sp_recalc_post_likes(OLD.post_id);
    IF NEW.post_id <> OLD.post_id THEN
        CALL sp_recalc_post_likes(NEW.post_id);
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
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`civic_user`@`%`*/ /*!50003 TRIGGER trg_like_entity_ad
AFTER DELETE ON like_entity
FOR EACH ROW
BEGIN
    CALL sp_recalc_post_likes(OLD.post_id);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `user_interactions`
--

DROP TABLE IF EXISTS `user_interactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_interactions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `action` enum('FUND','VOTE','COMMENT','ATTEND','LIKE','VIEW') NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `entity_id` bigint(20) NOT NULL,
  `entity_type` enum('CAMPAIGN','PROJECT','POST','EVENT') NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_interactions`
--

LOCK TABLES `user_interactions` WRITE;
/*!40000 ALTER TABLE `user_interactions` DISABLE KEYS */;
INSERT INTO `user_interactions` VALUES
(1,'ATTEND','2026-04-13 10:39:29.000000',2,'EVENT',107),
(2,'VIEW','2026-04-14 10:39:29.000000',2,'EVENT',107),
(3,'LIKE','2026-04-17 10:39:29.000000',2,'EVENT',107),
(4,'ATTEND','2026-04-15 10:39:29.000000',2,'EVENT',108),
(5,'VIEW','2026-04-16 10:39:29.000000',2,'EVENT',108),
(6,'LIKE','2026-04-18 10:39:29.000000',2,'EVENT',108),
(7,'ATTEND','2026-04-12 10:39:29.000000',2,'EVENT',109),
(8,'VIEW','2026-04-14 10:39:29.000000',2,'EVENT',109),
(9,'LIKE','2026-04-19 10:39:29.000000',2,'EVENT',109),
(10,'ATTEND','2026-04-16 10:39:29.000000',2,'EVENT',110),
(11,'VIEW','2026-04-18 10:39:29.000000',2,'EVENT',110),
(12,'ATTEND','2026-04-13 10:39:29.000000',2,'EVENT',111),
(13,'VIEW','2026-04-15 10:39:29.000000',2,'EVENT',111),
(14,'LIKE','2026-04-20 10:39:29.000000',2,'EVENT',111),
(15,'ATTEND','2026-04-11 10:39:29.000000',2,'EVENT',112),
(16,'VIEW','2026-04-13 10:39:29.000000',2,'EVENT',112),
(17,'LIKE','2026-04-21 10:39:29.000000',2,'EVENT',112),
(18,'ATTEND','2026-04-14 10:39:29.000000',2,'EVENT',113),
(19,'VIEW','2026-04-16 10:39:29.000000',2,'EVENT',113),
(20,'LIKE','2026-04-20 10:39:29.000000',2,'EVENT',113),
(21,'ATTEND','2026-04-15 10:39:29.000000',2,'EVENT',114),
(22,'VIEW','2026-04-17 10:39:29.000000',2,'EVENT',114),
(23,'ATTEND','2026-04-17 10:39:29.000000',2,'EVENT',115),
(24,'VIEW','2026-04-19 10:39:29.000000',2,'EVENT',115),
(25,'ATTEND','2026-04-18 10:39:29.000000',2,'EVENT',116),
(26,'VIEW','2026-04-20 10:39:29.000000',2,'EVENT',116),
(27,'LIKE','2026-04-21 10:39:29.000000',2,'EVENT',116),
(28,'ATTEND','2026-04-19 10:39:29.000000',2,'EVENT',117),
(29,'VIEW','2026-04-20 10:39:29.000000',2,'EVENT',117),
(30,'LIKE','2026-04-21 10:39:29.000000',2,'EVENT',117),
(31,'ATTEND','2026-04-22 10:43:48.326502',3,'EVENT',5),
(32,'LIKE','2026-04-22 10:54:20.766384',1,'POST',5),
(33,'VOTE','2026-04-22 10:57:01.464479',18,'PROJECT',5),
(34,'VOTE','2026-04-22 10:57:04.077450',97,'PROJECT',5),
(35,'FUND','2026-04-22 10:57:26.369748',97,'PROJECT',5),
(36,'ATTEND','2026-04-22 11:00:51.105822',4,'EVENT',5),
(37,'ATTEND','2026-04-22 11:01:16.854099',7,'EVENT',5),
(38,'ATTEND','2026-04-22 11:01:37.412639',19,'EVENT',5),
(39,'ATTEND','2026-04-22 11:01:47.138843',23,'EVENT',5),
(40,'ATTEND','2026-04-22 11:01:56.959322',22,'EVENT',5);
/*!40000 ALTER TABLE `user_interactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `body` text DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `link_url` varchar(512) DEFAULT NULL,
  `read_at` datetime(6) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `type` enum('INFO','SUCCESS','WARNING','ENGAGEMENT','MODERATION') NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK3dt2b80521eynbjg4nehtjnhy` (`user_id`),
  CONSTRAINT `FK3dt2b80521eynbjg4nehtjnhy` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES
(1,'We prioritized other community members for \"ss\". Browse upcoming events to find a better fit.','2026-04-22 10:24:38.628613','http://localhost:4200/events',NULL,'Suggested event for you','ENGAGEMENT',1),
(2,'We prioritized other community members for \"ss\". Browse upcoming events to find a better fit.','2026-04-22 10:24:38.631998','http://localhost:4200/events',NULL,'Suggested event for you','ENGAGEMENT',2),
(3,'We prioritized other community members for \"ss\". Browse upcoming events to find a better fit.','2026-04-22 10:24:38.633227','http://localhost:4200/events','2026-04-22 10:25:35.402122','Suggested event for you','ENGAGEMENT',5),
(4,'You were invited to \"ss\". Open My invitations to accept or decline.','2026-04-22 10:24:40.049527','http://localhost:4200/dashboard?tab=invitations',NULL,'Event invitation','ENGAGEMENT',1),
(5,'You were invited to \"ss\". Open My invitations to accept or decline.','2026-04-22 10:24:41.174665','http://localhost:4200/dashboard?tab=invitations',NULL,'Event invitation','ENGAGEMENT',2),
(6,'You were invited to \"ss\". Open My invitations to accept or decline.','2026-04-22 10:24:42.607991','http://localhost:4200/dashboard?tab=invitations','2026-04-22 10:25:35.402122','Event invitation','ENGAGEMENT',5),
(7,'We prioritized other community members for \"Weekend Food Distribution & Community Fridge Restock - Tunis\". Browse upcoming events to find a better fit.','2026-04-22 10:29:06.981859','http://localhost:4200/events',NULL,'Suggested event for you','ENGAGEMENT',1),
(8,'We prioritized other community members for \"Weekend Food Distribution & Community Fridge Restock - Tunis\". Browse upcoming events to find a better fit.','2026-04-22 10:29:06.983562','http://localhost:4200/events',NULL,'Suggested event for you','ENGAGEMENT',2),
(9,'We prioritized other community members for \"Weekend Food Distribution & Community Fridge Restock - Tunis\". Browse upcoming events to find a better fit.','2026-04-22 10:29:06.986096','http://localhost:4200/events','2026-04-22 11:02:04.826259','Suggested event for you','ENGAGEMENT',5),
(10,'You were invited to \"Weekend Food Distribution & Community Fridge Restock - Tunis\". Open My invitations to accept or decline.','2026-04-22 10:29:12.003814','http://localhost:4200/dashboard?tab=invitations',NULL,'Event invitation','ENGAGEMENT',1),
(11,'You were invited to \"Weekend Food Distribution & Community Fridge Restock - Tunis\". Open My invitations to accept or decline.','2026-04-22 10:29:12.013634','http://localhost:4200/dashboard?tab=invitations',NULL,'Event invitation','ENGAGEMENT',2),
(12,'You were invited to \"Weekend Food Distribution & Community Fridge Restock - Tunis\". Open My invitations to accept or decline.','2026-04-22 10:29:12.022351','http://localhost:4200/dashboard?tab=invitations','2026-04-22 10:31:14.912244','Event invitation','ENGAGEMENT',5),
(13,'We prioritized other community members for \"Weekend Food Distribution & Community Fridge Restock - Tunis\". Browse upcoming events to find a better fit.','2026-04-22 10:35:14.348444','http://localhost:4200/events','2026-04-22 11:02:04.826259','Suggested event for you','ENGAGEMENT',5),
(14,'We prioritized other community members for \"Weekend Food Distribution & Community Fridge Restock - Tunis\". Browse upcoming events to find a better fit.','2026-04-22 10:35:14.361416','http://localhost:4200/events',NULL,'Suggested event for you','ENGAGEMENT',1),
(15,'We prioritized other community members for \"Weekend Food Distribution & Community Fridge Restock - Tunis\". Browse upcoming events to find a better fit.','2026-04-22 10:35:14.362991','http://localhost:4200/events',NULL,'Suggested event for you','ENGAGEMENT',2),
(16,'You were invited to \"Weekend Food Distribution & Community Fridge Restock - Tunis\". Open My invitations to accept or decline.','2026-04-22 10:35:15.280523','http://localhost:4200/dashboard?tab=invitations','2026-04-22 10:46:36.273316','Event invitation','ENGAGEMENT',5),
(17,'You were invited to \"Weekend Food Distribution & Community Fridge Restock - Tunis\". Open My invitations to accept or decline.','2026-04-22 10:35:15.976862','http://localhost:4200/dashboard?tab=invitations',NULL,'Event invitation','ENGAGEMENT',1),
(18,'You were invited to \"Weekend Food Distribution & Community Fridge Restock - Tunis\". Open My invitations to accept or decline.','2026-04-22 10:35:16.455800','http://localhost:4200/dashboard?tab=invitations',NULL,'Event invitation','ENGAGEMENT',2),
(19,'Your post was accepted and is visible in the feed.','2026-04-22 10:51:44.655707','/posts/1',NULL,'Post approved','MODERATION',107),
(20,'Your post was accepted and is visible in the feed.','2026-04-22 10:51:45.076952','/posts/5',NULL,'Post approved','MODERATION',117),
(21,'Your post was accepted and is visible in the feed.','2026-04-22 10:51:45.240027','/posts/8',NULL,'Post approved','MODERATION',107),
(22,'Your post was accepted and is visible in the feed.','2026-04-22 10:51:45.390265','/posts/9',NULL,'Post approved','MODERATION',106),
(23,'Your post was accepted and is visible in the feed.','2026-04-22 10:51:45.526853','/posts/10',NULL,'Post approved','MODERATION',106),
(24,'Your post was accepted and is visible in the feed.','2026-04-22 10:51:45.669340','/posts/11',NULL,'Post approved','MODERATION',6),
(25,'Your post was accepted and is visible in the feed.','2026-04-22 10:51:45.813975','/posts/13',NULL,'Post approved','MODERATION',106),
(26,'Your post was accepted and is visible in the feed.','2026-04-22 10:51:45.983704','/posts/15',NULL,'Post approved','MODERATION',117),
(27,'Your post was accepted and is visible in the feed.','2026-04-22 10:51:46.134555','/posts/17',NULL,'Post approved','MODERATION',117),
(28,'Your post was accepted and is visible in the feed.','2026-04-22 10:51:46.277062','/posts/19',NULL,'Post approved','MODERATION',109),
(29,'Your post was accepted and is visible in the feed.','2026-04-22 10:51:46.431102','/posts/20',NULL,'Post approved','MODERATION',109),
(30,'Your post was accepted and is visible in the feed.','2026-04-22 10:51:46.582994','/posts/21',NULL,'Post approved','MODERATION',117),
(31,'Your post was accepted and is visible in the feed.','2026-04-22 10:51:46.719706','/posts/22',NULL,'Post approved','MODERATION',113),
(32,'Your post was accepted and is visible in the feed.','2026-04-22 10:51:46.865752','/posts/24',NULL,'Post approved','MODERATION',113),
(33,'Your post was accepted and is visible in the feed.','2026-04-22 10:51:47.016457','/posts/26',NULL,'Post approved','MODERATION',113),
(34,'Your post was accepted and is visible in the feed.','2026-04-22 10:51:47.169351','/posts/27',NULL,'Post approved','MODERATION',6),
(35,'Your post was accepted and is visible in the feed.','2026-04-22 10:51:47.311715','/posts/31',NULL,'Post approved','MODERATION',107),
(36,'Your post was accepted and is visible in the feed.','2026-04-22 10:51:47.466082','/posts/32',NULL,'Post approved','MODERATION',106),
(37,'Your post was accepted and is visible in the feed.','2026-04-22 10:51:47.632608','/posts/35',NULL,'Post approved','MODERATION',113),
(38,'Your post was accepted and is visible in the feed.','2026-04-22 10:51:47.783454','/posts/38',NULL,'Post approved','MODERATION',107),
(39,'Your post was accepted and is visible in the feed.','2026-04-22 10:51:47.952223','/posts/40',NULL,'Post approved','MODERATION',109),
(40,'Your post was accepted and is visible in the feed.','2026-04-22 10:51:48.113963','/posts/41',NULL,'Post approved','MODERATION',109),
(41,'Your post was accepted and is visible in the feed.','2026-04-22 10:51:48.281414','/posts/43',NULL,'Post approved','MODERATION',107),
(42,'Your post was accepted and is visible in the feed.','2026-04-22 10:51:48.442968','/posts/45',NULL,'Post approved','MODERATION',113),
(43,'Your post was accepted and is visible in the feed.','2026-04-22 10:51:48.610277','/posts/48',NULL,'Post approved','MODERATION',117),
(44,'Your post was accepted and is visible in the feed.','2026-04-22 10:51:48.770529','/posts/49',NULL,'Post approved','MODERATION',107),
(45,'Your post was accepted and is visible in the feed.','2026-04-22 10:51:48.938564','/posts/50',NULL,'Post approved','MODERATION',109),
(46,'Your post was accepted and is visible in the feed.','2026-04-22 10:51:49.098067','/posts/52',NULL,'Post approved','MODERATION',106),
(47,'Your post was accepted and is visible in the feed.','2026-04-22 10:51:49.249760','/posts/58',NULL,'Post approved','MODERATION',117),
(48,'Your post was accepted and is visible in the feed.','2026-04-22 10:51:49.416824','/posts/59',NULL,'Post approved','MODERATION',107),
(49,'Your post was accepted and is visible in the feed.','2026-04-22 10:51:49.593970','/posts/61',NULL,'Post approved','MODERATION',6),
(50,'Your post was accepted and is visible in the feed.','2026-04-22 10:51:49.764576','/posts/64',NULL,'Post approved','MODERATION',107),
(51,'Your post was accepted and is visible in the feed.','2026-04-22 10:51:49.950628','/posts/71',NULL,'Post approved','MODERATION',117),
(52,'Your post was accepted and is visible in the feed.','2026-04-22 10:51:50.124120','/posts/78',NULL,'Post approved','MODERATION',109),
(53,'Your post was accepted and is visible in the feed.','2026-04-22 10:51:50.300417','/posts/79',NULL,'Post approved','MODERATION',107),
(54,'Your post was accepted and is visible in the feed.','2026-04-22 10:51:50.484687','/posts/82',NULL,'Post approved','MODERATION',109),
(55,'Your post was accepted and is visible in the feed.','2026-04-22 10:51:50.653541','/posts/84',NULL,'Post approved','MODERATION',109),
(56,'Your post was accepted and is visible in the feed.','2026-04-22 10:51:50.820875','/posts/93',NULL,'Post approved','MODERATION',106),
(57,'Your post was accepted and is visible in the feed.','2026-04-22 10:51:50.979486','/posts/97',NULL,'Post approved','MODERATION',117),
(58,'Your post was accepted and is visible in the feed.','2026-04-22 10:51:51.149959','/posts/98',NULL,'Post approved','MODERATION',106),
(59,'Your post was accepted and is visible in the feed.','2026-04-22 10:51:51.303020','/posts/99',NULL,'Post approved','MODERATION',106),
(60,'dorra.benali1 voted on \"[TN26B1-P018] Ramadan Iftar Support Infrastructure - Manouba\".','2026-04-22 10:57:01.466479','/projects/18',NULL,'New vote on your project','ENGAGEMENT',107),
(61,'dorra.benali1 voted on \"[TN26B1-P097] Ramadan Iftar Support Infrastructure - Sfax\".','2026-04-22 10:57:04.078142','/projects/97',NULL,'New vote on your project','ENGAGEMENT',113),
(62,'dorra.benali1 contributed 25 to \"[TN26B1-P097] Ramadan Iftar Support Infrastructure - Sfax\".','2026-04-22 10:57:26.371111','/projects/97',NULL,'New funding on your project','ENGAGEMENT',113);
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-22 12:26:13
