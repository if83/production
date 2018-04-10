-- MySQL dump 10.13  Distrib 5.7.21, for Linux (x86_64)
--
-- Host: localhost    Database: bugtrckr
-- ------------------------------------------------------
-- Server version	5.7.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `History`
--

DROP TABLE IF EXISTS `History`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `History` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `issueId` int(11) NOT NULL,
  `changedByUserId` int(11) DEFAULT NULL,
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `action` varchar(15) NOT NULL,
  `assignedToUserId` int(11) NOT NULL,
  `title` varchar(32) DEFAULT NULL,
  `type` varchar(32) DEFAULT NULL,
  `priority` varchar(32) DEFAULT NULL,
  `status` varchar(32) DEFAULT NULL,
  `description` text,
  `issuecomment` text,
  `anonymName` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `History_fk0` (`issueId`),
  CONSTRAINT `History_fk0` FOREIGN KEY (`issueId`) REFERENCES `Issue` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `History`
--

LOCK TABLES `History` WRITE;
/*!40000 ALTER TABLE `History` DISABLE KEYS */;
INSERT INTO `History` VALUES (1,1,2,'2018-02-10 20:14:55','0',6,NULL,NULL,NULL,NULL,NULL,'some changes',NULL),(2,1,3,'2018-02-10 20:14:55','1',4,NULL,NULL,NULL,'2',NULL,'some changes',NULL),(3,1,2,'2018-02-10 20:14:55','5',7,NULL,NULL,'3',NULL,NULL,'some changes',NULL);
/*!40000 ALTER TABLE `History` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Issue`
--

DROP TABLE IF EXISTS `Issue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Issue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  `type` varchar(32) NOT NULL,
  `priority` varchar(32) NOT NULL,
  `status` varchar(32) NOT NULL DEFAULT 'OPEN',
  `projectReleaseId` int(11) NOT NULL,
  `projectId` int(11) NOT NULL,
  `assigneeId` int(11) NOT NULL,
  `createdById` int(11) DEFAULT NULL,
  `createTime` datetime NOT NULL DEFAULT '2016-01-01 00:00:00',
  `dueDate` datetime DEFAULT NULL,
  `lastUpdateDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `estimateTime` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`),
  KEY `Issue_fk0` (`projectReleaseId`),
  KEY `Issue_fk1` (`assigneeId`),
  KEY `Issue_fk3` (`projectId`),
  CONSTRAINT `Issue_fk0` FOREIGN KEY (`projectReleaseId`) REFERENCES `ProjectRelease` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Issue_fk1` FOREIGN KEY (`assigneeId`) REFERENCES `User` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Issue_fk3` FOREIGN KEY (`projectId`) REFERENCES `Project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Issue`
--

LOCK TABLES `Issue` WRITE;
/*!40000 ALTER TABLE `Issue` DISABLE KEYS */;
INSERT INTO `Issue` VALUES (1,'Remove configs','TASK','LOW','IN_PROGRESS',1,1,2,2,'2016-01-01 00:00:00','2016-12-12 00:00:00','2018-02-10 20:14:54',3,1,'some text'),(2,'Fix UI in search','TASK','LOW','IN_PROGRESS',1,1,4,2,'2016-01-01 00:00:00','2016-12-12 00:00:00','2018-02-10 20:14:54',10,1,'some text'),(3,'GUI doesn`t load','BUG','LOW','INVALID',1,1,3,2,'2016-01-01 00:00:00','2016-12-12 00:00:00','2018-02-10 20:14:54',30,1,'some text'),(4,'Fix typos','TASK','LOW','OPEN',1,1,2,2,'2016-01-01 00:00:00','2016-12-12 00:00:00','2018-02-10 20:14:54',50,1,'some text'),(5,'Update libs','BUG','LOW','IN_PROGRESS',1,1,2,2,'2016-01-01 00:00:00','2016-12-12 00:00:00','2018-02-10 20:14:54',13,1,'some text'),(6,'Don`t store user','TASK','LOW','OPEN',1,1,3,5,'2016-01-01 00:00:00','2016-12-12 00:00:00','2018-02-10 20:14:54',54,1,'some text'),(7,'Slow speed','EPIC','LOW','IN_PROGRESS',1,1,2,10,'2016-01-01 00:00:00','2016-12-12 00:00:00','2018-02-10 20:14:54',3,1,'some text'),(8,'Cannot logout','TASK','LOW','QA_VALIDATION',1,1,6,2,'2016-01-01 00:00:00','2016-12-12 00:00:00','2018-02-10 20:14:54',58,1,'some text'),(9,'Add default val','TASK','LOW','IN_PROGRESS',1,1,4,4,'2016-01-01 00:00:00','2016-12-12 00:00:00','2018-02-10 20:14:54',46,1,'some text'),(10,'Fix JS','TASK','LOW','IN_PROGRESS',1,1,5,4,'2016-01-01 00:00:00','2016-12-12 00:00:00','2018-02-10 20:14:54',12,1,'some text'),(11,'Fix styles','BUG','MEDIUM','OPEN',3,1,3,4,'2016-01-01 00:00:00','2016-12-12 00:00:00','2018-02-10 20:14:54',30,2,'some text'),(12,'Remove new user','IMPROVEMENT','HIGH','OPEN',4,1,4,4,'2016-01-01 00:00:00','2016-12-12 00:00:00','2018-02-10 20:14:54',25,3,'some text'),(13,'Add some options','EPIC','CRITICAL','OPEN',3,1,3,3,'2016-01-01 00:00:00','2016-12-12 00:00:00','2018-02-10 20:14:54',5,4,'some text'),(14,'Remove pictures','TASK','BLOCKER','OPEN',4,1,4,3,'2016-01-01 00:00:00','2016-12-12 00:00:00','2018-02-10 20:14:54',15,5,'some text'),(15,'Fix Add button','BUG','MEDIUM','OPEN',3,1,3,3,'2016-01-01 00:00:00','2016-12-12 00:00:00','2018-02-10 20:14:54',30,2,'some text'),(16,'Remove pictures','IMPROVEMENT','HIGH','OPEN',4,1,4,3,'2016-01-01 00:00:00','2016-12-12 00:00:00','2018-02-10 20:14:54',25,3,'some text'),(17,'Add some new information','EPIC','CRITICAL','OPEN',3,1,3,3,'2016-01-01 00:00:00','2016-12-12 00:00:00','2018-02-10 20:14:54',5,4,'some text'),(18,'Remove fonts','TASK','BLOCKER','OPEN',4,1,4,3,'2016-01-01 00:00:00','2016-12-12 00:00:00','2018-02-10 20:14:54',15,5,'some text'),(19,'Create new folder','BUG','MEDIUM','OPEN',3,1,3,3,'2016-01-01 00:00:00','2016-12-12 00:00:00','2018-02-10 20:14:54',30,2,'some text'),(20,'Test new labels','IMPROVEMENT','HIGH','OPEN',4,1,4,3,'2016-01-01 00:00:00','2016-12-12 00:00:00','2018-02-10 20:14:54',25,3,'some text'),(21,'Move pictures','EPIC','CRITICAL','OPEN',3,1,3,3,'2016-01-01 00:00:00','2016-12-12 00:00:00','2018-02-10 20:14:54',5,4,'some text'),(22,'Change status','TASK','BLOCKER','OPEN',4,1,4,3,'2016-01-01 00:00:00','2016-12-12 00:00:00','2018-02-10 20:14:54',15,5,'some text'),(23,'Fix new issue','BUG','MEDIUM','OPEN',3,1,3,3,'2016-01-01 00:00:00','2016-12-12 00:00:00','2018-02-10 20:14:54',30,2,'some text'),(24,'add new features','IMPROVEMENT','HIGH','OPEN',4,1,4,3,'2016-01-01 00:00:00','2016-12-12 00:00:00','2018-02-10 20:14:54',25,3,'some text'),(25,'Change information','EPIC','CRITICAL','OPEN',3,1,2,3,'2016-01-01 00:00:00','2016-12-12 00:00:00','2018-02-10 20:14:55',5,4,'some text'),(26,'Modify fonts','TASK','BLOCKER','OPEN',4,1,3,3,'2016-01-01 00:00:00','2016-12-12 00:00:00','2018-02-10 20:14:55',15,5,'some text'),(27,'Optimize performance','BUG','MEDIUM','OPEN',3,1,4,3,'2016-01-01 00:00:00','2016-12-12 00:00:00','2018-02-10 20:14:55',30,2,'some text'),(28,'Test new feature','IMPROVEMENT','HIGH','OPEN',4,1,2,3,'2016-01-01 00:00:00','2016-12-12 00:00:00','2018-02-10 20:14:55',25,3,'some text'),(29,'Create a button','EPIC','CRITICAL','OPEN',3,1,3,3,'2016-01-01 00:00:00','2016-12-12 00:00:00','2018-02-10 20:14:55',5,4,'some text'),(30,'Change users','TASK','BLOCKER','OPEN',4,1,4,3,'2016-01-01 00:00:00','2016-12-12 00:00:00','2018-02-10 20:14:55',15,5,'some text');
/*!40000 ALTER TABLE `Issue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IssueComment`
--

DROP TABLE IF EXISTS `IssueComment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `IssueComment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` text NOT NULL,
  `timeStamp` datetime DEFAULT NULL,
  `issueId` int(11) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  `isEdited` tinyint(1) NOT NULL DEFAULT '0',
  `anonymousName` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IssueComments_fk0` (`issueId`),
  KEY `IssueComments_fk1` (`userId`),
  CONSTRAINT `IssueComments_fk0` FOREIGN KEY (`issueId`) REFERENCES `Issue` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `IssueComments_fk1` FOREIGN KEY (`userId`) REFERENCES `User` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `IssueComment`
--

LOCK TABLES `IssueComment` WRITE;
/*!40000 ALTER TABLE `IssueComment` DISABLE KEYS */;
/*!40000 ALTER TABLE `IssueComment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Label`
--

DROP TABLE IF EXISTS `Label`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Label` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Label`
--

LOCK TABLES `Label` WRITE;
/*!40000 ALTER TABLE `Label` DISABLE KEYS */;
INSERT INTO `Label` VALUES (1,'Java'),(2,'C#'),(3,'Python'),(4,'HTML'),(5,'CSS');
/*!40000 ALTER TABLE `Label` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Label_Issue`
--

DROP TABLE IF EXISTS `Label_Issue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Label_Issue` (
  `labelId` int(11) NOT NULL,
  `issueId` int(11) NOT NULL,
  PRIMARY KEY (`labelId`,`issueId`),
  KEY `Label_Issue_fk1` (`issueId`),
  CONSTRAINT `Label_Issue_fk0` FOREIGN KEY (`labelId`) REFERENCES `Label` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Label_Issue_fk1` FOREIGN KEY (`issueId`) REFERENCES `Issue` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Label_Issue`
--

LOCK TABLES `Label_Issue` WRITE;
/*!40000 ALTER TABLE `Label_Issue` DISABLE KEYS */;
INSERT INTO `Label_Issue` VALUES (1,1),(3,1),(5,1),(1,2),(4,2);
/*!40000 ALTER TABLE `Label_Issue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Project`
--

DROP TABLE IF EXISTS `Project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Project` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(20) NOT NULL,
  `guestView` tinyint(1) NOT NULL,
  `guestCreateIssues` tinyint(1) NOT NULL,
  `guestAddComment` tinyint(1) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Project`
--

LOCK TABLES `Project` WRITE;
/*!40000 ALTER TABLE `Project` DISABLE KEYS */;
INSERT INTO `Project` VALUES (1,'BugTrckr',1,1,1,' Esse forensibus sententiae ut vel, pri te meis lucilius conceptam. Sumo evertitur ea per, populo aliquip dolores ei vis. Blandit expetendis no duo, augue nostro labitur te usu. Nam ne iriure aperiam. In veritus signiferumque quo, mea no alii fuisset, has in ipsum invidunt. Ei vero animal sea, et vix quaestio iudicabit signiferumque. Est ut alienum inimicus, enim dicat ea mea. His tantas semper argumentum ei, dictas admodum intellegam pri ad, alienum constituto repudiandae vix ex. Qui eros deseruisse ei, ad natum ludus scriptorem per, in vel lobortis salutandi prodesset. Accusamus patrioque nam in. Habemus adipisci eu est, has everti mollis voluptatibus at. Assum volutpat usu ei. Duo ex consulatu instructior, id dicta fierent mediocrem sed, mutat interpretaris te pri. Oratio sapientem adolescens ius id, an molestiae abhorreant eum, his suas dicit definitionem ut. Ut zril.'),(2,'Newhow',1,1,0,'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusamus architecto dolor illum incidunt ipsa magnam, numquam perferendis quae quos ut? architecto dolor illum incidunt ipsa magnam, numquam perferendis quae quos ut? Ducimus eaque quis quos.'),(3,'U-dincon',0,0,0,'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusamus architecto dolor illum incidunt ipsa magnam, numquam perferendis quae quos ut? Ducimus eaque quis quos.'),(4,'Zuming ',0,0,0,'description to project 2'),(5,'Bamcare',1,1,0,'Bamcare description'),(6,'Rocky Railroad',1,0,1,'Rocky Railroad description'),(7,'Faxgreen',1,0,1,'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusamus architecto dolor illum incidunt ipsa magnam, numquam perferendis quae quos ut? Ducimus eaque quis quos.'),(8,'Zimcone',1,0,1,'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusamus architecto dolor illum incidunt ipsa magnam, numquam perferendis quae quos ut? Ducimus eaque quis quos.'),(9,'Joyware',0,0,0,'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusamus architecto dolor illum incidunt ipsa magnam, numquam perferendis quae quos ut? Ducimus eaque quis quos.'),(10,'Codetex',1,1,1,'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusamus architecto dolor illum incidunt ipsa magnam, numquam perferendis quae quos ut? Ducimus eaque quis quos.'),(11,'Blue Smoke',1,1,1,'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusamus architecto dolor illum incidunt ipsa magnam, numquam perferendis quae quos ut? Ducimus eaque quis quos.'),(12,'Strongfase',1,1,0,'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusamus architecto dolor illum incidunt ipsa magnam, numquam perferendis quae quos ut? Ducimus eaque quis quos.'),(13,'Freelam',1,1,1,'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusamus architecto dolor illum incidunt ipsa magnam, numquam perferendis quae quos ut? Ducimus eaque quis quos.'),(14,'Lucky Fox',0,0,0,'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusamus architecto dolor illum incidunt ipsa magnam, numquam perferendis quae quos ut? Ducimus eaque quis quos.'),(15,'Zathcan',0,0,0,'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusamus architecto dolor illum incidunt ipsa magnam, numquam perferendis quae quos ut? Ducimus eaque quis quos.'),(16,'Whiteline',1,0,1,'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusamus architecto dolor illum incidunt ipsa magnam, numquam perferendis quae quos ut? Ducimus eaque quis quos.'),(17,'Gamma',1,0,0,'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusamus architecto dolor illum incidunt ipsa magnam, numquam perferendis quae quos ut? Ducimus eaque quis quos.'),(18,'Plexfi',1,1,0,'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusamus architecto dolor illum incidunt ipsa magnam, numquam perferendis quae quos ut? Ducimus eaque quis quos.'),(19,'Spantanhow',0,0,0,'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusamus architecto dolor illum incidunt ipsa magnam, numquam perferendis quae quos ut? Ducimus eaque quis quos.'),(20,'Eager Cloud',1,0,1,'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusamus architecto dolor illum incidunt ipsa magnam, numquam perferendis quae quos ut? Ducimus eaque quis quos.'),(21,'ganzphase',1,1,1,'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusamus architecto dolor illum incidunt ipsa magnam, numquam perferendis quae quos ut? Ducimus eaque quis quos.');
/*!40000 ALTER TABLE `Project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectRelease`
--

DROP TABLE IF EXISTS `ProjectRelease`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProjectRelease` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `projectId` int(11) NOT NULL,
  `version` varchar(32) NOT NULL,
  `releaseStatus` varchar(11) NOT NULL DEFAULT 'OPEN',
  `description` text,
  PRIMARY KEY (`id`),
  KEY `ProjectRelease_fk0` (`projectId`),
  CONSTRAINT `ProjectRelease_fk0` FOREIGN KEY (`projectId`) REFERENCES `Project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectRelease`
--

LOCK TABLES `ProjectRelease` WRITE;
/*!40000 ALTER TABLE `ProjectRelease` DISABLE KEYS */;
INSERT INTO `ProjectRelease` VALUES (1,1,'v1.0.0','CLOSED','Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusamus ncidunt sit amet, consectetur adipisicing ipsa magnam architecto dolor illum i, numquam illum incidunt ipsa magnam, numquam perferendis  perferendis quae quos ut? Ducimus eaque  Accusamus architecto dolor illum incidunt ipsa magnam, numquam perferendis quae quos ut? Ducimus eaque quis quos. '),(2,1,'v1.2.0','CLOSED','Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusantium adipisci aperiam assumenda at aut corporis cumque cupiditate doloremque, earum error facilis inventore iste laboriosam magni, natus non officiis placeat quis rem sequi sit suscipit tenetur voluptate? Molestias perspiciatis reiciendis voluptatem! '),(3,1,'v2.0.0','IN_PROGRESS','Adipisci autem cupiditate deleniti deserunt ducimus ex itaque mollitia non odio repellendus.'),(4,1,'v2.1.0','IN_PROGRESS','Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet architecto corporis deleniti dolores, eos error esse excepturi explicabo harum inventore molestiae obcaecati porro quia quisquam repudiandae, sed veniam voluptas voluptates.'),(5,1,'v3.0.0 Beta','OPEN','Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet architecto corporis deleniti dolores, eos error esse excepturi explicabo harum inventore molestiae obcaecati porro quia quisquam repudiandae, sed veniam voluptas voluptates.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet architecto corporis deleniti dolores, eos error esse excepturi explicabo.'),(6,1,'v3.0.0 Rel. cand.','OPEN','Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet architecto corporis deleniti dolores, eos error esse excepturi explicabo harum inventore molestiae obcaecati porro quia quisquam repudiandae, sed veniam voluptas voluptates.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet architecto corporis deleniti dolores, eos error esse excepturi explicabo.'),(7,1,'v3.0.0','CLOSED','Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet architecto corporis deleniti dolores, eos error esse excepturi explicabo harum inventore molestiae obcaecati porro quia quisquam repudiandae, sed veniam voluptas voluptates.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet architecto corporis deleniti dolores, eos error esse excepturi explicabo.'),(8,1,'v3.1.2','IN_PROGRESS','Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet architecto corporis deleniti dolores, eos error esse excepturi explicabo harum inventore molestiae obcaecati porro quia quisquam repudiandae, sed veniam voluptas voluptates.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet architecto corporis deleniti dolores, eos error esse excepturi explicabo.'),(9,1,'v3.2.0','CLOSED','Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet architecto corporis deleniti dolores, eos error esse excepturi explicabo harum inventore molestiae obcaecati porro quia quisquam repudiandae, sed veniam voluptas voluptates.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet architecto corporis deleniti dolores, eos error esse excepturi explicabo.'),(10,1,'v3.3.0 Beta 1','OPEN','Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet architecto corporis deleniti dolores, eos error esse excepturi explicabo harum inventore molestiae obcaecati porro quia quisquam repudiandae, sed veniam voluptas voluptates.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet architecto corporis deleniti dolores, eos error esse excepturi explicabo.'),(11,1,'v3.3.0 Beta 2','CLOSED','Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet architecto corporis deleniti dolores, eos error esse excepturi explicabo harum inventore molestiae obcaecati porro quia quisquam repudiandae, sed veniam voluptas voluptates.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet architecto corporis deleniti dolores, eos error esse excepturi explicabo.'),(12,1,'v3.4.0 Rel. cand.','CLOSED','Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet architecto corporis deleniti dolores, eos error esse excepturi explicabo harum inventore molestiae obcaecati porro quia quisquam repudiandae, sed veniam voluptas voluptates.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet architecto corporis deleniti dolores, eos error esse excepturi explicabo.'),(13,1,'v3.4.1','OPEN','Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet architecto corporis deleniti dolores, eos error esse excepturi explicabo harum inventore molestiae obcaecati porro quia quisquam repudiandae, sed veniam voluptas voluptates.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet architecto corporis deleniti dolores, eos error esse excepturi explicabo.'),(14,1,'v3.4.2','OPEN','Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet architecto corporis deleniti dolores, eos error esse excepturi explicabo harum inventore molestiae obcaecati porro quia quisquam repudiandae, sed veniam voluptas voluptates.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet architecto corporis deleniti dolores, eos error esse excepturi explicabo.'),(15,1,'v4.0.0 Rel. cand.','OPEN','Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet architecto corporis deleniti dolores, eos error esse excepturi explicabo harum inventore molestiae obcaecati porro quia quisquam repudiandae, sed veniam voluptas voluptates.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet architecto corporis deleniti dolores, eos error esse excepturi explicabo.'),(16,1,'v4.0.0','OPEN','Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet architecto corporis deleniti dolores, eos error esse excepturi explicabo harum inventore molestiae obcaecati porro quia quisquam repudiandae, sed veniam voluptas voluptates.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet architecto corporis deleniti dolores, eos error esse excepturi explicabo.'),(17,2,'2','OPEN','RELEASE 2'),(18,3,'3','OPEN','RELEASE 3'),(19,4,'4','OPEN','RELEASE 4');
/*!40000 ALTER TABLE `ProjectRelease` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `User` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(20) NOT NULL,
  `lastName` varchar(20) NOT NULL,
  `email` varchar(32) NOT NULL,
  `password` varchar(60) NOT NULL,
  `role` varchar(20) NOT NULL,
  `projectId` int(11) DEFAULT NULL,
  `description` text,
  `isDeleted` tinyint(1) NOT NULL DEFAULT '0',
  `enabled` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `User_fk0` (`projectId`),
  CONSTRAINT `User_fk0` FOREIGN KEY (`projectId`) REFERENCES `Project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES (1,'admin','admin','admin@ss.com','$2a$12$r.6YLln22ky5r5Wlb38iZ.v2fG30U/77of3CrsWkL4rJGTo3NwW86','ROLE_ADMIN',NULL,'first',0,1),(2,'Sergey','Brin','manager@ss.com','$2a$12$xic5wp8Nbgq2gyZtr/K0eevVPYzH/6XnEhOof4WSyChayZgN.unom','ROLE_PROJECT_MANAGER',1,'pm',0,1),(3,'Larry','Ellison','developer@ss.com','$2a$12$gKyrJQIWc6Q7EQXv9feAKOKnMf/DZWnNxn.5IzoBD2YBK/nVRFRV2','ROLE_DEVELOPER',1,'developer',0,1),(4,'Vint','Cerf','quality_e@ss.com','$2a$12$bTRBMwG6lnCVzvVD4YuyGuIJu4uF3lOaaY/48mo5hoeSjpe5w.JHG','ROLE_QA',1,'qa',0,1),(5,'Richard','Stallman','developer23@ss.com','$2a$12$xic5wp8Nbgq2gyZtr/K0eevVPYzH/6XnEhOof4WSyChayZgN.unom','ROLE_DEVELOPER',1,'dev',0,1),(6,'Ken','Thompson','developer24@ss.com','$2a$12$xic5wp8Nbgq2gyZtr/K0eevVPYzH/6XnEhOof4WSyChayZgN.unom','ROLE_DEVELOPER',1,'qa',0,1),(7,'Ada','Lovelace','developer249@ss.com','$2a$12$xic5wp8Nbgq2gyZtr/K0eevVPYzH/6XnEhOof4WSyChayZgN.unom','ROLE_DEVELOPER',1,'qa',0,1),(8,'Tim','Bray','dev112@ss.com','$2a$12$xic5wp8Nbgq2gyZtr/K0eevVPYzH/6XnEhOof4WSyChayZgN.unom','ROLE_QA',1,'qa',0,1),(9,'John','Carmack','developer224@ss.com','$2a$12$xic5wp8Nbgq2gyZtr/K0eevVPYzH/6XnEhOof4WSyChayZgN.unom','ROLE_DEVELOPER',1,'qa',0,1),(10,'Kristina','Vasquez','manager1@ss.com','$2a$12$r.6YLln22ky5r5Wlb38iZ.v2fG30U/77of3CrsWkL4rJGTo3NwW86','ROLE_PROJECT_MANAGER',2,'pm',0,1),(11,'Yvonne','Stevenson','developer1@ss.com','$2a$12$r.6YLln22ky5r5Wlb38iZ.v2fG30U/77of3CrsWkL4rJGTo3NwW86','ROLE_DEVELOPER',2,'developer',0,1),(12,'Justin','	Mills','quality_e1@ss.com','$2a$12$bTRBMwG6lnCVzvVD4YuyGuIJu4uF3lOaaY/48mo5hoeSjpe5w.JHG','ROLE_QA',2,'qa',0,1),(13,'Dallas','Morgan','manager2@ss.com','$2a$12$r.6YLln22ky5r5Wlb38iZ.v2fG30U/77of3CrsWkL4rJGTo3NwW86','ROLE_PROJECT_MANAGER',3,'pm',0,1),(14,'Emily','Reyes','developer2@ss.com','$2a$12$r.6YLln22ky5r5Wlb38iZ.v2fG30U/77of3CrsWkL4rJGTo3NwW86','ROLE_DEVELOPER',3,'developer',0,1),(15,'Lisa','Maldonado','quality_e2@ss.com','$2a$12$bTRBMwG6lnCVzvVD4YuyGuIJu4uF3lOaaY/48mo5hoeSjpe5w.JHG','ROLE_QA',3,'qa',0,1),(16,'Henrietta','Alvarado','manager3@ss.com','$2a$12$xic5wp8Nbgq2gyZtr/K0eevVPYzH/6XnEhOof4WSyChayZgN.unom','ROLE_PROJECT_MANAGER',4,'pm',0,1),(17,'Danny','Greene','developer3@ss.com','$2a$12$gKyrJQIWc6Q7EQXv9feAKOKnMf/DZWnNxn.5IzoBD2YBK/nVRFRV2','ROLE_DEVELOPER',4,'developer',0,1),(18,'Eva','Beck','quality_e3@ss.com','$2a$12$bTRBMwG6lnCVzvVD4YuyGuIJu4uF3lOaaY/48mo5hoeSjpe5w.JHG','ROLE_QA',4,'qa',0,1),(19,'Everett','Bishop','user1@ss.com','$2a$12$4f.T2qhKX9a4EUaN5otL4uAVIPYpO9yHu1nXM7CHf71sJnicp2oxy','ROLE_DEVELOPER',1,'user1',0,1),(20,'Jamie','Payne','user2@ss.com','$2a$12$4f.T2qhKX9a4EUaN5otL4uAVIPYpO9yHu1nXM7CHf71sJnicp2oxy','ROLE_DEVELOPER',1,'user2',0,1),(21,'Alvin','Pittman','user3@ss.com','$2a$12$4f.T2qhKX9a4EUaN5otL4uAVIPYpO9yHu1nXM7CHf71sJnicp2oxy','ROLE_DEVELOPER',1,'user3',0,1),(22,'Noah','Singleton','user4@ss.com','$2a$12$4f.T2qhKX9a4EUaN5otL4uAVIPYpO9yHu1nXM7CHf71sJnicp2oxy','ROLE_DEVELOPER',1,'user4',0,1),(23,'Orlando','Gordon','user5@ss.com','$2a$12$4f.T2qhKX9a4EUaN5otL4uAVIPYpO9yHu1nXM7CHf71sJnicp2oxy','ROLE_QA',1,'user5',0,1),(24,'Barry','Hopkins','guest1@ss.com','$2a$12$xcB0vHLRtCas3kNsZszwpewlCE35Zlc37fB4ZUJVDG9qiXlPyHxL6','ROLE_QA',1,'guest1',0,1),(25,'Nelson','Williams','guest2@ss.com','$2a$12$xcB0vHLRtCas3kNsZszwpewlCE35Zlc37fB4ZUJVDG9qiXlPyHxL6','ROLE_USER',NULL,'guest2',0,1),(26,'Leland','Joseph','guest3@ss.com','$2a$12$xcB0vHLRtCas3kNsZszwpewlCE35Zlc37fB4ZUJVDG9qiXlPyHxL6','ROLE_USER',NULL,'guest3',0,1),(27,'Felipe','Swanson','guest4@ss.com','$2a$12$xcB0vHLRtCas3kNsZszwpewlCE35Zlc37fB4ZUJVDG9qiXlPyHxL6','ROLE_USER',NULL,'guest4',0,1),(28,'Orville','Mullins','guest5@ss.com','$2a$12$xcB0vHLRtCas3kNsZszwpewlCE35Zlc37fB4ZUJVDG9qiXlPyHxL6','ROLE_USER',NULL,'guest5',0,1),(29,'Irving','Page','guest6@ss.com','$2a$12$xcB0vHLRtCas3kNsZszwpewlCE35Zlc37fB4ZUJVDG9qiXlPyHxL6','ROLE_USER',NULL,'guest6',0,1),(30,'Joshua','Rose','guest7@ss.com','$2a$12$xcB0vHLRtCas3kNsZszwpewlCE35Zlc37fB4ZUJVDG9qiXlPyHxL6','ROLE_USER',NULL,'guest7',0,1),(31,'Javier','Manning','user6@ss.com','$2a$12$4f.T2qhKX9a4EUaN5otL4uAVIPYpO9yHu1nXM7CHf71sJnicp2oxy','ROLE_USER',NULL,'user6',0,1),(32,'Seth','Lucas','user7@ss.com','$2a$12$4f.T2qhKX9a4EUaN5otL4uAVIPYpO9yHu1nXM7CHf71sJnicp2oxy','ROLE_USER',NULL,'user7',0,1),(33,'Raul','Jenkins','user8@ss.com','$2a$12$4f.T2qhKX9a4EUaN5otL4uAVIPYpO9yHu1nXM7CHf71sJnicp2oxy','ROLE_USER',NULL,'user8',0,1),(34,'Enrique','Ross','user9@ss.com','$2a$12$4f.T2qhKX9a4EUaN5otL4uAVIPYpO9yHu1nXM7CHf71sJnicp2oxy','ROLE_USER',NULL,'user9',1,1),(35,'Jake','Wallace','user10@ss.com','$2a$12$4f.T2qhKX9a4EUaN5otL4uAVIPYpO9yHu1nXM7CHf71sJnicp2oxy','ROLE_USER',NULL,'user10',1,1),(36,'Homer','Gregory','user11@ss.com','$2a$12$4f.T2qhKX9a4EUaN5otL4uAVIPYpO9yHu1nXM7CHf71sJnicp2oxy','ROLE_USER',NULL,'user11',1,1),(37,'Wendell','Craig','user12@ss.com','$2a$12$4f.T2qhKX9a4EUaN5otL4uAVIPYpO9yHu1nXM7CHf71sJnicp2oxy','ROLE_USER',NULL,'user12',0,1),(38,'Carroll','Gomez','user13@ss.com','$2a$12$4f.T2qhKX9a4EUaN5otL4uAVIPYpO9yHu1nXM7CHf71sJnicp2oxy','ROLE_USER',NULL,'user13',0,1),(39,'Kelly','Abbott','user14@ss.com','$2a$12$4f.T2qhKX9a4EUaN5otL4uAVIPYpO9yHu1nXM7CHf71sJnicp2oxy','ROLE_USER',NULL,'user14',0,1),(40,'Sean','Smith','user15@ss.com','$2a$12$4f.T2qhKX9a4EUaN5otL4uAVIPYpO9yHu1nXM7CHf71sJnicp2oxy','ROLE_USER',NULL,'user15',0,1),(41,'Elmer','Howard','user16@ss.com','$2a$12$4f.T2qhKX9a4EUaN5otL4uAVIPYpO9yHu1nXM7CHf71sJnicp2oxy','ROLE_USER',NULL,'user16',0,1),(42,'Kent','Brock','user17@ss.com','$2a$12$4f.T2qhKX9a4EUaN5otL4uAVIPYpO9yHu1nXM7CHf71sJnicp2oxy','ROLE_USER',NULL,'user17',0,1),(43,'Rogelio','Greer','user18@ss.com','$2a$12$4f.T2qhKX9a4EUaN5otL4uAVIPYpO9yHu1nXM7CHf71sJnicp2oxy','ROLE_USER',NULL,'user18',0,1),(44,'Raymond','Cole','user19@ss.com','$2a$12$4f.T2qhKX9a4EUaN5otL4uAVIPYpO9yHu1nXM7CHf71sJnicp2oxy','ROLE_USER',NULL,'user19',0,1),(45,'Dana','Santos','user20@ss.com','$2a$12$4f.T2qhKX9a4EUaN5otL4uAVIPYpO9yHu1nXM7CHf71sJnicp2oxy','ROLE_USER',NULL,'user20',0,1),(46,'Luther','Boone','user21@ss.com','$2a$12$4f.T2qhKX9a4EUaN5otL4uAVIPYpO9yHu1nXM7CHf71sJnicp2oxy','ROLE_USER',NULL,'user21',0,1),(47,'Charlie','Wagner','user22@ss.com','$2a$12$4f.T2qhKX9a4EUaN5otL4uAVIPYpO9yHu1nXM7CHf71sJnicp2oxy','ROLE_USER',NULL,'user22',0,1),(48,'Anthony','Patton','user23@ss.com','$2a$12$4f.T2qhKX9a4EUaN5otL4uAVIPYpO9yHu1nXM7CHf71sJnicp2oxy','ROLE_USER',NULL,'user23',0,1),(49,'Preston','Ray','user24@ss.com','$2a$12$4f.T2qhKX9a4EUaN5otL4uAVIPYpO9yHu1nXM7CHf71sJnicp2oxy','ROLE_USER',NULL,'user24',0,1),(50,'Malcolm','Waters','user25@ss.com','$2a$12$7f.T2qhKX9a4EUaN5otL4uAVIPYpO9yHu1nXM7CHf71sJnicp2oxy','ROLE_USER',NULL,'user25',0,1),(51,'Chris','Morris','user26@ss.com','$2a$12$3f.T2qhKX9a4EUaN5otL4uAVIPYpO9yHu1nXM7CHf71sJnicp2oxy','ROLE_USER',NULL,'user26',0,1),(52,'Guy','Wong','user27@ss.com','$2a$12$4f.T2qhKX9a4EUaN5otL4uAVIPYpO9yHu1nXM7CHf71sJnicp2oxy','ROLE_USER',NULL,'user27',0,1),(53,'user28','user28','user28@ss.com','$2a$12$7f.T2qhKX9a4EUaN5otL4uAVIPYpO9yHu1nXM7CHf71sJnicp2oxy','ROLE_USER',NULL,'user28',0,1),(54,'Stephen','Rhodes','user29@ss.com','$2a$12$3f.T2qhKX9a4EUaN5otL4uAVIPYpO9yHu1nXM7CHf71sJnicp2oxy','ROLE_USER',NULL,'user29',0,1),(55,'Kay','Mcdonald','developer8@ss.com','$2a$12$gKyrJQIWc6Q7EQXv9feAKOKnMf/DZWnNxn.5IzoBD2YBK/nVRFRV2','ROLE_USER',NULL,'developer8',1,1),(56,'Lula','Barnes','developer9@ss.com','$2a$12$gKyrJQIWc6Q7EQXv9feAKOKnMf/DZWnNxn.5IzoBD2YBK/nVRFRV2','ROLE_USER',NULL,'developer9',1,1),(57,'Darnell','Webster','developer10@ss.com','$2a$12$gKyrJQIWc6Q7EQXv9feAKOKnMf/DZWnNxn.5IzoBD2YBK/nVRFRV2','ROLE_USER',NULL,'developer10',1,1),(58,'Randall','Rose','manager7@ss.com','$2a$12$xic5wp8Nbgq2gyZtr/K0eevVPYzH/6XnEhOof4WSyChayZgN.unom','ROLE_USER',NULL,'pm',1,1),(59,'Justin','George','manager8@ss.com','$2a$12$xic5wp8Nbgq2gyZtr/K0eevVPYzH/6XnEhOof4WSyChayZgN.unom','ROLE_USER',NULL,'pm',1,1),(60,'Jody','Hudson','developer124@ss.com','$2a$12$gKyrJQIWc6Q7EQXv9feAKOKnMf/DZWnNxn.5IzoBD2YBK/nVRFRV2','ROLE_USER',NULL,'developer8',1,1),(61,'Melody','Webb','developer127@ss.com','$2a$12$gKyrJQIWc6Q7EQXv9feAKOKnMf/DZWnNxn.5IzoBD2YBK/nVRFRV2','ROLE_USER',NULL,'developer8',1,1);
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WorkLog`
--

DROP TABLE IF EXISTS `WorkLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `WorkLog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `issueId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `startDate` datetime NOT NULL,
  `endDate` datetime NOT NULL,
  `amountOfTime` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `WorkLog_fk0` (`issueId`),
  KEY `WorkLog_fk1` (`userId`),
  CONSTRAINT `WorkLog_fk0` FOREIGN KEY (`issueId`) REFERENCES `Issue` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `WorkLog_fk1` FOREIGN KEY (`userId`) REFERENCES `User` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WorkLog`
--

LOCK TABLES `WorkLog` WRITE;
/*!40000 ALTER TABLE `WorkLog` DISABLE KEYS */;
/*!40000 ALTER TABLE `WorkLog` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-02-17 20:15:36
