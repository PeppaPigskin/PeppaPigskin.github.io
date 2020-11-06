# 一、项目概述

  1、项目名称：blog(个人博客系统)
  
# 二、系统环境配置

  1、系统运行平台：Tomcat7.0+JDK1.8+Windows10
  
  2、开发语言：Java
  
  3、前端框架：Thymeleaf,Semantic UI
  
  4、后台框架：SSM
  
  5、数据库：MySQL
  
  6、开发环境：IntelliJ IDEA 2020.1.2
  
# 三、功能模块

  1、后台
  
    1）博主后台登录
    
    2）博客管理：包括博客的创建、修改、删除、列表展示功能
    
    3）博客类别管理：用于创建博客时的博客分类，包括类别的创建、修改、删除、列表展示功能
    
    4）评论管理：用于管理前台用户浏览博客时添加的评论信息，包括评论信息的审核、删除、敏感词汇记录（目前只是审核过程中做了记录，但是还未做处理功能）
    
    5）个人账户管理：包括博主基本信息的维护，以及密码的修改
    
    6）系统管理：用于对前台展示的友情链接的管理，系统缓存数据的刷新，安全退出操作
  
  2、前台
  
    1）首页页：展示博客列表，最新分类，最近归档信息，以及友情链接列表
    
    2）分类页：用于根据博客分类展示博客列表，可以选择查看具体某一分类下的博客列表
    
    3）归档：根据博客发布日期，将博客按照年月来归档
    
    4）关于我：对于博主进行一些概要
    
    5）点击博客列表项，可以查看每篇博客的详细内容，同时包含该博客的评论以及分享功能
    
# 四、数据库设计

  1、数据库名：db_blog
  
    CREATE DATABASE `db_blog` 
  
  2、数据库表：
  
    1）博客表：t_blog

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
    ) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COMMENT='博客表'
    
    2）博主信息表：t_blogger

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
    ) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='博客账户表'
    
    3）博客类型表：t_blogtype
    
    CREATE TABLE `t_blogtype` (
      `id` int(18) NOT NULL AUTO_INCREMENT COMMENT '主键',
      `typeName` varchar(100) DEFAULT NULL COMMENT '类型名称',
      `orderNo` int(11) DEFAULT NULL COMMENT '序号',
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COMMENT='博客分类表'
    
    4）博客评论表：t_comment
    
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
    ) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COMMENT='博客评论表'
    
    5）友情链接表：t_link
    
    CREATE TABLE `t_link` (
      `id` int(18) NOT NULL AUTO_INCREMENT COMMENT '主键',
      `linkName` varchar(100) DEFAULT NULL COMMENT '网站名称',
      `linkUrl` varchar(500) DEFAULT NULL COMMENT '网站URL',
      `orderNo` int(11) DEFAULT NULL COMMENT '序号',
      PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='友情链接'
    
# 五、系统维护

   1、修改博客管理功能，博客支持三种状态（未发布、已发布、撤销发布）
   
    1）涉及脚本更新：
        
        博客表新增字段（status-博客状态）：01_T_BLOG_ADD_COLUMN@STATUS.sql
      
    2）涉及模块：
      
        前台涉及博客展示的模块：
        
            只展示status==1，即已发布状态的博客；
            
        后台博客管理模块：
          
            新增博客时支持发布、暂存两种保存方式；
            
            修改博客时支持修改保存、保存修改并发布两种保存方式；
            
            博客列表管理模块支持显示博客的当前状态；
            
            博客列表可进行博客的发布和撤销发布功能；
            
            
        
     
   
# 欢迎大家给出指导意见，谢谢！

    
    

    
    
    
    
    
    
