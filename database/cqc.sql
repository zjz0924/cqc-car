/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50556
Source Host           : localhost:3306
Source Database       : cqc

Target Server Type    : MYSQL
Target Server Version : 50556
File Encoding         : 65001

Date: 2017-11-16 02:49:33
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
INSERT INTO `account` VALUES ('1', 'admin', 'admin', 'E10ADC3949BA59ABBE56E057F20F883E', '13434343422', '2016-12-18 23:06:04', 'N', '1', '15', '2342339261@qq.com', '', '1', null);
INSERT INTO `account` VALUES ('7', 'bill', 'ad', 'E10ADC3949BA59ABBE56E057F20F883E', '13512342323', '2017-06-21 23:30:12', 'N', '15', '15', '12312@qq.com', '', '1', null);
INSERT INTO `account` VALUES ('8', 'lily', 'lily', 'E10ADC3949BA59ABBE56E057F20F883E', '13723423434', '2017-06-21 23:30:34', 'N', '17', '14', '12313123@qq.com', '', '1', null);
INSERT INTO `account` VALUES ('13', 'William', 'William', 'E10ADC3949BA59ABBE56E057F20F883E', '15918703417', '2017-06-21 23:33:15', 'N', '17', '20', '12313123@qq.com', '', '1', null);

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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of apply_record
-- ----------------------------
INSERT INTO `apply_record` VALUES ('24', '41', null, null, '59', '1', '1', null, null, '1', null, '2017-11-15 23:33:48', '2017-11-15 23:34:01');

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
INSERT INTO `area` VALUES ('8', '006', '江门', '1', null);
INSERT INTO `area` VALUES ('24', '007', '天河区', '2', '天');
INSERT INTO `area` VALUES ('89', '008', '白云区', '2', '白云区');
INSERT INTO `area` VALUES ('90', '009', '荔湾区', '2', '荔湾区');
INSERT INTO `area` VALUES ('92', 'ab', 'ab', '2', '');
INSERT INTO `area` VALUES ('94', 'aaa', 'ab', '5', '');
INSERT INTO `area` VALUES ('95', 'ac', 'ac', '92', '');
INSERT INTO `area` VALUES ('96', 'ad', 'ac', '24', 'asdfaf');
INSERT INTO `area` VALUES ('97', 'abab', 'ab', '92', '');
INSERT INTO `area` VALUES ('104', 'sdf', 'xcv', '92', '');
INSERT INTO `area` VALUES ('105', 'test', null, '4', 'asdfad');
INSERT INTO `area` VALUES ('106', 'a', 'a', '97', '');
INSERT INTO `area` VALUES ('111', 'bb', 'bb', '106', '123');

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
) ENGINE=InnoDB AUTO_INCREMENT=217 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of atlas_result
-- ----------------------------
INSERT INTO `atlas_result` VALUES ('178', '59', '3', 'atlas/59/parts/tg/热重.png', '热重分析', '2017-11-15 23:27:50', '1', '1');
INSERT INTO `atlas_result` VALUES ('179', '59', '1', 'atlas/59/parts/inf/红外光.png', '红外光分析', '2017-11-15 23:27:50', '1', '1');
INSERT INTO `atlas_result` VALUES ('180', '59', '2', 'atlas/59/parts/dt/差热.png', '差热扫描', '2017-11-15 23:27:50', '1', '1');
INSERT INTO `atlas_result` VALUES ('181', '59', '3', 'atlas/59/material/tg/热重.png', '热重分析', '2017-11-15 23:27:50', '2', '1');
INSERT INTO `atlas_result` VALUES ('182', '59', '1', 'atlas/59/material/inf/红外光.png', '红外光分析', '2017-11-15 23:27:50', '2', '1');
INSERT INTO `atlas_result` VALUES ('183', '59', '2', 'atlas/59/material/dt/差热.png', '差热扫描', '2017-11-15 23:27:50', '2', '1');
INSERT INTO `atlas_result` VALUES ('184', '60', '3', 'atlas/60/parts/tg/热重.png', '', '2017-11-15 23:36:24', '1', '1');
INSERT INTO `atlas_result` VALUES ('185', '60', '1', 'atlas/60/parts/inf/红外光.png', '', '2017-11-15 23:36:24', '1', '1');
INSERT INTO `atlas_result` VALUES ('186', '60', '2', 'atlas/60/parts/dt/差热.png', '', '2017-11-15 23:36:24', '1', '1');
INSERT INTO `atlas_result` VALUES ('187', '60', '3', 'atlas/60/material/tg/热重.png', '', '2017-11-15 23:36:24', '2', '1');
INSERT INTO `atlas_result` VALUES ('188', '60', '1', 'atlas/60/material/inf/红外光.png', '', '2017-11-15 23:36:24', '2', '1');
INSERT INTO `atlas_result` VALUES ('189', '60', '2', 'atlas/60/material/dt/差热.png', '', '2017-11-15 23:36:24', '2', '1');
INSERT INTO `atlas_result` VALUES ('190', '61', '3', 'atlas/61/parts/tg/热重.png', '', '2017-11-15 23:39:36', '1', '1');
INSERT INTO `atlas_result` VALUES ('191', '61', '1', 'atlas/61/parts/inf/红外光.png', '', '2017-11-15 23:39:36', '1', '1');
INSERT INTO `atlas_result` VALUES ('192', '61', '2', 'atlas/61/parts/dt/差热.png', '', '2017-11-15 23:39:36', '1', '1');
INSERT INTO `atlas_result` VALUES ('193', '61', '3', 'atlas/61/material/tg/热重.png', '', '2017-11-15 23:39:36', '2', '1');
INSERT INTO `atlas_result` VALUES ('194', '61', '1', 'atlas/61/material/inf/红外光.png', '', '2017-11-15 23:39:36', '2', '1');
INSERT INTO `atlas_result` VALUES ('195', '61', '2', 'atlas/61/material/dt/差热.png', '', '2017-11-15 23:39:36', '2', '1');
INSERT INTO `atlas_result` VALUES ('196', '62', '3', 'atlas/62/parts/tg/热重.png', '', '2017-11-15 23:44:31', '1', '1');
INSERT INTO `atlas_result` VALUES ('197', '62', '1', 'atlas/62/parts/inf/差热.png', '', '2017-11-15 23:44:31', '1', '1');
INSERT INTO `atlas_result` VALUES ('198', '62', '2', 'atlas/62/parts/dt/抽样.png', '', '2017-11-15 23:44:31', '1', '1');
INSERT INTO `atlas_result` VALUES ('199', '62', '3', 'atlas/62/material/tg/差热.png', '', '2017-11-15 23:44:31', '2', '1');
INSERT INTO `atlas_result` VALUES ('200', '62', '1', 'atlas/62/material/inf/抽样.png', '', '2017-11-15 23:44:31', '2', '1');
INSERT INTO `atlas_result` VALUES ('201', '62', '2', 'atlas/62/material/dt/红外光.png', '', '2017-11-15 23:44:31', '2', '1');
INSERT INTO `atlas_result` VALUES ('202', '63', '3', 'atlas/63/parts/tg/抽样.png', '', '2017-11-15 23:50:19', '1', '1');
INSERT INTO `atlas_result` VALUES ('203', '63', '1', 'atlas/63/parts/inf/差热.png', '', '2017-11-15 23:50:19', '1', '1');
INSERT INTO `atlas_result` VALUES ('204', '63', '2', 'atlas/63/parts/dt/红外光.png', '', '2017-11-15 23:50:19', '1', '1');
INSERT INTO `atlas_result` VALUES ('205', '63', '3', 'atlas/63/material/tg/抽样.png', '', '2017-11-15 23:50:19', '2', '1');
INSERT INTO `atlas_result` VALUES ('206', '63', '1', 'atlas/63/material/inf/基准任务申请2.png', '', '2017-11-15 23:50:19', '2', '1');
INSERT INTO `atlas_result` VALUES ('207', '63', '2', 'atlas/63/material/dt/基准任务申请1.png', '', '2017-11-15 23:50:19', '2', '1');
INSERT INTO `atlas_result` VALUES ('208', '64', '3', 'atlas/64/parts/tg/差热.png', '', '2017-11-15 23:53:47', '1', '1');
INSERT INTO `atlas_result` VALUES ('209', '64', '1', 'atlas/64/parts/inf/抽样.png', '', '2017-11-15 23:53:47', '1', '1');
INSERT INTO `atlas_result` VALUES ('210', '64', '2', 'atlas/64/parts/dt/红外光.png', '', '2017-11-15 23:53:47', '1', '1');
INSERT INTO `atlas_result` VALUES ('211', '64', '3', 'atlas/64/material/tg/差热.png', '', '2017-11-15 23:53:47', '2', '1');
INSERT INTO `atlas_result` VALUES ('212', '64', '1', 'atlas/64/material/inf/对比.jpg', '', '2017-11-15 23:53:47', '2', '1');
INSERT INTO `atlas_result` VALUES ('213', '64', '2', 'atlas/64/material/dt/红外光.png', '', '2017-11-15 23:53:47', '2', '1');
INSERT INTO `atlas_result` VALUES ('214', '65', '3', 'atlas/65/material/tg/差热.png', '', '2017-11-16 00:14:44', '2', '1');
INSERT INTO `atlas_result` VALUES ('215', '65', '1', 'atlas/65/material/inf/抽样.png', '', '2017-11-16 00:14:44', '2', '1');
INSERT INTO `atlas_result` VALUES ('216', '65', '2', 'atlas/65/material/dt/对比.jpg', '', '2017-11-16 00:14:44', '2', '1');

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
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cost_record
-- ----------------------------
INSERT INTO `cost_record` VALUES ('28', '59', '1', '20', '15', '1', null, '2017-11-15 23:28:39', '1', '1', '2017-11-16 02:22:29', '1');
INSERT INTO `cost_record` VALUES ('29', '59', '1', '20', null, '0', null, '2017-11-15 23:28:39', '1', '2', null, '1');
INSERT INTO `cost_record` VALUES ('30', '59', '1', '20', null, '0', null, '2017-11-15 23:28:39', '1', '3', null, '1');
INSERT INTO `cost_record` VALUES ('31', '59', '1', '20', null, '0', null, '2017-11-15 23:28:39', '1', '4', null, '1');
INSERT INTO `cost_record` VALUES ('32', '60', '1', '20', null, '0', null, '2017-11-15 23:37:53', '1', '1', null, '1');
INSERT INTO `cost_record` VALUES ('33', '60', '1', '20', '15', '1', null, '2017-11-15 23:37:53', '1', '3', '2017-11-16 02:40:35', '1');
INSERT INTO `cost_record` VALUES ('38', '63', '1', '20', '15', '1', null, '2017-11-15 23:50:54', '1', '1', '2017-11-16 02:34:10', '2');
INSERT INTO `cost_record` VALUES ('39', '63', '1', '20', '15', '1', null, '2017-11-15 23:50:54', '1', '3', '2017-11-16 02:33:19', '2');
INSERT INTO `cost_record` VALUES ('40', '64', '1', '20', '15', '1', null, '2017-11-15 23:54:20', '1', '1', '2017-11-16 02:13:04', '2');
INSERT INTO `cost_record` VALUES ('41', '64', '1', '20', '15', '1', null, '2017-11-15 23:54:20', '1', '3', '2017-11-16 02:32:06', '2');
INSERT INTO `cost_record` VALUES ('42', '65', '1', '20', '21', '1', null, '2017-11-16 00:15:04', '1', '3', '2017-11-16 01:21:46', '1');
INSERT INTO `cost_record` VALUES ('43', '65', '1', '20', '18', '1', null, '2017-11-16 00:15:04', '1', '4', '2017-11-16 02:12:14', '1');

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
  `content` varchar(2000) DEFAULT NULL,
  `addr` varchar(1000) DEFAULT NULL,
  `task_id` bigint(20) DEFAULT NULL,
  `a_id` bigint(20) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `orgin_email` varchar(50) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of email_record
-- ----------------------------
INSERT INTO `email_record` VALUES ('32', '实验结果', '任务号：20171115232625，已完成零部件图谱试验并已上传结果，请及时确认结果。', '12312@qq.com', '59', '1', '1', '1', '314269261@qq.com', '2017-11-15 23:28:21');
INSERT INTO `email_record` VALUES ('33', '实验结果', '任务号：20171115232625，已完成零部件型式试验并已上传结果，请及时确认结果。', '12312@qq.com', '59', '1', '1', '1', '314269261@qq.com', '2017-11-15 23:28:21');
INSERT INTO `email_record` VALUES ('34', '实验结果', '任务号：20171115232625，已完成原材料图谱试验并已上传结果，请及时确认结果。', '12312@qq.com', '59', '1', '1', '1', '314269261@qq.com', '2017-11-15 23:28:21');
INSERT INTO `email_record` VALUES ('35', '实验结果', '任务号：20171115232625，已完成原材料型式试验并已上传结果，请及时确认结果。', '12312@qq.com', '59', '1', '1', '1', '314269261@qq.com', '2017-11-15 23:28:21');
INSERT INTO `email_record` VALUES ('36', '实验结果', '任务号：20171115233544，已完成零部件图谱试验并已上传结果，请及时确认结果。', '12312@qq.com', '60', '1', '1', '1', '314269261@qq.com', '2017-11-15 23:36:56');
INSERT INTO `email_record` VALUES ('37', '实验结果', '任务号：20171115233544，已完成原材料图谱试验并已上传结果，请及时确认结果。', '12312@qq.com', '60', '1', '1', '1', '314269261@qq.com', '2017-11-15 23:36:56');
INSERT INTO `email_record` VALUES ('42', '实验结果', '任务号：20171115234952，已完成零部件图谱试验并已上传结果，请及时确认结果。', '12312@qq.com', '63', '1', '2', '1', '314269261@qq.com', '2017-11-15 23:50:37');
INSERT INTO `email_record` VALUES ('43', '实验结果', '任务号：20171115234952，已完成原材料图谱试验并已上传结果，请及时确认结果。', '12312@qq.com', '63', '1', '2', '1', '314269261@qq.com', '2017-11-15 23:50:37');
INSERT INTO `email_record` VALUES ('44', '实验结果', '任务号：20171115234952-R1，已完成零部件图谱试验并已上传结果，请及时确认结果。', '12312@qq.com', '64', '1', '2', '1', '314269261@qq.com', '2017-11-15 23:54:03');
INSERT INTO `email_record` VALUES ('45', '实验结果', '任务号：20171115234952-R1，已完成原材料图谱试验并已上传结果，请及时确认结果。', '12312@qq.com', '64', '1', '2', '1', '314269261@qq.com', '2017-11-15 23:54:03');
INSERT INTO `email_record` VALUES ('46', '警告书', '任务号：20171115234952-R1，二次抽样均失败，第二次失败原因：2次不合格，请及时查清原因。', '2420292077@qq.com', '64', '1', '2', '3', '314269261@qq.com', '2017-11-15 23:54:20');
INSERT INTO `email_record` VALUES ('47', '实验结果', '任务号：20171116001359，已完成原材料图谱试验并已上传结果，请及时确认结果。', '12312@qq.com', '65', '1', '2', '1', '314269261@qq.com', '2017-11-16 00:14:54');
INSERT INTO `email_record` VALUES ('48', '实验结果', '任务号：20171116001359，已完成原材料型式试验并已上传结果，请及时确认结果。', '12312@qq.com', '65', '1', '2', '1', '314269261@qq.com', '2017-11-16 00:14:54');
INSERT INTO `email_record` VALUES ('49', '费用清单', '<div>任务号：20171115234952-R1，已完成零部件图谱试验实验，收费信息如下：</div><div><table style=\'margin-left: 5px;font-size: 14px;\'><tr style=\'height: 30px\'><td style=\'width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;\'>序号</td><td style=\'width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;\'>试验项目</td><td style=\'width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;\'>参考标准</td><td style=\'width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;\'>单价（元）</td><td style=\'width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;\'>数量</td><td style=\'width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;\'>价格（元）</td><td style=\'width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;\'>备注</td></tr><tr style=\'height: 30px\'><td style=\'background: #f5f5f5;padding-left: 5px;\'>1</td><td style=\'background: #f5f5f5;padding-left: 5px;\'>1</td><td style=\'background: #f5f5f5;padding-left: 5px;\'>a</td><td>1.0</td><td style=\'background: #f5f5f5;padding-left: 5px;\'>1</td><td>1.0</td><td style=\'background: #f5f5f5;padding-left: 5px;\'>1</td></tr></table></div>', '12312@qq.com,2342339261@qq.com', '64', '1', '1', '2', '', '2017-11-16 02:13:04');
INSERT INTO `email_record` VALUES ('50', '费用清单', '<div>任务号：20171115232625，已完成零部件图谱试验实验，收费信息如下：</div><div><table style=\'margin-left: 5px;font-size: 14px;\'><tr style=\'height: 30px\'><td style=\'width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;\'>序号</td><td style=\'width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;\'>试验项目</td><td style=\'width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;\'>参考标准</td><td style=\'width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;\'>单价（元）</td><td style=\'width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;\'>数量</td><td style=\'width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;\'>价格（元）</td><td style=\'width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;\'>备注</td></tr><tr style=\'height: 30px\'><td style=\'background: #f5f5f5;padding-left: 5px;\'>1</td><td style=\'background: #f5f5f5;padding-left: 5px;\'>1</td><td style=\'background: #f5f5f5;padding-left: 5px;\'>1</td><td>11.0</td><td style=\'background: #f5f5f5;padding-left: 5px;\'>11</td><td>121.0</td><td style=\'background: #f5f5f5;padding-left: 5px;\'></td></tr><tr style=\'height: 30px\'><td style=\'background: #f5f5f5;padding-left: 5px;\'>2</td><td style=\'background: #f5f5f5;padding-left: 5px;\'>1</td><td style=\'background: #f5f5f5;padding-left: 5px;\'>1</td><td>11.0</td><td style=\'background: #f5f5f5;padding-left: 5px;\'>11</td><td>121.0</td><td style=\'background: #f5f5f5;padding-left: 5px;\'></td></tr><tr style=\'height: 30px\'><td style=\'background: #f5f5f5;padding-left: 5px;\'>3</td><td style=\'background: #f5f5f5;padding-left: 5px;\'>1</td><td style=\'background: #f5f5f5;padding-left: 5px;\'>1</td><td>11.0</td><td style=\'background: #f5f5f5;padding-left: 5px;\'>11</td><td>121.0</td><td style=\'background: #f5f5f5;padding-left: 5px;\'></td></tr></table></div>', '12312@qq.com;2342339261@qq.com', '59', '1', '1', '2', '', '2017-11-16 02:22:29');
INSERT INTO `email_record` VALUES ('51', '费用清单', '<div>任务号：20171115232625，已完成零部件图谱试验实验，收费信息如下：</div><div><table style=\'margin-left: 5px;font-size: 14px;\'><tr style=\'height: 30px\'><td style=\'width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;\'>序号</td><td style=\'width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;\'>试验项目</td><td style=\'width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;\'>参考标准</td><td style=\'width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;\'>单价（元）</td><td style=\'width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;\'>数量</td><td style=\'width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;\'>价格（元）</td><td style=\'width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;\'>备注</td></tr><tr style=\'height: 30px\'><td style=\'background: #f5f5f5;padding-left: 5px;\'>1</td><td style=\'background: #f5f5f5;padding-left: 5px;\'>a</td><td style=\'background: #f5f5f5;padding-left: 5px;\'>a</td><td>11.0</td><td style=\'background: #f5f5f5;padding-left: 5px;\'>11</td><td>121.0</td><td style=\'background: #f5f5f5;padding-left: 5px;\'></td></tr></table></div>', '12312@qq.com;2342339261@qq.com', '64', '1', '1', '2', '', '2017-11-16 02:32:14');
INSERT INTO `email_record` VALUES ('52', '费用清单', '<div>任务号：20171115232625，已完成零部件图谱试验实验，收费信息如下：</div><div><table style=\'margin-left: 5px;font-size: 14px;\'><tr style=\'height: 30px\'><td style=\'width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;\'>序号</td><td style=\'width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;\'>试验项目</td><td style=\'width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;\'>参考标准</td><td style=\'width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;\'>单价（元）</td><td style=\'width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;\'>数量</td><td style=\'width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;\'>价格（元）</td><td style=\'width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;\'>备注</td></tr><tr style=\'height: 30px\'><td style=\'background: #f5f5f5;padding-left: 5px;\'>1</td><td style=\'background: #f5f5f5;padding-left: 5px;\'>a</td><td style=\'background: #f5f5f5;padding-left: 5px;\'>a11</td><td>1.0</td><td style=\'background: #f5f5f5;padding-left: 5px;\'>1</td><td>1.0</td><td style=\'background: #f5f5f5;padding-left: 5px;\'></td></tr></table></div>', '12312@qq.com;2342339261@qq.com', '63', '1', '1', '2', '', '2017-11-16 02:33:21');
INSERT INTO `email_record` VALUES ('53', '费用清单', '<div>任务号：20171115232625，已完成零部件图谱试验实验，收费信息如下：</div><div><table style=\'margin-left: 5px;font-size: 14px;\'><tr style=\'height: 30px\'><td style=\'width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;\'>序号</td><td style=\'width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;\'>试验项目</td><td style=\'width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;\'>参考标准</td><td style=\'width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;\'>单价（元）</td><td style=\'width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;\'>数量</td><td style=\'width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;\'>价格（元）</td><td style=\'width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;\'>备注</td></tr><tr style=\'height: 30px\'><td style=\'background: #f5f5f5;padding-left: 5px;\'>1</td><td style=\'background: #f5f5f5;padding-left: 5px;\'>asd</td><td style=\'background: #f5f5f5;padding-left: 5px;\'>asd</td><td>12.0</td><td style=\'background: #f5f5f5;padding-left: 5px;\'>1</td><td>12.0</td><td style=\'background: #f5f5f5;padding-left: 5px;\'></td></tr></table></div>', '12312@qq.com,2342339261@qq.com', '63', '1', '2', '2', '', '2017-11-16 02:34:12');
INSERT INTO `email_record` VALUES ('54', '费用清单', '<div>任务号：20171115232625，已完成零部件图谱试验实验，收费信息如下：</div><div><table style=\'margin-left: 5px;font-size: 14px;\'><tr style=\'height: 30px\'><td style=\'width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;\'>序号</td><td style=\'width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;\'>试验项目</td><td style=\'width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;\'>参考标准</td><td style=\'width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;\'>单价（元）</td><td style=\'width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;\'>数量</td><td style=\'width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;\'>价格（元）</td><td style=\'width:13%;background: #F0F0F0;padding-left: 5px;font-weight: bold;\'>备注</td></tr><tr style=\'height: 30px\'><td style=\'background: #f5f5f5;padding-left: 5px;\'>1</td><td style=\'background: #f5f5f5;padding-left: 5px;\'>asd</td><td style=\'background: #f5f5f5;padding-left: 5px;\'>asd</td><td>121.0</td><td style=\'background: #f5f5f5;padding-left: 5px;\'>1</td><td>121.0</td><td style=\'background: #f5f5f5;padding-left: 5px;\'>1</td></tr></table></div>', '12312@qq.com,2342339261@qq.com', '60', '1', '2', '2', '', '2017-11-16 02:40:38');

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
) ENGINE=InnoDB AUTO_INCREMENT=320 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of examine_record
-- ----------------------------
INSERT INTO `examine_record` VALUES ('260', '59', '1', '1', '', '2017-11-15 23:26:36', '1', null, '1');
INSERT INTO `examine_record` VALUES ('261', '59', '1', '1', '', '2017-11-15 23:26:51', '2', '5', '1');
INSERT INTO `examine_record` VALUES ('262', '59', '1', '1', '原材料图谱试验、原材料型式试验、零部件图谱试验、零部件型式试验结果确认合格', '2017-11-15 23:28:39', '3', '5', '1');
INSERT INTO `examine_record` VALUES ('263', '59', '1', '1', '', '2017-11-15 23:34:01', '2', '6', '1');
INSERT INTO `examine_record` VALUES ('264', '60', '1', '1', '', '2017-11-15 23:35:53', '2', null, '2');
INSERT INTO `examine_record` VALUES ('265', '60', '1', '1', '', '2017-11-15 23:36:37', '4', '1', '2');
INSERT INTO `examine_record` VALUES ('266', '60', '1', '1', '', '2017-11-15 23:36:37', '4', '2', '2');
INSERT INTO `examine_record` VALUES ('267', '60', '1', '1', '', '2017-11-15 23:36:37', '4', '3', '2');
INSERT INTO `examine_record` VALUES ('268', '60', '1', '1', '', '2017-11-15 23:36:37', '4', '4', '2');
INSERT INTO `examine_record` VALUES ('269', '60', '1', '1', '', '2017-11-15 23:36:37', '4', '5', '2');
INSERT INTO `examine_record` VALUES ('270', '60', '1', '1', '', '2017-11-15 23:36:37', '4', '6', '2');
INSERT INTO `examine_record` VALUES ('271', '60', '1', '1', '', '2017-11-15 23:36:37', '4', '7', '2');
INSERT INTO `examine_record` VALUES ('272', '60', '1', '1', '', '2017-11-15 23:36:37', '4', '8', '2');
INSERT INTO `examine_record` VALUES ('273', '60', '1', '1', '结果合格', '2017-11-15 23:37:53', '3', null, '2');
INSERT INTO `examine_record` VALUES ('274', '61', '1', '1', '', '2017-11-15 23:39:12', '2', null, '3');
INSERT INTO `examine_record` VALUES ('275', '61', '1', '1', '', '2017-11-15 23:39:44', '4', '1', '2');
INSERT INTO `examine_record` VALUES ('276', '61', '1', '1', '', '2017-11-15 23:39:44', '4', '2', '2');
INSERT INTO `examine_record` VALUES ('277', '61', '1', '1', '', '2017-11-15 23:39:44', '4', '3', '2');
INSERT INTO `examine_record` VALUES ('278', '61', '1', '1', '', '2017-11-15 23:39:44', '4', '4', '2');
INSERT INTO `examine_record` VALUES ('279', '61', '1', '1', '', '2017-11-15 23:39:44', '4', '5', '2');
INSERT INTO `examine_record` VALUES ('280', '61', '1', '1', '', '2017-11-15 23:39:44', '4', '6', '2');
INSERT INTO `examine_record` VALUES ('281', '61', '1', '1', '', '2017-11-15 23:39:44', '4', '7', '2');
INSERT INTO `examine_record` VALUES ('282', '61', '1', '1', '', '2017-11-15 23:39:44', '4', '8', '2');
INSERT INTO `examine_record` VALUES ('283', '61', '1', '2', '第一次抽样结果不合格，原因：测试第一次不合格', '2017-11-15 23:40:15', '3', null, '2');
INSERT INTO `examine_record` VALUES ('284', '61', '1', '1', '进行二次抽样', '2017-11-15 23:42:28', '5', null, '2');
INSERT INTO `examine_record` VALUES ('285', '62', '1', '1', '', '2017-11-15 23:44:04', '2', null, '3');
INSERT INTO `examine_record` VALUES ('286', '62', '1', '1', '', '2017-11-15 23:44:38', '4', '1', '2');
INSERT INTO `examine_record` VALUES ('287', '62', '1', '1', '', '2017-11-15 23:44:38', '4', '2', '2');
INSERT INTO `examine_record` VALUES ('288', '62', '1', '1', '', '2017-11-15 23:44:38', '4', '3', '2');
INSERT INTO `examine_record` VALUES ('289', '62', '1', '1', '', '2017-11-15 23:44:38', '4', '4', '2');
INSERT INTO `examine_record` VALUES ('290', '62', '1', '1', '', '2017-11-15 23:44:38', '4', '5', '2');
INSERT INTO `examine_record` VALUES ('291', '62', '1', '1', '', '2017-11-15 23:44:38', '4', '6', '2');
INSERT INTO `examine_record` VALUES ('292', '62', '1', '1', '', '2017-11-15 23:44:38', '4', '7', '2');
INSERT INTO `examine_record` VALUES ('293', '62', '1', '1', '', '2017-11-15 23:44:38', '4', '8', '2');
INSERT INTO `examine_record` VALUES ('294', '62', '1', '2', '第一次抽样结果不合格，原因：测试2次不合格', '2017-11-15 23:45:15', '3', null, '2');
INSERT INTO `examine_record` VALUES ('295', '63', '1', '1', '', '2017-11-15 23:50:00', '2', null, '2');
INSERT INTO `examine_record` VALUES ('296', '63', '1', '1', '', '2017-11-15 23:50:26', '4', '1', '2');
INSERT INTO `examine_record` VALUES ('297', '63', '1', '1', '', '2017-11-15 23:50:26', '4', '2', '2');
INSERT INTO `examine_record` VALUES ('298', '63', '1', '1', '', '2017-11-15 23:50:26', '4', '3', '2');
INSERT INTO `examine_record` VALUES ('299', '63', '1', '1', '', '2017-11-15 23:50:26', '4', '4', '2');
INSERT INTO `examine_record` VALUES ('300', '63', '1', '1', '', '2017-11-15 23:50:26', '4', '5', '2');
INSERT INTO `examine_record` VALUES ('301', '63', '1', '1', '', '2017-11-15 23:50:26', '4', '6', '2');
INSERT INTO `examine_record` VALUES ('302', '63', '1', '1', '', '2017-11-15 23:50:26', '4', '7', '2');
INSERT INTO `examine_record` VALUES ('303', '63', '1', '1', '', '2017-11-15 23:50:26', '4', '8', '2');
INSERT INTO `examine_record` VALUES ('304', '63', '1', '2', '第一次抽样结果不合格，原因：第一次不合格', '2017-11-15 23:50:54', '3', null, '2');
INSERT INTO `examine_record` VALUES ('305', '63', '1', '1', '进行二次抽样', '2017-11-15 23:52:19', '5', null, '2');
INSERT INTO `examine_record` VALUES ('306', '62', '1', '2', '中止任务，原因：asdf', '2017-11-15 23:52:41', '5', null, '2');
INSERT INTO `examine_record` VALUES ('307', '64', '1', '1', '', '2017-11-15 23:53:29', '2', null, '2');
INSERT INTO `examine_record` VALUES ('308', '64', '1', '1', '', '2017-11-15 23:53:54', '4', '1', '2');
INSERT INTO `examine_record` VALUES ('309', '64', '1', '1', '', '2017-11-15 23:53:54', '4', '2', '2');
INSERT INTO `examine_record` VALUES ('310', '64', '1', '1', '', '2017-11-15 23:53:54', '4', '3', '2');
INSERT INTO `examine_record` VALUES ('311', '64', '1', '1', '', '2017-11-15 23:53:54', '4', '4', '2');
INSERT INTO `examine_record` VALUES ('312', '64', '1', '1', '', '2017-11-15 23:53:54', '4', '5', '2');
INSERT INTO `examine_record` VALUES ('313', '64', '1', '1', '', '2017-11-15 23:53:54', '4', '6', '2');
INSERT INTO `examine_record` VALUES ('314', '64', '1', '1', '', '2017-11-15 23:53:54', '4', '7', '2');
INSERT INTO `examine_record` VALUES ('315', '64', '1', '1', '', '2017-11-15 23:53:54', '4', '8', '2');
INSERT INTO `examine_record` VALUES ('316', '64', '1', '2', '第二次抽样结果不合格，原因：2次不合格', '2017-11-15 23:54:20', '3', null, '2');
INSERT INTO `examine_record` VALUES ('317', '65', '1', '1', '', '2017-11-16 00:14:06', '1', null, '4');
INSERT INTO `examine_record` VALUES ('318', '65', '1', '1', '', '2017-11-16 00:14:20', '2', '5', '4');
INSERT INTO `examine_record` VALUES ('319', '65', '1', '1', '原材料图谱试验、原材料型式试验结果确认合格', '2017-11-16 00:15:04', '3', '5', '1');

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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of exp_item
-- ----------------------------
INSERT INTO `exp_item` VALUES ('1', '1', 'a', 'a', '1', '1', '1', '11', '2017-11-16 01:21:46', '42');
INSERT INTO `exp_item` VALUES ('2', '1', 'a', 'a', '1', '1', '1', '1', '2017-11-16 02:12:14', '43');
INSERT INTO `exp_item` VALUES ('3', '1', '1', 'a', '1', '1', '1', '1', '2017-11-16 02:13:04', '40');
INSERT INTO `exp_item` VALUES ('4', '1', '1', '1', '11', '11', '121', '', '2017-11-16 02:22:29', '28');
INSERT INTO `exp_item` VALUES ('5', '1', '1', '1', '11', '11', '121', '', '2017-11-16 02:22:29', '28');
INSERT INTO `exp_item` VALUES ('6', '1', '1', '1', '11', '11', '121', '', '2017-11-16 02:22:29', '28');
INSERT INTO `exp_item` VALUES ('7', '1', 'a', 'a', '11', '11', '121', '', '2017-11-16 02:32:03', '41');
INSERT INTO `exp_item` VALUES ('8', '1', 'a', 'a11', '1', '1', '1', '', '2017-11-16 02:33:17', '39');
INSERT INTO `exp_item` VALUES ('9', '1', 'asd', 'asd', '12', '1', '12', '', '2017-11-16 02:34:08', '38');
INSERT INTO `exp_item` VALUES ('10', '1', 'asd', 'asd', '121', '1', '121', '1', '2017-11-16 02:40:32', '33');

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
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of info
-- ----------------------------
INSERT INTO `info` VALUES ('56', '37', '38', '47', '1', '0', null, '2017-11-15 22:45:45');
INSERT INTO `info` VALUES ('57', '41', '39', '48', '1', '1', null, '2017-11-15 23:26:25');
INSERT INTO `info` VALUES ('58', '41', null, '49', '1', '1', null, '2017-11-16 00:13:59');

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
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of material
-- ----------------------------
INSERT INTO `material` VALUES ('48', '1', '橡胶', '0001', '黑色', 'No.0001', null, '', '2017-11-15 23:26:25', '1', '21');
INSERT INTO `material` VALUES ('49', '1', '钢材', '00001', '银色', 'No.0001', null, '', '2017-11-16 00:13:59', '1', '18');

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
) ENGINE=InnoDB AUTO_INCREMENT=1423 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of operation_log
-- ----------------------------
INSERT INTO `operation_log` VALUES ('1356', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-15 23:26:25', '任务申请，任务号：20171115232625', '任务管理', '申请');
INSERT INTO `operation_log` VALUES ('1357', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-15 23:26:36', '任务：20171115232625，审核通过', '任务管理', '审核');
INSERT INTO `operation_log` VALUES ('1358', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-15 23:26:43', '下达任务，任务号：20171115232625', '任务管理', '下达任务');
INSERT INTO `operation_log` VALUES ('1359', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-15 23:26:51', '审批任务，任务号：20171115232625，审批结果：图谱和型式试验全部审批通过', '任务管理', '审批任务');
INSERT INTO `operation_log` VALUES ('1360', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-15 23:27:07', '上传零部件型式试验和原材料型式试验结果，任务号：20171115232625', '任务管理', '上传型式结果');
INSERT INTO `operation_log` VALUES ('1361', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-15 23:27:51', '上传零部件和原材料图谱试验结果，任务号：20171115232625', '任务管理', '上传图谱结果');
INSERT INTO `operation_log` VALUES ('1362', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-15 23:28:26', '发送零部件图谱试验、零部件型式试验、原材料图谱试验、原材料型式试验结果，任务号：20171115232625', '任务管理', '结果发送');
INSERT INTO `operation_log` VALUES ('1363', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-15 23:28:39', '原材料图谱试验、原材料型式试验、零部件图谱试验、零部件型式试验结果确认合格，任务号：20171115232625', '任务管理', '结果确认');
INSERT INTO `operation_log` VALUES ('1364', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-15 23:33:10', null, '用户管理', '登录');
INSERT INTO `operation_log` VALUES ('1365', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-15 23:33:48', '申请信息修改，任务号：20171115232625', '申请管理', '信息修改申请');
INSERT INTO `operation_log` VALUES ('1366', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-15 23:35:44', '下达任务，任务号：20171115233544', '任务管理', '下达任务');
INSERT INTO `operation_log` VALUES ('1367', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-15 23:35:53', '审批任务，任务号：20171115233544，审批结果：', '任务管理', '审批任务');
INSERT INTO `operation_log` VALUES ('1368', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-15 23:36:24', '上传零部件和原材料图谱试验结果，任务号：20171115233544', '实验管理', '上传图谱结果');
INSERT INTO `operation_log` VALUES ('1369', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-15 23:36:37', '提交对比结果，任务号：20171115233544', '实验管理', '结果对比');
INSERT INTO `operation_log` VALUES ('1370', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-15 23:36:58', '发送零部件图谱试验、原材料图谱试验结果，任务号：20171115233544', '实验管理', '结果发送');
INSERT INTO `operation_log` VALUES ('1371', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-15 23:37:53', '，任务号：20171115233544', '实验管理', '结果确认');
INSERT INTO `operation_log` VALUES ('1372', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-15 23:39:05', '下达任务，任务号：20171115233905', '任务管理', '下达任务');
INSERT INTO `operation_log` VALUES ('1373', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-15 23:39:12', '审批任务，任务号：20171115233905，审批结果：', '任务管理', '审批任务');
INSERT INTO `operation_log` VALUES ('1374', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-15 23:39:36', '上传零部件和原材料图谱试验结果，任务号：20171115233905', '实验管理', '上传图谱结果');
INSERT INTO `operation_log` VALUES ('1375', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-15 23:39:44', '提交对比结果，任务号：20171115233905', '实验管理', '结果对比');
INSERT INTO `operation_log` VALUES ('1376', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-15 23:39:57', '发送零部件图谱试验、原材料图谱试验结果，任务号：20171115233905', '实验管理', '结果发送');
INSERT INTO `operation_log` VALUES ('1377', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-15 23:40:15', '测试第一次不合格，任务号：20171115233905', '实验管理', '结果确认');
INSERT INTO `operation_log` VALUES ('1378', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-15 23:44:04', '审批任务，任务号：20171115233905-R1，审批结果：', '任务管理', '审批任务');
INSERT INTO `operation_log` VALUES ('1379', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-15 23:44:31', '上传零部件和原材料图谱试验结果，任务号：20171115233905-R1', '实验管理', '上传图谱结果');
INSERT INTO `operation_log` VALUES ('1380', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-15 23:44:38', '提交对比结果，任务号：20171115233905-R1', '实验管理', '结果对比');
INSERT INTO `operation_log` VALUES ('1381', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-15 23:44:54', '发送零部件图谱试验、原材料图谱试验结果，任务号：20171115233905-R1', '实验管理', '结果发送');
INSERT INTO `operation_log` VALUES ('1382', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-15 23:45:15', '测试2次不合格，任务号：20171115233905-R1', '实验管理', '结果确认');
INSERT INTO `operation_log` VALUES ('1383', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-15 23:49:52', '下达任务，任务号：20171115234952', '任务管理', '下达任务');
INSERT INTO `operation_log` VALUES ('1384', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-15 23:50:00', '审批任务，任务号：20171115234952，审批结果：', '任务管理', '审批任务');
INSERT INTO `operation_log` VALUES ('1385', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-15 23:50:19', '上传零部件和原材料图谱试验结果，任务号：20171115234952', '实验管理', '上传图谱结果');
INSERT INTO `operation_log` VALUES ('1386', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-15 23:50:26', '提交对比结果，任务号：20171115234952', '实验管理', '结果对比');
INSERT INTO `operation_log` VALUES ('1387', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-15 23:50:39', '发送零部件图谱试验、原材料图谱试验结果，任务号：20171115234952', '实验管理', '结果发送');
INSERT INTO `operation_log` VALUES ('1388', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-15 23:50:54', '第一次不合格，任务号：20171115234952', '实验管理', '结果确认');
INSERT INTO `operation_log` VALUES ('1389', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-15 23:53:29', '审批任务，任务号：20171115234952-R1，审批结果：', '任务管理', '审批任务');
INSERT INTO `operation_log` VALUES ('1390', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-15 23:53:47', '上传零部件和原材料图谱试验结果，任务号：20171115234952-R1', '实验管理', '上传图谱结果');
INSERT INTO `operation_log` VALUES ('1391', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-15 23:53:54', '提交对比结果，任务号：20171115234952-R1', '实验管理', '结果对比');
INSERT INTO `operation_log` VALUES ('1392', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-15 23:54:05', '发送零部件图谱试验、原材料图谱试验结果，任务号：20171115234952-R1', '实验管理', '结果发送');
INSERT INTO `operation_log` VALUES ('1393', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-15 23:54:24', '2次不合格，任务号：20171115234952-R1', '实验管理', '结果确认');
INSERT INTO `operation_log` VALUES ('1394', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-16 00:13:59', '任务申请，任务号：20171116001359', '任务管理', '申请');
INSERT INTO `operation_log` VALUES ('1395', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-16 00:14:06', '任务：20171116001359，审核通过', '任务管理', '审核');
INSERT INTO `operation_log` VALUES ('1396', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-16 00:14:12', '下达任务，任务号：20171116001359', '任务管理', '下达任务');
INSERT INTO `operation_log` VALUES ('1397', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-16 00:14:20', '审批任务，任务号：20171116001359，审批结果：图谱和型式试验全部审批通过', '任务管理', '审批任务');
INSERT INTO `operation_log` VALUES ('1398', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-16 00:14:31', '上传原材料型式试验结果，任务号：20171116001359', '实验管理', '上传型式结果');
INSERT INTO `operation_log` VALUES ('1399', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-16 00:14:44', '上传原材料图谱试验结果，任务号：20171116001359', '实验管理', '上传图谱结果');
INSERT INTO `operation_log` VALUES ('1400', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-16 00:14:56', '发送原材料图谱试验、原材料型式试验结果，任务号：20171116001359', '实验管理', '结果发送');
INSERT INTO `operation_log` VALUES ('1401', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-16 00:15:04', '原材料图谱试验、原材料型式试验结果确认合格，任务号：20171116001359', '实验管理', '结果确认');
INSERT INTO `operation_log` VALUES ('1402', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-16 00:17:33', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"id\\\" : 42,\\r\\n  \\\"userName\\\" : \\\"ad1\\\",\\r\\n  \\\"nickName\\\" : \\\"ad\\\",\\r\\n  \\\"mobile\\\" : \\\"1431123\\\",\\r\\n  \\\"createTime\\\" : 1506528071000,\\r\\n  \\\"lock\\\" : \\\"N\\\",\\r\\n  \\\"roleId\\\" : 15,\\r\\n  \\\"role\\\" : {\\r\\n    \\\"id\\\" : 15,\\r\\n    \\\"name\\\" : \\\"PE_工程师\\\",\\r\\n    \\\"code\\\" : \\\"pe_eng\\\",\\r\\n    \\\"desc\\\" : \\\"上汽通用五菱PE-工程师\\\",\\r\\n    \\\"group\\\" : {\\r\\n      \\\"id\\\" : 18,\\r\\n      \\\"name\\\" : \\\"上汽通用五菱PE\\\",\\r\\n      \\\"parentid\\\" : 1,\\r\\n      \\\"desc\\\" : \\\"上汽通用五菱PE\\\",\\r\\n      \\\"parent\\\" : {\\r\\n        \\\"id\\\" : 1,\\r\\n        \\\"name\\\" : \\\"角色\\\",\\r\\n        \\\"desc\\\" : \\\"根节点\\\"\\r\\n      }\\r\\n    }\\r\\n  },\\r\\n  \\\"orgId\\\" : 22,\\r\\n  \\\"email\\\" : \\\"\\\",\\r\\n  \\\"remark\\\" : \\\"\\\",\\r\\n  \\\"signType\\\" : 1\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.Account\",\r\n  \"OLDENTITY\" : \"{\\r\\n  \\\"id\\\" : 42,\\r\\n  \\\"userName\\\" : \\\"ad1\\\",\\r\\n  \\\"nickName\\\" : \\\"ad\\\",\\r\\n  \\\"mobile\\\" : \\\"1431123\\\",\\r\\n  \\\"createTime\\\" : 1506528071000,\\r\\n  \\\"lock\\\" : \\\"N\\\",\\r\\n  \\\"roleId\\\" : 15,\\r\\n  \\\"role\\\" : {\\r\\n    \\\"id\\\" : 15,\\r\\n    \\\"name\\\" : \\\"PE_工程师\\\",\\r\\n    \\\"code\\\" : \\\"pe_eng\\\",\\r\\n    \\\"desc\\\" : \\\"上汽通用五菱PE-工程师\\\",\\r\\n    \\\"group\\\" : {\\r\\n      \\\"id\\\" : 18,\\r\\n      \\\"name\\\" : \\\"上汽通用五菱PE\\\",\\r\\n      \\\"parentid\\\" : 1,\\r\\n      \\\"desc\\\" : \\\"上汽通用五菱PE\\\",\\r\\n      \\\"parent\\\" : {\\r\\n        \\\"id\\\" : 1,\\r\\n        \\\"name\\\" : \\\"角色\\\",\\r\\n        \\\"desc\\\" : \\\"根节点\\\"\\r\\n      }\\r\\n    }\\r\\n  },\\r\\n  \\\"email\\\" : \\\"\\\"\\r\\n}\",\r\n  \"OPERATION\" : \"编辑\"\r\n}', '用户管理', '编辑');
INSERT INTO `operation_log` VALUES ('1403', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-16 00:30:55', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"id\\\" : 1,\\r\\n  \\\"userName\\\" : \\\"admin\\\",\\r\\n  \\\"nickName\\\" : \\\"admin\\\",\\r\\n  \\\"mobile\\\" : \\\"13434343422\\\",\\r\\n  \\\"createTime\\\" : 1482073564000,\\r\\n  \\\"lock\\\" : \\\"N\\\",\\r\\n  \\\"roleId\\\" : 1,\\r\\n  \\\"role\\\" : {\\r\\n    \\\"id\\\" : 1,\\r\\n    \\\"name\\\" : \\\"admin\\\",\\r\\n    \\\"code\\\" : \\\"admin\\\",\\r\\n    \\\"desc\\\" : \\\"超级管理员\\\",\\r\\n    \\\"group\\\" : {\\r\\n      \\\"id\\\" : 22,\\r\\n      \\\"name\\\" : \\\"系统维护人员\\\",\\r\\n      \\\"parentid\\\" : 1,\\r\\n      \\\"desc\\\" : \\\"系统维护人员\\\",\\r\\n      \\\"parent\\\" : {\\r\\n        \\\"id\\\" : 1,\\r\\n        \\\"name\\\" : \\\"角色\\\",\\r\\n        \\\"desc\\\" : \\\"根节点\\\"\\r\\n      }\\r\\n    }\\r\\n  },\\r\\n  \\\"orgId\\\" : 15,\\r\\n  \\\"org\\\" : {\\r\\n    \\\"id\\\" : 18,\\r\\n    \\\"name\\\" : \\\"供应商1\\\",\\r\\n    \\\"code\\\" : \\\"g1\\\",\\r\\n    \\\"areaid\\\" : 111,\\r\\n    \\\"area\\\" : {\\r\\n      \\\"id\\\" : 111,\\r\\n      \\\"code\\\" : \\\"bb\\\",\\r\\n      \\\"name\\\" : \\\"bb\\\",\\r\\n      \\\"parentid\\\" : 106,\\r\\n      \\\"parent\\\" : {\\r\\n        \\\"id\\\" : 106,\\r\\n        \\\"code\\\" : \\\"a\\\",\\r\\n        \\\"name\\\" : \\\"a\\\",\\r\\n        \\\"parentid\\\" : 97,\\r\\n        \\\"parent\\\" : {\\r\\n          \\\"id\\\" : 97,\\r\\n          \\\"code\\\" : \\\"abab\\\",\\r\\n          \\\"name\\\" : \\\"ab\\\",\\r\\n          \\\"parentid\\\" : 92,\\r\\n          \\\"parent\\\" : {\\r\\n            \\\"id\\\" : 92,\\r\\n            \\\"code\\\" : \\\"ab\\\",\\r\\n            \\\"name\\\" : \\\"ab\\\",\\r\\n            \\\"parentid\\\" : 2,\\r\\n            \\\"parent\\\" : {\\r\\n              \\\"id\\\" : 2,\\r\\n              \\\"code\\\" : \\\"001\\\",\\r\\n              \\\"name\\\" : \\\"广州\\\",\\r\\n              \\\"parentid\\\" : 1,\\r\\n              \\\"parent\\\" : {\\r\\n                \\\"id\\\" : 1,\\r\\n                \\\"code\\\" : \\\"000\\\",\\r\\n                \\\"name\\\" : \\\"地区\\\",\\r\\n                \\\"parentid\\\" : 0,\\r\\n                \\\"desc\\\" : \\\"根节点\\\"\\r\\n              },\\r\\n              \\\"desc\\\" : \\\"\\\"\\r\\n            },\\r\\n            \\\"desc\\\" : \\\"\\\"\\r\\n          },\\r\\n          \\\"desc\\\" : \\\"\\\"\\r\\n        },\\r\\n        \\\"desc\\\" : \\\"\\\"\\r\\n      },\\r\\n      \\\"desc\\\" : \\\"123\\\"\\r\\n    },\\r\\n    \\\"desc\\\" : \\\"\\\",\\r\\n    \\\"parentid\\\" : 17,\\r\\n    \\\"parent\\\" : {\\r\\n      \\\"id\\\" : 17,\\r\\n      \\\"name\\\" : \\\"供应商\\\",\\r\\n      \\\"code\\\" : \\\"gy\\\",\\r\\n      \\\"areaid\\\" : 106,\\r\\n      \\\"area\\\" : {\\r\\n        \\\"id\\\" : 106,\\r\\n        \\\"code\\\" : \\\"a\\\",\\r\\n        \\\"name\\\" : \\\"a\\\",\\r\\n        \\\"parentid\\\" : 97,\\r\\n        \\\"parent\\\" : {\\r\\n          \\\"id\\\" : 97,\\r\\n          \\\"code\\\" : \\\"abab\\\",\\r\\n          \\\"name\\\" : \\\"ab\\\",\\r\\n          \\\"parentid\\\" : 92,\\r\\n          \\\"parent\\\" : {\\r\\n            \\\"id\\\" : 92,\\r\\n            \\\"code\\\" : \\\"ab\\\",\\r\\n            \\\"name\\\" : \\\"ab\\\",\\r\\n            \\\"parentid\\\" : 2,\\r\\n            \\\"parent\\\" : {\\r\\n              \\\"id\\\" : 2,\\r\\n              \\\"code\\\" : \\\"001\\\",\\r\\n              \\\"name\\\" : \\\"广州\\\",\\r\\n              \\\"parentid\\\" : 1,\\r\\n              \\\"parent\\\" : {\\r\\n                \\\"id\\\" : 1,\\r\\n                \\\"code\\\" : \\\"000\\\",\\r\\n                \\\"name\\\" : \\\"地区\\\",\\r\\n                \\\"parentid\\\" : 0,\\r\\n                \\\"desc\\\" : \\\"根节点\\\"\\r\\n              },\\r\\n              \\\"desc\\\" : \\\"\\\"\\r\\n            },\\r\\n            \\\"desc\\\" : \\\"\\\"\\r\\n          },\\r\\n          \\\"desc\\\" : \\\"\\\"\\r\\n        },\\r\\n        \\\"desc\\\" : \\\"\\\"\\r\\n      },\\r\\n      \\\"desc\\\" : \\\"\\\",\\r\\n      \\\"parentid\\\" : 1,\\r\\n      \\\"parent\\\" : {\\r\\n        \\\"id\\\" : 1,\\r\\n        \\\"name\\\" : \\\"机构\\\",\\r\\n        \\\"code\\\" : \\\"001\\\"\\r\\n      },\\r\\n      \\\"type\\\" : 2\\r\\n    },\\r\\n    \\\"type\\\" : 2,\\r\\n    \\\"addr\\\" : \\\"广州市天河区\\\"\\r\\n  },\\r\\n  \\\"email\\\" : \\\"2342339261@qq.com\\\",\\r\\n  \\\"remark\\\" : \\\"\\\",\\r\\n  \\\"signType\\\" : 1\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.Account\",\r\n  \"OLDENTITY\" : \"{\\r\\n  \\\"id\\\" : 1,\\r\\n  \\\"userName\\\" : \\\"admin\\\",\\r\\n  \\\"nickName\\\" : \\\"admin\\\",\\r\\n  \\\"mobile\\\" : \\\"13434343422\\\",\\r\\n  \\\"createTime\\\" : 1482073564000,\\r\\n  \\\"lock\\\" : \\\"N\\\",\\r\\n  \\\"roleId\\\" : 1,\\r\\n  \\\"role\\\" : {\\r\\n    \\\"id\\\" : 1,\\r\\n    \\\"name\\\" : \\\"admin\\\",\\r\\n    \\\"code\\\" : \\\"admin\\\",\\r\\n    \\\"desc\\\" : \\\"超级管理员\\\",\\r\\n    \\\"group\\\" : {\\r\\n      \\\"id\\\" : 22,\\r\\n      \\\"name\\\" : \\\"系统维护人员\\\",\\r\\n      \\\"parentid\\\" : 1,\\r\\n      \\\"desc\\\" : \\\"系统维护人员\\\",\\r\\n      \\\"parent\\\" : {\\r\\n        \\\"id\\\" : 1,\\r\\n        \\\"name\\\" : \\\"角色\\\",\\r\\n        \\\"desc\\\" : \\\"根节点\\\"\\r\\n      }\\r\\n    }\\r\\n  },\\r\\n  \\\"orgId\\\" : 18,\\r\\n  \\\"org\\\" : {\\r\\n    \\\"id\\\" : 18,\\r\\n    \\\"name\\\" : \\\"供应商1\\\",\\r\\n    \\\"code\\\" : \\\"g1\\\",\\r\\n    \\\"areaid\\\" : 111,\\r\\n    \\\"area\\\" : {\\r\\n      \\\"id\\\" : 111,\\r\\n      \\\"code\\\" : \\\"bb\\\",\\r\\n      \\\"name\\\" : \\\"bb\\\",\\r\\n      \\\"parentid\\\" : 106,\\r\\n      \\\"parent\\\" : {\\r\\n        \\\"id\\\" : 106,\\r\\n        \\\"code\\\" : \\\"a\\\",\\r\\n        \\\"name\\\" : \\\"a\\\",\\r\\n        \\\"parentid\\\" : 97,\\r\\n        \\\"parent\\\" : {\\r\\n          \\\"id\\\" : 97,\\r\\n          \\\"code\\\" : \\\"abab\\\",\\r\\n          \\\"name\\\" : \\\"ab\\\",\\r\\n          \\\"parentid\\\" : 92,\\r\\n          \\\"parent\\\" : {\\r\\n            \\\"id\\\" : 92,\\r\\n            \\\"code\\\" : \\\"ab\\\",\\r\\n            \\\"name\\\" : \\\"ab\\\",\\r\\n            \\\"parentid\\\" : 2,\\r\\n            \\\"parent\\\" : {\\r\\n              \\\"id\\\" : 2,\\r\\n              \\\"code\\\" : \\\"001\\\",\\r\\n              \\\"name\\\" : \\\"广州\\\",\\r\\n              \\\"parentid\\\" : 1,\\r\\n              \\\"parent\\\" : {\\r\\n                \\\"id\\\" : 1,\\r\\n                \\\"code\\\" : \\\"000\\\",\\r\\n                \\\"name\\\" : \\\"地区\\\",\\r\\n                \\\"parentid\\\" : 0,\\r\\n                \\\"desc\\\" : \\\"根节点\\\"\\r\\n              },\\r\\n              \\\"desc\\\" : \\\"\\\"\\r\\n            },\\r\\n            \\\"desc\\\" : \\\"\\\"\\r\\n          },\\r\\n          \\\"desc\\\" : \\\"\\\"\\r\\n        },\\r\\n        \\\"desc\\\" : \\\"\\\"\\r\\n      },\\r\\n      \\\"desc\\\" : \\\"123\\\"\\r\\n    },\\r\\n    \\\"desc\\\" : \\\"\\\",\\r\\n    \\\"parentid\\\" : 17,\\r\\n    \\\"parent\\\" : {\\r\\n      \\\"id\\\" : 17,\\r\\n      \\\"name\\\" : \\\"供应商\\\",\\r\\n      \\\"code\\\" : \\\"gy\\\",\\r\\n      \\\"areaid\\\" : 106,\\r\\n      \\\"area\\\" : {\\r\\n        \\\"id\\\" : 106,\\r\\n        \\\"code\\\" : \\\"a\\\",\\r\\n        \\\"name\\\" : \\\"a\\\",\\r\\n        \\\"parentid\\\" : 97,\\r\\n        \\\"parent\\\" : {\\r\\n          \\\"id\\\" : 97,\\r\\n          \\\"code\\\" : \\\"abab\\\",\\r\\n          \\\"name\\\" : \\\"ab\\\",\\r\\n          \\\"parentid\\\" : 92,\\r\\n          \\\"parent\\\" : {\\r\\n            \\\"id\\\" : 92,\\r\\n            \\\"code\\\" : \\\"ab\\\",\\r\\n            \\\"name\\\" : \\\"ab\\\",\\r\\n            \\\"parentid\\\" : 2,\\r\\n            \\\"parent\\\" : {\\r\\n              \\\"id\\\" : 2,\\r\\n              \\\"code\\\" : \\\"001\\\",\\r\\n              \\\"name\\\" : \\\"广州\\\",\\r\\n              \\\"parentid\\\" : 1,\\r\\n              \\\"parent\\\" : {\\r\\n                \\\"id\\\" : 1,\\r\\n                \\\"code\\\" : \\\"000\\\",\\r\\n                \\\"name\\\" : \\\"地区\\\",\\r\\n                \\\"parentid\\\" : 0,\\r\\n                \\\"desc\\\" : \\\"根节点\\\"\\r\\n              },\\r\\n              \\\"desc\\\" : \\\"\\\"\\r\\n            },\\r\\n            \\\"desc\\\" : \\\"\\\"\\r\\n          },\\r\\n          \\\"desc\\\" : \\\"\\\"\\r\\n        },\\r\\n        \\\"desc\\\" : \\\"\\\"\\r\\n      },\\r\\n      \\\"desc\\\" : \\\"\\\",\\r\\n      \\\"parentid\\\" : 1,\\r\\n      \\\"parent\\\" : {\\r\\n        \\\"id\\\" : 1,\\r\\n        \\\"name\\\" : \\\"机构\\\",\\r\\n        \\\"code\\\" : \\\"001\\\"\\r\\n      },\\r\\n      \\\"type\\\" : 2\\r\\n    },\\r\\n    \\\"type\\\" : 2,\\r\\n    \\\"addr\\\" : \\\"广州市天河区\\\"\\r\\n  },\\r\\n  \\\"email\\\" : \\\"2342339261@qq.com\\\",\\r\\n  \\\"remark\\\" : \\\"\\\",\\r\\n  \\\"signType\\\" : 1\\r\\n}\",\r\n  \"OPERATION\" : \"编辑\"\r\n}', '用户管理', '编辑');
INSERT INTO `operation_log` VALUES ('1404', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-16 00:31:11', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"id\\\" : 7,\\r\\n  \\\"userName\\\" : \\\"bill\\\",\\r\\n  \\\"nickName\\\" : \\\"ad\\\",\\r\\n  \\\"mobile\\\" : \\\"13512342323\\\",\\r\\n  \\\"createTime\\\" : 1498059012000,\\r\\n  \\\"lock\\\" : \\\"N\\\",\\r\\n  \\\"roleId\\\" : 15,\\r\\n  \\\"role\\\" : {\\r\\n    \\\"id\\\" : 1,\\r\\n    \\\"name\\\" : \\\"admin\\\",\\r\\n    \\\"code\\\" : \\\"admin\\\",\\r\\n    \\\"desc\\\" : \\\"超级管理员\\\",\\r\\n    \\\"group\\\" : {\\r\\n      \\\"id\\\" : 22,\\r\\n      \\\"name\\\" : \\\"系统维护人员\\\",\\r\\n      \\\"parentid\\\" : 1,\\r\\n      \\\"desc\\\" : \\\"系统维护人员\\\",\\r\\n      \\\"parent\\\" : {\\r\\n        \\\"id\\\" : 1,\\r\\n        \\\"name\\\" : \\\"角色\\\",\\r\\n        \\\"desc\\\" : \\\"根节点\\\"\\r\\n      }\\r\\n    }\\r\\n  },\\r\\n  \\\"orgId\\\" : 15,\\r\\n  \\\"email\\\" : \\\"12312@qq.com\\\",\\r\\n  \\\"remark\\\" : \\\"\\\",\\r\\n  \\\"signType\\\" : 1\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.Account\",\r\n  \"OLDENTITY\" : \"{\\r\\n  \\\"id\\\" : 7,\\r\\n  \\\"userName\\\" : \\\"bill\\\",\\r\\n  \\\"nickName\\\" : \\\"ad\\\",\\r\\n  \\\"mobile\\\" : \\\"13512342323\\\",\\r\\n  \\\"createTime\\\" : 1498059012000,\\r\\n  \\\"lock\\\" : \\\"N\\\",\\r\\n  \\\"roleId\\\" : 1,\\r\\n  \\\"role\\\" : {\\r\\n    \\\"id\\\" : 1,\\r\\n    \\\"name\\\" : \\\"admin\\\",\\r\\n    \\\"code\\\" : \\\"admin\\\",\\r\\n    \\\"desc\\\" : \\\"超级管理员\\\",\\r\\n    \\\"group\\\" : {\\r\\n      \\\"id\\\" : 22,\\r\\n      \\\"name\\\" : \\\"系统维护人员\\\",\\r\\n      \\\"parentid\\\" : 1,\\r\\n      \\\"desc\\\" : \\\"系统维护人员\\\",\\r\\n      \\\"parent\\\" : {\\r\\n        \\\"id\\\" : 1,\\r\\n        \\\"name\\\" : \\\"角色\\\",\\r\\n        \\\"desc\\\" : \\\"根节点\\\"\\r\\n      }\\r\\n    }\\r\\n  },\\r\\n  \\\"email\\\" : \\\"12312@qq.com\\\"\\r\\n}\",\r\n  \"OPERATION\" : \"编辑\"\r\n}', '用户管理', '编辑');
INSERT INTO `operation_log` VALUES ('1405', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-16 00:31:21', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"id\\\" : 8,\\r\\n  \\\"userName\\\" : \\\"lily\\\",\\r\\n  \\\"nickName\\\" : \\\"lily\\\",\\r\\n  \\\"mobile\\\" : \\\"13723423434\\\",\\r\\n  \\\"createTime\\\" : 1498059034000,\\r\\n  \\\"lock\\\" : \\\"N\\\",\\r\\n  \\\"roleId\\\" : 17,\\r\\n  \\\"orgId\\\" : 14,\\r\\n  \\\"email\\\" : \\\"12313123@qq.com\\\",\\r\\n  \\\"remark\\\" : \\\"\\\",\\r\\n  \\\"signType\\\" : 1\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.Account\",\r\n  \"OLDENTITY\" : \"{\\r\\n  \\\"id\\\" : 8,\\r\\n  \\\"userName\\\" : \\\"lily\\\",\\r\\n  \\\"nickName\\\" : \\\"lily\\\",\\r\\n  \\\"mobile\\\" : \\\"13723423434\\\",\\r\\n  \\\"createTime\\\" : 1498059034000,\\r\\n  \\\"lock\\\" : \\\"N\\\",\\r\\n  \\\"roleId\\\" : 33,\\r\\n  \\\"email\\\" : \\\"12313123@qq.com\\\"\\r\\n}\",\r\n  \"OPERATION\" : \"编辑\"\r\n}', '用户管理', '编辑');
INSERT INTO `operation_log` VALUES ('1406', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-16 00:31:51', '{\r\n  \"ENTITY\" : \"{\\r\\n  \\\"id\\\" : 13,\\r\\n  \\\"userName\\\" : \\\"William\\\",\\r\\n  \\\"nickName\\\" : \\\"William\\\",\\r\\n  \\\"mobile\\\" : \\\"15918703417\\\",\\r\\n  \\\"createTime\\\" : 1498059195000,\\r\\n  \\\"lock\\\" : \\\"N\\\",\\r\\n  \\\"roleId\\\" : 17,\\r\\n  \\\"orgId\\\" : 20,\\r\\n  \\\"email\\\" : \\\"12313123@qq.com\\\",\\r\\n  \\\"remark\\\" : \\\"\\\",\\r\\n  \\\"signType\\\" : 1\\r\\n}\",\r\n  \"ENTITYTYPE\" : \"cn.wow.common.domain.Account\",\r\n  \"OLDENTITY\" : \"{\\r\\n  \\\"id\\\" : 13,\\r\\n  \\\"userName\\\" : \\\"William\\\",\\r\\n  \\\"nickName\\\" : \\\"William\\\",\\r\\n  \\\"mobile\\\" : \\\"15918703417\\\",\\r\\n  \\\"createTime\\\" : 1498059195000,\\r\\n  \\\"lock\\\" : \\\"N\\\",\\r\\n  \\\"roleId\\\" : 33,\\r\\n  \\\"email\\\" : \\\"12313123@qq.com\\\"\\r\\n}\",\r\n  \"OPERATION\" : \"编辑\"\r\n}', '用户管理', '编辑');
INSERT INTO `operation_log` VALUES ('1410', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-16 01:21:25', null, '用户管理', '登录');
INSERT INTO `operation_log` VALUES ('1411', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-16 01:21:46', '任务：20171116001359,原材料图谱试验费用单', '费用管理', '费用单发送');
INSERT INTO `operation_log` VALUES ('1412', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-16 01:55:23', null, '用户管理', '登录');
INSERT INTO `operation_log` VALUES ('1413', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-16 02:11:54', null, '用户管理', '登录');
INSERT INTO `operation_log` VALUES ('1414', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-16 02:12:20', '任务：20171116001359,原材料型式试验费用单', '费用管理', '费用单发送');
INSERT INTO `operation_log` VALUES ('1415', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-16 02:13:04', '任务：20171115234952-R1,零部件图谱试验费用单', '费用管理', '费用单发送');
INSERT INTO `operation_log` VALUES ('1416', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-16 02:16:03', null, '用户管理', '登录');
INSERT INTO `operation_log` VALUES ('1417', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-16 02:22:29', '任务：20171115232625,零部件图谱试验费用单', '费用管理', '费用单发送');
INSERT INTO `operation_log` VALUES ('1418', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-16 02:32:48', '任务：20171115234952-R1,原材料图谱试验费用单', '费用管理', '费用单发送');
INSERT INTO `operation_log` VALUES ('1419', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-16 02:33:25', '任务：20171115234952,原材料图谱试验费用单', '费用管理', '费用单发送');
INSERT INTO `operation_log` VALUES ('1420', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-16 02:34:13', '任务：20171115234952,零部件图谱试验费用单', '费用管理', '费用单发送');
INSERT INTO `operation_log` VALUES ('1421', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-16 02:40:43', '任务：20171115233544,原材料图谱试验费用单', '费用管理', '费用单发送');
INSERT INTO `operation_log` VALUES ('1422', 'admin', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.89 Safari/537.36', '0:0:0:0:0:0:0:1', '2017-11-16 02:45:13', null, '用户管理', '登录');

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
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of parts
-- ----------------------------
INSERT INTO `parts` VALUES ('39', '1', '001', '轮胎', '2017-11-01', '广州市天河区xx路', 'No.0001', '', '2017-11-15 23:26:25', '1', '18', '0', '');

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
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pf_result
-- ----------------------------
INSERT INTO `pf_result` VALUES ('54', '59', 'A', 'A', 'A', 'A', 'A', 'A', '2017-11-15 23:27:07', '1', '1');
INSERT INTO `pf_result` VALUES ('55', '59', 'B', 'B', 'B', 'B', 'B', 'B', '2017-11-15 23:27:07', '2', '1');
INSERT INTO `pf_result` VALUES ('56', '65', 'C', 'C', 'C', 'C', 'C', 'C', '2017-11-16 00:14:31', '2', '1');

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
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of task
-- ----------------------------
INSERT INTO `task` VALUES ('59', '20171115232625', '57', '18', '1', '4', '20', '20', '20', '20', null, '2017-11-15 23:26:25', '0', '1', '4', '4', '4', '4', '1', '1', '1', '1', '2017-11-15 23:28:39', '0', '0', null);
INSERT INTO `task` VALUES ('60', '20171115233544', '57', '18', '2', '7', '20', '20', null, null, null, '2017-11-15 23:35:44', '0', '1', '3', '3', '0', '0', '1', '1', '0', '0', '2017-11-15 23:37:53', '0', '0', null);
INSERT INTO `task` VALUES ('63', '20171115234952', '57', '18', '2', '7', '20', '20', null, null, '第一次不合格', '2017-11-15 23:49:52', '1', '1', '3', '3', '0', '0', '1', '1', '0', '0', '2017-11-15 23:50:54', '0', '0', null);
INSERT INTO `task` VALUES ('64', '20171115234952-R1', '57', '18', '2', '7', '20', '20', null, null, '2次不合格', '2017-11-15 23:52:19', '2', '1', '3', '3', '0', '0', '1', '1', '0', '0', '2017-11-15 23:55:11', '0', '0', '63');
INSERT INTO `task` VALUES ('65', '20171116001359', '58', '18', '4', '4', null, '20', null, '20', null, '2017-11-16 00:13:59', '0', '1', '0', '4', '0', '4', '0', '1', '0', '1', '2017-11-16 00:15:04', '0', '0', null);

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
) ENGINE=InnoDB AUTO_INCREMENT=421 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of task_record
-- ----------------------------
INSERT INTO `task_record` VALUES ('370', '20171115232625', '1', '1', '填写信息', '2017-11-15 23:26:25', '1');
INSERT INTO `task_record` VALUES ('371', '20171115232625', '1', '2', '信息审核通过', '2017-11-15 23:26:36', '1');
INSERT INTO `task_record` VALUES ('372', '20171115232625', '1', '4', '分配任务到实验室', '2017-11-15 23:26:43', '1');
INSERT INTO `task_record` VALUES ('373', '20171115232625', '1', '5', '图谱和型式试验全部审批通过', '2017-11-15 23:26:51', '1');
INSERT INTO `task_record` VALUES ('374', '20171115232625', '1', '7', '上传零部件型式试验和原材料型式试验结果', '2017-11-15 23:27:07', '1');
INSERT INTO `task_record` VALUES ('375', '20171115232625', '1', '7', '上传零部件和原材料图谱试验结果', '2017-11-15 23:27:50', '1');
INSERT INTO `task_record` VALUES ('376', '20171115232625', '1', '8', '发送零部件图谱试验、零部件型式试验、原材料图谱试验、原材料型式试验结果', '2017-11-15 23:28:21', '1');
INSERT INTO `task_record` VALUES ('377', '20171115232625', '1', '10', '基准信息已保存', '2017-11-15 23:28:39', '1');
INSERT INTO `task_record` VALUES ('378', '20171115232625', '1', '9', '原材料图谱试验、原材料型式试验、零部件图谱试验、零部件型式试验结果确认合格', '2017-11-15 23:28:39', '1');
INSERT INTO `task_record` VALUES ('379', '20171115232625', '1', '13', '申请信息修改', '2017-11-15 23:33:48', '1');
INSERT INTO `task_record` VALUES ('380', '20171115232625', '1', '15', '修改基本信息', '2017-11-15 23:34:01', '1');
INSERT INTO `task_record` VALUES ('381', '20171115233544', '1', '1', '下达试验任务', '2017-11-15 23:35:44', '2');
INSERT INTO `task_record` VALUES ('382', '20171115233544', '1', '2', '审批通过', '2017-11-15 23:35:53', '2');
INSERT INTO `task_record` VALUES ('383', '20171115233544', '1', '7', '上传零部件和原材料图谱试验结果', '2017-11-15 23:36:24', '2');
INSERT INTO `task_record` VALUES ('384', '20171115233544', '1', '5', '提交对比结果', '2017-11-15 23:36:37', '2');
INSERT INTO `task_record` VALUES ('385', '20171115233544', '1', '8', '发送零部件图谱试验、原材料图谱试验结果', '2017-11-15 23:36:56', '2');
INSERT INTO `task_record` VALUES ('386', '20171115233544', '1', '9', '结果留存', '2017-11-15 23:37:53', '2');
INSERT INTO `task_record` VALUES ('387', '20171115233905', '1', '1', '下达试验任务', '2017-11-15 23:39:05', '3');
INSERT INTO `task_record` VALUES ('388', '20171115233905', '1', '2', '审批通过', '2017-11-15 23:39:12', '3');
INSERT INTO `task_record` VALUES ('389', '20171115233905', '1', '7', '上传零部件和原材料图谱试验结果', '2017-11-15 23:39:36', '3');
INSERT INTO `task_record` VALUES ('390', '20171115233905', '1', '5', '提交对比结果', '2017-11-15 23:39:44', '3');
INSERT INTO `task_record` VALUES ('391', '20171115233905', '1', '8', '发送零部件图谱试验、原材料图谱试验结果', '2017-11-15 23:39:55', '3');
INSERT INTO `task_record` VALUES ('392', '20171115233905', '1', '10', '结果不合格，进行第2次抽样，不合格原因：测试第一次不合格', '2017-11-15 23:40:15', '3');
INSERT INTO `task_record` VALUES ('393', '20171115233905', '1', '13', '进行二次抽样', '2017-11-15 23:42:28', '3');
INSERT INTO `task_record` VALUES ('394', '20171115233905-R1', '1', '2', '审批通过', '2017-11-15 23:44:04', '3');
INSERT INTO `task_record` VALUES ('395', '20171115233905-R1', '1', '7', '上传零部件和原材料图谱试验结果', '2017-11-15 23:44:31', '3');
INSERT INTO `task_record` VALUES ('396', '20171115233905-R1', '1', '5', '提交对比结果', '2017-11-15 23:44:38', '3');
INSERT INTO `task_record` VALUES ('397', '20171115233905-R1', '1', '8', '发送零部件图谱试验、原材料图谱试验结果', '2017-11-15 23:44:52', '3');
INSERT INTO `task_record` VALUES ('398', '20171115233905-R1', '1', '10', '结果不合格，进行第2次抽样，不合格原因：测试2次不合格', '2017-11-15 23:45:15', '3');
INSERT INTO `task_record` VALUES ('399', '20171115234952', '1', '1', '下达试验任务', '2017-11-15 23:49:52', '2');
INSERT INTO `task_record` VALUES ('400', '20171115234952', '1', '2', '审批通过', '2017-11-15 23:50:00', '2');
INSERT INTO `task_record` VALUES ('401', '20171115234952', '1', '7', '上传零部件和原材料图谱试验结果', '2017-11-15 23:50:19', '2');
INSERT INTO `task_record` VALUES ('402', '20171115234952', '1', '5', '提交对比结果', '2017-11-15 23:50:26', '2');
INSERT INTO `task_record` VALUES ('403', '20171115234952', '1', '8', '发送零部件图谱试验、原材料图谱试验结果', '2017-11-15 23:50:37', '2');
INSERT INTO `task_record` VALUES ('404', '20171115234952', '1', '10', '结果不合格，进行第2次抽样，不合格原因：第一次不合格', '2017-11-15 23:50:54', '2');
INSERT INTO `task_record` VALUES ('405', '20171115234952', '1', '13', '进行二次抽样', '2017-11-15 23:52:19', '2');
INSERT INTO `task_record` VALUES ('406', '20171115233905-R1', '1', '13', '中止任务，原因：asdf', '2017-11-15 23:52:41', '3');
INSERT INTO `task_record` VALUES ('407', '20171115234952-R1', '1', '2', '审批通过', '2017-11-15 23:53:29', '2');
INSERT INTO `task_record` VALUES ('408', '20171115234952-R1', '1', '7', '上传零部件和原材料图谱试验结果', '2017-11-15 23:53:47', '2');
INSERT INTO `task_record` VALUES ('409', '20171115234952-R1', '1', '5', '提交对比结果', '2017-11-15 23:53:54', '2');
INSERT INTO `task_record` VALUES ('410', '20171115234952-R1', '1', '8', '发送零部件图谱试验、原材料图谱试验结果', '2017-11-15 23:54:03', '2');
INSERT INTO `task_record` VALUES ('411', '20171115234952-R1', '1', '11', '结果不合格，发送警告书，不合格原因：2次不合格', '2017-11-15 23:54:20', '2');
INSERT INTO `task_record` VALUES ('412', '20171116001359', '1', '1', '填写信息', '2017-11-16 00:13:59', '4');
INSERT INTO `task_record` VALUES ('413', '20171116001359', '1', '2', '信息审核通过', '2017-11-16 00:14:06', '4');
INSERT INTO `task_record` VALUES ('414', '20171116001359', '1', '4', '分配任务到实验室', '2017-11-16 00:14:12', '4');
INSERT INTO `task_record` VALUES ('415', '20171116001359', '1', '5', '图谱和型式试验全部审批通过', '2017-11-16 00:14:20', '4');
INSERT INTO `task_record` VALUES ('416', '20171116001359', '1', '7', '上传原材料型式试验结果', '2017-11-16 00:14:31', '4');
INSERT INTO `task_record` VALUES ('417', '20171116001359', '1', '7', '上传原材料图谱试验结果', '2017-11-16 00:14:44', '4');
INSERT INTO `task_record` VALUES ('418', '20171116001359', '1', '8', '发送原材料图谱试验、原材料型式试验结果', '2017-11-16 00:14:54', '4');
INSERT INTO `task_record` VALUES ('419', '20171116001359', '1', '10', '基准信息已保存', '2017-11-16 00:15:04', '4');
INSERT INTO `task_record` VALUES ('420', '20171116001359', '1', '9', '原材料图谱试验、原材料型式试验结果确认合格', '2017-11-16 00:15:04', '4');

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
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of vehicle
-- ----------------------------
INSERT INTO `vehicle` VALUES ('40', '001', '宝马7系', '2017-11-07', '广州市天河区xx路', '', '2017-11-15 23:26:25', '2');
INSERT INTO `vehicle` VALUES ('41', '001', '宝马7系', '2017-11-07', '广州市天河区xx路', '测试', '2017-11-15 23:33:48', '1');
