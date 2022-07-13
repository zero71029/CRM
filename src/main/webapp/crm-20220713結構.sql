-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: crm
-- ------------------------------------------------------
-- Server version	8.0.28

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
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `adminid` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `address` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `password` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `state` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `position` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '職位',
  `create_data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `department` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '部門',
  `director` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '主管',
  `dutyDay` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '到職日',
  PRIMARY KEY (`adminid`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `adminmail`
--

DROP TABLE IF EXISTS `adminmail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adminmail` (
  `adminmail` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `adminid` int NOT NULL,
  `billboardid` int NOT NULL,
  `reply` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`adminmail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `agreement`
--

DROP TABLE IF EXISTS `agreement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agreement` (
  `agreementid` int NOT NULL AUTO_INCREMENT,
  `company` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `fax` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `contactname` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `contactmoblie` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `contactjobtitle` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `city` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `postal` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `address` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `specialterms` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '特殊條款',
  `agreementdescribe` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '描述',
  `agreementname` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '客戶簽約人',
  `agreementjobtitle` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT ' 客戶簽約人職稱',
  `agreementtime` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '客戶簽約日期',
  `companyname` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '公司簽約人',
  `companyjobtitle` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT ' 公司簽約人職稱',
  `companytime` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '公司簽約日期',
  `user` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '負責人',
  `createtime` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `endtime` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`agreementid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `application`
--

DROP TABLE IF EXISTS `application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application` (
  `applicationid` int NOT NULL AUTO_INCREMENT,
  `admin` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '申請⼈',
  `english` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '護照英⽂名',
  `department` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '部⾨職位',
  `privateemail` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '私⼈Email',
  `privateid` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'ID名稱',
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '公司Email帳號',
  `arrivetime` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '到職⽇',
  `createtime` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '創造日',
  PRIMARY KEY (`applicationid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='新進⼈員帳號申請表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `authorize`
--

DROP TABLE IF EXISTS `authorize`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authorize` (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `used` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastmodified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最後修改時間',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billboard`
--

DROP TABLE IF EXISTS `billboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billboard` (
  `billboardid` int NOT NULL AUTO_INCREMENT,
  `user` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '發表人',
  `theme` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '主題',
  `content` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '內容',
  `state` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '狀態',
  `replytime` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '最後回覆時間',
  `time` varchar(1) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `top` varchar(2) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `readcount` varchar(1) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `billtowngroup` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `billboardgroupid` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `remark` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '註釋',
  `lastmodified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最後修改時間',
  PRIMARY KEY (`billboardid`)
) ENGINE=InnoDB AUTO_INCREMENT=550 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billboardadvice`
--

DROP TABLE IF EXISTS `billboardadvice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billboardadvice` (
  `adviceid` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `advicefrom` int NOT NULL,
  `formname` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `adviceto` int NOT NULL,
  `billboardid` int NOT NULL,
  `reply` varchar(2) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `lastmodified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最後修改時間',
  PRIMARY KEY (`adviceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billboardfile`
--

DROP TABLE IF EXISTS `billboardfile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billboardfile` (
  `fileid` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `billboardid` int NOT NULL,
  `url` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `authorize` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `lastmodified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最後修改時間',
  PRIMARY KEY (`fileid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billboardgroup`
--

DROP TABLE IF EXISTS `billboardgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billboardgroup` (
  `billboardgroupid` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `billboardgroup` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `billboardoption` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`billboardgroupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billboardread`
--

DROP TABLE IF EXISTS `billboardread`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billboardread` (
  `readid` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `billboardid` int NOT NULL,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `lastmodified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最後修改時間',
  PRIMARY KEY (`readid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billboardreply`
--

DROP TABLE IF EXISTS `billboardreply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billboardreply` (
  `replyid` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `billboardid` int NOT NULL,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `content` varchar(1000) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `lastmodified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最後修改時間',
  PRIMARY KEY (`replyid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billboardtop`
--

DROP TABLE IF EXISTS `billboardtop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billboardtop` (
  `topid` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `billboardid` int NOT NULL,
  `adminid` int NOT NULL,
  PRIMARY KEY (`topid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bosmessage`
--

DROP TABLE IF EXISTS `bosmessage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bosmessage` (
  `bosmessageid` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'id',
  `bosid` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '上一層外鍵',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '留言者',
  `message` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '留言內容',
  `createtime` datetime DEFAULT NULL,
  `lastmodified` varchar(40) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`bosmessageid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `changemessage`
--

DROP TABLE IF EXISTS `changemessage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `changemessage` (
  `changemessageid` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `changeid` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `filed` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '欄位',
  `source` varchar(1000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '原本',
  `after` varchar(1000) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '修改後',
  `createtime` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '建立時間',
  `lastmodified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最後修改時間',
  PRIMARY KEY (`changemessageid`),
  KEY `changemessage_changeid_IDX` (`changeid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client` (
  `clientid` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `sort` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '類別',
  `url` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '網站',
  `industry` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '產業',
  `uniformnumber` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '統一號碼',
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `fax` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `peoplenumber` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '員工人數',
  `billcity` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '帳單城市',
  `billtown` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '帳單地區',
  `billpostal` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '帳單郵遞區號',
  `billaddress` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '帳單地址',
  `delivercity` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '送貨城市',
  `delivertown` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '送貨地區',
  `deliverpostal` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '送貨郵遞區號',
  `deliveraddress` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '送貨地址',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `user` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `state` int DEFAULT '1',
  `extension` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `serialnumber` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '編號',
  `department` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '部門',
  `aaa` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '創造時間',
  PRIMARY KEY (`clientid`)
) ENGINE=InnoDB AUTO_INCREMENT=2475 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clientaddress`
--

DROP TABLE IF EXISTS `clientaddress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientaddress` (
  `addressid` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `clientid` int NOT NULL,
  `city` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '城市',
  `town` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '地區',
  `postal` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '郵遞區號	',
  `address` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '地址',
  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`addressid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clienttag`
--

DROP TABLE IF EXISTS `clienttag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clienttag` (
  `clienttagid` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `clientid` int NOT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contact`
--

DROP TABLE IF EXISTS `contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact` (
  `contactid` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `clientid` int NOT NULL,
  `company` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `jobtitle` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '職務',
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'Email',
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '電話',
  `moblie` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '手機',
  `city` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `town` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `postal` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `address` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '地址',
  `department` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '部門',
  `director` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '直屬主管',
  `fax` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '傳真',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '備註',
  `user` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `contacttime` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '上次聯絡時間',
  `line` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'LineID',
  `extension` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `contacttitle` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '稱謂',
  PRIMARY KEY (`contactid`)
) ENGINE=InnoDB AUTO_INCREMENT=2857 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `evaluate`
--

DROP TABLE IF EXISTS `evaluate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evaluate` (
  `evaluateid` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `department` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '部門',
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '姓名',
  `evaluatedate` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '日期',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '備註',
  `score` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '評語	',
  `assessment` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '考評',
  `director` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '主管',
  `hr` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '人事',
  `costtime` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`evaluateid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `evaluatetask`
--

DROP TABLE IF EXISTS `evaluatetask`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evaluatetask` (
  `taskid` int NOT NULL AUTO_INCREMENT,
  `evaluateid` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '評估書id',
  `finish` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '完成',
  `content` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '任務',
  `important` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '重要度',
  `costtime` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '耗時',
  `taskdate` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '創建時間',
  PRIMARY KEY (`taskid`)
) ENGINE=InnoDB AUTO_INCREMENT=26882 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `forgetauthorize`
--

DROP TABLE IF EXISTS `forgetauthorize`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `forgetauthorize` (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jobdescription`
--

DROP TABLE IF EXISTS `jobdescription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobdescription` (
  `jobdescriptionid` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `jobname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '職務名稱',
  `admin` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '姓名',
  `arrivaldate` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '到職⽇',
  `director` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '直屬主管',
  `counselor` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '輔導員',
  `workcontent` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '⼯作內容',
  `assessmentindicators` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '考核指標',
  `aaa` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '創建日期',
  `department` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '部門',
  PRIMARY KEY (`jobdescriptionid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `library`
--

DROP TABLE IF EXISTS `library`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `library` (
  `libraryid` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `librarygroup` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `libraryoption` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `remark` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '備註',
  PRIMARY KEY (`libraryid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `librarychange`
--

DROP TABLE IF EXISTS `librarychange`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `librarychange` (
  `librarychangeid` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `librarygroup` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `libraryoption` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `action` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '動作',
  `aaa` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `admin` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '修改人',
  PRIMARY KEY (`librarychangeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `market`
--

DROP TABLE IF EXISTS `market`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `market` (
  `marketid` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `user` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '業務',
  `createtime` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '案件類型',
  `endtime` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '結束時間',
  `message` varchar(1000) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '描述',
  `cost` int DEFAULT NULL COMMENT '花費',
  `client` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '客戶',
  `contactname` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '聯絡人',
  `contactphone` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '聯絡人電話',
  `contactextension` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '聯絡人電話分機',
  `contactmoblie` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '聯絡人手機',
  `contactemail` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '聯絡人email',
  `contacttitle` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '稱謂',
  `type` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '類型',
  `source` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '機會來源',
  `clinch` int DEFAULT NULL COMMENT '成交機率',
  `stage` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '階段',
  `need` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '需求確認',
  `roianalyze` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'ROI分析',
  `product` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '產品名稱',
  `producttype` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '產品類別',
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '公司電話',
  `aaa` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '創建時間	',
  `bbb` varchar(40) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '最後修改時間',
  `opentime` varchar(40) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '打開時間',
  `important` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '重要性',
  `line` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'LineID',
  `customerid` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '追蹤資訊',
  `contactmethod` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '聯絡方式',
  `extension` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '電話分機',
  `clicks` int DEFAULT '0' COMMENT '點擊數',
  `fax` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `clientid` int DEFAULT NULL COMMENT '客戶id',
  `quote` varchar(1000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `jobtitle` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `serialnumber` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `callbos` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '通知主管',
  `callhelp` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '求助',
  `fileforeignid` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '附件',
  `founder` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '創始人',
  `othersource` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '其他來源',
  `closereason` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '結案理由',
  `closeextend` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '結案理由延伸',
  `receive` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `receivestate` tinyint unsigned DEFAULT NULL COMMENT '領取狀態',
  PRIMARY KEY (`marketid`),
  KEY `market_customerid_IDX` (`customerid`) USING BTREE,
  KEY `market_bbb_IDX` (`bbb`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `marketfile`
--

DROP TABLE IF EXISTS `marketfile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `marketfile` (
  `fileid` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `fileforeignid` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '外鍵id',
  `url` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '路徑',
  `authorize` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '認證',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '名稱',
  PRIMARY KEY (`fileid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `marketremark`
--

DROP TABLE IF EXISTS `marketremark`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `marketremark` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marketid` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `user` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '留言人',
  `remark` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '留言',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `marketstate`
--

DROP TABLE IF EXISTS `marketstate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `marketstate` (
  `marketstateid` varchar(32) NOT NULL COMMENT 'id',
  `adminid` int NOT NULL COMMENT '使用者',
  `field` varchar(10) NOT NULL COMMENT '欄位',
  `state` varchar(50) NOT NULL COMMENT '狀態',
  `type` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`marketstateid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `persistent_logins`
--

DROP TABLE IF EXISTS `persistent_logins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `persistent_logins` (
  `username` varchar(64) NOT NULL,
  `series` varchar(64) NOT NULL,
  `token` varchar(64) NOT NULL,
  `last_used` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`series`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `potentialcustomer`
--

DROP TABLE IF EXISTS `potentialcustomer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `potentialcustomer` (
  `customerid` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '名稱',
  `company` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '公司',
  `jobtitle` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '職稱',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `extension` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `moblie` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '手機號',
  `fax` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '傳真',
  `department` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '部門',
  `director` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '主管',
  `industry` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '產業',
  `companynum` varchar(21) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '公司人數',
  `source` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '來源',
  `fromactivity` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '來自活動',
  `user` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '業務',
  `contacttime` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '上次聯絡時間',
  `status` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '狀態',
  `city` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `town` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `postal` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `address` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '地址',
  `remark` varchar(700) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '備註',
  `important` varchar(4) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `line` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'LineID',
  `aaa` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '創建時間',
  `bbb` varchar(40) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '最後修改時間',
  `opentime` varchar(40) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '打開時間',
  `serialnumber` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '編號',
  `callhelp` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '求助',
  `fileforeignid` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '附件',
  `contacttitle` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '稱謂',
  `founder` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '創始人',
  `othersource` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '其他來源',
  `closereason` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '結案理由',
  `closeextend` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '結案理由延伸',
  `receive` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '領取',
  `receivestate` tinyint unsigned DEFAULT NULL COMMENT '領取狀態',
  PRIMARY KEY (`customerid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `potentialcustomerhelper`
--

DROP TABLE IF EXISTS `potentialcustomerhelper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `potentialcustomerhelper` (
  `helperid` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `customerid` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `adminid` int NOT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`helperid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quotation`
--

DROP TABLE IF EXISTS `quotation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quotation` (
  `quotationid` int NOT NULL AUTO_INCREMENT COMMENT '報價單',
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `fax` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `contactname` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `contactmoblie` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `contactjobtitle` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `user` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`quotationid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quotationdetail`
--

DROP TABLE IF EXISTS `quotationdetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quotationdetail` (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `quotationid` int DEFAULT NULL,
  `product` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `producttype` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `price` int DEFAULT NULL,
  `num` int DEFAULT NULL,
  `total` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `replyadvice`
--

DROP TABLE IF EXISTS `replyadvice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `replyadvice` (
  `replyadvice` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `replyid` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `adviceto` int NOT NULL,
  PRIMARY KEY (`replyadvice`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `replyfile`
--

DROP TABLE IF EXISTS `replyfile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `replyfile` (
  `replyfileid` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `replyid` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `url` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `authorize` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`replyfileid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `replyreply`
--

DROP TABLE IF EXISTS `replyreply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `replyreply` (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `replyid` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `content` varchar(1000) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `lastmodified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最後修改時間',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `replytime`
--

DROP TABLE IF EXISTS `replytime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `replytime` (
  `billboardid` int NOT NULL,
  `aaa` varchar(1) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `lastmodified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最後修改時間',
  PRIMARY KEY (`billboardid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `track`
--

DROP TABLE IF EXISTS `track`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `track` (
  `trackid` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `customerid` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `trackdescribe` varchar(1000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '描述',
  `result` varchar(1000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '結果',
  `remark` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '備註',
  `tracktime` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '時間',
  PRIMARY KEY (`trackid`),
  KEY `track_customerid_IDX` (`customerid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trackremark`
--

DROP TABLE IF EXISTS `trackremark`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trackremark` (
  `trackremarkid` varchar(32) NOT NULL,
  `trackid` varchar(32) NOT NULL COMMENT 'trackid',
  `content` varchar(200) NOT NULL COMMENT '內容',
  `createtime` varchar(20) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`trackremarkid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `work`
--

DROP TABLE IF EXISTS `work`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `work` (
  `workid` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '主題',
  `endtime` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '到期日',
  `important` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '重要性',
  `remake` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '備註',
  `user` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '負責人',
  `state` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '狀態',
  `clientid` int DEFAULT NULL COMMENT '客戶',
  `contactid` int DEFAULT NULL COMMENT '聯絡人',
  `customerid` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '潛在顧客',
  `marketid` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '銷售機會',
  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創造時間',
  `track` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `marketname` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `customername` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `aaa` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '創造時間',
  `lastmodified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最後修改時間',
  PRIMARY KEY (`workid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `zeromail`
--

DROP TABLE IF EXISTS `zeromail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zeromail` (
  `zeromailid` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'id',
  `createtime` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '計件日',
  `num` int NOT NULL COMMENT '數量',
  PRIMARY KEY (`zeromailid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'crm'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-07-13  8:42:53
