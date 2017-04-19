-- --------------------------------------------------------
-- Host:                         rm-bp1wag664oqr93du9o.mysql.rds.aliyuncs.com
-- Server version:               5.7.15-log - Source distribution
-- Server OS:                    Linux
-- HeidiSQL Version:             9.4.0.5168
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for bloodnet
CREATE DATABASE IF NOT EXISTS `bloodnet` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `bloodnet`;

-- Dumping structure for table bloodnet.couple
CREATE TABLE IF NOT EXISTS `couple` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `husband_profile_id` bigint(20) unsigned NOT NULL COMMENT '丈夫profile_id',
  `wife_profile_id` bigint(20) unsigned NOT NULL COMMENT '妻子profile_id',
  `is_deleted` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `create_user_id` bigint(20) unsigned NOT NULL COMMENT '创建者user_id',
  `modify_time` datetime NOT NULL COMMENT '修改时间',
  `modify_user_id` bigint(20) unsigned NOT NULL COMMENT '修改者user_id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='夫妻对';

-- Data exporting was unselected.
-- Dumping structure for table bloodnet.couple_daughter
CREATE TABLE IF NOT EXISTS `couple_daughter` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '关系id',
  `couple_id` bigint(20) unsigned NOT NULL COMMENT '夫妻对ID',
  `daughter_profile_id` bigint(20) unsigned NOT NULL COMMENT '女儿user_id',
  `is_deleted` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `create_user_id` bigint(20) NOT NULL COMMENT '创建者user_id',
  `modify_time` datetime NOT NULL COMMENT '修改时间',
  `modify_user_id` bigint(20) NOT NULL COMMENT '修改者user_id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
-- Dumping structure for table bloodnet.couple_son
CREATE TABLE IF NOT EXISTS `couple_son` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `couple_id` bigint(20) unsigned NOT NULL COMMENT '夫妻对的couple_id',
  `son_profile_id` bigint(20) unsigned NOT NULL COMMENT '儿子的Profile_id',
  `delflg` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_user_id` bigint(20) unsigned NOT NULL COMMENT '创建者user_id',
  `modify_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '修改时间',
  `modify_user_id` bigint(20) unsigned NOT NULL COMMENT '修改者user_id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='父母对（couple）关系与儿子的关系表';

-- Data exporting was unselected.
-- Dumping structure for table bloodnet.integration_request
CREATE TABLE IF NOT EXISTS `integration_request` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '请求ID',
  `raising_user_id` bigint(20) unsigned NOT NULL COMMENT '发起融合请求的user_id',
  `raised_profile_id` bigint(20) unsigned NOT NULL COMMENT '发起融合请求时被判断为同一个人的profile_id',
  `target_profile_id` bigint(20) unsigned NOT NULL COMMENT '发起融合请求的目标profile_id',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0：默认  1:接受   2：拒绝 ',
  `is_target_profile_deleted` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0：否  1:已被删除，该请求无效',
  `accepted_owner_id` bigint(20) NOT NULL COMMENT '接受请求的该profile的owner的user_id',
  `is_deleted` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `create_time` datetime NOT NULL COMMENT '作成时间',
  `create_user_id` bigint(20) unsigned NOT NULL COMMENT '创建者user_id',
  `modify_time` datetime NOT NULL COMMENT '更新时间',
  `modify_user_id` bigint(20) unsigned NOT NULL COMMENT '修改者user_id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户提出的树整合的请求';

-- Data exporting was unselected.
-- Dumping structure for table bloodnet.place
CREATE TABLE IF NOT EXISTS `place` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `dynasty_id` int(11) unsigned DEFAULT NULL,
  `place_code_level1` int(11) unsigned DEFAULT NULL COMMENT '现代的情况下是省',
  `place_code_level2` int(11) unsigned DEFAULT NULL COMMENT '现代的情况下是市',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
-- Dumping structure for table bloodnet.profile
CREATE TABLE IF NOT EXISTS `profile` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `sex` char(1) NOT NULL COMMENT '性别  0：男 1：女',
  `family_name` varchar(64) NOT NULL COMMENT '姓',
  `first_name` varchar(64) NOT NULL COMMENT '名',
  `birth_year` year(4) NOT NULL COMMENT '出生年',
  `birth_month` tinyint(2) unsigned zerofill DEFAULT NULL COMMENT '出生月',
  `birth_day` tinyint(2) unsigned zerofill DEFAULT NULL COMMENT '出生日',
  `birth_place_id` bigint(20) DEFAULT NULL COMMENT '出生地ID',
  `has_died` tinyint(1) unsigned NOT NULL COMMENT '0：在世    1：去世',
  `death_year` year(4) DEFAULT NULL COMMENT '去世年',
  `death_month` tinyint(2) unsigned zerofill DEFAULT NULL COMMENT '去世月',
  `death_day` tinyint(2) unsigned zerofill DEFAULT NULL COMMENT '去世日',
  `death_place_id` bigint(20) DEFAULT NULL COMMENT '去世地ID',
  `id_number` varchar(20) DEFAULT NULL COMMENT '身份证号',
  `email` varchar(128) DEFAULT NULL COMMENT '电子邮件',
  `phone_no` char(11) DEFAULT NULL COMMENT '电话号码',
  `is_integration_node` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT ' 0：否　1：是     是的话，用户删除该Profile时应显示警告',
  `is_invitation_node` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT ' 0：否　1：是     是的话，代表该Profile的用户正在赶来使用网站，拒绝用户删除此profile或修改该profile姓名',
  `is_system_user` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '该profile是否已经成为网站的用户   0：否    1：是',
  `is_deleted` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT ' 0：未删除　1：删除',
  `create_time` datetime NOT NULL COMMENT '作成时间',
  `create_user_id` bigint(20) unsigned NOT NULL COMMENT '创建者user_id',
  `modify_time` datetime NOT NULL COMMENT '更新时间',
  `modify_user_id` bigint(20) unsigned NOT NULL COMMENT '修改者user_id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='自然人，也就是家族树的节点表';

-- Data exporting was unselected.
-- Dumping structure for table bloodnet.profile_creator
CREATE TABLE IF NOT EXISTS `profile_creator` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `profile_id` bigint(20) unsigned NOT NULL COMMENT 'profile_id',
  `creator_user_id` bigint(20) unsigned NOT NULL COMMENT 'Profile所有者的user_id',
  `is_deleted` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT ' 0：未删除　1：删除',
  `create_time` datetime NOT NULL COMMENT '作成时间',
  `create_user_id` bigint(20) unsigned NOT NULL COMMENT '创建者user_id',
  `modify_time` datetime NOT NULL COMMENT '更新时间',
  `modify_user_id` bigint(20) unsigned NOT NULL COMMENT '修改者user_id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Profile的创建者。如果两个不同创建者创建的Profile被融合，则融合后的Profile拥有两个以上的创建者';

-- Data exporting was unselected.
-- Dumping structure for table bloodnet.pv
CREATE TABLE IF NOT EXISTS `pv` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL COMMENT '日期',
  `value` bigint(20) unsigned NOT NULL COMMENT 'PV值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='PAGE VIEW记录';

-- Data exporting was unselected.
-- Dumping structure for table bloodnet.session
CREATE TABLE IF NOT EXISTS `session` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `value` char(36) NOT NULL COMMENT 'session值，36位UUID',
  `id_address` int(10) unsigned NOT NULL COMMENT '将ip地址转换成整数存储',
  `create_time` datetime NOT NULL COMMENT '作成时间',
  `create_user_id` int(10) unsigned NOT NULL COMMENT '创建者user_id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31000016 DEFAULT CHARSET=utf8 COMMENT='API用来管理用户的session。';

-- Data exporting was unselected.
-- Dumping structure for table bloodnet.user
CREATE TABLE IF NOT EXISTS `user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(32) NOT NULL COMMENT '用户名，用户指定，最大32位',
  `profile_id` bigint(20) unsigned NOT NULL COMMENT '对应的profile_id',
  `password` varchar(32) NOT NULL COMMENT '密码',
  `email` varchar(128) DEFAULT NULL COMMENT '电子邮箱',
  `email_verified` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '电子邮箱验证状态    0：未验证　1：验证',
  `phone_number` char(11) DEFAULT NULL COMMENT '手机号',
  `phone_number_verified` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '手机号验证状态    0：未验证　1：未验证',
  `family_key` char(4) NOT NULL COMMENT '用户秘钥。知道此秘钥的人可以无需请求活的同意即加入该家族',
  `is_with_invitation_code` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否持邀请码来到网站注册',
  `is_deleted` tinyint(1) unsigned NOT NULL COMMENT ' 0：未删除　1：删除',
  `create_time` datetime NOT NULL COMMENT '作成时间',
  `create_user_id` char(32) NOT NULL COMMENT '创建者user_id',
  `modify_time` datetime NOT NULL COMMENT '更新时间',
  `modify_user_id` char(32) NOT NULL COMMENT '修改者user_id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='系统用户表';

-- Data exporting was unselected.
-- Dumping structure for table bloodnet.user_invitation
CREATE TABLE IF NOT EXISTS `user_invitation` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `inviting_user_id` bigint(20) unsigned NOT NULL COMMENT '发出邀请的user_id',
  `invited_profile_id` bigint(20) unsigned NOT NULL COMMENT '被邀请的profile_id。树融合时如果Profile_id发生变化，需要更新',
  `invitation_code` tinyint(3) unsigned NOT NULL COMMENT '邀请码。随机的大于10的数字。如果该邀请码正在被同一姓名的人使用，则重新生成',
  `invated_profile_faimily_name` varchar(36) NOT NULL COMMENT '被邀请人姓',
  `invited_profile_first_name` varchar(36) NOT NULL COMMENT '被邀请人名',
  `has_used` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '已经被使用',
  `create_time` datetime NOT NULL COMMENT '作成时间',
  `create_user_id` char(32) NOT NULL COMMENT '创建者user_id',
  `modify_time` datetime NOT NULL COMMENT '更新时间',
  `modify_user_id` char(32) NOT NULL COMMENT '修改者user_id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='现有用户可以对自己登录的profile（已经登录了手机号或者邮箱）发出邀请';

-- Data exporting was unselected.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
