CREATE DATABASE  IF NOT EXISTS `toysgroup` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `toysgroup`;
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: toysgroup
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
  `IdCategoria` int NOT NULL AUTO_INCREMENT,
  `NomeCategoria` varchar(45) DEFAULT NULL,
  `Tipologia` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`IdCategoria`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'Biciclette','Sport'),(2,'Abbigliamento','Sport'),(3,'Costruzioni','Didattica'),(4,'Peluches','Infanzia');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mercati`
--

DROP TABLE IF EXISTS `mercati`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mercati` (
  `IdMercati` int NOT NULL AUTO_INCREMENT,
  `Stato` varchar(45) DEFAULT NULL,
  `IdRegioni` int NOT NULL,
  PRIMARY KEY (`IdMercati`),
  KEY `fk_mercati_regioni_idx` (`IdRegioni`),
  CONSTRAINT `fk_mercati_regioni` FOREIGN KEY (`IdRegioni`) REFERENCES `regioni` (`IdRegioni`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mercati`
--

LOCK TABLES `mercati` WRITE;
/*!40000 ALTER TABLE `mercati` DISABLE KEYS */;
INSERT INTO `mercati` VALUES (1,'Italia',2),(2,'Spagna',2),(3,'Francia',1),(4,'Germania',1),(5,'Belgio',3),(6,'Paesi Bassi',3),(7,'Portogallo',2),(8,'Austria',3);
/*!40000 ALTER TABLE `mercati` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prodotti`
--

DROP TABLE IF EXISTS `prodotti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prodotti` (
  `IdProdotti` int NOT NULL AUTO_INCREMENT,
  `NomeProdotto` varchar(45) DEFAULT NULL,
  `CostoUnitario` decimal(10,2) DEFAULT NULL,
  `IdCategoria` int NOT NULL,
  PRIMARY KEY (`IdProdotti`),
  KEY `fk_prodotti_categoria_idx` (`IdCategoria`),
  CONSTRAINT `fk_prodotti_categoria` FOREIGN KEY (`IdCategoria`) REFERENCES `categoria` (`IdCategoria`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prodotti`
--

LOCK TABLES `prodotti` WRITE;
/*!40000 ALTER TABLE `prodotti` DISABLE KEYS */;
INSERT INTO `prodotti` VALUES (1,'Bici Junior 16',120.00,1),(2,'Bici Mountain 20',200.00,1),(3,'Casco Bici Kids',35.00,2),(4,'Guanti Bici S',15.00,2),(5,'Kit Mattoncini 200pz',45.00,3),(6,'Castello Mattoncini',60.00,3),(7,'Orsetto Peluche 30cm',20.00,4),(8,'Coniglietto Peluche',18.00,4);
/*!40000 ALTER TABLE `prodotti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `regioni`
--

DROP TABLE IF EXISTS `regioni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `regioni` (
  `IdRegioni` int NOT NULL AUTO_INCREMENT,
  `NomeRegione` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`IdRegioni`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `regioni`
--

LOCK TABLES `regioni` WRITE;
/*!40000 ALTER TABLE `regioni` DISABLE KEYS */;
INSERT INTO `regioni` VALUES (1,'NordEuropa'),(2,'SudEuropa'),(3,'CentroEuropa');
/*!40000 ALTER TABLE `regioni` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendite`
--

DROP TABLE IF EXISTS `vendite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendite` (
  `IdVendite` int NOT NULL AUTO_INCREMENT,
  `Data` date DEFAULT NULL,
  `Quantità` int DEFAULT NULL,
  `Prezzo` decimal(10,2) DEFAULT NULL,
  `IdProdotto` int NOT NULL,
  `IdMercati` int NOT NULL,
  PRIMARY KEY (`IdVendite`),
  KEY `fk_vendite_prodotti_idx` (`IdProdotto`),
  KEY `fk_vendite_mercati_idx` (`IdMercati`),
  CONSTRAINT `fk_vendite_mercati` FOREIGN KEY (`IdMercati`) REFERENCES `mercati` (`IdMercati`),
  CONSTRAINT `fk_vendite_prodotti` FOREIGN KEY (`IdProdotto`) REFERENCES `prodotti` (`IdProdotti`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='	';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendite`
--

LOCK TABLES `vendite` WRITE;
/*!40000 ALTER TABLE `vendite` DISABLE KEYS */;
INSERT INTO `vendite` VALUES (1,'2024-01-10',2,150.00,1,1),(2,'2024-01-15',1,150.00,1,3),(3,'2024-02-05',1,280.00,2,4),(4,'2024-02-15',3,25.00,4,1),(5,'2024-03-01',1,50.00,3,2),(6,'2024-03-10',2,70.00,5,5),(7,'2024-03-15',1,95.00,6,6),(8,'2024-04-01',4,30.00,7,7),(9,'2024-04-12',2,28.00,8,6),(10,'2024-04-20',1,280.00,2,1),(11,'2024-05-04',3,25.00,4,4),(12,'2024-05-15',2,95.00,6,3),(13,'2024-06-01',1,70.00,5,1),(14,'2024-06-12',5,30.00,7,2),(15,'2024-06-20',2,28.00,8,5),(16,'2024-07-02',4,150.00,1,1),(17,'2024-07-15',2,280.00,2,4),(18,'2024-07-30',1,50.00,3,3),(19,'2024-08-10',3,25.00,4,6),(20,'2024-08-20',2,95.00,6,8);
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

-- Dump completed on 2026-01-08 23:10:16
