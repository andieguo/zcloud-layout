/*
Navicat MySQL Data Transfer

Source Server         : t.zhiyun360.com
Source Server Version : 50520
Source Host           : 120.24.67.222:13784
Source Database       : db_zcloudlayout

Target Server Type    : MYSQL
Target Server Version : 50520
File Encoding         : 65001

Date: 2016-05-28 17:28:17
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `tb_admin`
-- ----------------------------
DROP TABLE IF EXISTS `tb_admin`;
CREATE TABLE `tb_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nickname` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `phoneNumber` varchar(20) NOT NULL,
  `email` varchar(20) NOT NULL,
  `sex` tinyint(4) NOT NULL,
  `role` tinyint(4) NOT NULL,
  `createTime` datetime DEFAULT NULL,
  `modifyTime` datetime DEFAULT NULL,
  `visible` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_admin
-- ----------------------------
INSERT INTO `tb_admin` VALUES ('2', 'andy', 'andy', '13720120701', 'andieguo@foxmail.com', '1', '2', '2016-04-21 14:34:13', '2016-05-26 10:27:45', '1');
INSERT INTO `tb_admin` VALUES ('3', 'posly', 'posly', '13720120700', 'andieguo@foxmail.com', '1', '0', '2016-04-22 09:33:30', '2016-05-26 09:51:30', '1');
INSERT INTO `tb_admin` VALUES ('103', 'jack', 'jack', '13720120700', 'andieguo@foxmail.com', '1', '1', '2016-04-22 09:33:37', '2016-05-26 10:07:06', '1');
INSERT INTO `tb_admin` VALUES ('104', 'rose', 'rose', '13720120700', 'andieguo@foxmail.com', '1', '1', '2016-05-03 14:24:31', '2016-04-22 09:33:37', '1');

-- ----------------------------
-- Table structure for `tb_project`
-- ----------------------------
DROP TABLE IF EXISTS `tb_project`;
CREATE TABLE `tb_project` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `imageUrl` varchar(40) NOT NULL,
  `tid` int(11) NOT NULL,
  `aid` int(11) NOT NULL,
  `zcloudID` varchar(20) NOT NULL,
  `zcloudKEY` varchar(100) NOT NULL,
  `serverAddr` varchar(20) NOT NULL,
  `macList` text NOT NULL,
  `createTime` datetime NOT NULL,
  `modifyTime` datetime NOT NULL,
  `visible` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `tid` (`tid`),
  KEY `aid` (`aid`),
  CONSTRAINT `tb_project_ibfk_2` FOREIGN KEY (`aid`) REFERENCES `tb_admin` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tb_project_ibfk_1` FOREIGN KEY (`tid`) REFERENCES `tb_template` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for `tb_template`
-- ----------------------------
DROP TABLE IF EXISTS `tb_template`;
CREATE TABLE `tb_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `layoutJSON` text NOT NULL,
  `layoutContent` text NOT NULL,
  `aid` int(11) NOT NULL,
  `type` tinyint(4) NOT NULL,
  `createTime` datetime NOT NULL,
  `modifyTime` datetime NOT NULL,
  `visible` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `aid` (`aid`),
  CONSTRAINT `tb_template_ibfk_1` FOREIGN KEY (`aid`) REFERENCES `tb_admin` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8;

