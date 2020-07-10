-- MySQL dump 10.13  Distrib 5.5.21, for Win32 (x86)
--
-- Host: localhost    Database: hotel
-- ------------------------------------------------------
-- Server version	5.5.21-log

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
-- Table structure for table `adres_h`
--

DROP TABLE IF EXISTS `adres_h`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adres_h` (
  `id_a` int(11) NOT NULL AUTO_INCREMENT,
  `miasto` varchar(30) NOT NULL,
  `ulica` varchar(30) NOT NULL,
  `nr_a` varchar(3) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id_a`),
  CONSTRAINT `adres_h_ibfk_1` FOREIGN KEY (`id_a`) REFERENCES `hotele` (`id_h`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adres_h`
--

LOCK TABLES `adres_h` WRITE;
/*!40000 ALTER TABLE `adres_h` DISABLE KEYS */;
INSERT INTO `adres_h` VALUES (1,'Warszawa','Szeroka','7'),(2,'Kraków','Wąska','2');
/*!40000 ALTER TABLE `adres_h` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotele`
--

DROP TABLE IF EXISTS `hotele`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hotele` (
  `id_h` int(11) NOT NULL AUTO_INCREMENT,
  `nazwa` varchar(26) CHARACTER SET latin1 NOT NULL,
  `email` varchar(40) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id_h`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotele`
--

LOCK TABLES `hotele` WRITE;
/*!40000 ALTER TABLE `hotele` DISABLE KEYS */;
INSERT INTO `hotele` VALUES (1,'Mokoszowski','Mokoszowski@wp.pl'),(2,'Kasztanowski','Kasztanowski@wp.pl');
/*!40000 ALTER TABLE `hotele` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `klienci`
--

DROP TABLE IF EXISTS `klienci`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `klienci` (
  `id_k` int(11) NOT NULL AUTO_INCREMENT,
  `imię` varchar(30) NOT NULL,
  `nazwisko` varchar(30) NOT NULL,
  `telefon` varchar(9) CHARACTER SET latin1 NOT NULL,
  `ilość_wizyt` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_k`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `klienci`
--

LOCK TABLES `klienci` WRITE;
/*!40000 ALTER TABLE `klienci` DISABLE KEYS */;
INSERT INTO `klienci` VALUES (1,'Karol','Niedźwiedź','945455454',NULL),(2,'Karolina','Ryś','111111111',NULL),(3,'Natalia','Pruch','294245678',NULL),(5,'Karolina','Niewaszka','124214241',NULL);
/*!40000 ALTER TABLE `klienci` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pokoje`
--

DROP TABLE IF EXISTS `pokoje`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pokoje` (
  `nr` int(11) NOT NULL,
  `pakiet` enum('premium','standard','all inclusive') CHARACTER SET latin1 NOT NULL,
  `cena` int(10) unsigned NOT NULL,
  `id_p` int(11) NOT NULL AUTO_INCREMENT,
  `id_h` int(11) NOT NULL,
  PRIMARY KEY (`id_p`),
  UNIQUE KEY `hotel_pokoj` (`id_h`,`nr`),
  CONSTRAINT `pokoje_ibfk_1` FOREIGN KEY (`id_h`) REFERENCES `hotele` (`id_h`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pokoje`
--

LOCK TABLES `pokoje` WRITE;
/*!40000 ALTER TABLE `pokoje` DISABLE KEYS */;
INSERT INTO `pokoje` VALUES (1,'premium',50,1,1),(2,'premium',75,3,1),(3,'premium',85,4,1),(4,'standard',100,5,1),(5,'standard',130,6,1),(6,'all inclusive',150,7,1),(1,'premium',45,14,2),(2,'premium',55,15,2),(3,'premium',65,16,2),(4,'standard',90,17,2),(5,'standard',100,18,2),(6,'all inclusive',125,19,2);
/*!40000 ALTER TABLE `pokoje` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pokoje_pracownicy`
--

DROP TABLE IF EXISTS `pokoje_pracownicy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pokoje_pracownicy` (
  `id_mix` int(11) NOT NULL AUTO_INCREMENT,
  `id_p` int(11) NOT NULL,
  `id_pokoju` int(11) NOT NULL,
  `od` date NOT NULL,
  `do` date NOT NULL,
  PRIMARY KEY (`id_mix`),
  KEY `id_p` (`id_p`),
  KEY `id_pokoju` (`id_pokoju`),
  CONSTRAINT `pokoje_pracownicy_ibfk_2` FOREIGN KEY (`id_p`) REFERENCES `pracownicy` (`id_p`),
  CONSTRAINT `pokoje_pracownicy_ibfk_3` FOREIGN KEY (`id_pokoju`) REFERENCES `pokoje` (`id_p`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pokoje_pracownicy`
--

LOCK TABLES `pokoje_pracownicy` WRITE;
/*!40000 ALTER TABLE `pokoje_pracownicy` DISABLE KEYS */;
INSERT INTO `pokoje_pracownicy` VALUES (38,1,1,'2020-07-01','2021-07-01'),(39,1,3,'2020-07-01','2021-07-01'),(40,1,4,'2020-07-01','2021-07-01'),(41,1,5,'2020-07-01','2021-07-01'),(42,1,6,'2020-07-01','2021-07-01'),(43,1,7,'2020-07-01','2021-07-01'),(44,2,14,'2020-07-01','2021-07-01'),(45,2,15,'2020-07-01','2021-07-01'),(46,2,16,'2020-07-01','2021-07-01'),(47,2,17,'2020-07-01','2021-07-01'),(48,2,18,'2020-07-01','2021-07-01'),(49,2,19,'2020-07-01','2021-07-01'),(50,3,1,'2020-07-01','2021-07-01'),(51,3,3,'2020-07-01','2021-07-01'),(52,3,4,'2020-07-01','2021-07-01'),(53,3,5,'2020-07-01','2021-07-01'),(54,3,6,'2020-07-01','2021-07-01'),(55,3,7,'2020-07-01','2021-07-01'),(56,3,14,'2020-07-01','2021-07-01'),(57,3,15,'2020-07-01','2021-07-01'),(58,3,16,'2020-07-01','2021-07-01'),(59,3,17,'2020-07-01','2021-07-01'),(60,3,18,'2020-07-01','2021-07-01'),(61,3,19,'2020-07-01','2021-07-01');
/*!40000 ALTER TABLE `pokoje_pracownicy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pokoje_rezerwacje`
--

DROP TABLE IF EXISTS `pokoje_rezerwacje`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pokoje_rezerwacje` (
  `id_mix` int(11) NOT NULL AUTO_INCREMENT,
  `id_r` int(11) NOT NULL,
  `id_p` int(11) NOT NULL,
  PRIMARY KEY (`id_mix`),
  KEY `id_r` (`id_r`),
  KEY `id_p` (`id_p`),
  CONSTRAINT `pokoje_rezerwacje_ibfk_1` FOREIGN KEY (`id_r`) REFERENCES `rezerwacje` (`id_r`),
  CONSTRAINT `pokoje_rezerwacje_ibfk_2` FOREIGN KEY (`id_p`) REFERENCES `pokoje` (`id_p`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pokoje_rezerwacje`
--

LOCK TABLES `pokoje_rezerwacje` WRITE;
/*!40000 ALTER TABLE `pokoje_rezerwacje` DISABLE KEYS */;
INSERT INTO `pokoje_rezerwacje` VALUES (20,11,3),(21,12,1),(22,13,4),(24,15,5),(25,16,16),(27,18,7),(28,19,5),(29,20,5),(30,21,16),(31,22,3),(32,23,14),(33,24,1),(34,25,1),(35,26,1);
/*!40000 ALTER TABLE `pokoje_rezerwacje` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pracownicy`
--

DROP TABLE IF EXISTS `pracownicy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pracownicy` (
  `id_p` int(11) NOT NULL AUTO_INCREMENT,
  `imię` varchar(30) NOT NULL,
  `nazwisko` varchar(30) NOT NULL,
  `stanowisko` enum('pokojówka','recepcjonista','kucharz','tragarz') CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id_p`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pracownicy`
--

LOCK TABLES `pracownicy` WRITE;
/*!40000 ALTER TABLE `pracownicy` DISABLE KEYS */;
INSERT INTO `pracownicy` VALUES (1,'Tomek','Kalosz','pokojówka'),(2,'Diana','Widmo','recepcjonista'),(3,'Derek','Kot','kucharz');
/*!40000 ALTER TABLE `pracownicy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rezerwacje`
--

DROP TABLE IF EXISTS `rezerwacje`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rezerwacje` (
  `id_r` int(11) NOT NULL AUTO_INCREMENT,
  `zniżka` enum('T','F') CHARACTER SET latin1 NOT NULL DEFAULT 'F',
  `id_k` int(11) NOT NULL,
  `zakończono` enum('T','F') CHARACTER SET latin1 NOT NULL DEFAULT 'F',
  `od` date NOT NULL,
  `do` date NOT NULL,
  `opinia` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_r`),
  KEY `id_k` (`id_k`),
  CONSTRAINT `rezerwacje_ibfk_2` FOREIGN KEY (`id_k`) REFERENCES `klienci` (`id_k`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rezerwacje`
--

LOCK TABLES `rezerwacje` WRITE;
/*!40000 ALTER TABLE `rezerwacje` DISABLE KEYS */;
INSERT INTO `rezerwacje` VALUES (11,'F',2,'T','2020-07-08','2020-07-08',NULL),(12,'F',2,'F','2020-07-08','2020-07-08',NULL),(13,'F',1,'T','2020-07-08','2020-07-08',NULL),(15,'F',1,'F','2020-07-08','2020-07-08',NULL),(16,'F',1,'T','2020-07-08','2020-07-08',NULL),(18,'F',2,'T','2020-07-08','2020-07-08',NULL),(19,'F',2,'T','2020-07-08','2020-07-08',NULL),(20,'F',5,'F','2020-07-08','2020-07-08',NULL),(21,'F',5,'T','2020-07-08','2020-07-08',NULL),(22,'F',3,'F','2020-07-08','2020-07-08',NULL),(23,'F',1,'T','2020-07-08','2020-07-08',NULL),(24,'F',1,'T','2020-07-09','2020-07-24',NULL),(25,'F',1,'T','2020-07-25','2020-07-28',NULL),(26,'F',1,'F','2020-07-09','2020-07-09',NULL);
/*!40000 ALTER TABLE `rezerwacje` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `telefony`
--

DROP TABLE IF EXISTS `telefony`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `telefony` (
  `numer` char(9) NOT NULL,
  `id_h` int(11) NOT NULL,
  PRIMARY KEY (`numer`),
  KEY `id_h` (`id_h`),
  CONSTRAINT `telefony_ibfk_1` FOREIGN KEY (`id_h`) REFERENCES `hotele` (`id_h`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `telefony`
--

LOCK TABLES `telefony` WRITE;
/*!40000 ALTER TABLE `telefony` DISABLE KEYS */;
INSERT INTO `telefony` VALUES ('999999999',1),('124214217',2),('767546434',2);
/*!40000 ALTER TABLE `telefony` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-07-10 11:38:03
