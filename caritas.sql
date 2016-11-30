-- MySQL dump 10.13  Distrib 5.7.16, for Linux (x86_64)
--
-- Host: localhost    Database: caritas
-- ------------------------------------------------------
-- Server version	5.7.16
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--


--
-- Table structure for table `auth_group_permissions`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissi_permission_id_84c5c92e_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_group_permissi_permission_id_84c5c92e_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--


--
-- Table structure for table `auth_permission`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permissi_content_type_id_2f476e4b_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (1,'Can add permission',1,'add_permission');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (2,'Can change permission',1,'change_permission');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (3,'Can delete permission',1,'delete_permission');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (4,'Can add group',2,'add_group');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (5,'Can change group',2,'change_group');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (6,'Can delete group',2,'delete_group');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (7,'Can add user',3,'add_user');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (8,'Can change user',3,'change_user');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (9,'Can delete user',3,'delete_user');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (13,'Can add log entry',5,'add_logentry');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (14,'Can change log entry',5,'change_logentry');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (15,'Can delete log entry',5,'delete_logentry');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (16,'Can add content type',6,'add_contenttype');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (17,'Can change content type',6,'change_contenttype');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (18,'Can delete content type',6,'delete_contenttype');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (19,'Can add session',7,'add_session');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (20,'Can change session',7,'change_session');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (21,'Can delete session',7,'delete_session');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (22,'Can add site',8,'add_site');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (23,'Can change site',8,'change_site');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (24,'Can delete site',8,'delete_site');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (25,'Can add News item',9,'add_newsitem');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (26,'Can change News item',9,'change_newsitem');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (27,'Can delete News item',9,'delete_newsitem');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (28,'Can add template',10,'add_template');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (29,'Can change template',10,'change_template');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (30,'Can delete template',10,'delete_template');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (31,'Can add menu',11,'add_menu');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (32,'Can change menu',11,'change_menu');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (33,'Can delete menu',11,'delete_menu');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (34,'Can add menu item',12,'add_menuitem');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (35,'Can change menu item',12,'change_menuitem');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (36,'Can delete menu item',12,'delete_menuitem');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (37,'Can add page',13,'add_page');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (38,'Can change page',13,'change_page');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (39,'Can delete page',13,'delete_page');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (40,'Can add language',14,'add_language');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (41,'Can change language',14,'change_language');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (42,'Can delete language',14,'delete_language');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (43,'Can add news item i18n',15,'add_newsitemi18n');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (44,'Can change news item i18n',15,'change_newsitemi18n');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (45,'Can delete news item i18n',15,'delete_newsitemi18n');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (46,'Can add menu item i18n',16,'add_menuitemi18n');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (47,'Can change menu item i18n',16,'change_menuitemi18n');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (48,'Can delete menu item i18n',16,'delete_menuitemi18n');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (49,'Can add page i18n',17,'add_pagei18n');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (50,'Can change page i18n',17,'change_pagei18n');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (51,'Can delete page i18n',17,'delete_pagei18n');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (52,'Can add Setting',18,'add_settings');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (53,'Can change Setting',18,'change_settings');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (54,'Can delete Setting',18,'delete_settings');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (55,'Can add html part',19,'add_htmlpart');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (56,'Can change html part',19,'change_htmlpart');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (57,'Can delete html part',19,'delete_htmlpart');

--
-- Table structure for table `auth_user`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `first_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(254) COLLATE utf8_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES (1,'','2016-09-27 10:13:29.160331',1,'andriy','','','andriy',1,1,'2010-02-03 21:55:39.171000');
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES (2,'','2012-04-19 16:01:53.072000',1,'caritas','','','',1,1,'2010-03-17 11:13:13.000000');

--
-- Table structure for table `auth_user_groups`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--


--
-- Table structure for table `auth_user_user_permissions`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_perm_permission_id_1fbb5f2c_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_user_user_perm_permission_id_1fbb5f2c_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--


--
-- Table structure for table `django_admin_log`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8_unicode_ci,
  `object_repr` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext COLLATE utf8_unicode_ci NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin__content_type_id_c4bce8eb_fk_django_content_type_id` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin__content_type_id_c4bce8eb_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=504 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

--
-- Table structure for table `django_content_type`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `model` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (5,'admin','logentry');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (2,'auth','group');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (1,'auth','permission');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (3,'auth','user');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (6,'contenttypes','contenttype');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (19,'portal','htmlpart');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (14,'portal','language');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (11,'portal','menu');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (12,'portal','menuitem');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (16,'portal','menuitemi18n');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (9,'portal','newsitem');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (15,'portal','newsitemi18n');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (13,'portal','page');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (17,'portal','pagei18n');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (18,'portal','settings');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (10,'portal','template');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (7,'sessions','session');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (8,'sites','site');

--
-- Table structure for table `django_migrations`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (1,'contenttypes','0001_initial','2016-04-20 18:00:42.693238');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (2,'auth','0001_initial','2016-04-20 18:00:43.274944');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (3,'admin','0001_initial','2016-04-20 18:00:43.502562');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (4,'admin','0002_logentry_remove_auto_add','2016-04-20 18:00:43.543143');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (5,'contenttypes','0002_remove_content_type_name','2016-04-20 18:00:43.725206');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (6,'auth','0002_alter_permission_name_max_length','2016-04-20 18:00:43.867952');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (7,'auth','0003_alter_user_email_max_length','2016-04-20 18:00:43.973997');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (8,'auth','0004_alter_user_username_opts','2016-04-20 18:00:44.004890');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (9,'auth','0005_alter_user_last_login_null','2016-04-20 18:00:44.069832');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (10,'auth','0006_require_contenttypes_0002','2016-04-20 18:00:44.077554');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (11,'auth','0007_alter_validators_add_error_messages','2016-04-20 18:00:44.105576');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (12,'sessions','0001_initial','2016-04-20 18:00:44.154323');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (13,'sites','0001_initial','2016-04-20 18:00:44.183862');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (14,'sites','0002_alter_domain_unique','2016-04-20 18:00:44.218883');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (15,'portal','0001_initial','2016-04-20 18:05:07.860284');

--
-- Table structure for table `django_session`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `session_data` longtext COLLATE utf8_unicode_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_de54fa62` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--


--
-- Table structure for table `django_site`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_site_domain_a2e37b91_uniq` (`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_site`
--

INSERT INTO `django_site` (`id`, `domain`, `name`) VALUES (1,'http://caritas-kolomyya.org','caritas');

--
-- Table structure for table `portal_htmlpart`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portal_htmlpart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `evaluate` tinyint(1) NOT NULL,
  `html` longtext COLLATE utf8_unicode_ci NOT NULL,
  `lang_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`),
  UNIQUE KEY `portal_htmlpart_key_3dc33e19_uniq` (`key`,`lang_id`),
  KEY `portal_htmlpart_78e6dd7a` (`lang_id`),
  CONSTRAINT `portal_htmlpart_lang_id_b58d2467_fk_portal_language_id` FOREIGN KEY (`lang_id`) REFERENCES `portal_language` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portal_htmlpart`
--

INSERT INTO `portal_htmlpart` (`id`, `key`, `description`, `evaluate`, `html`, `lang_id`) VALUES (2,'menu-bottom-banners','',0,'<p><a href=\"http://scct.caritas-kolomyya.org\" target=\"_blank\"><img src=\"/caritas/cr/scct.jpg\" alt=\"\" width=\"200\" height=\"262\" /></a></p>\r\n<p><a href=\"http://www.acho.caritas.cz\"><img src=\"/caritas/cr/supported-by-small.png\" alt=\"\" width=\"200\" height=\"314\" /></a></p>',NULL);

--
-- Table structure for table `portal_language`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portal_language` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `is_default` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `portal_language_f62baf4c` (`is_default`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portal_language`
--

INSERT INTO `portal_language` (`id`, `code`, `name`, `is_default`) VALUES (1,'uk','Ukrainian',1);
INSERT INTO `portal_language` (`id`, `code`, `name`, `is_default`) VALUES (3,'en','english',0);

--
-- Table structure for table `portal_menu`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portal_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `template_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `portal_menu_74f53564` (`template_id`),
  CONSTRAINT `portal_menu_template_id_a297f890_fk_portal_template_id` FOREIGN KEY (`template_id`) REFERENCES `portal_template` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portal_menu`
--

INSERT INTO `portal_menu` (`id`, `name`, `description`, `template_id`) VALUES (1,'up','верхнє',NULL);
INSERT INTO `portal_menu` (`id`, `name`, `description`, `template_id`) VALUES (2,'main','головне',NULL);

--
-- Table structure for table `portal_menuitem`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portal_menuitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `caption` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `order` int(11) NOT NULL,
  `non_navigable` tinyint(1) NOT NULL,
  `menu_id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `url` (`url`),
  KEY `portal_menuitem_menu_id_c771540b_fk_portal_menu_id` (`menu_id`),
  KEY `portal_menuitem_parent_id_04e18b3f_fk_portal_menuitem_id` (`parent_id`),
  CONSTRAINT `portal_menuitem_menu_id_c771540b_fk_portal_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `portal_menu` (`id`),
  CONSTRAINT `portal_menuitem_parent_id_04e18b3f_fk_portal_menuitem_id` FOREIGN KEY (`parent_id`) REFERENCES `portal_menuitem` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portal_menuitem`
--

INSERT INTO `portal_menuitem` (`id`, `caption`, `url`, `order`, `non_navigable`, `menu_id`, `parent_id`) VALUES (1,'Діти та молодь','young/',10,1,1,NULL);
INSERT INTO `portal_menuitem` (`id`, `caption`, `url`, `order`, `non_navigable`, `menu_id`, `parent_id`) VALUES (2,'Домашня опіка','home-care/',20,1,1,NULL);
INSERT INTO `portal_menuitem` (`id`, `caption`, `url`, `order`, `non_navigable`, `menu_id`, `parent_id`) VALUES (3,'Соціальна допомога','social-care/',30,1,1,NULL);
INSERT INTO `portal_menuitem` (`id`, `caption`, `url`, `order`, `non_navigable`, `menu_id`, `parent_id`) VALUES (4,'Акції','actions/',40,1,1,NULL);
INSERT INTO `portal_menuitem` (`id`, `caption`, `url`, `order`, `non_navigable`, `menu_id`, `parent_id`) VALUES (5,'Надзвичайні ситуації','emergency/',60,0,1,NULL);
INSERT INTO `portal_menuitem` (`id`, `caption`, `url`, `order`, `non_navigable`, `menu_id`, `parent_id`) VALUES (6,'Соціальний центр для дітей трудових мігрантів','young/social-center/',10,0,1,1);
INSERT INTO `portal_menuitem` (`id`, `caption`, `url`, `order`, `non_navigable`, `menu_id`, `parent_id`) VALUES (7,'Діти вулиці','young/child-of-street/',20,0,1,1);
INSERT INTO `portal_menuitem` (`id`, `caption`, `url`, `order`, `non_navigable`, `menu_id`, `parent_id`) VALUES (11,'Інформаційний та навчальний центр домашнього догляду','home-care/eldes/',20,0,1,2);
INSERT INTO `portal_menuitem` (`id`, `caption`, `url`, `order`, `non_navigable`, `menu_id`, `parent_id`) VALUES (12,'Благодійна їдальня','social-care/social-dinning/',10,0,1,3);
INSERT INTO `portal_menuitem` (`id`, `caption`, `url`, `order`, `non_navigable`, `menu_id`, `parent_id`) VALUES (13,'Пункти видачі гуманітарної допомоги','social-care/human-aid-points/',20,0,1,3);
INSERT INTO `portal_menuitem` (`id`, `caption`, `url`, `order`, `non_navigable`, `menu_id`, `parent_id`) VALUES (14,'Сирітський портфелик','actions/orphan-bag/',10,0,1,4);
INSERT INTO `portal_menuitem` (`id`, `caption`, `url`, `order`, `non_navigable`, `menu_id`, `parent_id`) VALUES (15,'Різдвяна свічка','actions/christmas-candle/',20,0,1,4);
INSERT INTO `portal_menuitem` (`id`, `caption`, `url`, `order`, `non_navigable`, `menu_id`, `parent_id`) VALUES (16,'Допоможи Св. Миколаю прийти до дітей-сиріт','actions/help-to-st-nicolas/',30,0,1,4);
INSERT INTO `portal_menuitem` (`id`, `caption`, `url`, `order`, `non_navigable`, `menu_id`, `parent_id`) VALUES (17,'Великодній кошик','actions/easter-basket/',40,0,1,4);
INSERT INTO `portal_menuitem` (`id`, `caption`, `url`, `order`, `non_navigable`, `menu_id`, `parent_id`) VALUES (18,'Головна','/',10,0,2,NULL);
INSERT INTO `portal_menuitem` (`id`, `caption`, `url`, `order`, `non_navigable`, `menu_id`, `parent_id`) VALUES (19,'Про нас','about-us/',20,0,2,NULL);
INSERT INTO `portal_menuitem` (`id`, `caption`, `url`, `order`, `non_navigable`, `menu_id`, `parent_id`) VALUES (20,'Партнери','partners/',30,0,2,NULL);
INSERT INTO `portal_menuitem` (`id`, `caption`, `url`, `order`, `non_navigable`, `menu_id`, `parent_id`) VALUES (21,'Контакти','contacts/',40,0,2,NULL);
INSERT INTO `portal_menuitem` (`id`, `caption`, `url`, `order`, `non_navigable`, `menu_id`, `parent_id`) VALUES (22,'Волонтерство','volunteers/',50,0,2,NULL);
INSERT INTO `portal_menuitem` (`id`, `caption`, `url`, `order`, `non_navigable`, `menu_id`, `parent_id`) VALUES (23,'Книга відгуків','book-reviews/',60,0,2,NULL);
INSERT INTO `portal_menuitem` (`id`, `caption`, `url`, `order`, `non_navigable`, `menu_id`, `parent_id`) VALUES (24,'Як допомогти','how-help/',70,0,2,NULL);
INSERT INTO `portal_menuitem` (`id`, `caption`, `url`, `order`, `non_navigable`, `menu_id`, `parent_id`) VALUES (26,'Звіти про діяльність','zvity/',90,0,2,NULL);
INSERT INTO `portal_menuitem` (`id`, `caption`, `url`, `order`, `non_navigable`, `menu_id`, `parent_id`) VALUES (27,'Анімаційна ферма','entertainment-farm/',50,0,1,NULL);

--
-- Table structure for table `portal_menuitemi18n`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portal_menuitemi18n` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `caption` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `lang_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  `menu_item_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `portal_menuitemi18n_menu_item_id_1053b465_uniq` (`menu_item_id`,`lang_id`),
  KEY `portal_menuitemi18n_lang_id_741e530e_fk_portal_language_id` (`lang_id`),
  KEY `portal_menuitemi18n_menu_id_17836332_fk_portal_menu_id` (`menu_id`),
  CONSTRAINT `portal_menuitemi18n_lang_id_741e530e_fk_portal_language_id` FOREIGN KEY (`lang_id`) REFERENCES `portal_language` (`id`),
  CONSTRAINT `portal_menuitemi18n_menu_id_17836332_fk_portal_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `portal_menu` (`id`),
  CONSTRAINT `portal_menuitemi18n_menu_item_id_3bfdc944_fk_portal_menuitem_id` FOREIGN KEY (`menu_item_id`) REFERENCES `portal_menuitem` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portal_menuitemi18n`
--


--
-- Table structure for table `portal_newsitem`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portal_newsitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `publish_date` datetime(6) NOT NULL,
  `caption` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `status` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `image` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image_small` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `origin_url` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=154 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portal_newsitem`
--


--
-- Table structure for table `portal_newsitemi18n`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portal_newsitemi18n` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `caption` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `keywords` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `anounce` longtext COLLATE utf8_unicode_ci NOT NULL,
  `body` longtext COLLATE utf8_unicode_ci NOT NULL,
  `author` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `origin` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lang_id` int(11) NOT NULL,
  `news_item_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `portal_newsitemi18n_news_item_id_52aba4dc_uniq` (`news_item_id`,`caption`),
  KEY `portal_newsitemi18n_lang_id_672dd04b_fk_portal_language_id` (`lang_id`),
  CONSTRAINT `portal_newsitemi18n_lang_id_672dd04b_fk_portal_language_id` FOREIGN KEY (`lang_id`) REFERENCES `portal_language` (`id`),
  CONSTRAINT `portal_newsitemi18n_news_item_id_10ea0a34_fk_portal_newsitem_id` FOREIGN KEY (`news_item_id`) REFERENCES `portal_newsitem` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=150 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portal_newsitemi18n`
--


--
-- Table structure for table `portal_page`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portal_page` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `publish_date` datetime(6) NOT NULL,
  `caption` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `status` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `menu_item_id` int(11) DEFAULT NULL,
  `template_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `menu_item_id` (`menu_item_id`),
  KEY `portal_page_572d4e42` (`url`),
  KEY `portal_page_74f53564` (`template_id`),
  CONSTRAINT `portal_page_menu_item_id_49c598ec_fk_portal_menuitem_id` FOREIGN KEY (`menu_item_id`) REFERENCES `portal_menuitem` (`id`),
  CONSTRAINT `portal_page_template_id_ac592dbf_fk_portal_template_id` FOREIGN KEY (`template_id`) REFERENCES `portal_template` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portal_page`
--

--
-- Table structure for table `portal_pagei18n`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portal_pagei18n` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `caption` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `keywords` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `body` longtext COLLATE utf8_unicode_ci NOT NULL,
  `lang_id` int(11) NOT NULL,
  `page_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `portal_pagei18n_lang_id_fb0d1400_fk_portal_language_id` (`lang_id`),
  KEY `portal_pagei18n_page_id_f65aefb2_fk_portal_page_id` (`page_id`),
  CONSTRAINT `portal_pagei18n_lang_id_fb0d1400_fk_portal_language_id` FOREIGN KEY (`lang_id`) REFERENCES `portal_language` (`id`),
  CONSTRAINT `portal_pagei18n_page_id_f65aefb2_fk_portal_page_id` FOREIGN KEY (`page_id`) REFERENCES `portal_page` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portal_pagei18n`
--


--
-- Table structure for table `portal_settings`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portal_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `str` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `int` int(11) DEFAULT NULL,
  `date` datetime(6) DEFAULT NULL,
  `lang_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `portal_settings_key_b2dc6471_uniq` (`key`,`lang_id`),
  KEY `portal_settings_lang_id_6bdde50b_fk_portal_language_id` (`lang_id`),
  CONSTRAINT `portal_settings_lang_id_6bdde50b_fk_portal_language_id` FOREIGN KEY (`lang_id`) REFERENCES `portal_language` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portal_settings`
--

INSERT INTO `portal_settings` (`id`, `key`, `str`, `int`, `date`, `lang_id`) VALUES (1,'news_items_per_page','',5,NULL,NULL);
INSERT INTO `portal_settings` (`id`, `key`, `str`, `int`, `date`, `lang_id`) VALUES (2,'news_page_title','Благодійний фонд Карітас Коломийськo-Чернівецької єпархії',NULL,NULL,1);
INSERT INTO `portal_settings` (`id`, `key`, `str`, `int`, `date`, `lang_id`) VALUES (3,'news_page_keywords','Благодійний фонд Карітас Коломийськo-Чернівецької єпархії, БФ Карітас',NULL,NULL,1);
INSERT INTO `portal_settings` (`id`, `key`, `str`, `int`, `date`, `lang_id`) VALUES (4,'rss_stream_title','Новини Карітас Коломия',NULL,NULL,1);
INSERT INTO `portal_settings` (`id`, `key`, `str`, `int`, `date`, `lang_id`) VALUES (5,'news_items_in_rss_streem','',10,NULL,NULL);
INSERT INTO `portal_settings` (`id`, `key`, `str`, `int`, `date`, `lang_id`) VALUES (6,'news_informet_template','caritas/news_informer.html',NULL,NULL,NULL);
INSERT INTO `portal_settings` (`id`, `key`, `str`, `int`, `date`, `lang_id`) VALUES (7,'news_page_template','caritas/index.html',NULL,NULL,NULL);
INSERT INTO `portal_settings` (`id`, `key`, `str`, `int`, `date`, `lang_id`) VALUES (8,'news_item_template','caritas/news_item.html',NULL,NULL,NULL);
INSERT INTO `portal_settings` (`id`, `key`, `str`, `int`, `date`, `lang_id`) VALUES (9,'publication_page_template','caritas/page.html',NULL,NULL,NULL);

--
-- Table structure for table `portal_template`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portal_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `path` varchar(2056) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portal_template`
--

INSERT INTO `portal_template` (`id`, `name`, `path`) VALUES (1,'guestbook','caritas/guest.html');
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed
