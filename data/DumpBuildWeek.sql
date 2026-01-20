CREATE DATABASE  IF NOT EXISTS `vendicose_spa` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `vendicose_spa`;
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: vendicose_spa
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `idcategoria` int NOT NULL AUTO_INCREMENT,
  `nomecategoria` varchar(60) NOT NULL,
  PRIMARY KEY (`idcategoria`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'Alimentari Freschi'),(2,'Alimentari Confezionati'),(3,'Bevande'),(4,'Cosmetica'),(5,'Pulizia Casa');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `giacenzamagazzino`
--

DROP TABLE IF EXISTS `giacenzamagazzino`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `giacenzamagazzino` (
  `idgiacenzamagazzino` int NOT NULL AUTO_INCREMENT,
  `codmagazzino` int NOT NULL,
  `codprodotto` int NOT NULL,
  `quantitàdisponibile` int NOT NULL,
  PRIMARY KEY (`idgiacenzamagazzino`,`codmagazzino`,`codprodotto`),
  KEY `idmagazzino_idx` (`codmagazzino`),
  KEY `idprodotto_idx` (`codprodotto`),
  CONSTRAINT `codmagazzino` FOREIGN KEY (`codmagazzino`) REFERENCES `magazzino` (`idmagazzino`),
  CONSTRAINT `codprodotto` FOREIGN KEY (`codprodotto`) REFERENCES `prodotto` (`idprodotto`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `giacenzamagazzino`
--

LOCK TABLES `giacenzamagazzino` WRITE;
/*!40000 ALTER TABLE `giacenzamagazzino` DISABLE KEYS */;
INSERT INTO `giacenzamagazzino` VALUES (1,1,1,100),(2,1,5,190),(3,1,9,500),(4,1,13,15),(5,1,17,100),(6,2,2,80),(7,2,6,150),(8,2,10,300),(9,2,14,45),(10,2,18,100),(11,3,3,120),(12,3,7,90),(13,3,11,200),(14,3,15,60),(15,3,19,100),(16,4,4,50),(17,4,8,100),(18,4,12,120),(19,4,16,10),(20,4,20,100);
/*!40000 ALTER TABLE `giacenzamagazzino` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `magazzino`
--

DROP TABLE IF EXISTS `magazzino`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `magazzino` (
  `idmagazzino` int NOT NULL AUTO_INCREMENT,
  `nomemagazzino` varchar(50) NOT NULL,
  `città` varchar(50) NOT NULL,
  `giacenzamassima` int NOT NULL,
  PRIMARY KEY (`idmagazzino`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `magazzino`
--

LOCK TABLES `magazzino` WRITE;
/*!40000 ALTER TABLE `magazzino` DISABLE KEYS */;
INSERT INTO `magazzino` VALUES (1,'Logistica Nord-Ovest','Torino',5000),(2,'Hub Centrale','Roma',8000),(3,'Distribuzione Lombardia','Milano',6000),(4,'Deposito Sud','Lecce',4000);
/*!40000 ALTER TABLE `magazzino` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `negozio`
--

DROP TABLE IF EXISTS `negozio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `negozio` (
  `idnegozio` int NOT NULL AUTO_INCREMENT,
  `nomenegozio` varchar(45) NOT NULL,
  `città` varchar(60) NOT NULL,
  `idmagazzino` int NOT NULL,
  PRIMARY KEY (`idnegozio`),
  KEY `idmagazzino_idx` (`idmagazzino`),
  CONSTRAINT `idmagazzino` FOREIGN KEY (`idmagazzino`) REFERENCES `magazzino` (`idmagazzino`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `negozio`
--

LOCK TABLES `negozio` WRITE;
/*!40000 ALTER TABLE `negozio` DISABLE KEYS */;
INSERT INTO `negozio` VALUES (1,'VendiCose Torino Centro','Torino',1),(2,'VendiCose Moncalieri','Moncalieri',1),(3,'VendiCose Roma Termini','Roma',2),(4,'VendiCose Roma Prati','Roma',2),(5,'VendiCose Latina','Latina',2),(6,'VendiCose Milano Duomo','Milano',3),(7,'VendiCose Rho','Rho',3),(8,'VendiCose Lecce Centro','Lecce',4),(9,'VendiCose Brindisi','Brindisi',4),(10,'VendiCose Gallipoli','Gallipoli',4);
/*!40000 ALTER TABLE `negozio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prodotto`
--

DROP TABLE IF EXISTS `prodotto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prodotto` (
  `idprodotto` int NOT NULL AUTO_INCREMENT,
  `nomeprodotto` varchar(60) NOT NULL,
  `idcategoria` int NOT NULL,
  `sogliaminimarestock` int NOT NULL,
  PRIMARY KEY (`idprodotto`),
  KEY `idcategoria_idx` (`idcategoria`),
  CONSTRAINT `idcategoria` FOREIGN KEY (`idcategoria`) REFERENCES `categoria` (`idcategoria`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prodotto`
--

LOCK TABLES `prodotto` WRITE;
/*!40000 ALTER TABLE `prodotto` DISABLE KEYS */;
INSERT INTO `prodotto` VALUES (1,'Latte Intero 1L',1,50),(2,'Uova 6pz',1,40),(3,'Mozzarella 125g',1,30),(4,'Yogurt Greco',1,25),(5,'Pasta Barilla 500g',2,100),(6,'Riso Scotti 1kg',2,60),(7,'Biscotti Tarallucci',2,45),(8,'Passata Pomodoro',2,80),(9,'Acqua Naturale 1.5L',3,200),(10,'Coca Cola 1.5L',3,100),(11,'Birra Moretti',3,80),(12,'Succo Arancia',3,50),(13,'Shampoo Antiforfora',4,20),(14,'Dentifricio Mentadent',4,30),(15,'Sapone Liquido',4,25),(16,'Crema Viso',4,15),(17,'Sgrassatore Universale',5,40),(18,'Detersivo Lavatrice',5,35),(19,'Candeggina',5,20),(20,'Pastiglie Lavastoviglie',5,25);
/*!40000 ALTER TABLE `prodotto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendite`
--

DROP TABLE IF EXISTS `vendite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendite` (
  `idvendite` int NOT NULL AUTO_INCREMENT,
  `idnegozio` int NOT NULL,
  `idprodotto` int NOT NULL,
  `datavendita` date NOT NULL,
  `quantitàvenduta` int NOT NULL,
  PRIMARY KEY (`idvendite`),
  KEY `idprodotto_idx` (`idprodotto`),
  KEY `idnegozio_idx` (`idnegozio`),
  CONSTRAINT `idnegozio` FOREIGN KEY (`idnegozio`) REFERENCES `negozio` (`idnegozio`),
  CONSTRAINT `idprodotto` FOREIGN KEY (`idprodotto`) REFERENCES `prodotto` (`idprodotto`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendite`
--

LOCK TABLES `vendite` WRITE;
/*!40000 ALTER TABLE `vendite` DISABLE KEYS */;
INSERT INTO `vendite` VALUES (1,1,1,'2025-01-15',5),(2,1,5,'2025-01-20',10),(3,2,9,'2025-02-05',20),(4,3,2,'2025-02-12',2),(5,4,6,'2025-02-18',5),(6,5,10,'2025-03-05',12),(7,6,3,'2025-03-10',8),(8,7,7,'2025-03-22',4),(9,6,11,'2025-03-28',15),(10,8,4,'2025-04-02',3),(11,9,8,'2025-04-15',6),(12,10,12,'2025-05-10',10),(13,1,1,'2025-05-12',2),(14,3,2,'2025-06-01',4),(15,6,3,'2025-06-20',10),(16,8,4,'2025-07-05',5),(17,2,13,'2025-07-18',1),(18,4,14,'2025-08-02',2),(19,7,15,'2025-08-25',3),(20,9,16,'2025-09-10',1),(21,1,5,'2025-09-30',20),(22,3,6,'2025-10-05',15),(23,6,7,'2025-10-12',8),(24,8,8,'2025-11-02',12),(25,2,9,'2025-11-15',50),(26,5,10,'2025-11-20',25),(27,7,11,'2025-12-01',30),(28,10,12,'2025-12-10',5),(29,1,1,'2025-12-15',10),(30,4,2,'2025-12-28',6);
/*!40000 ALTER TABLE `vendite` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-13 20:44:49
