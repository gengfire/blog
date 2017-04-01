/*
SQLyog Ultimate v11.27 (32 bit)
MySQL - 5.5.20 : Database - blog
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`blog` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `blog`;

/*Table structure for table `mu_admin` */

DROP TABLE IF EXISTS `mu_admin`;

CREATE TABLE `mu_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `passwd` varchar(100) NOT NULL,
  `flag` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

/*Data for the table `mu_admin` */

insert  into `mu_admin`(`id`,`username`,`passwd`,`flag`) values (1,'admin','fcc6134deb05a36adc6a988235eb86c6',1);

/*Table structure for table `mu_category` */

DROP TABLE IF EXISTS `mu_category`;

CREATE TABLE `mu_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `f_id` int(11) NOT NULL DEFAULT '0',
  `cat_name` varchar(225) NOT NULL,
  `rank_id` int(11) NOT NULL DEFAULT '50',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

/*Data for the table `mu_category` */

insert  into `mu_category`(`id`,`uid`,`f_id`,`cat_name`,`rank_id`) values (1,1,0,'栏目一',1),(2,1,3,'栏目二',2),(3,1,1,'栏目三',3),(4,1,3,'栏目四',33),(5,1,1,'栏目五',101);

/*Table structure for table `mu_config` */

DROP TABLE IF EXISTS `mu_config`;

CREATE TABLE `mu_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `conobj` varchar(225) NOT NULL,
  `conval` text NOT NULL,
  `valtype` varchar(50) NOT NULL,
  `delor` int(11) NOT NULL DEFAULT '0',
  `rank_id` int(11) NOT NULL DEFAULT '50',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

/*Data for the table `mu_config` */

insert  into `mu_config`(`id`,`conobj`,`conval`,`valtype`,`delor`,`rank_id`) values (1,'sitename','note','input',1,50),(2,'keywords','笔记','input',1,50),(3,'description','note','textarea',1,50),(4,'copyright','MUMOON','input',1,3),(5,'tjcode','<script>frfr</script>','textarea',1,1);

/*Table structure for table `mu_note` */

DROP TABLE IF EXISTS `mu_note`;

CREATE TABLE `mu_note` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `title` varchar(225) NOT NULL,
  `mark` varchar(50) NOT NULL,
  `content` text NOT NULL,
  `cat_id` int(11) NOT NULL DEFAULT '0',
  `permission` int(11) NOT NULL DEFAULT '0',
  `tag` varchar(50) NOT NULL,
  `view` bigint(55) NOT NULL DEFAULT '0',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0',
  `rank_id` int(11) NOT NULL DEFAULT '50',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

/*Data for the table `mu_note` */

insert  into `mu_note`(`id`,`uid`,`title`,`mark`,`content`,`cat_id`,`permission`,`tag`,`view`,`add_time`,`rank_id`) values (1,4,'css3跳动','C','<p>先定义跳动动作</p><p>@keyframes tiao_fly {<br clear=\\\"none\\\"/>&nbsp;&nbsp;&nbsp; 0% {transform:translateX(0%) translateY(-15%) rotateZ(-20.5deg);}<br clear=\\\"none\\\"/>&nbsp;&nbsp;&nbsp; 100% {transform:translateX(0%) translateY(-0%) rotateZ(-20.5deg);}<br clear=\\\"none\\\"/>}<br clear=\\\"none\\\"/>@-webkit-keyframes tiao_fly {<br clear=\\\"none\\\"/>&nbsp;&nbsp;&nbsp; 0% {-webkit-transform:translateX(0%) translateY(-15%) rotateZ(-20.5deg);}<br clear=\\\"none\\\"/>&nbsp;&nbsp;&nbsp; 100% {-webkit-transform:translateX(0%) translateY(-0%) rotateZ(-20.5deg);}<br clear=\\\"none\\\"/>}<br clear=\\\"none\\\"/>@-moz-keyframes tiao_fly {<br clear=\\\"none\\\"/>&nbsp;&nbsp;&nbsp; 0% {-moz-transform:translateX(0%) translateY(-15%) rotateZ(-20.5deg);}<br clear=\\\"none\\\"/>&nbsp;&nbsp;&nbsp; 100% {-moz-transform:translateX(0%) translateY(-0%) rotateZ(-20.5deg);}<br clear=\\\"none\\\"/>}<br clear=\\\"none\\\"/>@-ms-keyframes tiao_fly {<br clear=\\\"none\\\"/>&nbsp;&nbsp;&nbsp; 0% {-ms-transform:translateX(0%) translateY(-15%) rotateZ(-20.5deg);}<br clear=\\\"none\\\"/>&nbsp;&nbsp;&nbsp; 100% {-ms-transform:translateX(0%) translateY(-0%) rotateZ(-20.5deg);}<br clear=\\\"none\\\"/>}<br clear=\\\"none\\\"/>@-o-keyframes tiao_fly {<br clear=\\\"none\\\"/>&nbsp;&nbsp;&nbsp; 0% {-o-transform:translateX(0%) translateY(-15%) rotateZ(-20.5deg);}<br clear=\\\"none\\\"/>&nbsp;&nbsp;&nbsp; 100% {-o-transform:translateX(0%) translateY(-0%) rotateZ(-20.5deg);}<br clear=\\\"none\\\"/>}<br clear=\\\"none\\\"/>@keyframes tiao_fly {<br clear=\\\"none\\\"/>&nbsp;&nbsp;&nbsp; 0% {transform:translateX(0%) translateY(-15%) rotateZ(-20.5deg);}<br clear=\\\"none\\\"/>&nbsp;&nbsp;&nbsp; 100% {transform:translateX(0%) translateY(-0%) rotateZ(-20.5deg);}<br clear=\\\"none\\\"/>}</p><p>然后针对div进行animate控制</p><p>.div{</p><p>&nbsp;&nbsp;&nbsp;&nbsp; position: absolute;</p><p>&nbsp;&nbsp;&nbsp; animation: tiao_fly 0.2s 0s alternate infinite;<br clear=\\\"none\\\"/>&nbsp;&nbsp;&nbsp;&nbsp; -webkit-animation: tiao_fly 0.2s 0s alternate infinite;<br clear=\\\"none\\\"/>&nbsp;&nbsp;&nbsp;&nbsp; -moz-animation: tiao_fly 0.2s 0s alternate infinite;<br clear=\\\"none\\\"/>&nbsp;&nbsp;&nbsp;&nbsp; -ms-animation: tiao_fly 0.2s 0s alternate infinite;<br clear=\\\"none\\\"/>&nbsp;&nbsp;&nbsp;&nbsp; -o-animation: tiao_fly 0.2s 0s alternate infinite;<br clear=\\\"none\\\"/>&nbsp;&nbsp;&nbsp;&nbsp; transform: rotateZ(-20.5deg);<br clear=\\\"none\\\"/>&nbsp;&nbsp;&nbsp;&nbsp; -webkit-transform: rotateZ(-20.5deg);<br clear=\\\"none\\\"/>&nbsp;&nbsp;&nbsp;&nbsp; -moz-transform: rotateZ(-20.5deg);<br clear=\\\"none\\\"/>&nbsp;&nbsp;&nbsp;&nbsp; -ms-transform: rotateZ(-20.5deg);<br clear=\\\"none\\\"/>&nbsp;&nbsp;&nbsp;&nbsp; -o-transform: rotateZ(-20.5deg);<br clear=\\\"none\\\"/></p><p>}</p><p><br/></p>',1,0,'',145,1425697212,50);

/*Table structure for table `mu_page` */

DROP TABLE IF EXISTS `mu_page`;

CREATE TABLE `mu_page` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `f_id` int(11) NOT NULL DEFAULT '50',
  `title` varchar(225) NOT NULL,
  `content` text NOT NULL,
  `desc` varchar(255) NOT NULL,
  `add_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `rank_id` int(11) NOT NULL DEFAULT '50',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `mu_page` */

/*Table structure for table `mu_user` */

DROP TABLE IF EXISTS `mu_user`;

CREATE TABLE `mu_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `passwd` varchar(100) NOT NULL,
  `token` varchar(100) NOT NULL,
  `reg_time` int(10) NOT NULL DEFAULT '0',
  `ulevel` int(11) NOT NULL DEFAULT '0',
  `favorite` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `mu_user` */

insert  into `mu_user`(`id`,`username`,`email`,`passwd`,`token`,`reg_time`,`ulevel`,`favorite`) values (1,'gengfire','gengfire@foxmail.com','fcc6134deb05a36adc6a988235eb86c6','fcc6134deb05a36adc6a988235eb86c6',1422437338,0,'');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
