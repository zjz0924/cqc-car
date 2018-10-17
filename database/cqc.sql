/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50556
Source Host           : localhost:3306
Source Database       : cqc1

Target Server Type    : MYSQL
Target Server Version : 50556
File Encoding         : 65001

Date: 2018-10-18 01:22:44
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `account`
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(32) DEFAULT NULL COMMENT '用户名',
  `nickname` varchar(32) DEFAULT NULL COMMENT '昵称',
  `password` varchar(50) DEFAULT NULL COMMENT '密码',
  `mobile` varchar(16) DEFAULT NULL COMMENT '手机',
  `create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `lock` enum('N','Y') DEFAULT 'N' COMMENT '状态',
  `role_id` bigint(50) DEFAULT NULL,
  `org_id` bigint(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `remark` varchar(200) DEFAULT NULL,
  `sign_type` int(11) DEFAULT NULL,
  `pic` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_name` (`username`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of account
-- ----------------------------
INSERT INTO `account` VALUES ('1', 'admin', 'admin', 'E10ADC3949BA59ABBE56E057F20F883E', '13434343422', '2016-12-18 23:06:04', 'N', '1', '15', '312265264@qq.com', '', '1', null);
INSERT INTO `account` VALUES ('7', 'bill', 'ad', 'E10ADC3949BA59ABBE56E057F20F883E', '13512342323', '2017-06-21 23:30:12', 'N', '15', '15', '2422292577@qq.com', '', '1', null);
INSERT INTO `account` VALUES ('8', 'lily', 'lily', 'E10ADC3949BA59ABBE56E057F20F883E', '13723423434', '2017-06-21 23:30:34', 'N', '17', '21', '2422192577@qq.com', '', '1', null);
INSERT INTO `account` VALUES ('13', 'William', 'William', 'E10ADC3949BA59ABBE56E057F20F883E', '15918703417', '2017-06-21 23:33:15', 'N', '17', '20', '2522292577@qq.com', '', '1', null);

-- ----------------------------
-- Table structure for `address`
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES ('1', '柳州');
INSERT INTO `address` VALUES ('2', '福州');
INSERT INTO `address` VALUES ('3', '广州');

-- ----------------------------
-- Table structure for `applicat`
-- ----------------------------
DROP TABLE IF EXISTS `applicat`;
CREATE TABLE `applicat` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `depart` varchar(100) DEFAULT NULL,
  `org_id` bigint(20) DEFAULT NULL,
  `contact` varchar(50) DEFAULT NULL,
  `remark` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of applicat
-- ----------------------------
INSERT INTO `applicat` VALUES ('1', 'aa', 'asdf', '52', 'aaa', 'test');

-- ----------------------------
-- Table structure for `apply_record`
-- ----------------------------
DROP TABLE IF EXISTS `apply_record`;
CREATE TABLE `apply_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `v_id` bigint(20) DEFAULT NULL,
  `p_id` bigint(20) DEFAULT NULL,
  `m_id` bigint(20) DEFAULT NULL,
  `t_id` bigint(20) DEFAULT NULL,
  `a_id` bigint(20) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `pf_result_ids` varchar(100) DEFAULT NULL,
  `atlas_result` varchar(100) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `remark` varchar(200) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `confirm_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of apply_record
-- ----------------------------

-- ----------------------------
-- Table structure for `area`
-- ----------------------------
DROP TABLE IF EXISTS `area`;
CREATE TABLE `area` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `parentid` bigint(20) DEFAULT NULL,
  `desc` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of area
-- ----------------------------
INSERT INTO `area` VALUES ('1', '000', '地区', '0', '根节点');
INSERT INTO `area` VALUES ('2', '001', '广州', '1', '');
INSERT INTO `area` VALUES ('5', '003', '惠州', '1', null);
INSERT INTO `area` VALUES ('24', '007', '天河区', '2', '天');
INSERT INTO `area` VALUES ('89', '008', '白云区', '2', '白云区');
INSERT INTO `area` VALUES ('90', '009', '荔湾区', '2', '荔湾区');

-- ----------------------------
-- Table structure for `atlas_result`
-- ----------------------------
DROP TABLE IF EXISTS `atlas_result`;
CREATE TABLE `atlas_result` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `t_id` bigint(20) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `pic` varchar(100) DEFAULT NULL,
  `remark` varchar(500) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `catagory` int(11) DEFAULT NULL,
  `exp_no` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=277 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of atlas_result
-- ----------------------------

-- ----------------------------
-- Table structure for `car_code`
-- ----------------------------
DROP TABLE IF EXISTS `car_code`;
CREATE TABLE `car_code` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) DEFAULT NULL,
  `remark` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of car_code
-- ----------------------------
INSERT INTO `car_code` VALUES ('2', '1', null);
INSERT INTO `car_code` VALUES ('3', 'bj730', null);
INSERT INTO `car_code` VALUES ('4', 'bj703-02', null);
INSERT INTO `car_code` VALUES ('5', '111', null);
INSERT INTO `car_code` VALUES ('6', 'skd', null);
INSERT INTO `car_code` VALUES ('7', '材料测试', null);
INSERT INTO `car_code` VALUES ('8', '1130', null);
INSERT INTO `car_code` VALUES ('9', '修改实验结果', null);
INSERT INTO `car_code` VALUES ('10', 'A1', null);
INSERT INTO `car_code` VALUES ('11', 'A2', null);
INSERT INTO `car_code` VALUES ('12', 'A3', null);
INSERT INTO `car_code` VALUES ('13', 'A4', null);
INSERT INTO `car_code` VALUES ('14', 'A5', null);
INSERT INTO `car_code` VALUES ('15', 'A6', null);
INSERT INTO `car_code` VALUES ('16', 'A7', null);
INSERT INTO `car_code` VALUES ('17', 'A8', null);
INSERT INTO `car_code` VALUES ('18', 'A9', null);
INSERT INTO `car_code` VALUES ('19', 'A10', null);
INSERT INTO `car_code` VALUES ('20', 'A11', null);
INSERT INTO `car_code` VALUES ('21', 'A12', null);
INSERT INTO `car_code` VALUES ('22', 'A13', null);
INSERT INTO `car_code` VALUES ('23', 'A14', null);
INSERT INTO `car_code` VALUES ('24', 'A15', null);
INSERT INTO `car_code` VALUES ('25', 'A16', null);
INSERT INTO `car_code` VALUES ('26', 'A17', null);
INSERT INTO `car_code` VALUES ('27', 'A18', null);
INSERT INTO `car_code` VALUES ('28', 'A19', null);
INSERT INTO `car_code` VALUES ('29', 'A20', null);
INSERT INTO `car_code` VALUES ('30', 'A21', null);
INSERT INTO `car_code` VALUES ('31', '007', null);
INSERT INTO `car_code` VALUES ('32', '180S', null);
INSERT INTO `car_code` VALUES ('33', '190S', null);
INSERT INTO `car_code` VALUES ('34', '191S', null);
INSERT INTO `car_code` VALUES ('35', '204S', null);
INSERT INTO `car_code` VALUES ('36', '205S', null);
INSERT INTO `car_code` VALUES ('37', '206S', null);
INSERT INTO `car_code` VALUES ('38', '207S', null);
INSERT INTO `car_code` VALUES ('39', '208S', null);
INSERT INTO `car_code` VALUES ('40', '209S', null);
INSERT INTO `car_code` VALUES ('41', '210S', null);
INSERT INTO `car_code` VALUES ('42', '211S', null);
INSERT INTO `car_code` VALUES ('43', '212S', null);
INSERT INTO `car_code` VALUES ('44', '213S', null);
INSERT INTO `car_code` VALUES ('45', '214S', null);
INSERT INTO `car_code` VALUES ('46', '215S', null);
INSERT INTO `car_code` VALUES ('47', '216S', null);
INSERT INTO `car_code` VALUES ('48', '217S', null);
INSERT INTO `car_code` VALUES ('49', '218S', null);
INSERT INTO `car_code` VALUES ('50', '219S', null);
INSERT INTO `car_code` VALUES ('51', '220S', null);
INSERT INTO `car_code` VALUES ('52', '221S', null);
INSERT INTO `car_code` VALUES ('53', '222S', null);
INSERT INTO `car_code` VALUES ('54', '223S', null);
INSERT INTO `car_code` VALUES ('55', '224S', null);
INSERT INTO `car_code` VALUES ('56', '225S', null);
INSERT INTO `car_code` VALUES ('57', '226S', null);
INSERT INTO `car_code` VALUES ('58', '227S', null);
INSERT INTO `car_code` VALUES ('59', '228S', null);
INSERT INTO `car_code` VALUES ('60', '229S', null);
INSERT INTO `car_code` VALUES ('61', '230S', null);
INSERT INTO `car_code` VALUES ('62', '231S', null);
INSERT INTO `car_code` VALUES ('63', '232S', null);
INSERT INTO `car_code` VALUES ('64', '233S', null);
INSERT INTO `car_code` VALUES ('65', '234S', null);
INSERT INTO `car_code` VALUES ('66', '235S', null);
INSERT INTO `car_code` VALUES ('67', '236S', null);
INSERT INTO `car_code` VALUES ('68', '237S', null);
INSERT INTO `car_code` VALUES ('69', '238S', null);
INSERT INTO `car_code` VALUES ('70', '239S', null);
INSERT INTO `car_code` VALUES ('71', '240S', null);
INSERT INTO `car_code` VALUES ('72', '241S', null);
INSERT INTO `car_code` VALUES ('73', '242S', null);
INSERT INTO `car_code` VALUES ('74', '243S', null);
INSERT INTO `car_code` VALUES ('75', '244S', null);
INSERT INTO `car_code` VALUES ('76', '245S', null);
INSERT INTO `car_code` VALUES ('77', '246S', null);
INSERT INTO `car_code` VALUES ('78', '247S', null);
INSERT INTO `car_code` VALUES ('79', '248S', null);
INSERT INTO `car_code` VALUES ('80', '249S', null);
INSERT INTO `car_code` VALUES ('81', '250S', null);
INSERT INTO `car_code` VALUES ('82', '251S', null);
INSERT INTO `car_code` VALUES ('83', '252S', null);
INSERT INTO `car_code` VALUES ('84', '253S', null);
INSERT INTO `car_code` VALUES ('85', '254S', null);
INSERT INTO `car_code` VALUES ('86', '255S', null);
INSERT INTO `car_code` VALUES ('87', '256S', null);
INSERT INTO `car_code` VALUES ('88', '257S', null);
INSERT INTO `car_code` VALUES ('89', '258S', null);
INSERT INTO `car_code` VALUES ('90', '259S', null);
INSERT INTO `car_code` VALUES ('91', '260S', null);
INSERT INTO `car_code` VALUES ('92', '261S', null);
INSERT INTO `car_code` VALUES ('93', '262S', null);
INSERT INTO `car_code` VALUES ('94', '262', null);
INSERT INTO `car_code` VALUES ('95', '377S', null);
INSERT INTO `car_code` VALUES ('96', '376S', null);
INSERT INTO `car_code` VALUES ('97', '375S', null);
INSERT INTO `car_code` VALUES ('98', '370', null);
INSERT INTO `car_code` VALUES ('99', '323S', null);
INSERT INTO `car_code` VALUES ('100', '331S', null);
INSERT INTO `car_code` VALUES ('101', '332S', null);
INSERT INTO `car_code` VALUES ('102', '333S', null);
INSERT INTO `car_code` VALUES ('103', '334S', null);
INSERT INTO `car_code` VALUES ('104', '323S2', null);
INSERT INTO `car_code` VALUES ('105', '2621S', null);
INSERT INTO `car_code` VALUES ('106', '311S', null);
INSERT INTO `car_code` VALUES ('107', '456', null);
INSERT INTO `car_code` VALUES ('108', 'B11', null);
INSERT INTO `car_code` VALUES ('109', 'CN113', null);
INSERT INTO `car_code` VALUES ('110', 'CN202S', null);
INSERT INTO `car_code` VALUES ('111', 'CN180S', null);
INSERT INTO `car_code` VALUES ('112', 'CN120S', null);
INSERT INTO `car_code` VALUES ('113', 'good', null);
INSERT INTO `car_code` VALUES ('114', 'bad', null);

-- ----------------------------
-- Table structure for `cost_record`
-- ----------------------------
DROP TABLE IF EXISTS `cost_record`;
CREATE TABLE `cost_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `t_id` bigint(20) DEFAULT NULL,
  `a_id` bigint(20) DEFAULT NULL,
  `lab_id` bigint(20) DEFAULT NULL,
  `orgs` varchar(200) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `remark` varchar(200) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `times` int(11) DEFAULT NULL,
  `lab_type` int(11) DEFAULT NULL,
  `send_time` timestamp NULL DEFAULT NULL,
  `lab_result` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cost_record
-- ----------------------------

-- ----------------------------
-- Table structure for `dictionary`
-- ----------------------------
DROP TABLE IF EXISTS `dictionary`;
CREATE TABLE `dictionary` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `val` varchar(50) DEFAULT NULL,
  `desc` varchar(200) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dictionary
-- ----------------------------

-- ----------------------------
-- Table structure for `email_record`
-- ----------------------------
DROP TABLE IF EXISTS `email_record`;
CREATE TABLE `email_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `subject` varchar(100) DEFAULT NULL,
  `content` text,
  `addr` varchar(1000) DEFAULT NULL,
  `task_id` bigint(20) DEFAULT NULL,
  `a_id` bigint(20) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `orgin_email` varchar(50) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of email_record
-- ----------------------------

-- ----------------------------
-- Table structure for `examine_record`
-- ----------------------------
DROP TABLE IF EXISTS `examine_record`;
CREATE TABLE `examine_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `t_id` bigint(20) DEFAULT NULL,
  `a_id` bigint(20) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `remark` varchar(200) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `catagory` int(11) DEFAULT NULL,
  `task_type` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=384 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of examine_record
-- ----------------------------

-- ----------------------------
-- Table structure for `exp_item`
-- ----------------------------
DROP TABLE IF EXISTS `exp_item`;
CREATE TABLE `exp_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `a_id` bigint(20) DEFAULT NULL,
  `project` varchar(50) DEFAULT NULL,
  `standard` varchar(500) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `num` int(11) DEFAULT NULL,
  `total` double DEFAULT NULL,
  `remark` varchar(200) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `c_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of exp_item
-- ----------------------------

-- ----------------------------
-- Table structure for `info`
-- ----------------------------
DROP TABLE IF EXISTS `info`;
CREATE TABLE `info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `v_id` bigint(20) DEFAULT NULL,
  `p_id` bigint(20) DEFAULT NULL,
  `m_id` bigint(20) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `remark` varchar(200) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of info
-- ----------------------------

-- ----------------------------
-- Table structure for `lab_conclusion`
-- ----------------------------
DROP TABLE IF EXISTS `lab_conclusion`;
CREATE TABLE `lab_conclusion` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `conclusion` varchar(10) DEFAULT NULL,
  `rep_num` varchar(20) DEFAULT NULL,
  `main_inspe` varchar(100) DEFAULT NULL,
  `examine` varchar(100) DEFAULT NULL,
  `issue` varchar(100) DEFAULT NULL,
  `receive_date` date DEFAULT NULL,
  `examine_date` date DEFAULT NULL,
  `issue_date` date DEFAULT NULL,
  `remark` varchar(200) DEFAULT NULL,
  `task_id` bigint(20) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lab_conclusion
-- ----------------------------
INSERT INTO `lab_conclusion` VALUES ('55', '合格', 'a1', 'a2', 'a3', 'a4', '2018-01-01', '2018-01-02', '2018-01-03', 'a5', '150', '1');
INSERT INTO `lab_conclusion` VALUES ('56', '合格', 'b1', 'b2', 'b3', 'b4', '2018-01-21', '2018-01-23', '2018-01-25', 'b5', '150', '2');
INSERT INTO `lab_conclusion` VALUES ('57', '合格', 'N10123', '丁', '吴', '张', '2018-01-01', '2018-01-10', '2018-01-12', '12343', '93', '3');
INSERT INTO `lab_conclusion` VALUES ('58', '不合格', '12089', '李', '王', '李', '2018-01-04', '2018-01-18', '2018-01-24', '', '93', '4');
INSERT INTO `lab_conclusion` VALUES ('59', '合格', 'fghh', 'rytreyr', 'aetey', 'ayyuu', '2018-01-18', '2018-01-18', '2018-01-18', 'xfhf', '151', '3');
INSERT INTO `lab_conclusion` VALUES ('60', '合格', 'xccn', 'zgzhj', 'utuii', 'tduity', '2018-01-17', '2018-01-02', '2018-01-09', '', '151', '4');
INSERT INTO `lab_conclusion` VALUES ('61', '合格', 'a', 'a', 'a', 'a', '2018-01-18', '2018-01-23', '2018-01-24', '', '151', '1');
INSERT INTO `lab_conclusion` VALUES ('62', '合格', 'a', 'a', 'a', 'a', '2018-01-18', '2018-01-18', '2018-01-18', '', '151', '2');
INSERT INTO `lab_conclusion` VALUES ('63', '合格', 'u', 'u', 'u', 'u', '2018-01-18', '2018-01-18', '2018-01-18', '', '152', '1');
INSERT INTO `lab_conclusion` VALUES ('64', '合格', 'c', 'u', 'u', 'u', '2018-01-04', '2018-01-03', '2018-01-22', '', '152', '2');
INSERT INTO `lab_conclusion` VALUES ('65', '合格', 'u', 'u', 'u', 'u', '2018-01-18', '2018-01-18', '2018-01-18', '', '153', '1');
INSERT INTO `lab_conclusion` VALUES ('66', '合格', 'c', 'u', 'u', 'u', '2018-01-18', '2018-01-18', '2018-01-18', '', '153', '2');
INSERT INTO `lab_conclusion` VALUES ('67', '合格', 'wee', 'fgh', 'ghj', 'yyu', '2018-03-14', '2018-03-16', '2018-03-17', '', '162', '1');
INSERT INTO `lab_conclusion` VALUES ('68', '合格', '210', 'yu', 'uj', 'ui', '2018-03-13', '2018-03-23', '2018-03-22', '', '165', '1');
INSERT INTO `lab_conclusion` VALUES ('69', '合格', '123', 'R', 'T', 'H', '2018-03-08', '2018-03-20', '2018-03-26', '', '171', '3');
INSERT INTO `lab_conclusion` VALUES ('70', '合格', '123', 'W', 'R', 'G', '2018-03-01', '2018-03-15', '2018-03-15', '', '171', '4');
INSERT INTO `lab_conclusion` VALUES ('71', '其它', 'N0123', 'A', 'B', 'C', '2018-03-01', '2018-03-02', '2018-04-09', '', '173', '1');
INSERT INTO `lab_conclusion` VALUES ('72', '合格', 'a', 'a', 'a', 'a', '2018-04-18', '2018-04-20', '2018-04-23', '', '168', '1');
INSERT INTO `lab_conclusion` VALUES ('73', '其它', 'N11267', '吴', '胡', '黄', '2018-04-02', '2018-04-05', '2018-04-16', '', '171', '1');
INSERT INTO `lab_conclusion` VALUES ('74', '其它', 'N11267', '吴', '胡', '黄', '2018-04-02', '2018-04-05', '2018-04-10', '', '171', '2');
INSERT INTO `lab_conclusion` VALUES ('75', '其它', 'N12003', '吴', '胡', '黄', '2018-04-02', '2018-04-04', '2018-04-11', '', '174', '1');
INSERT INTO `lab_conclusion` VALUES ('76', '其它', 'N12003', '吴', '胡', '黄', '2018-04-02', '2018-04-04', '2018-04-11', '', '174', '2');
INSERT INTO `lab_conclusion` VALUES ('77', '合格', '4444', '2222', '2222', '2222', '2018-05-22', '2018-05-31', '2018-05-31', '', '209', '4');

-- ----------------------------
-- Table structure for `lab_req`
-- ----------------------------
DROP TABLE IF EXISTS `lab_req`;
CREATE TABLE `lab_req` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) DEFAULT NULL,
  `time` date DEFAULT NULL,
  `remark` varchar(300) DEFAULT NULL,
  `task_id` bigint(20) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=231 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lab_req
-- ----------------------------
INSERT INTO `lab_req` VALUES ('65', 'aa', '2018-01-09', 'aa', '150', '1');
INSERT INTO `lab_req` VALUES ('66', 'bb', '2018-01-23', 'bb', '150', '2');
INSERT INTO `lab_req` VALUES ('67', '123', '2018-01-18', 'fdhfjkll', '133', '1');
INSERT INTO `lab_req` VALUES ('68', '2355', '2018-01-19', '', '133', '2');
INSERT INTO `lab_req` VALUES ('69', '123', '2018-01-18', '', '151', '1');
INSERT INTO `lab_req` VALUES ('70', 'qwer', '2018-01-10', 'were', '151', '2');
INSERT INTO `lab_req` VALUES ('71', 'wfdg', '2018-01-18', '', '151', '3');
INSERT INTO `lab_req` VALUES ('72', 'grhy', '2018-01-18', 'etyyu', '151', '4');
INSERT INTO `lab_req` VALUES ('73', 'a', '2018-01-18', '', '152', '1');
INSERT INTO `lab_req` VALUES ('74', 'd', '2018-01-18', '', '152', '2');
INSERT INTO `lab_req` VALUES ('75', 'a', '2018-01-18', '', '153', '1');
INSERT INTO `lab_req` VALUES ('76', 'd', '2018-01-18', '', '153', '2');
INSERT INTO `lab_req` VALUES ('77', '', null, '', '154', '2');
INSERT INTO `lab_req` VALUES ('78', '', null, '', '155', '1');
INSERT INTO `lab_req` VALUES ('79', '', null, '', '155', '2');
INSERT INTO `lab_req` VALUES ('80', '', null, '', '156', '1');
INSERT INTO `lab_req` VALUES ('81', '', null, '', '156', '2');
INSERT INTO `lab_req` VALUES ('82', '', null, '', '157', '1');
INSERT INTO `lab_req` VALUES ('83', '', null, '', '157', '2');
INSERT INTO `lab_req` VALUES ('84', '', null, '', '158', '1');
INSERT INTO `lab_req` VALUES ('85', '', null, '', '158', '2');
INSERT INTO `lab_req` VALUES ('86', '', null, '', '159', '1');
INSERT INTO `lab_req` VALUES ('87', '87655', '2018-03-08', 'sfdhh', '160', '1');
INSERT INTO `lab_req` VALUES ('88', '1', '2018-03-23', '1', '161', '1');
INSERT INTO `lab_req` VALUES ('89', '23', '2018-03-21', '3ert', '162', '1');
INSERT INTO `lab_req` VALUES ('90', '03015', '2018-03-16', 'GB', '163', '1');
INSERT INTO `lab_req` VALUES ('91', '', null, '', '164', '1');
INSERT INTO `lab_req` VALUES ('92', '', null, '', '164', '2');
INSERT INTO `lab_req` VALUES ('93', '0320-1', '2018-03-24', 'GB', '165', '1');
INSERT INTO `lab_req` VALUES ('94', '', null, '', '166', '1');
INSERT INTO `lab_req` VALUES ('95', '', null, '', '167', '1');
INSERT INTO `lab_req` VALUES ('96', '', null, '', '167', '2');
INSERT INTO `lab_req` VALUES ('97', '', null, '', '168', '1');
INSERT INTO `lab_req` VALUES ('98', '', null, '', '117', '1');
INSERT INTO `lab_req` VALUES ('99', '', null, '', '117', '2');
INSERT INTO `lab_req` VALUES ('100', '', null, '', '117', '3');
INSERT INTO `lab_req` VALUES ('101', '', null, '', '117', '4');
INSERT INTO `lab_req` VALUES ('102', '', null, '', '3', '2');
INSERT INTO `lab_req` VALUES ('103', '', null, '', '3', '4');
INSERT INTO `lab_req` VALUES ('104', '以后', '2018-03-26', 'GB', '169', '1');
INSERT INTO `lab_req` VALUES ('105', 'we', '2018-03-30', '', '170', '1');
INSERT INTO `lab_req` VALUES ('106', 'A01', '2018-03-30', 'GB', '171', '1');
INSERT INTO `lab_req` VALUES ('107', 'A02', '2018-03-29', '', '171', '2');
INSERT INTO `lab_req` VALUES ('108', 'A03', '2018-03-30', '', '171', '3');
INSERT INTO `lab_req` VALUES ('109', 'A04', null, '', '171', '4');
INSERT INTO `lab_req` VALUES ('111', '', null, '', '172', '1');
INSERT INTO `lab_req` VALUES ('112', '', null, '', '129', '2');
INSERT INTO `lab_req` VALUES ('113', '', null, '', '129', '3');
INSERT INTO `lab_req` VALUES ('114', '', null, '', '129', '4');
INSERT INTO `lab_req` VALUES ('115', '', null, '', '173', '1');
INSERT INTO `lab_req` VALUES ('117', 'N12345', null, 'GB/T', '174', '1');
INSERT INTO `lab_req` VALUES ('118', 'N12345', null, 'GB/T', '174', '2');
INSERT INTO `lab_req` VALUES ('120', '', '2018-05-14', '', '176', '1');
INSERT INTO `lab_req` VALUES ('137', '', '2018-05-17', '', '182', '1');
INSERT INTO `lab_req` VALUES ('138', '', '2018-05-26', '', '182', '2');
INSERT INTO `lab_req` VALUES ('139', '', '2018-05-09', '', '183', '1');
INSERT INTO `lab_req` VALUES ('140', '', '2018-05-23', '', '183', '2');
INSERT INTO `lab_req` VALUES ('141', '', '2018-05-11', '', '184', '1');
INSERT INTO `lab_req` VALUES ('142', '', '2018-05-11', '', '184', '2');
INSERT INTO `lab_req` VALUES ('143', '', '2018-05-09', '', '185', '1');
INSERT INTO `lab_req` VALUES ('144', '', '2018-05-11', '', '185', '2');
INSERT INTO `lab_req` VALUES ('145', '', '2018-05-18', '', '186', '1');
INSERT INTO `lab_req` VALUES ('146', '', '2018-05-18', '', '186', '2');
INSERT INTO `lab_req` VALUES ('147', '', '2018-05-17', '', '188', '1');
INSERT INTO `lab_req` VALUES ('148', '', '2018-05-16', '', '189', '2');
INSERT INTO `lab_req` VALUES ('149', '', '2018-05-08', '', '190', '1');
INSERT INTO `lab_req` VALUES ('150', '', '2018-05-08', '', '190', '2');
INSERT INTO `lab_req` VALUES ('151', '', '2018-05-18', '', '191', '1');
INSERT INTO `lab_req` VALUES ('152', '', '2018-05-18', '', '191', '2');
INSERT INTO `lab_req` VALUES ('153', '', '2018-05-15', '', '192', '1');
INSERT INTO `lab_req` VALUES ('154', '', '2018-05-08', '', '192', '2');
INSERT INTO `lab_req` VALUES ('165', '', null, '', '201', '1');
INSERT INTO `lab_req` VALUES ('166', '', '2018-05-26', '', '202', '1');
INSERT INTO `lab_req` VALUES ('167', '', '2018-05-26', '', '203', '1');
INSERT INTO `lab_req` VALUES ('168', '', '2018-05-26', '', '204', '1');
INSERT INTO `lab_req` VALUES ('169', '', '2018-05-26', '', '206', '1');
INSERT INTO `lab_req` VALUES ('170', '', null, '', '207', '1');
INSERT INTO `lab_req` VALUES ('171', '', null, '', '207', '2');
INSERT INTO `lab_req` VALUES ('172', '', null, '', '207', '3');
INSERT INTO `lab_req` VALUES ('173', '', null, '', '207', '4');
INSERT INTO `lab_req` VALUES ('174', '', null, '', '200', '1');
INSERT INTO `lab_req` VALUES ('175', '', null, '', '200', '2');
INSERT INTO `lab_req` VALUES ('176', '', null, '', '200', '3');
INSERT INTO `lab_req` VALUES ('177', '', null, '', '200', '4');
INSERT INTO `lab_req` VALUES ('178', '', null, '', '205', '1');
INSERT INTO `lab_req` VALUES ('179', '', null, '', '205', '2');
INSERT INTO `lab_req` VALUES ('180', '', null, '', '205', '3');
INSERT INTO `lab_req` VALUES ('181', '', null, '', '205', '4');
INSERT INTO `lab_req` VALUES ('182', '', null, '', '199', '1');
INSERT INTO `lab_req` VALUES ('183', '', null, '', '199', '2');
INSERT INTO `lab_req` VALUES ('184', '', null, '', '199', '3');
INSERT INTO `lab_req` VALUES ('185', '', null, '', '199', '4');
INSERT INTO `lab_req` VALUES ('186', '', null, '', '198', '1');
INSERT INTO `lab_req` VALUES ('187', '', null, '', '198', '2');
INSERT INTO `lab_req` VALUES ('188', '', null, '', '198', '3');
INSERT INTO `lab_req` VALUES ('189', '', null, '', '198', '4');
INSERT INTO `lab_req` VALUES ('190', '', null, '', '181', '1');
INSERT INTO `lab_req` VALUES ('191', '', null, '', '181', '2');
INSERT INTO `lab_req` VALUES ('192', '', null, '', '181', '3');
INSERT INTO `lab_req` VALUES ('193', '', null, '', '181', '4');
INSERT INTO `lab_req` VALUES ('194', '', null, '', '180', '1');
INSERT INTO `lab_req` VALUES ('195', '', null, '', '180', '2');
INSERT INTO `lab_req` VALUES ('196', '', null, '', '180', '3');
INSERT INTO `lab_req` VALUES ('197', '', null, '', '180', '4');
INSERT INTO `lab_req` VALUES ('200', '', null, '', '179', '2');
INSERT INTO `lab_req` VALUES ('201', '', null, '', '179', '3');
INSERT INTO `lab_req` VALUES ('202', '', null, '', '175', '1');
INSERT INTO `lab_req` VALUES ('203', '', null, '', '175', '2');
INSERT INTO `lab_req` VALUES ('204', '', null, '', '175', '3');
INSERT INTO `lab_req` VALUES ('205', '', null, '', '175', '4');
INSERT INTO `lab_req` VALUES ('206', '', null, '', '127', '1');
INSERT INTO `lab_req` VALUES ('207', '', null, '', '127', '2');
INSERT INTO `lab_req` VALUES ('208', '', null, '', '127', '3');
INSERT INTO `lab_req` VALUES ('209', '', null, '', '127', '4');
INSERT INTO `lab_req` VALUES ('210', '', '2018-05-19', '', '211', '4');
INSERT INTO `lab_req` VALUES ('212', '', '2018-05-24', '', '210', '2');
INSERT INTO `lab_req` VALUES ('213', '', '2018-05-19', '另外附件', '209', '4');
INSERT INTO `lab_req` VALUES ('214', '', null, '', '208', '4');
INSERT INTO `lab_req` VALUES ('215', '', null, '', '197', '2');
INSERT INTO `lab_req` VALUES ('216', '', null, '', '197', '4');
INSERT INTO `lab_req` VALUES ('217', '', null, '', '196', '2');
INSERT INTO `lab_req` VALUES ('218', '', null, '', '196', '4');
INSERT INTO `lab_req` VALUES ('219', '', '2018-05-26', '', '195', '4');
INSERT INTO `lab_req` VALUES ('220', '', null, '', '194', '4');
INSERT INTO `lab_req` VALUES ('221', '', '2018-05-19', '', '193', '4');
INSERT INTO `lab_req` VALUES ('222', '', null, '', '178', '1');
INSERT INTO `lab_req` VALUES ('223', '', null, '', '178', '2');
INSERT INTO `lab_req` VALUES ('224', '', null, '', '178', '3');
INSERT INTO `lab_req` VALUES ('225', '', null, '', '178', '4');
INSERT INTO `lab_req` VALUES ('226', '', null, '', '214', '1');
INSERT INTO `lab_req` VALUES ('227', '', null, '', '214', '2');
INSERT INTO `lab_req` VALUES ('228', '', null, '', '214', '3');
INSERT INTO `lab_req` VALUES ('229', '', null, '', '214', '4');
INSERT INTO `lab_req` VALUES ('230', '', null, '', '219', '4');

-- ----------------------------
-- Table structure for `material`
-- ----------------------------
DROP TABLE IF EXISTS `material`;
CREATE TABLE `material` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` int(11) DEFAULT NULL,
  `mat_name` varchar(50) DEFAULT NULL,
  `mat_no` varchar(50) DEFAULT NULL,
  `mat_color` varchar(50) DEFAULT NULL,
  `pro_no` varchar(50) DEFAULT NULL,
  `pic` varchar(50) DEFAULT NULL,
  `remark` varchar(200) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `org_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of material
-- ----------------------------

-- ----------------------------
-- Table structure for `menu`
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `url` varchar(100) DEFAULT NULL,
  `p_id` bigint(20) DEFAULT NULL,
  `sort_num` int(11) DEFAULT NULL,
  `is_parent` enum('N','Y') DEFAULT 'N',
  `alias` varchar(50) DEFAULT NULL COMMENT '别名，必须唯一',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('1', '系统管理', 'system/index', null, '10', 'Y', 'system');
INSERT INTO `menu` VALUES ('2', '用户管理', 'account/list', '1', '1', 'N', 'account');
INSERT INTO `menu` VALUES ('3', '角色管理', 'role/list', '1', '2', 'N', 'role');
INSERT INTO `menu` VALUES ('10', '字典管理', 'dictionary/list', '1', '6', 'N', 'dictionary');
INSERT INTO `menu` VALUES ('11', '日志管理', 'operationlog/list', '1', '4', 'N', 'log');
INSERT INTO `menu` VALUES ('12', '区域管理', 'area/list', '1', '2', 'N', 'area');
INSERT INTO `menu` VALUES ('13', '机构管理', 'org/list', '1', '3', 'N', 'org');
INSERT INTO `menu` VALUES ('14', '菜单管理', 'menu/list', '1', '5', 'N', 'menu');
INSERT INTO `menu` VALUES ('15', '任务管理', '', null, '1', 'Y', 'info');
INSERT INTO `menu` VALUES ('16', '车型OTS阶段任务', 'ots/index?taskType=1', '15', '1', 'N', 'otsTask');
INSERT INTO `menu` VALUES ('17', '任务申请', 'ots/requireList?taskType=1', '16', '1', 'N', 'otsRequire');
INSERT INTO `menu` VALUES ('18', '信息审核', 'ots/examineList?taskType=1', '16', '2', 'N', 'otsExamine');
INSERT INTO `menu` VALUES ('19', '任务下达', 'ots/transmitList?taskType=1', '16', '3', 'N', 'otsOrder');
INSERT INTO `menu` VALUES ('20', '任务审批', 'ots/approveList?taskType=1', '16', '4', 'N', 'otsApprove');
INSERT INTO `menu` VALUES ('21', '车型PPAP阶段任务', 'ppap/index?taskType=2', '15', '2', 'N', 'ppapTask');
INSERT INTO `menu` VALUES ('22', '任务下达 ', 'ppap/transmitList?taskType=2', '21', '1', 'N', 'ppapOrder');
INSERT INTO `menu` VALUES ('23', '任务审批', 'ppap/approveList?taskType=2', '21', '2', 'N', 'ppapApprove');
INSERT INTO `menu` VALUES ('24', '结果确认', 'ppap/confirmList?taskType=2', '21', '3', 'N', 'ppapConfirm');
INSERT INTO `menu` VALUES ('25', '车型SOP阶段任务', 'ppap/index?taskType=3', '15', '3', 'N', 'sopTask');
INSERT INTO `menu` VALUES ('26', '任务下达 ', 'ppap/transmitList?taskType=3', '25', '1', 'N', 'sopOrder');
INSERT INTO `menu` VALUES ('27', '任务审批 ', 'ppap/approveList?taskType=3', '25', '2', 'N', 'sopApprove');
INSERT INTO `menu` VALUES ('28', '结果确认', 'ppap/confirmList?taskType=3', '25', '3', 'N', 'sopConfirm');
INSERT INTO `menu` VALUES ('36', '非车型材料任务', 'ots/index?taskType=4', '15', '4', 'N', 'gsTask');
INSERT INTO `menu` VALUES ('37', '任务申请', 'ots/requireList?taskType=4', '36', '1', 'N', 'gsRequire');
INSERT INTO `menu` VALUES ('38', '信息审核 ', 'ots/examineList?taskType=4', '36', '2', 'N', 'gsExamine');
INSERT INTO `menu` VALUES ('39', '任务下达 ', 'ots/transmitList?taskType=4', '36', '3', 'N', 'gsOrder');
INSERT INTO `menu` VALUES ('40', '任务审批 ', 'ots/approveList?taskType=4', '36', '4', 'N', 'gsApprove');
INSERT INTO `menu` VALUES ('41', '实验管理', null, null, '2', 'Y', '');
INSERT INTO `menu` VALUES ('42', '结果上传', null, '41', null, 'N', 'result');
INSERT INTO `menu` VALUES ('43', '型式试验结果上传', 'result/uploadList?type=1', '42', '1', 'N', 'patternUpload');
INSERT INTO `menu` VALUES ('44', '图谱结果上传', 'result/uploadList?type=2', '42', '2', 'N', 'atlasUpload');
INSERT INTO `menu` VALUES ('45', '结果比对', 'result/compareList', '41', null, 'N', 'compare');
INSERT INTO `menu` VALUES ('46', '结果发送', 'result/sendList', '41', null, 'N', 'send');
INSERT INTO `menu` VALUES ('47', '结果确认', null, '41', null, 'N', 'confirm');
INSERT INTO `menu` VALUES ('48', '待上传结果', 'result/confirmList?type=1', '47', '1', 'N', 'waitConfirm');
INSERT INTO `menu` VALUES ('49', '已上传结果', 'result/confirmList?type=2', '47', null, 'N', 'finishConfirm');
INSERT INTO `menu` VALUES ('50', '申请管理', null, null, '3', 'Y', 'apply');
INSERT INTO `menu` VALUES ('51', '修改申请', 'apply/taskList', '50', null, 'N', 'updateApply');
INSERT INTO `menu` VALUES ('52', '终止申请', 'apply/applyList', '50', null, 'N', 'endApply');
INSERT INTO `menu` VALUES ('54', '查询管理', 'query/list', null, '4', 'Y', 'query');
INSERT INTO `menu` VALUES ('55', '统计管理', null, null, '5', 'Y', 'statistic');
INSERT INTO `menu` VALUES ('57', '结果统计', 'statistic/result', '55', null, 'N', 'resultStatistic');
INSERT INTO `menu` VALUES ('58', '费用管理', '', null, '6', 'Y', 'cost');
INSERT INTO `menu` VALUES ('59', '待发送列表', 'cost/list?type=1', '58', null, 'N', 'tosend');
INSERT INTO `menu` VALUES ('60', '收费通知单列表', 'cost/list?type=2', '58', null, 'N', 'sent');
INSERT INTO `menu` VALUES ('61', '消息管理', 'message/list', null, '5', 'Y', 'message');

-- ----------------------------
-- Table structure for `operation_log`
-- ----------------------------
DROP TABLE IF EXISTS `operation_log`;
CREATE TABLE `operation_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(50) DEFAULT NULL,
  `user_agent` varchar(200) DEFAULT NULL,
  `client_ip` varchar(50) DEFAULT NULL,
  `time` timestamp NULL DEFAULT NULL,
  `detail` longtext,
  `type` varchar(100) DEFAULT NULL,
  `operation` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1546 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of operation_log
-- ----------------------------

-- ----------------------------
-- Table structure for `org`
-- ----------------------------
DROP TABLE IF EXISTS `org`;
CREATE TABLE `org` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `areaid` bigint(20) DEFAULT NULL,
  `desc` varchar(200) DEFAULT NULL,
  `parentid` bigint(20) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `addr` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of org
-- ----------------------------
INSERT INTO `org` VALUES ('1', '机构', '001', null, null, null, null, null);
INSERT INTO `org` VALUES ('13', '通用五菱', 'sgmw', '2', '', '1', '1', null);
INSERT INTO `org` VALUES ('14', '上汽通用五菱SQE', 'SQE', '111', '', '13', '1', null);
INSERT INTO `org` VALUES ('15', '上汽通用五菱 PE', 'PE', '111', '', '13', '1', null);
INSERT INTO `org` VALUES ('16', '上汽通用五菱材料研究所', 'cl', '111', '', '13', '1', null);
INSERT INTO `org` VALUES ('17', '供应商', 'gy', '106', '', '1', '2', null);
INSERT INTO `org` VALUES ('18', '供应商1', 'g1', '111', '', '17', '2', '广州市天河区');
INSERT INTO `org` VALUES ('19', '实验室', 'sy', '111', '', '1', '3', null);
INSERT INTO `org` VALUES ('20', 'CQC华南实验室', 'cqc', '111', '', '19', '3', null);
INSERT INTO `org` VALUES ('21', '供应商2', 'g2', '111', '', '17', '2', '广州市海珠区');
INSERT INTO `org` VALUES ('22', '供应商3', 'g3', '111', '', '17', '2', '广州市白云区');
INSERT INTO `org` VALUES ('23', '其它实验室', 'qt', '2', '', '19', '3', '');

-- ----------------------------
-- Table structure for `parts`
-- ----------------------------
DROP TABLE IF EXISTS `parts`;
CREATE TABLE `parts` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` int(11) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `pro_time` date DEFAULT NULL,
  `place` varchar(100) DEFAULT NULL,
  `pro_no` varchar(50) DEFAULT NULL,
  `remark` varchar(200) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `org_id` bigint(20) DEFAULT NULL,
  `is_key` int(11) DEFAULT NULL,
  `key_code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of parts
-- ----------------------------

-- ----------------------------
-- Table structure for `pf_result`
-- ----------------------------
DROP TABLE IF EXISTS `pf_result`;
CREATE TABLE `pf_result` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `t_id` bigint(20) DEFAULT NULL,
  `project` varchar(100) DEFAULT NULL,
  `standard` varchar(500) DEFAULT NULL,
  `require` varchar(500) DEFAULT NULL,
  `result` varchar(500) DEFAULT NULL,
  `evaluate` varchar(500) DEFAULT NULL,
  `remark` varchar(200) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `catagory` int(11) DEFAULT NULL,
  `exp_no` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pf_result
-- ----------------------------

-- ----------------------------
-- Table structure for `role`
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `code` varchar(50) DEFAULT NULL,
  `grid` bigint(20) DEFAULT NULL,
  `desc` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', 'admin', 'admin', '22', '超级管理员');
INSERT INTO `role` VALUES ('14', 'PE_文员', 'pe_wy', '18', '上汽通用五菱PE-文员');
INSERT INTO `role` VALUES ('15', 'PE_工程师', 'pe_eng', '18', '上汽通用五菱PE-工程师');
INSERT INTO `role` VALUES ('16', 'PE_负责人', 'pe_leader', '18', '上汽通用五菱PE-负责人');
INSERT INTO `role` VALUES ('17', 'SQE_工程师', 'sqe_eng', '17', '');
INSERT INTO `role` VALUES ('18', 'SQE_负责人', 'sqe_leader', '17', '');
INSERT INTO `role` VALUES ('19', 'SQE_文员', 'sqe_wy', '17', '');
INSERT INTO `role` VALUES ('20', 'cqc实验室', 'cqc', '21', '');

-- ----------------------------
-- Table structure for `role_group`
-- ----------------------------
DROP TABLE IF EXISTS `role_group`;
CREATE TABLE `role_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `parentid` bigint(20) DEFAULT NULL,
  `desc` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role_group
-- ----------------------------
INSERT INTO `role_group` VALUES ('1', '角色', null, '根节点');
INSERT INTO `role_group` VALUES ('17', '上汽通用五菱SQE', '1', '上汽通用五菱SQE');
INSERT INTO `role_group` VALUES ('18', '上汽通用五菱PE', '1', '上汽通用五菱PE');
INSERT INTO `role_group` VALUES ('19', '上汽通用五菱TDC', '1', '上汽通用五菱TDC');
INSERT INTO `role_group` VALUES ('20', '上汽通用五菱供应商', '1', '上汽通用五菱供应商');
INSERT INTO `role_group` VALUES ('21', '实验室用户', '1', '实验室用户');
INSERT INTO `role_group` VALUES ('22', '系统维护人员', '1', '系统维护人员');

-- ----------------------------
-- Table structure for `role_permission`
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) NOT NULL,
  `permission` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role_permission
-- ----------------------------
INSERT INTO `role_permission` VALUES ('5', '1', 'account-1,role-2,log-2,home-2,area-2,org-2,menu-2,dictionary-2');
INSERT INTO `role_permission` VALUES ('11', '33', 'home-1,user-1,role-1');
INSERT INTO `role_permission` VALUES ('24', '14', '');
INSERT INTO `role_permission` VALUES ('26', '16', '17,18');
INSERT INTO `role_permission` VALUES ('27', '15', '17,18,19,20,42,43,45,46,48,49,51,52,2,3,12,13,11,14,10');

-- ----------------------------
-- Table structure for `task`
-- ----------------------------
DROP TABLE IF EXISTS `task`;
CREATE TABLE `task` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) DEFAULT NULL,
  `i_id` bigint(20) DEFAULT NULL,
  `org_id` bigint(20) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `parts_atl_id` bigint(20) DEFAULT NULL,
  `mat_atl_id` bigint(20) DEFAULT NULL,
  `parts_pat_id` bigint(20) DEFAULT NULL,
  `mat_pat_id` bigint(20) DEFAULT NULL,
  `remark` varchar(200) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `fail_num` int(11) DEFAULT NULL,
  `a_id` bigint(20) DEFAULT NULL,
  `parts_atl_result` int(11) DEFAULT NULL,
  `mat_atl_result` int(11) DEFAULT NULL,
  `parts_pat_result` int(11) DEFAULT NULL,
  `mat_pat_result` int(11) DEFAULT NULL,
  `parts_atl_times` int(11) unsigned DEFAULT '0',
  `mat_atl_times` int(11) unsigned DEFAULT '0',
  `parts_pat_times` int(11) unsigned DEFAULT '0',
  `mat_pat_times` int(11) unsigned DEFAULT '0',
  `confirm_time` timestamp NULL DEFAULT NULL,
  `info_apply` int(11) DEFAULT NULL,
  `result_apply` int(11) DEFAULT NULL,
  `t_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of task
-- ----------------------------

-- ----------------------------
-- Table structure for `task_info`
-- ----------------------------
DROP TABLE IF EXISTS `task_info`;
CREATE TABLE `task_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `applicant` varchar(50) DEFAULT NULL,
  `department` varchar(50) DEFAULT NULL,
  `figure` varchar(50) DEFAULT NULL,
  `num` int(11) DEFAULT NULL,
  `origin` varchar(200) DEFAULT NULL,
  `reason` varchar(200) DEFAULT NULL,
  `provenance` varchar(50) DEFAULT NULL,
  `task_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of task_info
-- ----------------------------
INSERT INTO `task_info` VALUES ('5', '', '', '', null, '', '', '', '169');
INSERT INTO `task_info` VALUES ('6', '', '', '', null, '', '', '', '170');
INSERT INTO `task_info` VALUES ('7', '', '', '', null, '', '', '', '172');
INSERT INTO `task_info` VALUES ('8', '', '', '', null, '', '', '', '173');
INSERT INTO `task_info` VALUES ('9', '丁', '内饰', '123', '1', '抽样', '', '', '174');
INSERT INTO `task_info` VALUES ('10', '', '', '', null, '', '', '', '176');
INSERT INTO `task_info` VALUES ('11', '赖家财', '内外饰', 'B11', '2', '现场', '实物抽查', '供应商', '182');
INSERT INTO `task_info` VALUES ('12', '赖家财', '内外饰', 'B152', '4', '供应商现场', 'PPAP', '供应商', '183');
INSERT INTO `task_info` VALUES ('13', '赖家财', '内外饰', 'B12', '4', '售后', '售后问题分析', '供应商', '184');
INSERT INTO `task_info` VALUES ('14', '赖家财', '内外饰', 'B12', '2', '供应商生产现场', '实物抽查', '供应商', '185');
INSERT INTO `task_info` VALUES ('15', '赖家财', '内外饰', 'B6', '1', '售后', '售后问题分析', 'SGMW', '186');
INSERT INTO `task_info` VALUES ('16', '周光发', '科室', 'B11', '5', '供应商生产线', '实物抽查', '供应商', '188');
INSERT INTO `task_info` VALUES ('17', '周光发', '内外饰', '1234', '45', '售后', '售后问题分析', 'SGMW', '189');
INSERT INTO `task_info` VALUES ('18', '周光发', '内外饰', '890', '1', 'SGMW 生产线旁', '实物抽查', '供应商', '190');
INSERT INTO `task_info` VALUES ('19', '周光发', '内外饰', '2345', '8', '供应商现场', '实物抽查', '供应商', '191');
INSERT INTO `task_info` VALUES ('20', '周光发', '内外饰', '2345', '1', '售后', '售后分析', '供应商', '192');
INSERT INTO `task_info` VALUES ('21', '秦晓恒', 'TS', '11111111', '1', '供应商现场', '现场问题1', 'SGMW1', '201');
INSERT INTO `task_info` VALUES ('22', '秦晓恒', 'TS', '22222222', '2', '总装2', '现场问题2', 'SGMW2', '202');
INSERT INTO `task_info` VALUES ('23', '秦晓恒', 'TS', '33333333', '3', '供应商现场3', '现场问题4', 'SGMW4', '203');
INSERT INTO `task_info` VALUES ('24', '秦晓恒', 'TS', '44444444', '4', '4S店4', '售后问题4', 'SGMW4', '204');
INSERT INTO `task_info` VALUES ('25', '秦晓恒', 'TS', '5555555555', '5', '4S店5', '现场问题5', 'SGMW5', '206');

-- ----------------------------
-- Table structure for `task_record`
-- ----------------------------
DROP TABLE IF EXISTS `task_record`;
CREATE TABLE `task_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) DEFAULT NULL,
  `a_id` bigint(20) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `remark` varchar(200) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `task_type` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=536 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of task_record
-- ----------------------------
INSERT INTO `task_record` VALUES ('521', '20171117001505', '1', '1', '填写信息', '2017-11-17 00:15:05', '1');
INSERT INTO `task_record` VALUES ('522', '20171117001505', '1', '2', '信息审核通过', '2017-11-17 00:15:09', '1');
INSERT INTO `task_record` VALUES ('523', '20171117001505', '1', '4', '分配任务到实验室', '2017-11-17 00:15:16', '1');
INSERT INTO `task_record` VALUES ('524', '20171117001505', '1', '5', '图谱和型式试验全部审批通过', '2017-11-17 00:15:21', '1');
INSERT INTO `task_record` VALUES ('525', '20171117001505', '1', '7', '上传零部件型式试验和原材料型式试验结果', '2017-11-17 00:15:32', '1');
INSERT INTO `task_record` VALUES ('526', '20171117001505', '1', '7', '上传零部件和原材料图谱试验结果', '2017-11-17 00:15:57', '1');
INSERT INTO `task_record` VALUES ('527', '20171117001505', '1', '8', '发送零部件图谱试验、零部件型式试验、原材料图谱试验、原材料型式试验结果', '2017-11-17 00:16:15', '1');
INSERT INTO `task_record` VALUES ('528', '20171117001505', '1', '10', '基准信息已保存', '2017-11-17 00:16:27', '1');
INSERT INTO `task_record` VALUES ('529', '20171117001505', '1', '9', '原材料图谱试验、原材料型式试验、零部件图谱试验、零部件型式试验结果确认合格', '2017-11-17 00:16:27', '1');
INSERT INTO `task_record` VALUES ('530', '20171117001722', '1', '1', '下达试验任务', '2017-11-17 00:17:22', '2');
INSERT INTO `task_record` VALUES ('531', '20171117001722', '1', '2', '审批通过', '2017-11-17 00:17:29', '2');
INSERT INTO `task_record` VALUES ('532', '20171117001722', '1', '4', '上传零部件和原材料图谱试验结果', '2017-11-17 00:17:51', '2');
INSERT INTO `task_record` VALUES ('533', '20171117001722', '1', '5', '提交对比结果', '2017-11-17 00:17:59', '2');
INSERT INTO `task_record` VALUES ('534', '20171117001722', '1', '8', '发送零部件图谱试验、原材料图谱试验结果', '2017-11-17 00:18:15', '2');
INSERT INTO `task_record` VALUES ('535', '20171117001722', '1', '9', '结果留存', '2017-11-17 00:18:24', '2');

-- ----------------------------
-- Table structure for `vehicle`
-- ----------------------------
DROP TABLE IF EXISTS `vehicle`;
CREATE TABLE `vehicle` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `pro_time` date DEFAULT NULL,
  `pro_addr` varchar(100) DEFAULT NULL,
  `remark` varchar(200) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of vehicle
-- ----------------------------
