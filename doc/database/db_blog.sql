/*
SQLyog Ultimate v8.32 
MySQL - 5.5.62 : Database - db_blog
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`db_blog` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `db_blog`;

/*Table structure for table `t_blog` */

DROP TABLE IF EXISTS `t_blog`;

CREATE TABLE `t_blog` (
  `id` int(18) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(200) DEFAULT NULL COMMENT '标题',
  `summary` varchar(500) DEFAULT NULL COMMENT '摘要',
  `releaseDate` datetime DEFAULT NULL COMMENT '发表时间',
  `clickHit` int(11) DEFAULT NULL COMMENT '被访问次数',
  `replyHit` int(11) DEFAULT NULL COMMENT '评论数',
  `content` text COMMENT '内容',
  `modifyDate` datetime DEFAULT NULL COMMENT '修改日期',
  `typeId` int(18) DEFAULT NULL COMMENT '所属分类',
  `keyWord` varchar(200) DEFAULT NULL COMMENT '关键字',
  `bloggerId` int(18) NOT NULL COMMENT '所属博主',
  PRIMARY KEY (`id`),
  KEY `FK_t_blogger` (`bloggerId`),
  KEY `FK_t_blogtype` (`typeId`),
  CONSTRAINT `FK_t_blogger` FOREIGN KEY (`bloggerId`) REFERENCES `t_blogger` (`id`),
  CONSTRAINT `FK_t_blogtype` FOREIGN KEY (`typeId`) REFERENCES `t_blogtype` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='博客表';

/*Table structure for table `t_blogger` */

DROP TABLE IF EXISTS `t_blogger`;

CREATE TABLE `t_blogger` (
  `id` int(18) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `userName` varchar(50) DEFAULT NULL COMMENT '登录名',
  `password` varchar(100) DEFAULT NULL COMMENT '密码',
  `profile` text COMMENT '个人信息',
  `nickName` varchar(50) DEFAULT NULL COMMENT '昵称',
  `sign` varchar(100) DEFAULT NULL COMMENT '个性签名',
  `imageName` varchar(100) DEFAULT NULL COMMENT '个人头像地址',
  `accountType` int(2) DEFAULT NULL COMMENT '账户类型',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='博客账户表';

/*Table structure for table `t_blogtype` */

DROP TABLE IF EXISTS `t_blogtype`;

CREATE TABLE `t_blogtype` (
  `id` int(18) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `typeName` varchar(100) DEFAULT NULL COMMENT '类型名称',
  `orderNo` int(11) DEFAULT NULL COMMENT '序号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='博客分类表';

/*Table structure for table `t_comment` */

DROP TABLE IF EXISTS `t_comment`;

CREATE TABLE `t_comment` (
  `id` int(18) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `userIp` varchar(50) DEFAULT NULL COMMENT '评论者IP',
  `blogId` int(18) DEFAULT NULL COMMENT '被博客ID',
  `content` varchar(1000) DEFAULT NULL COMMENT '评论内容',
  `commentDate` datetime DEFAULT NULL COMMENT '评论时间',
  `state` int(11) DEFAULT NULL COMMENT '评论状态：0-未审核；1-审核通过；2-审核不通过；',
  `sensitiveWord` varchar(1000) DEFAULT NULL COMMENT '需要被处理的敏感词汇：例如：xx,xx,xx,xx（即多个使用逗号隔开）',
  PRIMARY KEY (`id`),
  KEY `FK_t_comment` (`blogId`),
  CONSTRAINT `FK_t_comment` FOREIGN KEY (`blogId`) REFERENCES `t_blog` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='博客评论表';

/*Table structure for table `t_link` */

DROP TABLE IF EXISTS `t_link`;

CREATE TABLE `t_link` (
  `id` int(18) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `linkName` varchar(100) DEFAULT NULL COMMENT '网站名称',
  `linkUrl` varchar(500) DEFAULT NULL COMMENT '网站URL',
  `orderNo` int(11) DEFAULT NULL COMMENT '序号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='友情链接';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
