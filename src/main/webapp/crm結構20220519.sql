-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- 主機： localhost:3306
-- 產生時間： 2022-05-19 08:13:09
-- 伺服器版本： 5.7.24
-- PHP 版本： 8.0.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 資料庫： `crm`
--

-- --------------------------------------------------------

--
-- 資料表結構 `admin`
--

CREATE TABLE `admin` (
  `adminid` int(21) NOT NULL,
  `name` varchar(100) COLLATE utf8_bin NOT NULL,
  `phone` varchar(20) COLLATE utf8_bin NOT NULL,
  `email` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `address` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `password` varchar(20) COLLATE utf8_bin NOT NULL,
  `state` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `position` varchar(10) COLLATE utf8_bin DEFAULT NULL COMMENT '職位',
  `create_data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `department` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '部門',
  `director` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '主管',
  `dutyDay` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '到職日'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- 資料表結構 `adminmail`
--

CREATE TABLE `adminmail` (
  `adminmail` varchar(32) COLLATE utf8_bin NOT NULL,
  `adminid` int(11) NOT NULL,
  `billboardid` int(21) NOT NULL,
  `reply` varchar(10) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- 資料表結構 `agreement`
--

CREATE TABLE `agreement` (
  `agreementid` int(21) NOT NULL,
  `company` varchar(20) COLLATE utf8_bin NOT NULL,
  `phone` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `email` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `fax` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `contactname` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `contactmoblie` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `contactjobtitle` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `city` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `postal` varchar(20) COLLATE utf8_bin NOT NULL,
  `address` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `specialterms` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '特殊條款',
  `agreementdescribe` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '描述',
  `agreementname` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '客戶簽約人',
  `agreementjobtitle` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT ' 客戶簽約人職稱',
  `agreementtime` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '客戶簽約日期',
  `companyname` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '公司簽約人',
  `companyjobtitle` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT ' 公司簽約人職稱',
  `companytime` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '公司簽約日期',
  `user` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '負責人',
  `createtime` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `endtime` varchar(20) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- 資料表結構 `application`
--

CREATE TABLE `application` (
  `applicationid` int(32) NOT NULL,
  `admin` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '申請⼈',
  `english` varchar(10) COLLATE utf8_bin DEFAULT NULL COMMENT '護照英⽂名',
  `department` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '部⾨職位',
  `privateemail` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '私⼈Email',
  `privateid` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT 'ID名稱',
  `email` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '公司Email帳號',
  `arrivetime` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '到職⽇',
  `createtime` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '創造日'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='新進⼈員帳號申請表';

-- --------------------------------------------------------

--
-- 資料表結構 `authorize`
--

CREATE TABLE `authorize` (
  `id` varchar(32) COLLATE utf8_bin NOT NULL,
  `used` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastmodified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最後修改時間'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- 資料表結構 `billboard`
--

CREATE TABLE `billboard` (
  `billboardid` int(21) NOT NULL,
  `user` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '發表人',
  `theme` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '主題',
  `content` varchar(2000) COLLATE utf8_bin NOT NULL COMMENT '內容',
  `state` varchar(10) COLLATE utf8_bin NOT NULL COMMENT '狀態',
  `replytime` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '最後回覆時間',
  `time` varchar(1) COLLATE utf8_bin DEFAULT NULL,
  `top` varchar(2) COLLATE utf8_bin NOT NULL,
  `readcount` varchar(1) COLLATE utf8_bin DEFAULT NULL,
  `billtowngroup` varchar(20) COLLATE utf8_bin NOT NULL,
  `billboardgroupid` varchar(32) COLLATE utf8_bin NOT NULL,
  `remark` varchar(10) COLLATE utf8_bin DEFAULT NULL COMMENT '註釋',
  `lastmodified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最後修改時間'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- 資料表結構 `billboardadvice`
--

CREATE TABLE `billboardadvice` (
  `adviceid` varchar(32) COLLATE utf8_bin NOT NULL,
  `advicefrom` int(20) NOT NULL,
  `formname` varchar(20) COLLATE utf8_bin NOT NULL,
  `adviceto` int(20) NOT NULL,
  `billboardid` int(20) NOT NULL,
  `reply` varchar(2) COLLATE utf8_bin NOT NULL,
  `lastmodified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最後修改時間'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- 資料表結構 `billboardfile`
--

CREATE TABLE `billboardfile` (
  `fileid` varchar(32) COLLATE utf8_bin NOT NULL,
  `billboardid` int(21) NOT NULL,
  `url` varchar(100) COLLATE utf8_bin NOT NULL,
  `authorize` varchar(32) COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `lastmodified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最後修改時間'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- 資料表結構 `billboardgroup`
--

CREATE TABLE `billboardgroup` (
  `billboardgroupid` varchar(32) COLLATE utf8_bin NOT NULL,
  `billboardgroup` varchar(20) COLLATE utf8_bin NOT NULL,
  `billboardoption` varchar(20) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- 資料表結構 `billboardread`
--

CREATE TABLE `billboardread` (
  `readid` varchar(32) COLLATE utf8_bin NOT NULL,
  `billboardid` int(21) NOT NULL,
  `name` varchar(20) COLLATE utf8_bin NOT NULL,
  `lastmodified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最後修改時間'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- 資料表結構 `billboardreply`
--

CREATE TABLE `billboardreply` (
  `replyid` varchar(32) COLLATE utf8_bin NOT NULL,
  `billboardid` int(21) NOT NULL,
  `name` varchar(20) COLLATE utf8_bin NOT NULL,
  `content` varchar(1000) COLLATE utf8_bin NOT NULL,
  `lastmodified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最後修改時間'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- 資料表結構 `billboardtop`
--

CREATE TABLE `billboardtop` (
  `topid` varchar(32) COLLATE utf8_bin NOT NULL,
  `billboardid` int(21) NOT NULL,
  `adminid` int(21) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- 資料表結構 `bosmessage`
--

CREATE TABLE `bosmessage` (
  `bosmessageid` varchar(32) COLLATE utf8_bin NOT NULL COMMENT 'id',
  `bosid` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '上一層外鍵',
  `name` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '留言者',
  `message` varchar(200) COLLATE utf8_bin NOT NULL COMMENT '留言內容',
  `createtime` datetime DEFAULT NULL,
  `lastmodified` varchar(40) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- 資料表結構 `changemessage`
--

CREATE TABLE `changemessage` (
  `changemessageid` varchar(32) COLLATE utf8_bin NOT NULL,
  `changeid` varchar(32) COLLATE utf8_bin NOT NULL,
  `name` varchar(20) COLLATE utf8_bin NOT NULL,
  `filed` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '欄位',
  `source` varchar(1000) COLLATE utf8_bin NOT NULL COMMENT '原本',
  `after` varchar(1000) COLLATE utf8_bin NOT NULL COMMENT '修改後',
  `createtime` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '建立時間',
  `lastmodified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最後修改時間'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- 資料表結構 `client`
--

CREATE TABLE `client` (
  `clientid` int(32) NOT NULL,
  `name` varchar(100) COLLATE utf8_bin NOT NULL,
  `sort` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '類別',
  `url` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '網站',
  `industry` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '產業',
  `uniformnumber` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '統一號碼',
  `email` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `fax` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `peoplenumber` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '員工人數',
  `billcity` varchar(10) COLLATE utf8_bin DEFAULT NULL COMMENT '帳單城市',
  `billtown` varchar(10) COLLATE utf8_bin DEFAULT NULL COMMENT '帳單地區',
  `billpostal` varchar(10) COLLATE utf8_bin DEFAULT NULL COMMENT '帳單郵遞區號',
  `billaddress` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '帳單地址',
  `delivercity` varchar(10) COLLATE utf8_bin DEFAULT NULL COMMENT '送貨城市',
  `delivertown` varchar(10) COLLATE utf8_bin DEFAULT NULL COMMENT '送貨地區',
  `deliverpostal` varchar(10) COLLATE utf8_bin DEFAULT NULL COMMENT '送貨郵遞區號',
  `deliveraddress` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '送貨地址',
  `remark` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `user` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `state` int(1) DEFAULT '1',
  `extension` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `serialnumber` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '編號',
  `department` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '部門'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- 資料表結構 `clientaddress`
--

CREATE TABLE `clientaddress` (
  `addressid` varchar(32) COLLATE utf8_bin NOT NULL,
  `clientid` int(32) NOT NULL,
  `city` varchar(10) COLLATE utf8_bin NOT NULL COMMENT '城市',
  `town` varchar(10) COLLATE utf8_bin NOT NULL COMMENT '地區',
  `postal` varchar(10) COLLATE utf8_bin NOT NULL COMMENT '郵遞區號	',
  `address` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '地址',
  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- 資料表結構 `clienttag`
--

CREATE TABLE `clienttag` (
  `clienttagid` varchar(32) COLLATE utf8_bin NOT NULL,
  `clientid` int(32) NOT NULL,
  `name` varchar(100) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- 資料表結構 `contact`
--

CREATE TABLE `contact` (
  `contactid` int(21) NOT NULL,
  `name` varchar(20) COLLATE utf8_bin NOT NULL,
  `clientid` int(21) NOT NULL,
  `company` varchar(100) COLLATE utf8_bin NOT NULL,
  `jobtitle` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '職務',
  `email` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT 'Email',
  `phone` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '電話',
  `moblie` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '手機',
  `city` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `town` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `postal` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `address` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '地址',
  `department` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '部門',
  `director` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '直屬主管',
  `fax` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '傳真',
  `remark` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '備註',
  `user` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `contacttime` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '上次聯絡時間',
  `line` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT 'LineID',
  `extension` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `contacttitle` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '稱謂'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- 資料表結構 `evaluate`
--

CREATE TABLE `evaluate` (
  `evaluateid` varchar(32) COLLATE utf8_bin NOT NULL,
  `department` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '部門',
  `name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '姓名',
  `evaluatedate` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '日期',
  `remark` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '備註',
  `score` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '評語	',
  `assessment` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '考評',
  `director` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '主管',
  `hr` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '人事',
  `costtime` varchar(20) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- 資料表結構 `evaluatetask`
--

CREATE TABLE `evaluatetask` (
  `taskid` int(32) NOT NULL,
  `evaluateid` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '評估書id',
  `finish` varchar(5) COLLATE utf8_bin DEFAULT NULL COMMENT '完成',
  `content` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '任務',
  `important` varchar(5) COLLATE utf8_bin DEFAULT NULL COMMENT '重要度',
  `costtime` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '耗時',
  `taskdate` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '創建時間'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- 資料表結構 `forgetauthorize`
--

CREATE TABLE `forgetauthorize` (
  `id` varchar(32) COLLATE utf8_bin NOT NULL,
  `email` varchar(100) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- 資料表結構 `jobdescription`
--

CREATE TABLE `jobdescription` (
  `jobdescriptionid` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `jobname` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '職務名稱',
  `admin` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '姓名',
  `arrivaldate` varchar(30) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '到職⽇',
  `director` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '直屬主管',
  `counselor` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '輔導員',
  `workcontent` varchar(1000) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '⼯作內容',
  `assessmentindicators` varchar(1000) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '考核指標',
  `aaa` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '創建日期',
  `department` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '部門'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- 資料表結構 `library`
--

CREATE TABLE `library` (
  `libraryid` varchar(32) COLLATE utf8_bin NOT NULL,
  `librarygroup` varchar(50) COLLATE utf8_bin NOT NULL,
  `libraryoption` varchar(50) COLLATE utf8_bin NOT NULL,
  `remark` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '備註'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- 資料表結構 `librarychange`
--

CREATE TABLE `librarychange` (
  `librarychangeid` varchar(32) COLLATE utf8_bin NOT NULL,
  `librarygroup` varchar(50) COLLATE utf8_bin NOT NULL,
  `libraryoption` varchar(50) COLLATE utf8_bin NOT NULL,
  `action` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '動作',
  `aaa` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `admin` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '修改人'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- 資料表結構 `market`
--

CREATE TABLE `market` (
  `marketid` varchar(32) COLLATE utf8_bin NOT NULL,
  `name` varchar(50) COLLATE utf8_bin NOT NULL,
  `user` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '業務',
  `createtime` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '案件類型',
  `endtime` varchar(10) COLLATE utf8_bin DEFAULT NULL COMMENT '結束時間',
  `message` varchar(1000) COLLATE utf8_bin NOT NULL COMMENT '描述',
  `cost` int(30) DEFAULT NULL COMMENT '花費',
  `client` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '客戶',
  `contactname` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '聯絡人',
  `contactphone` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '聯絡人電話',
  `contactextension` varchar(10) COLLATE utf8_bin DEFAULT NULL COMMENT '聯絡人電話分機',
  `contactmoblie` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '聯絡人手機',
  `contactemail` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '聯絡人email',
  `contacttitle` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '稱謂',
  `type` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '類型',
  `source` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '機會來源',
  `clinch` int(5) DEFAULT NULL COMMENT '成交機率',
  `stage` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '階段',
  `need` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '需求確認',
  `roianalyze` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT 'ROI分析',
  `product` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '產品名稱',
  `producttype` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '產品類別',
  `phone` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '公司電話',
  `aaa` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '創建時間	',
  `important` varchar(5) COLLATE utf8_bin DEFAULT NULL COMMENT '重要性',
  `line` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT 'LineID',
  `customerid` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '追蹤資訊',
  `contactmethod` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '聯絡方式',
  `extension` varchar(10) COLLATE utf8_bin DEFAULT NULL COMMENT '電話分機',
  `clicks` int(32) DEFAULT '0' COMMENT '點擊數',
  `fax` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `clientid` int(32) DEFAULT NULL COMMENT '客戶id',
  `quote` varchar(1000) COLLATE utf8_bin DEFAULT NULL,
  `jobtitle` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `serialnumber` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `callbos` varchar(5) COLLATE utf8_bin DEFAULT NULL COMMENT '通知主管',
  `callhelp` varchar(5) COLLATE utf8_bin DEFAULT NULL COMMENT '求助',
  `fileforeignid` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '附件',
  `founder` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '創始人',
  `othersource` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '其他來源',
  `closereason` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '結案理由',
  `closeextend` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '結案理由延伸'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- 資料表結構 `marketfile`
--

CREATE TABLE `marketfile` (
  `fileid` varchar(32) COLLATE utf8_bin NOT NULL,
  `fileforeignid` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '外鍵id',
  `url` varchar(200) COLLATE utf8_bin NOT NULL COMMENT '路徑',
  `authorize` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '認證',
  `name` varchar(200) COLLATE utf8_bin NOT NULL COMMENT '名稱'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- 資料表結構 `marketremark`
--

CREATE TABLE `marketremark` (
  `id` int(20) NOT NULL,
  `marketid` varchar(32) COLLATE utf8_bin NOT NULL,
  `user` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '留言人',
  `remark` varchar(200) COLLATE utf8_bin NOT NULL COMMENT '留言'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- 資料表結構 `marketstate`
--

CREATE TABLE `marketstate` (
  `marketstateid` varchar(32) NOT NULL COMMENT 'id',
  `adminid` int(21) NOT NULL COMMENT '使用者',
  `field` varchar(10) NOT NULL COMMENT '欄位',
  `state` varchar(50) NOT NULL COMMENT '狀態',
  `type` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 資料表結構 `persistent_logins`
--

CREATE TABLE `persistent_logins` (
  `username` varchar(64) NOT NULL,
  `series` varchar(64) NOT NULL,
  `token` varchar(64) NOT NULL,
  `last_used` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 資料表結構 `potentialcustomer`
--

CREATE TABLE `potentialcustomer` (
  `customerid` varchar(32) COLLATE utf8_bin NOT NULL,
  `name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '名稱',
  `company` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '公司',
  `jobtitle` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '職稱',
  `email` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `extension` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `moblie` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '手機號',
  `fax` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '傳真',
  `department` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '部門',
  `director` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '主管',
  `industry` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '產業',
  `companynum` varchar(21) COLLATE utf8_bin DEFAULT NULL COMMENT '公司人數',
  `source` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '來源',
  `fromactivity` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '來自活動',
  `user` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '業務',
  `contacttime` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '上次聯絡時間',
  `status` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '狀態',
  `city` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `town` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `postal` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `address` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '地址',
  `remark` varchar(700) COLLATE utf8_bin DEFAULT NULL COMMENT '備註',
  `important` varchar(4) COLLATE utf8_bin DEFAULT NULL,
  `line` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT 'LineID',
  `aaa` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '創建時間',
  `serialnumber` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '編號',
  `callhelp` varchar(5) COLLATE utf8_bin DEFAULT NULL COMMENT '求助',
  `fileforeignid` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '附件',
  `contacttitle` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '稱謂',
  `founder` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '創始人',
  `othersource` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '其他來源',
  `closereason` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '結案理由',
  `closeextend` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '結案理由延伸'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- 資料表結構 `potentialcustomerhelper`
--

CREATE TABLE `potentialcustomerhelper` (
  `helperid` varchar(32) COLLATE utf8_bin NOT NULL,
  `customerid` varchar(32) COLLATE utf8_bin NOT NULL,
  `adminid` int(21) NOT NULL,
  `name` varchar(100) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- 資料表結構 `quotation`
--

CREATE TABLE `quotation` (
  `quotationid` int(21) NOT NULL COMMENT '報價單',
  `name` varchar(20) COLLATE utf8_bin NOT NULL,
  `phone` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `email` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `fax` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `contactname` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `contactmoblie` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `contactjobtitle` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `remark` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `user` varchar(20) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- 資料表結構 `quotationdetail`
--

CREATE TABLE `quotationdetail` (
  `id` varchar(32) COLLATE utf8_bin NOT NULL,
  `quotationid` int(21) DEFAULT NULL,
  `product` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `producttype` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `price` int(20) DEFAULT NULL,
  `num` int(20) DEFAULT NULL,
  `total` int(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- 資料表結構 `replyadvice`
--

CREATE TABLE `replyadvice` (
  `replyadvice` varchar(32) COLLATE utf8_bin NOT NULL,
  `replyid` varchar(32) COLLATE utf8_bin NOT NULL,
  `adviceto` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- 資料表結構 `replyfile`
--

CREATE TABLE `replyfile` (
  `replyfileid` varchar(32) COLLATE utf8_bin NOT NULL,
  `replyid` varchar(32) COLLATE utf8_bin NOT NULL,
  `url` varchar(100) COLLATE utf8_bin NOT NULL,
  `authorize` varchar(32) COLLATE utf8_bin NOT NULL,
  `name` varchar(100) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- 資料表結構 `replyreply`
--

CREATE TABLE `replyreply` (
  `id` varchar(32) COLLATE utf8_bin NOT NULL,
  `replyid` varchar(32) COLLATE utf8_bin NOT NULL,
  `name` varchar(20) COLLATE utf8_bin NOT NULL,
  `content` varchar(1000) COLLATE utf8_bin NOT NULL,
  `lastmodified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最後修改時間'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- 資料表結構 `replytime`
--

CREATE TABLE `replytime` (
  `billboardid` int(21) NOT NULL,
  `aaa` varchar(1) COLLATE utf8_bin NOT NULL,
  `lastmodified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最後修改時間'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- 資料表結構 `track`
--

CREATE TABLE `track` (
  `trackid` varchar(32) COLLATE utf8_bin NOT NULL,
  `customerid` varchar(32) COLLATE utf8_bin NOT NULL,
  `trackdescribe` varchar(1000) COLLATE utf8_bin DEFAULT NULL COMMENT '描述',
  `result` varchar(1000) COLLATE utf8_bin DEFAULT NULL COMMENT '結果',
  `remark` varchar(10) COLLATE utf8_bin DEFAULT NULL COMMENT '備註',
  `tracktime` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '時間'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- 資料表結構 `trackremark`
--

CREATE TABLE `trackremark` (
  `trackremarkid` varchar(32) NOT NULL,
  `trackid` varchar(32) NOT NULL COMMENT 'trackid',
  `content` varchar(200) NOT NULL COMMENT '內容',
  `createtime` varchar(20) NOT NULL,
  `name` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 資料表結構 `work`
--

CREATE TABLE `work` (
  `workid` varchar(32) COLLATE utf8_bin NOT NULL,
  `name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '主題',
  `endtime` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '到期日',
  `important` varchar(10) COLLATE utf8_bin DEFAULT NULL COMMENT '重要性',
  `remake` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '備註',
  `user` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '負責人',
  `state` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '狀態',
  `clientid` int(11) DEFAULT NULL COMMENT '客戶',
  `contactid` int(21) DEFAULT NULL COMMENT '聯絡人',
  `customerid` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '潛在顧客',
  `marketid` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '銷售機會',
  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '創造時間',
  `track` varchar(32) COLLATE utf8_bin DEFAULT NULL,
  `marketname` varchar(50) COLLATE utf8_bin NOT NULL,
  `customername` varchar(50) COLLATE utf8_bin NOT NULL,
  `aaa` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '創造時間',
  `lastmodified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最後修改時間'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- 資料表結構 `zeromail`
--

CREATE TABLE `zeromail` (
  `zeromailid` varchar(32) COLLATE utf8_bin NOT NULL COMMENT 'id',
  `createtime` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '計件日',
  `num` int(11) NOT NULL COMMENT '數量'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- 已傾印資料表的索引
--

--
-- 資料表索引 `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`adminid`);

--
-- 資料表索引 `adminmail`
--
ALTER TABLE `adminmail`
  ADD PRIMARY KEY (`adminmail`);

--
-- 資料表索引 `agreement`
--
ALTER TABLE `agreement`
  ADD PRIMARY KEY (`agreementid`);

--
-- 資料表索引 `application`
--
ALTER TABLE `application`
  ADD PRIMARY KEY (`applicationid`);

--
-- 資料表索引 `authorize`
--
ALTER TABLE `authorize`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `billboard`
--
ALTER TABLE `billboard`
  ADD PRIMARY KEY (`billboardid`);

--
-- 資料表索引 `billboardadvice`
--
ALTER TABLE `billboardadvice`
  ADD PRIMARY KEY (`adviceid`);

--
-- 資料表索引 `billboardfile`
--
ALTER TABLE `billboardfile`
  ADD PRIMARY KEY (`fileid`);

--
-- 資料表索引 `billboardgroup`
--
ALTER TABLE `billboardgroup`
  ADD PRIMARY KEY (`billboardgroupid`);

--
-- 資料表索引 `billboardread`
--
ALTER TABLE `billboardread`
  ADD PRIMARY KEY (`readid`);

--
-- 資料表索引 `billboardreply`
--
ALTER TABLE `billboardreply`
  ADD PRIMARY KEY (`replyid`);

--
-- 資料表索引 `billboardtop`
--
ALTER TABLE `billboardtop`
  ADD PRIMARY KEY (`topid`);

--
-- 資料表索引 `bosmessage`
--
ALTER TABLE `bosmessage`
  ADD PRIMARY KEY (`bosmessageid`);

--
-- 資料表索引 `changemessage`
--
ALTER TABLE `changemessage`
  ADD PRIMARY KEY (`changemessageid`);

--
-- 資料表索引 `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`clientid`);

--
-- 資料表索引 `clientaddress`
--
ALTER TABLE `clientaddress`
  ADD PRIMARY KEY (`addressid`);

--
-- 資料表索引 `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`contactid`);

--
-- 資料表索引 `evaluate`
--
ALTER TABLE `evaluate`
  ADD PRIMARY KEY (`evaluateid`);

--
-- 資料表索引 `evaluatetask`
--
ALTER TABLE `evaluatetask`
  ADD PRIMARY KEY (`taskid`);

--
-- 資料表索引 `forgetauthorize`
--
ALTER TABLE `forgetauthorize`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `jobdescription`
--
ALTER TABLE `jobdescription`
  ADD PRIMARY KEY (`jobdescriptionid`);

--
-- 資料表索引 `library`
--
ALTER TABLE `library`
  ADD PRIMARY KEY (`libraryid`);

--
-- 資料表索引 `librarychange`
--
ALTER TABLE `librarychange`
  ADD PRIMARY KEY (`librarychangeid`);

--
-- 資料表索引 `market`
--
ALTER TABLE `market`
  ADD PRIMARY KEY (`marketid`);

--
-- 資料表索引 `marketfile`
--
ALTER TABLE `marketfile`
  ADD PRIMARY KEY (`fileid`);

--
-- 資料表索引 `marketremark`
--
ALTER TABLE `marketremark`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `marketstate`
--
ALTER TABLE `marketstate`
  ADD PRIMARY KEY (`marketstateid`);

--
-- 資料表索引 `persistent_logins`
--
ALTER TABLE `persistent_logins`
  ADD PRIMARY KEY (`series`);

--
-- 資料表索引 `potentialcustomer`
--
ALTER TABLE `potentialcustomer`
  ADD PRIMARY KEY (`customerid`);

--
-- 資料表索引 `potentialcustomerhelper`
--
ALTER TABLE `potentialcustomerhelper`
  ADD PRIMARY KEY (`helperid`);

--
-- 資料表索引 `quotation`
--
ALTER TABLE `quotation`
  ADD PRIMARY KEY (`quotationid`);

--
-- 資料表索引 `quotationdetail`
--
ALTER TABLE `quotationdetail`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `replyadvice`
--
ALTER TABLE `replyadvice`
  ADD PRIMARY KEY (`replyadvice`);

--
-- 資料表索引 `replyfile`
--
ALTER TABLE `replyfile`
  ADD PRIMARY KEY (`replyfileid`);

--
-- 資料表索引 `replyreply`
--
ALTER TABLE `replyreply`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `replytime`
--
ALTER TABLE `replytime`
  ADD PRIMARY KEY (`billboardid`);

--
-- 資料表索引 `track`
--
ALTER TABLE `track`
  ADD PRIMARY KEY (`trackid`);

--
-- 資料表索引 `trackremark`
--
ALTER TABLE `trackremark`
  ADD PRIMARY KEY (`trackremarkid`);

--
-- 資料表索引 `work`
--
ALTER TABLE `work`
  ADD PRIMARY KEY (`workid`);

--
-- 資料表索引 `zeromail`
--
ALTER TABLE `zeromail`
  ADD PRIMARY KEY (`zeromailid`);

--
-- 在傾印的資料表使用自動遞增(AUTO_INCREMENT)
--

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `admin`
--
ALTER TABLE `admin`
  MODIFY `adminid` int(21) NOT NULL AUTO_INCREMENT;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `agreement`
--
ALTER TABLE `agreement`
  MODIFY `agreementid` int(21) NOT NULL AUTO_INCREMENT;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `application`
--
ALTER TABLE `application`
  MODIFY `applicationid` int(32) NOT NULL AUTO_INCREMENT;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `billboard`
--
ALTER TABLE `billboard`
  MODIFY `billboardid` int(21) NOT NULL AUTO_INCREMENT;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `client`
--
ALTER TABLE `client`
  MODIFY `clientid` int(32) NOT NULL AUTO_INCREMENT;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `contact`
--
ALTER TABLE `contact`
  MODIFY `contactid` int(21) NOT NULL AUTO_INCREMENT;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `evaluatetask`
--
ALTER TABLE `evaluatetask`
  MODIFY `taskid` int(32) NOT NULL AUTO_INCREMENT;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `marketremark`
--
ALTER TABLE `marketremark`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `quotation`
--
ALTER TABLE `quotation`
  MODIFY `quotationid` int(21) NOT NULL AUTO_INCREMENT COMMENT '報價單';
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
