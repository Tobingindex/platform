/*
SQLyog Professional v12.09 (64 bit)
MySQL - 5.7.18-log : Database - platform
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`platform` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `platform`;

/*Table structure for table `mq_message` */

CREATE TABLE `mq_message` (
  `message_id` char(32) NOT NULL COMMENT '消息标识',
  `content` text COMMENT '消息要保存的内容，可以考虑转换为json',
  `to_exchange` varchar(255) NOT NULL COMMENT 'Exchange',
  `routing_key` varchar(255) NOT NULL COMMENT 'routing_key',
  `class_type` varchar(255) NOT NULL,
  `message_status` int(11) DEFAULT '0' COMMENT '0-新建 1-已发送 2-错误抵达 3-成功抵达',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `mq_message` */

/*Table structure for table `oms_order` */

CREATE TABLE `oms_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `member_id` bigint(20) DEFAULT NULL COMMENT 'member_id',
  `order_sn` char(64) DEFAULT NULL COMMENT '订单号',
  `coupon_id` bigint(20) DEFAULT NULL COMMENT '使用的优惠券',
  `create_time` datetime DEFAULT NULL COMMENT 'create_time',
  `member_username` varchar(200) DEFAULT NULL COMMENT '用户名',
  `total_amount` decimal(18,4) DEFAULT NULL COMMENT '订单总额',
  `pay_amount` decimal(18,4) DEFAULT NULL COMMENT '应付总额',
  `freight_amount` decimal(18,4) DEFAULT NULL COMMENT '运费金额',
  `promotion_amount` decimal(18,4) DEFAULT NULL COMMENT '促销优化金额（促销价、满减、阶梯价）',
  `integration_amount` decimal(18,4) DEFAULT NULL COMMENT '积分抵扣金额',
  `coupon_amount` decimal(18,4) DEFAULT NULL COMMENT '优惠券抵扣金额',
  `discount_amount` decimal(18,4) DEFAULT NULL COMMENT '后台调整订单使用的折扣金额',
  `pay_type` tinyint(4) DEFAULT NULL COMMENT '支付方式【1->支付宝；2->微信；3->银联； 4->货到付款；】',
  `source_type` tinyint(4) DEFAULT NULL COMMENT '订单来源[0->PC订单；1->app订单]',
  `status` tinyint(4) DEFAULT NULL COMMENT '订单状态【0->待付款；1->待发货；2->已发货；3->已完成；4->已关闭；5->无效订单】',
  `delivery_company` varchar(64) DEFAULT NULL COMMENT '物流公司(配送方式)',
  `delivery_sn` varchar(64) DEFAULT NULL COMMENT '物流单号',
  `auto_confirm_day` int(11) DEFAULT NULL COMMENT '自动确认时间（天）',
  `integration` int(11) DEFAULT NULL COMMENT '可以获得的积分',
  `growth` int(11) DEFAULT NULL COMMENT '可以获得的成长值',
  `bill_type` tinyint(4) DEFAULT NULL COMMENT '发票类型[0->不开发票；1->电子发票；2->纸质发票]',
  `bill_header` varchar(255) DEFAULT NULL COMMENT '发票抬头',
  `bill_content` varchar(255) DEFAULT NULL COMMENT '发票内容',
  `bill_receiver_phone` varchar(32) DEFAULT NULL COMMENT '收票人电话',
  `bill_receiver_email` varchar(64) DEFAULT NULL COMMENT '收票人邮箱',
  `receiver_name` varchar(100) DEFAULT NULL COMMENT '收货人姓名',
  `receiver_phone` varchar(32) DEFAULT NULL COMMENT '收货人电话',
  `receiver_post_code` varchar(32) DEFAULT NULL COMMENT '收货人邮编',
  `receiver_province` varchar(32) DEFAULT NULL COMMENT '省份/直辖市',
  `receiver_city` varchar(32) DEFAULT NULL COMMENT '城市',
  `receiver_region` varchar(32) DEFAULT NULL COMMENT '区',
  `receiver_detail_address` varchar(200) DEFAULT NULL COMMENT '详细地址',
  `note` varchar(500) DEFAULT NULL COMMENT '订单备注',
  `confirm_status` tinyint(4) DEFAULT NULL COMMENT '确认收货状态[0->未确认；1->已确认]',
  `delete_status` tinyint(4) DEFAULT NULL COMMENT '删除状态【0->未删除；1->已删除】',
  `use_integration` int(11) DEFAULT NULL COMMENT '下单时使用的积分',
  `payment_time` datetime DEFAULT NULL COMMENT '支付时间',
  `delivery_time` datetime DEFAULT NULL COMMENT '发货时间',
  `receive_time` datetime DEFAULT NULL COMMENT '确认收货时间',
  `comment_time` datetime DEFAULT NULL COMMENT '评价时间',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1389134196613668866 DEFAULT CHARSET=utf8mb4 COMMENT='订单';

/*Data for the table `oms_order` */

insert  into `oms_order`(`id`,`member_id`,`order_sn`,`coupon_id`,`create_time`,`member_username`,`total_amount`,`pay_amount`,`freight_amount`,`promotion_amount`,`integration_amount`,`coupon_amount`,`discount_amount`,`pay_type`,`source_type`,`status`,`delivery_company`,`delivery_sn`,`auto_confirm_day`,`integration`,`growth`,`bill_type`,`bill_header`,`bill_content`,`bill_receiver_phone`,`bill_receiver_email`,`receiver_name`,`receiver_phone`,`receiver_post_code`,`receiver_province`,`receiver_city`,`receiver_region`,`receiver_detail_address`,`note`,`confirm_status`,`delete_status`,`use_integration`,`payment_time`,`delivery_time`,`receive_time`,`comment_time`,`modify_time`) values (1387766123486859265,1383046426916814849,'202104292150018061387766122916433922',NULL,'2021-04-29 21:50:02','tobingindex','49393.0000','49402.0000','9.0000','0.0000','0.0000','0.0000',NULL,1,1,4,NULL,NULL,7,0,49393,NULL,NULL,NULL,NULL,NULL,'广东','12345311212','525100','广东省',NULL,NULL,'广东省化州市第一中学',NULL,0,0,NULL,NULL,NULL,NULL,NULL,'2021-04-29 21:50:02');
insert  into `oms_order`(`id`,`member_id`,`order_sn`,`coupon_id`,`create_time`,`member_username`,`total_amount`,`pay_amount`,`freight_amount`,`promotion_amount`,`integration_amount`,`coupon_amount`,`discount_amount`,`pay_type`,`source_type`,`status`,`delivery_company`,`delivery_sn`,`auto_confirm_day`,`integration`,`growth`,`bill_type`,`bill_header`,`bill_content`,`bill_receiver_phone`,`bill_receiver_email`,`receiver_name`,`receiver_phone`,`receiver_post_code`,`receiver_province`,`receiver_city`,`receiver_region`,`receiver_detail_address`,`note`,`confirm_status`,`delete_status`,`use_integration`,`payment_time`,`delivery_time`,`receive_time`,`comment_time`,`modify_time`) values (1387776667732180993,1383046426916814849,'202104292231557421387776667124006913',NULL,'2021-04-29 22:31:56','tobingindex','49393.0000','49402.0000','9.0000','0.0000','0.0000','0.0000',NULL,1,1,4,NULL,NULL,7,0,49393,NULL,NULL,NULL,NULL,NULL,'广东','12345311212','525100','广东省',NULL,NULL,'广东省化州市第一中学',NULL,0,0,NULL,NULL,NULL,NULL,NULL,'2021-04-29 22:31:56');
insert  into `oms_order`(`id`,`member_id`,`order_sn`,`coupon_id`,`create_time`,`member_username`,`total_amount`,`pay_amount`,`freight_amount`,`promotion_amount`,`integration_amount`,`coupon_amount`,`discount_amount`,`pay_type`,`source_type`,`status`,`delivery_company`,`delivery_sn`,`auto_confirm_day`,`integration`,`growth`,`bill_type`,`bill_header`,`bill_content`,`bill_receiver_phone`,`bill_receiver_email`,`receiver_name`,`receiver_phone`,`receiver_post_code`,`receiver_province`,`receiver_city`,`receiver_region`,`receiver_detail_address`,`note`,`confirm_status`,`delete_status`,`use_integration`,`payment_time`,`delivery_time`,`receive_time`,`comment_time`,`modify_time`) values (1387778986637021185,1383046426916814849,'202104292241085991387778985978515457',NULL,'2021-04-29 22:41:09','tobingindex','49393.0000','49402.0000','9.0000','0.0000','0.0000','0.0000',NULL,1,1,4,NULL,NULL,7,0,49393,NULL,NULL,NULL,NULL,NULL,'四川','12131413241','610500','四川省',NULL,NULL,'四川省成都市新都区西南石油大学',NULL,0,0,NULL,NULL,NULL,NULL,NULL,'2021-04-29 22:41:09');
insert  into `oms_order`(`id`,`member_id`,`order_sn`,`coupon_id`,`create_time`,`member_username`,`total_amount`,`pay_amount`,`freight_amount`,`promotion_amount`,`integration_amount`,`coupon_amount`,`discount_amount`,`pay_type`,`source_type`,`status`,`delivery_company`,`delivery_sn`,`auto_confirm_day`,`integration`,`growth`,`bill_type`,`bill_header`,`bill_content`,`bill_receiver_phone`,`bill_receiver_email`,`receiver_name`,`receiver_phone`,`receiver_post_code`,`receiver_province`,`receiver_city`,`receiver_region`,`receiver_detail_address`,`note`,`confirm_status`,`delete_status`,`use_integration`,`payment_time`,`delivery_time`,`receive_time`,`comment_time`,`modify_time`) values (1387968041635033090,1383046426916814849,'202104301112228251387968040980721665',NULL,'2021-04-30 11:12:23','tobingindex','56992.0000','57001.0000','9.0000','0.0000','0.0000','0.0000',NULL,1,1,4,NULL,NULL,7,0,56992,NULL,NULL,NULL,NULL,NULL,'广东','12345311212','525100','广东省',NULL,NULL,'广东省化州市第一中学',NULL,0,0,NULL,NULL,NULL,NULL,NULL,'2021-04-30 11:12:23');
insert  into `oms_order`(`id`,`member_id`,`order_sn`,`coupon_id`,`create_time`,`member_username`,`total_amount`,`pay_amount`,`freight_amount`,`promotion_amount`,`integration_amount`,`coupon_amount`,`discount_amount`,`pay_type`,`source_type`,`status`,`delivery_company`,`delivery_sn`,`auto_confirm_day`,`integration`,`growth`,`bill_type`,`bill_header`,`bill_content`,`bill_receiver_phone`,`bill_receiver_email`,`receiver_name`,`receiver_phone`,`receiver_post_code`,`receiver_province`,`receiver_city`,`receiver_region`,`receiver_detail_address`,`note`,`confirm_status`,`delete_status`,`use_integration`,`payment_time`,`delivery_time`,`receive_time`,`comment_time`,`modify_time`) values (1387981568852746242,1383046426916814849,'202104301206079851387981568286515202',NULL,'2021-04-30 12:06:08','tobingindex','56992.0000','57001.0000','9.0000','0.0000','0.0000','0.0000',NULL,1,1,4,NULL,NULL,7,0,56992,NULL,NULL,NULL,NULL,NULL,'四川','12131413241','610500','四川省',NULL,NULL,'四川省成都市新都区西南石油大学',NULL,0,0,NULL,NULL,NULL,NULL,NULL,'2021-04-30 12:06:08');
insert  into `oms_order`(`id`,`member_id`,`order_sn`,`coupon_id`,`create_time`,`member_username`,`total_amount`,`pay_amount`,`freight_amount`,`promotion_amount`,`integration_amount`,`coupon_amount`,`discount_amount`,`pay_type`,`source_type`,`status`,`delivery_company`,`delivery_sn`,`auto_confirm_day`,`integration`,`growth`,`bill_type`,`bill_header`,`bill_content`,`bill_receiver_phone`,`bill_receiver_email`,`receiver_name`,`receiver_phone`,`receiver_post_code`,`receiver_province`,`receiver_city`,`receiver_region`,`receiver_detail_address`,`note`,`confirm_status`,`delete_status`,`use_integration`,`payment_time`,`delivery_time`,`receive_time`,`comment_time`,`modify_time`) values (1387988728944910337,1383046426916814849,'202104301234350771387988728349319170',NULL,'2021-04-30 12:34:35','tobingindex','56992.0000','57001.0000','9.0000','0.0000','0.0000','0.0000',NULL,1,1,4,NULL,NULL,7,0,56992,NULL,NULL,NULL,NULL,NULL,'广东','12345311212','525100','广东省',NULL,NULL,'广东省化州市第一中学',NULL,0,0,NULL,NULL,NULL,NULL,NULL,'2021-04-30 12:34:35');
insert  into `oms_order`(`id`,`member_id`,`order_sn`,`coupon_id`,`create_time`,`member_username`,`total_amount`,`pay_amount`,`freight_amount`,`promotion_amount`,`integration_amount`,`coupon_amount`,`discount_amount`,`pay_type`,`source_type`,`status`,`delivery_company`,`delivery_sn`,`auto_confirm_day`,`integration`,`growth`,`bill_type`,`bill_header`,`bill_content`,`bill_receiver_phone`,`bill_receiver_email`,`receiver_name`,`receiver_phone`,`receiver_post_code`,`receiver_province`,`receiver_city`,`receiver_region`,`receiver_detail_address`,`note`,`confirm_status`,`delete_status`,`use_integration`,`payment_time`,`delivery_time`,`receive_time`,`comment_time`,`modify_time`) values (1387994949580083202,1383046426916814849,'202104301259182291387994949135486978',NULL,'2021-04-30 12:59:18','tobingindex','56992.0000','57001.0000','9.0000','0.0000','0.0000','0.0000',NULL,1,1,4,NULL,NULL,7,0,56992,NULL,NULL,NULL,NULL,NULL,'广东','12345311212','525100','广东省',NULL,NULL,'广东省化州市第一中学',NULL,0,0,NULL,NULL,NULL,NULL,NULL,'2021-04-30 12:59:18');
insert  into `oms_order`(`id`,`member_id`,`order_sn`,`coupon_id`,`create_time`,`member_username`,`total_amount`,`pay_amount`,`freight_amount`,`promotion_amount`,`integration_amount`,`coupon_amount`,`discount_amount`,`pay_type`,`source_type`,`status`,`delivery_company`,`delivery_sn`,`auto_confirm_day`,`integration`,`growth`,`bill_type`,`bill_header`,`bill_content`,`bill_receiver_phone`,`bill_receiver_email`,`receiver_name`,`receiver_phone`,`receiver_post_code`,`receiver_province`,`receiver_city`,`receiver_region`,`receiver_detail_address`,`note`,`confirm_status`,`delete_status`,`use_integration`,`payment_time`,`delivery_time`,`receive_time`,`comment_time`,`modify_time`) values (1387995481539465217,1383046426916814849,'202104301301251201387995481342332929',NULL,'2021-04-30 13:01:25','tobingindex','56992.0000','57001.0000','9.0000','0.0000','0.0000','0.0000',NULL,1,1,4,NULL,NULL,7,0,56992,NULL,NULL,NULL,NULL,NULL,'广东','12345311212','525100','广东省',NULL,NULL,'广东省化州市第一中学',NULL,0,0,NULL,NULL,NULL,NULL,NULL,'2021-04-30 13:01:25');
insert  into `oms_order`(`id`,`member_id`,`order_sn`,`coupon_id`,`create_time`,`member_username`,`total_amount`,`pay_amount`,`freight_amount`,`promotion_amount`,`integration_amount`,`coupon_amount`,`discount_amount`,`pay_type`,`source_type`,`status`,`delivery_company`,`delivery_sn`,`auto_confirm_day`,`integration`,`growth`,`bill_type`,`bill_header`,`bill_content`,`bill_receiver_phone`,`bill_receiver_email`,`receiver_name`,`receiver_phone`,`receiver_post_code`,`receiver_province`,`receiver_city`,`receiver_region`,`receiver_detail_address`,`note`,`confirm_status`,`delete_status`,`use_integration`,`payment_time`,`delivery_time`,`receive_time`,`comment_time`,`modify_time`) values (1388043219568250881,1383046426916814849,'202104301611067031388043219178180610',NULL,'2021-04-30 16:11:07','tobingindex','20397.0000','20406.0000','9.0000','0.0000','0.0000','0.0000',NULL,1,1,4,NULL,NULL,7,0,20397,NULL,NULL,NULL,NULL,NULL,'广东','12345311212','525100','广东省',NULL,NULL,'广东省化州市第一中学',NULL,0,0,NULL,NULL,NULL,NULL,NULL,'2021-04-30 16:11:07');
insert  into `oms_order`(`id`,`member_id`,`order_sn`,`coupon_id`,`create_time`,`member_username`,`total_amount`,`pay_amount`,`freight_amount`,`promotion_amount`,`integration_amount`,`coupon_amount`,`discount_amount`,`pay_type`,`source_type`,`status`,`delivery_company`,`delivery_sn`,`auto_confirm_day`,`integration`,`growth`,`bill_type`,`bill_header`,`bill_content`,`bill_receiver_phone`,`bill_receiver_email`,`receiver_name`,`receiver_phone`,`receiver_post_code`,`receiver_province`,`receiver_city`,`receiver_region`,`receiver_detail_address`,`note`,`confirm_status`,`delete_status`,`use_integration`,`payment_time`,`delivery_time`,`receive_time`,`comment_time`,`modify_time`) values (1388112220256210946,1383046426916814849,'202104302045177271388112219769671681',NULL,'2021-04-30 20:45:18','tobingindex','41394.0000','41403.0000','9.0000','0.0000','0.0000','0.0000',NULL,1,1,4,NULL,NULL,7,0,41394,NULL,NULL,NULL,NULL,NULL,'广东','12345311212','525100','广东省',NULL,NULL,'广东省化州市第一中学',NULL,0,0,NULL,NULL,NULL,NULL,NULL,'2021-04-30 20:45:18');
insert  into `oms_order`(`id`,`member_id`,`order_sn`,`coupon_id`,`create_time`,`member_username`,`total_amount`,`pay_amount`,`freight_amount`,`promotion_amount`,`integration_amount`,`coupon_amount`,`discount_amount`,`pay_type`,`source_type`,`status`,`delivery_company`,`delivery_sn`,`auto_confirm_day`,`integration`,`growth`,`bill_type`,`bill_header`,`bill_content`,`bill_receiver_phone`,`bill_receiver_email`,`receiver_name`,`receiver_phone`,`receiver_post_code`,`receiver_province`,`receiver_city`,`receiver_region`,`receiver_detail_address`,`note`,`confirm_status`,`delete_status`,`use_integration`,`payment_time`,`delivery_time`,`receive_time`,`comment_time`,`modify_time`) values (1388304871903571969,1383046426916814849,'202105010930494401388304871341535234',NULL,'2021-05-01 09:30:49','tobingindex','41394.0000','41403.0000','9.0000','0.0000','0.0000','0.0000',NULL,1,1,4,NULL,NULL,7,0,41394,NULL,NULL,NULL,NULL,NULL,'广东','12345311212','525100','广东省',NULL,NULL,'广东省化州市第一中学',NULL,0,0,NULL,NULL,NULL,NULL,NULL,'2021-05-01 09:30:49');
insert  into `oms_order`(`id`,`member_id`,`order_sn`,`coupon_id`,`create_time`,`member_username`,`total_amount`,`pay_amount`,`freight_amount`,`promotion_amount`,`integration_amount`,`coupon_amount`,`discount_amount`,`pay_type`,`source_type`,`status`,`delivery_company`,`delivery_sn`,`auto_confirm_day`,`integration`,`growth`,`bill_type`,`bill_header`,`bill_content`,`bill_receiver_phone`,`bill_receiver_email`,`receiver_name`,`receiver_phone`,`receiver_post_code`,`receiver_province`,`receiver_city`,`receiver_region`,`receiver_detail_address`,`note`,`confirm_status`,`delete_status`,`use_integration`,`payment_time`,`delivery_time`,`receive_time`,`comment_time`,`modify_time`) values (1388305270798659586,1383046426916814849,'202105010932246431388305270597332994',NULL,'2021-05-01 09:32:25','tobingindex','41394.0000','41403.0000','9.0000','0.0000','0.0000','0.0000',NULL,1,1,4,NULL,NULL,7,0,41394,NULL,NULL,NULL,NULL,NULL,'四川','12131413241','610500','四川省',NULL,NULL,'四川省成都市新都区西南石油大学',NULL,0,0,NULL,NULL,NULL,NULL,NULL,'2021-05-01 09:32:25');
insert  into `oms_order`(`id`,`member_id`,`order_sn`,`coupon_id`,`create_time`,`member_username`,`total_amount`,`pay_amount`,`freight_amount`,`promotion_amount`,`integration_amount`,`coupon_amount`,`discount_amount`,`pay_type`,`source_type`,`status`,`delivery_company`,`delivery_sn`,`auto_confirm_day`,`integration`,`growth`,`bill_type`,`bill_header`,`bill_content`,`bill_receiver_phone`,`bill_receiver_email`,`receiver_name`,`receiver_phone`,`receiver_post_code`,`receiver_province`,`receiver_city`,`receiver_region`,`receiver_detail_address`,`note`,`confirm_status`,`delete_status`,`use_integration`,`payment_time`,`delivery_time`,`receive_time`,`comment_time`,`modify_time`) values (1388351568285380609,1383046426916814849,'202105011236228041388351568021139457',NULL,'2021-05-01 12:36:23','tobingindex','41394.0000','41403.0000','9.0000','0.0000','0.0000','0.0000',NULL,1,1,4,NULL,NULL,7,0,41394,NULL,NULL,NULL,NULL,NULL,'四川','12131413241','610500','四川省',NULL,NULL,'四川省成都市新都区西南石油大学',NULL,0,0,NULL,NULL,NULL,NULL,NULL,'2021-05-01 12:36:23');
insert  into `oms_order`(`id`,`member_id`,`order_sn`,`coupon_id`,`create_time`,`member_username`,`total_amount`,`pay_amount`,`freight_amount`,`promotion_amount`,`integration_amount`,`coupon_amount`,`discount_amount`,`pay_type`,`source_type`,`status`,`delivery_company`,`delivery_sn`,`auto_confirm_day`,`integration`,`growth`,`bill_type`,`bill_header`,`bill_content`,`bill_receiver_phone`,`bill_receiver_email`,`receiver_name`,`receiver_phone`,`receiver_post_code`,`receiver_province`,`receiver_city`,`receiver_region`,`receiver_detail_address`,`note`,`confirm_status`,`delete_status`,`use_integration`,`payment_time`,`delivery_time`,`receive_time`,`comment_time`,`modify_time`) values (1388352299889340418,1383046426916814849,'202105011239171861388352299461521410',NULL,'2021-05-01 12:39:17','tobingindex','41394.0000','41403.0000','9.0000','0.0000','0.0000','0.0000',NULL,1,1,4,NULL,NULL,7,0,41394,NULL,NULL,NULL,NULL,NULL,'四川','12131413241','610500','四川省',NULL,NULL,'四川省成都市新都区西南石油大学',NULL,0,0,NULL,NULL,NULL,NULL,NULL,'2021-05-01 12:39:17');
insert  into `oms_order`(`id`,`member_id`,`order_sn`,`coupon_id`,`create_time`,`member_username`,`total_amount`,`pay_amount`,`freight_amount`,`promotion_amount`,`integration_amount`,`coupon_amount`,`discount_amount`,`pay_type`,`source_type`,`status`,`delivery_company`,`delivery_sn`,`auto_confirm_day`,`integration`,`growth`,`bill_type`,`bill_header`,`bill_content`,`bill_receiver_phone`,`bill_receiver_email`,`receiver_name`,`receiver_phone`,`receiver_post_code`,`receiver_province`,`receiver_city`,`receiver_region`,`receiver_detail_address`,`note`,`confirm_status`,`delete_status`,`use_integration`,`payment_time`,`delivery_time`,`receive_time`,`comment_time`,`modify_time`) values (1388352959565275138,1383046426916814849,'202105011241544931388352959254896642',NULL,'2021-05-01 12:41:54','tobingindex','6799.0000','6808.0000','9.0000','0.0000','0.0000','0.0000',NULL,1,1,1,NULL,NULL,7,0,6799,NULL,NULL,NULL,NULL,NULL,'四川','12131413241','610500','四川省',NULL,NULL,'四川省成都市新都区西南石油大学',NULL,0,0,NULL,NULL,NULL,NULL,NULL,'2021-05-01 12:41:54');
insert  into `oms_order`(`id`,`member_id`,`order_sn`,`coupon_id`,`create_time`,`member_username`,`total_amount`,`pay_amount`,`freight_amount`,`promotion_amount`,`integration_amount`,`coupon_amount`,`discount_amount`,`pay_type`,`source_type`,`status`,`delivery_company`,`delivery_sn`,`auto_confirm_day`,`integration`,`growth`,`bill_type`,`bill_header`,`bill_content`,`bill_receiver_phone`,`bill_receiver_email`,`receiver_name`,`receiver_phone`,`receiver_post_code`,`receiver_province`,`receiver_city`,`receiver_region`,`receiver_detail_address`,`note`,`confirm_status`,`delete_status`,`use_integration`,`payment_time`,`delivery_time`,`receive_time`,`comment_time`,`modify_time`) values (1388355068058775554,1383046426916814849,'202105011250171611388355067601596417',NULL,'2021-05-01 12:50:17','tobingindex','6799.0000','6808.0000','9.0000','0.0000','0.0000','0.0000',NULL,1,1,1,NULL,NULL,7,0,6799,NULL,NULL,NULL,NULL,NULL,'四川','12131413241','610500','四川省',NULL,NULL,'四川省成都市新都区西南石油大学',NULL,0,0,NULL,NULL,NULL,NULL,NULL,'2021-05-01 12:50:17');
insert  into `oms_order`(`id`,`member_id`,`order_sn`,`coupon_id`,`create_time`,`member_username`,`total_amount`,`pay_amount`,`freight_amount`,`promotion_amount`,`integration_amount`,`coupon_amount`,`discount_amount`,`pay_type`,`source_type`,`status`,`delivery_company`,`delivery_sn`,`auto_confirm_day`,`integration`,`growth`,`bill_type`,`bill_header`,`bill_content`,`bill_receiver_phone`,`bill_receiver_email`,`receiver_name`,`receiver_phone`,`receiver_post_code`,`receiver_province`,`receiver_city`,`receiver_region`,`receiver_detail_address`,`note`,`confirm_status`,`delete_status`,`use_integration`,`payment_time`,`delivery_time`,`receive_time`,`comment_time`,`modify_time`) values (1389080576056705025,1383046426916814849,'202105031253117231389080575498862594',NULL,'2021-05-03 12:53:12','tobingindex','14398.0000','14407.0000','9.0000','0.0000','0.0000','0.0000',NULL,1,1,4,NULL,NULL,7,0,14398,NULL,NULL,NULL,NULL,NULL,'广东','12345311212','525100','广东省',NULL,NULL,'广东省化州市第一中学',NULL,0,0,NULL,NULL,NULL,NULL,NULL,'2021-05-03 12:53:12');
insert  into `oms_order`(`id`,`member_id`,`order_sn`,`coupon_id`,`create_time`,`member_username`,`total_amount`,`pay_amount`,`freight_amount`,`promotion_amount`,`integration_amount`,`coupon_amount`,`discount_amount`,`pay_type`,`source_type`,`status`,`delivery_company`,`delivery_sn`,`auto_confirm_day`,`integration`,`growth`,`bill_type`,`bill_header`,`bill_content`,`bill_receiver_phone`,`bill_receiver_email`,`receiver_name`,`receiver_phone`,`receiver_post_code`,`receiver_province`,`receiver_city`,`receiver_region`,`receiver_detail_address`,`note`,`confirm_status`,`delete_status`,`use_integration`,`payment_time`,`delivery_time`,`receive_time`,`comment_time`,`modify_time`) values (1389081086444699650,1383046426916814849,'202105031255134401389081086012686337',NULL,'2021-05-03 12:55:13','tobingindex','14398.0000','14407.0000','9.0000','0.0000','0.0000','0.0000',NULL,1,1,4,NULL,NULL,7,0,14398,NULL,NULL,NULL,NULL,NULL,'四川','12131413241','610500','四川省',NULL,NULL,'四川省成都市新都区西南石油大学',NULL,0,0,NULL,NULL,NULL,NULL,NULL,'2021-05-03 12:55:13');
insert  into `oms_order`(`id`,`member_id`,`order_sn`,`coupon_id`,`create_time`,`member_username`,`total_amount`,`pay_amount`,`freight_amount`,`promotion_amount`,`integration_amount`,`coupon_amount`,`discount_amount`,`pay_type`,`source_type`,`status`,`delivery_company`,`delivery_sn`,`auto_confirm_day`,`integration`,`growth`,`bill_type`,`bill_header`,`bill_content`,`bill_receiver_phone`,`bill_receiver_email`,`receiver_name`,`receiver_phone`,`receiver_post_code`,`receiver_province`,`receiver_city`,`receiver_region`,`receiver_detail_address`,`note`,`confirm_status`,`delete_status`,`use_integration`,`payment_time`,`delivery_time`,`receive_time`,`comment_time`,`modify_time`) values (1389081207098048514,1383046426916814849,'202105031255422711389081206900916226',NULL,'2021-05-03 12:55:42','tobingindex','14398.0000','14407.0000','9.0000','0.0000','0.0000','0.0000',NULL,1,1,4,NULL,NULL,7,0,14398,NULL,NULL,NULL,NULL,NULL,'广东','12345311212','525100','广东省',NULL,NULL,'广东省化州市第一中学',NULL,0,0,NULL,NULL,NULL,NULL,NULL,'2021-05-03 12:55:42');
insert  into `oms_order`(`id`,`member_id`,`order_sn`,`coupon_id`,`create_time`,`member_username`,`total_amount`,`pay_amount`,`freight_amount`,`promotion_amount`,`integration_amount`,`coupon_amount`,`discount_amount`,`pay_type`,`source_type`,`status`,`delivery_company`,`delivery_sn`,`auto_confirm_day`,`integration`,`growth`,`bill_type`,`bill_header`,`bill_content`,`bill_receiver_phone`,`bill_receiver_email`,`receiver_name`,`receiver_phone`,`receiver_post_code`,`receiver_province`,`receiver_city`,`receiver_region`,`receiver_detail_address`,`note`,`confirm_status`,`delete_status`,`use_integration`,`payment_time`,`delivery_time`,`receive_time`,`comment_time`,`modify_time`) values (1389134196613668865,1383046426916814849,'202105031626158551389134196030660609',NULL,'2021-05-03 16:26:16','tobingindex','14398.0000','14407.0000','9.0000','0.0000','0.0000','0.0000',NULL,1,1,4,NULL,NULL,7,0,14398,NULL,NULL,NULL,NULL,NULL,'广东','12345311212','525100','广东省',NULL,NULL,'广东省化州市第一中学',NULL,0,0,NULL,NULL,NULL,NULL,NULL,'2021-05-03 16:26:16');

/*Table structure for table `oms_order_item` */

CREATE TABLE `oms_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` bigint(20) DEFAULT NULL COMMENT 'order_id',
  `order_sn` char(64) DEFAULT NULL COMMENT 'order_sn',
  `spu_id` bigint(20) DEFAULT NULL COMMENT 'spu_id',
  `spu_name` varchar(255) DEFAULT NULL COMMENT 'spu_name',
  `spu_pic` varchar(500) DEFAULT NULL COMMENT 'spu_pic',
  `spu_brand` varchar(200) DEFAULT NULL COMMENT '品牌',
  `category_id` bigint(20) DEFAULT NULL COMMENT '商品分类id',
  `sku_id` bigint(20) DEFAULT NULL COMMENT '商品sku编号',
  `sku_name` varchar(255) DEFAULT NULL COMMENT '商品sku名字',
  `sku_pic` varchar(500) DEFAULT NULL COMMENT '商品sku图片',
  `sku_price` decimal(18,4) DEFAULT NULL COMMENT '商品sku价格',
  `sku_quantity` int(11) DEFAULT NULL COMMENT '商品购买的数量',
  `sku_attrs_vals` varchar(500) DEFAULT NULL COMMENT '商品销售属性组合（JSON）',
  `promotion_amount` decimal(18,4) DEFAULT NULL COMMENT '商品促销分解金额',
  `coupon_amount` decimal(18,4) DEFAULT NULL COMMENT '优惠券优惠分解金额',
  `integration_amount` decimal(18,4) DEFAULT NULL COMMENT '积分优惠分解金额',
  `real_amount` decimal(18,4) DEFAULT NULL COMMENT '该商品经过优惠后的分解金额',
  `gift_integration` int(11) DEFAULT NULL COMMENT '赠送积分',
  `gift_growth` int(11) DEFAULT NULL COMMENT '赠送成长值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1389134196798218243 DEFAULT CHARSET=utf8mb4 COMMENT='订单项信息';

/*Data for the table `oms_order_item` */

insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1387766123683991554,NULL,'202104292150018061387766122916433922',10,'华为 HUAWEI Mate 40 Pro',NULL,'9',225,28,'【华为Mate40Pro】5nm麒麟芯片!超感知徕卡电影影像!双线超级快充!隔空操控屏!!!限量抢购更多选择猛戳查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/6b4fd587-6293-4428-8673-c8751452a74b_huawei_zhengmian.jpg','6999.0000',5,'CPU类型：海思（Hisilicon）;运行内存：8G+256G;机身颜色：亮黑色','0.0000','0.0000','0.0000','34995.0000',34995,34995);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1387766123683991555,NULL,'202104292150018061387766122916433922',9,'Apple iPhone 12',NULL,'8',225,25,'【领券立减600元！】加9元得价值149元20W原装充电头，加799元享价值1246元AirPods蓝牙耳机！惊喜直达查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0382fc61-adb3-4720-8611-0c5ae700a8b2_iPhone_hongse_zheng.jpg','6799.0000',1,'CPU类型：Apple A14;运行内存：128G;机身颜色：红色','0.0000','0.0000','0.0000','6799.0000',6799,6799);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1387766123683991556,NULL,'202104292150018061387766122916433922',9,'Apple iPhone 12',NULL,'8',225,23,'【领券立减600元！】加9元得价值149元20W原装充电头，加799元享价值1246元AirPods蓝牙耳机！惊喜直达查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0382fc61-adb3-4720-8611-0c5ae700a8b2_iPhone_hongse_zheng.jpg','7599.0000',1,'CPU类型：Apple A14;运行内存：256G;机身颜色：红色','0.0000','0.0000','0.0000','7599.0000',7599,7599);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1387776667929313281,NULL,'202104292231557421387776667124006913',10,'华为 HUAWEI Mate 40 Pro',NULL,'9',225,28,'【华为Mate40Pro】5nm麒麟芯片!超感知徕卡电影影像!双线超级快充!隔空操控屏!!!限量抢购更多选择猛戳查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/6b4fd587-6293-4428-8673-c8751452a74b_huawei_zhengmian.jpg','6999.0000',5,'CPU类型：海思（Hisilicon）;运行内存：8G+256G;机身颜色：亮黑色','0.0000','0.0000','0.0000','34995.0000',34995,34995);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1387776667929313282,NULL,'202104292231557421387776667124006913',9,'Apple iPhone 12',NULL,'8',225,25,'【领券立减600元！】加9元得价值149元20W原装充电头，加799元享价值1246元AirPods蓝牙耳机！惊喜直达查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0382fc61-adb3-4720-8611-0c5ae700a8b2_iPhone_hongse_zheng.jpg','6799.0000',1,'CPU类型：Apple A14;运行内存：128G;机身颜色：红色','0.0000','0.0000','0.0000','6799.0000',6799,6799);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1387776667929313283,NULL,'202104292231557421387776667124006913',9,'Apple iPhone 12',NULL,'8',225,23,'【领券立减600元！】加9元得价值149元20W原装充电头，加799元享价值1246元AirPods蓝牙耳机！惊喜直达查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0382fc61-adb3-4720-8611-0c5ae700a8b2_iPhone_hongse_zheng.jpg','7599.0000',1,'CPU类型：Apple A14;运行内存：256G;机身颜色：红色','0.0000','0.0000','0.0000','7599.0000',7599,7599);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1387778986704130049,NULL,'202104292241085991387778985978515457',10,'华为 HUAWEI Mate 40 Pro',NULL,'9',225,28,'【华为Mate40Pro】5nm麒麟芯片!超感知徕卡电影影像!双线超级快充!隔空操控屏!!!限量抢购更多选择猛戳查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/6b4fd587-6293-4428-8673-c8751452a74b_huawei_zhengmian.jpg','6999.0000',5,'CPU类型：海思（Hisilicon）;运行内存：8G+256G;机身颜色：亮黑色','0.0000','0.0000','0.0000','34995.0000',34995,34995);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1387778986704130050,NULL,'202104292241085991387778985978515457',9,'Apple iPhone 12',NULL,'8',225,25,'【领券立减600元！】加9元得价值149元20W原装充电头，加799元享价值1246元AirPods蓝牙耳机！惊喜直达查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0382fc61-adb3-4720-8611-0c5ae700a8b2_iPhone_hongse_zheng.jpg','6799.0000',1,'CPU类型：Apple A14;运行内存：128G;机身颜色：红色','0.0000','0.0000','0.0000','6799.0000',6799,6799);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1387778986704130051,NULL,'202104292241085991387778985978515457',9,'Apple iPhone 12',NULL,'8',225,23,'【领券立减600元！】加9元得价值149元20W原装充电头，加799元享价值1246元AirPods蓝牙耳机！惊喜直达查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0382fc61-adb3-4720-8611-0c5ae700a8b2_iPhone_hongse_zheng.jpg','7599.0000',1,'CPU类型：Apple A14;运行内存：256G;机身颜色：红色','0.0000','0.0000','0.0000','7599.0000',7599,7599);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1387968041765056514,NULL,'202104301112228251387968040980721665',9,'Apple iPhone 12',NULL,'8',225,25,'【领券立减600元！】加9元得价值149元20W原装充电头，加799元享价值1246元AirPods蓝牙耳机！惊喜直达查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0382fc61-adb3-4720-8611-0c5ae700a8b2_iPhone_hongse_zheng.jpg','6799.0000',1,'CPU类型：Apple A14;运行内存：128G;机身颜色：红色','0.0000','0.0000','0.0000','6799.0000',6799,6799);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1387968041765056515,NULL,'202104301112228251387968040980721665',10,'华为 HUAWEI Mate 40 Pro',NULL,'9',225,28,'【华为Mate40Pro】5nm麒麟芯片!超感知徕卡电影影像!双线超级快充!隔空操控屏!!!限量抢购更多选择猛戳查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/6b4fd587-6293-4428-8673-c8751452a74b_huawei_zhengmian.jpg','6999.0000',5,'CPU类型：海思（Hisilicon）;运行内存：8G+256G;机身颜色：亮黑色','0.0000','0.0000','0.0000','34995.0000',34995,34995);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1387968041765056516,NULL,'202104301112228251387968040980721665',9,'Apple iPhone 12',NULL,'8',225,23,'【领券立减600元！】加9元得价值149元20W原装充电头，加799元享价值1246元AirPods蓝牙耳机！惊喜直达查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0382fc61-adb3-4720-8611-0c5ae700a8b2_iPhone_hongse_zheng.jpg','7599.0000',2,'CPU类型：Apple A14;运行内存：256G;机身颜色：红色','0.0000','0.0000','0.0000','15198.0000',15198,15198);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1387981568986963970,NULL,'202104301206079851387981568286515202',9,'Apple iPhone 12',NULL,'8',225,25,'【领券立减600元！】加9元得价值149元20W原装充电头，加799元享价值1246元AirPods蓝牙耳机！惊喜直达查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0382fc61-adb3-4720-8611-0c5ae700a8b2_iPhone_hongse_zheng.jpg','6799.0000',1,'CPU类型：Apple A14;运行内存：128G;机身颜色：红色','0.0000','0.0000','0.0000','6799.0000',6799,6799);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1387981569049878530,NULL,'202104301206079851387981568286515202',10,'华为 HUAWEI Mate 40 Pro',NULL,'9',225,28,'【华为Mate40Pro】5nm麒麟芯片!超感知徕卡电影影像!双线超级快充!隔空操控屏!!!限量抢购更多选择猛戳查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/6b4fd587-6293-4428-8673-c8751452a74b_huawei_zhengmian.jpg','6999.0000',5,'CPU类型：海思（Hisilicon）;运行内存：8G+256G;机身颜色：亮黑色','0.0000','0.0000','0.0000','34995.0000',34995,34995);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1387981569049878531,NULL,'202104301206079851387981568286515202',9,'Apple iPhone 12',NULL,'8',225,23,'【领券立减600元！】加9元得价值149元20W原装充电头，加799元享价值1246元AirPods蓝牙耳机！惊喜直达查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0382fc61-adb3-4720-8611-0c5ae700a8b2_iPhone_hongse_zheng.jpg','7599.0000',2,'CPU类型：Apple A14;运行内存：256G;机身颜色：红色','0.0000','0.0000','0.0000','15198.0000',15198,15198);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1387988729012019201,NULL,'202104301234350771387988728349319170',10,'华为 HUAWEI Mate 40 Pro',NULL,'9',225,28,'【华为Mate40Pro】5nm麒麟芯片!超感知徕卡电影影像!双线超级快充!隔空操控屏!!!限量抢购更多选择猛戳查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/6b4fd587-6293-4428-8673-c8751452a74b_huawei_zhengmian.jpg','6999.0000',5,'CPU类型：海思（Hisilicon）;运行内存：8G+256G;机身颜色：亮黑色','0.0000','0.0000','0.0000','34995.0000',34995,34995);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1387988729012019202,NULL,'202104301234350771387988728349319170',9,'Apple iPhone 12',NULL,'8',225,25,'【领券立减600元！】加9元得价值149元20W原装充电头，加799元享价值1246元AirPods蓝牙耳机！惊喜直达查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0382fc61-adb3-4720-8611-0c5ae700a8b2_iPhone_hongse_zheng.jpg','6799.0000',1,'CPU类型：Apple A14;运行内存：128G;机身颜色：红色','0.0000','0.0000','0.0000','6799.0000',6799,6799);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1387988729012019203,NULL,'202104301234350771387988728349319170',9,'Apple iPhone 12',NULL,'8',225,23,'【领券立减600元！】加9元得价值149元20W原装充电头，加799元享价值1246元AirPods蓝牙耳机！惊喜直达查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0382fc61-adb3-4720-8611-0c5ae700a8b2_iPhone_hongse_zheng.jpg','7599.0000',2,'CPU类型：Apple A14;运行内存：256G;机身颜色：红色','0.0000','0.0000','0.0000','15198.0000',15198,15198);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1387994949647192065,NULL,'202104301259182291387994949135486978',10,'华为 HUAWEI Mate 40 Pro',NULL,'9',225,28,'【华为Mate40Pro】5nm麒麟芯片!超感知徕卡电影影像!双线超级快充!隔空操控屏!!!限量抢购更多选择猛戳查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/6b4fd587-6293-4428-8673-c8751452a74b_huawei_zhengmian.jpg','6999.0000',5,'CPU类型：海思（Hisilicon）;运行内存：8G+256G;机身颜色：亮黑色','0.0000','0.0000','0.0000','34995.0000',34995,34995);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1387994949647192066,NULL,'202104301259182291387994949135486978',9,'Apple iPhone 12',NULL,'8',225,25,'【领券立减600元！】加9元得价值149元20W原装充电头，加799元享价值1246元AirPods蓝牙耳机！惊喜直达查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0382fc61-adb3-4720-8611-0c5ae700a8b2_iPhone_hongse_zheng.jpg','6799.0000',1,'CPU类型：Apple A14;运行内存：128G;机身颜色：红色','0.0000','0.0000','0.0000','6799.0000',6799,6799);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1387994949647192067,NULL,'202104301259182291387994949135486978',9,'Apple iPhone 12',NULL,'8',225,23,'【领券立减600元！】加9元得价值149元20W原装充电头，加799元享价值1246元AirPods蓝牙耳机！惊喜直达查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0382fc61-adb3-4720-8611-0c5ae700a8b2_iPhone_hongse_zheng.jpg','7599.0000',2,'CPU类型：Apple A14;运行内存：256G;机身颜色：红色','0.0000','0.0000','0.0000','15198.0000',15198,15198);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1387995481602379778,NULL,'202104301301251201387995481342332929',10,'华为 HUAWEI Mate 40 Pro',NULL,'9',225,28,'【华为Mate40Pro】5nm麒麟芯片!超感知徕卡电影影像!双线超级快充!隔空操控屏!!!限量抢购更多选择猛戳查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/6b4fd587-6293-4428-8673-c8751452a74b_huawei_zhengmian.jpg','6999.0000',5,'CPU类型：海思（Hisilicon）;运行内存：8G+256G;机身颜色：亮黑色','0.0000','0.0000','0.0000','34995.0000',34995,34995);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1387995481602379779,NULL,'202104301301251201387995481342332929',9,'Apple iPhone 12',NULL,'8',225,25,'【领券立减600元！】加9元得价值149元20W原装充电头，加799元享价值1246元AirPods蓝牙耳机！惊喜直达查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0382fc61-adb3-4720-8611-0c5ae700a8b2_iPhone_hongse_zheng.jpg','6799.0000',1,'CPU类型：Apple A14;运行内存：128G;机身颜色：红色','0.0000','0.0000','0.0000','6799.0000',6799,6799);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1387995481602379780,NULL,'202104301301251201387995481342332929',9,'Apple iPhone 12',NULL,'8',225,23,'【领券立减600元！】加9元得价值149元20W原装充电头，加799元享价值1246元AirPods蓝牙耳机！惊喜直达查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0382fc61-adb3-4720-8611-0c5ae700a8b2_iPhone_hongse_zheng.jpg','7599.0000',2,'CPU类型：Apple A14;运行内存：256G;机身颜色：红色','0.0000','0.0000','0.0000','15198.0000',15198,15198);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1388043219639554050,NULL,'202104301611067031388043219178180610',9,'Apple iPhone 12',NULL,'8',225,25,'【领券立减600元！】加9元得价值149元20W原装充电头，加799元享价值1246元AirPods蓝牙耳机！惊喜直达查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0382fc61-adb3-4720-8611-0c5ae700a8b2_iPhone_hongse_zheng.jpg','6799.0000',3,'CPU类型：Apple A14;运行内存：128G;机身颜色：红色','0.0000','0.0000','0.0000','20397.0000',20397,20397);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1388112220323319810,NULL,'202104302045177271388112219769671681',9,'Apple iPhone 12',NULL,'8',225,25,'【领券立减600元！】加9元得价值149元20W原装充电头，加799元享价值1246元AirPods蓝牙耳机！惊喜直达查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0382fc61-adb3-4720-8611-0c5ae700a8b2_iPhone_hongse_zheng.jpg','6799.0000',3,'CPU类型：Apple A14;运行内存：128G;机身颜色：红色','0.0000','0.0000','0.0000','20397.0000',20397,20397);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1388112220323319811,NULL,'202104302045177271388112219769671681',10,'华为 HUAWEI Mate 40 Pro',NULL,'9',225,27,'【华为Mate40Pro】5nm麒麟芯片!超感知徕卡电影影像!双线超级快充!隔空操控屏!!!限量抢购更多选择猛戳查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0b9953b7-87f9-42a2-8fbf-ca7cfdd3364e_huawei_zhengmina_bai.jpg','6999.0000',3,'CPU类型：海思（Hisilicon）;运行内存：8G+256G;机身颜色：柚白色','0.0000','0.0000','0.0000','20997.0000',20997,20997);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1388304872100704258,NULL,'202105010930494401388304871341535234',9,'Apple iPhone 12',NULL,'8',225,25,'【领券立减600元！】加9元得价值149元20W原装充电头，加799元享价值1246元AirPods蓝牙耳机！惊喜直达查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0382fc61-adb3-4720-8611-0c5ae700a8b2_iPhone_hongse_zheng.jpg','6799.0000',3,'CPU类型：Apple A14;运行内存：128G;机身颜色：红色','0.0000','0.0000','0.0000','20397.0000',20397,20397);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1388304872100704259,NULL,'202105010930494401388304871341535234',10,'华为 HUAWEI Mate 40 Pro',NULL,'9',225,27,'【华为Mate40Pro】5nm麒麟芯片!超感知徕卡电影影像!双线超级快充!隔空操控屏!!!限量抢购更多选择猛戳查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0b9953b7-87f9-42a2-8fbf-ca7cfdd3364e_huawei_zhengmina_bai.jpg','6999.0000',3,'CPU类型：海思（Hisilicon）;运行内存：8G+256G;机身颜色：柚白色','0.0000','0.0000','0.0000','20997.0000',20997,20997);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1388305270865768450,NULL,'202105010932246431388305270597332994',9,'Apple iPhone 12',NULL,'8',225,25,'【领券立减600元！】加9元得价值149元20W原装充电头，加799元享价值1246元AirPods蓝牙耳机！惊喜直达查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0382fc61-adb3-4720-8611-0c5ae700a8b2_iPhone_hongse_zheng.jpg','6799.0000',3,'CPU类型：Apple A14;运行内存：128G;机身颜色：红色','0.0000','0.0000','0.0000','20397.0000',20397,20397);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1388305270865768451,NULL,'202105010932246431388305270597332994',10,'华为 HUAWEI Mate 40 Pro',NULL,'9',225,27,'【华为Mate40Pro】5nm麒麟芯片!超感知徕卡电影影像!双线超级快充!隔空操控屏!!!限量抢购更多选择猛戳查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0b9953b7-87f9-42a2-8fbf-ca7cfdd3364e_huawei_zhengmina_bai.jpg','6999.0000',3,'CPU类型：海思（Hisilicon）;运行内存：8G+256G;机身颜色：柚白色','0.0000','0.0000','0.0000','20997.0000',20997,20997);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1388351568352489473,NULL,'202105011236228041388351568021139457',9,'Apple iPhone 12',NULL,'8',225,25,'【领券立减600元！】加9元得价值149元20W原装充电头，加799元享价值1246元AirPods蓝牙耳机！惊喜直达查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0382fc61-adb3-4720-8611-0c5ae700a8b2_iPhone_hongse_zheng.jpg','6799.0000',3,'CPU类型：Apple A14;运行内存：128G;机身颜色：红色','0.0000','0.0000','0.0000','20397.0000',20397,20397);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1388351568352489474,NULL,'202105011236228041388351568021139457',10,'华为 HUAWEI Mate 40 Pro',NULL,'9',225,27,'【华为Mate40Pro】5nm麒麟芯片!超感知徕卡电影影像!双线超级快充!隔空操控屏!!!限量抢购更多选择猛戳查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0b9953b7-87f9-42a2-8fbf-ca7cfdd3364e_huawei_zhengmina_bai.jpg','6999.0000',3,'CPU类型：海思（Hisilicon）;运行内存：8G+256G;机身颜色：柚白色','0.0000','0.0000','0.0000','20997.0000',20997,20997);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1388352299889340419,NULL,'202105011239171861388352299461521410',9,'Apple iPhone 12',NULL,'8',225,25,'【领券立减600元！】加9元得价值149元20W原装充电头，加799元享价值1246元AirPods蓝牙耳机！惊喜直达查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0382fc61-adb3-4720-8611-0c5ae700a8b2_iPhone_hongse_zheng.jpg','6799.0000',3,'CPU类型：Apple A14;运行内存：128G;机身颜色：红色','0.0000','0.0000','0.0000','20397.0000',20397,20397);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1388352299956449281,NULL,'202105011239171861388352299461521410',10,'华为 HUAWEI Mate 40 Pro',NULL,'9',225,27,'【华为Mate40Pro】5nm麒麟芯片!超感知徕卡电影影像!双线超级快充!隔空操控屏!!!限量抢购更多选择猛戳查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0b9953b7-87f9-42a2-8fbf-ca7cfdd3364e_huawei_zhengmina_bai.jpg','6999.0000',3,'CPU类型：海思（Hisilicon）;运行内存：8G+256G;机身颜色：柚白色','0.0000','0.0000','0.0000','20997.0000',20997,20997);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1388352959632384001,NULL,'202105011241544931388352959254896642',9,'Apple iPhone 12',NULL,'8',225,25,'【领券立减600元！】加9元得价值149元20W原装充电头，加799元享价值1246元AirPods蓝牙耳机！惊喜直达查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0382fc61-adb3-4720-8611-0c5ae700a8b2_iPhone_hongse_zheng.jpg','6799.0000',1,'CPU类型：Apple A14;运行内存：128G;机身颜色：红色','0.0000','0.0000','0.0000','6799.0000',6799,6799);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1388355068125884417,NULL,'202105011250171611388355067601596417',9,'Apple iPhone 12',NULL,'8',225,25,'【领券立减600元！】加9元得价值149元20W原装充电头，加799元享价值1246元AirPods蓝牙耳机！惊喜直达查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0382fc61-adb3-4720-8611-0c5ae700a8b2_iPhone_hongse_zheng.jpg','6799.0000',1,'CPU类型：Apple A14;运行内存：128G;机身颜色：红色','0.0000','0.0000','0.0000','6799.0000',6799,6799);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1389080576216088578,NULL,'202105031253117231389080575498862594',9,'Apple iPhone 12',NULL,'8',225,24,'【领券立减600元！】加9元得价值149元20W原装充电头，加799元享价值1246元AirPods蓝牙耳机！惊喜直达查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/b2ef173e-4344-4002-8b5a-b766f7a37f64_iPhone_baise.jpg','7599.0000',1,'CPU类型：Apple A14;运行内存：256G;机身颜色：白色','0.0000','0.0000','0.0000','7599.0000',7599,7599);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1389080576216088579,NULL,'202105031253117231389080575498862594',9,'Apple iPhone 12',NULL,'8',225,25,'【领券立减600元！】加9元得价值149元20W原装充电头，加799元享价值1246元AirPods蓝牙耳机！惊喜直达查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0382fc61-adb3-4720-8611-0c5ae700a8b2_iPhone_hongse_zheng.jpg','6799.0000',1,'CPU类型：Apple A14;运行内存：128G;机身颜色：红色','0.0000','0.0000','0.0000','6799.0000',6799,6799);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1389081086478254081,NULL,'202105031255134401389081086012686337',9,'Apple iPhone 12',NULL,'8',225,24,'【领券立减600元！】加9元得价值149元20W原装充电头，加799元享价值1246元AirPods蓝牙耳机！惊喜直达查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/b2ef173e-4344-4002-8b5a-b766f7a37f64_iPhone_baise.jpg','7599.0000',1,'CPU类型：Apple A14;运行内存：256G;机身颜色：白色','0.0000','0.0000','0.0000','7599.0000',7599,7599);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1389081086511808513,NULL,'202105031255134401389081086012686337',9,'Apple iPhone 12',NULL,'8',225,25,'【领券立减600元！】加9元得价值149元20W原装充电头，加799元享价值1246元AirPods蓝牙耳机！惊喜直达查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0382fc61-adb3-4720-8611-0c5ae700a8b2_iPhone_hongse_zheng.jpg','6799.0000',1,'CPU类型：Apple A14;运行内存：128G;机身颜色：红色','0.0000','0.0000','0.0000','6799.0000',6799,6799);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1389081207131602946,NULL,'202105031255422711389081206900916226',9,'Apple iPhone 12',NULL,'8',225,24,'【领券立减600元！】加9元得价值149元20W原装充电头，加799元享价值1246元AirPods蓝牙耳机！惊喜直达查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/b2ef173e-4344-4002-8b5a-b766f7a37f64_iPhone_baise.jpg','7599.0000',1,'CPU类型：Apple A14;运行内存：256G;机身颜色：白色','0.0000','0.0000','0.0000','7599.0000',7599,7599);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1389081207131602947,NULL,'202105031255422711389081206900916226',9,'Apple iPhone 12',NULL,'8',225,25,'【领券立减600元！】加9元得价值149元20W原装充电头，加799元享价值1246元AirPods蓝牙耳机！惊喜直达查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0382fc61-adb3-4720-8611-0c5ae700a8b2_iPhone_hongse_zheng.jpg','6799.0000',1,'CPU类型：Apple A14;运行内存：128G;机身颜色：红色','0.0000','0.0000','0.0000','6799.0000',6799,6799);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1389134196789829633,NULL,'202105031626158551389134196030660609',9,'Apple iPhone 12',NULL,'8',225,24,'【领券立减600元！】加9元得价值149元20W原装充电头，加799元享价值1246元AirPods蓝牙耳机！惊喜直达查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/b2ef173e-4344-4002-8b5a-b766f7a37f64_iPhone_baise.jpg','7599.0000',1,'CPU类型：Apple A14;运行内存：256G;机身颜色：白色','0.0000','0.0000','0.0000','7599.0000',7599,7599);
insert  into `oms_order_item`(`id`,`order_id`,`order_sn`,`spu_id`,`spu_name`,`spu_pic`,`spu_brand`,`category_id`,`sku_id`,`sku_name`,`sku_pic`,`sku_price`,`sku_quantity`,`sku_attrs_vals`,`promotion_amount`,`coupon_amount`,`integration_amount`,`real_amount`,`gift_integration`,`gift_growth`) values (1389134196798218242,NULL,'202105031626158551389134196030660609',9,'Apple iPhone 12',NULL,'8',225,25,'【领券立减600元！】加9元得价值149元20W原装充电头，加799元享价值1246元AirPods蓝牙耳机！惊喜直达查看>','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0382fc61-adb3-4720-8611-0c5ae700a8b2_iPhone_hongse_zheng.jpg','6799.0000',1,'CPU类型：Apple A14;运行内存：128G;机身颜色：红色','0.0000','0.0000','0.0000','6799.0000',6799,6799);

/*Table structure for table `oms_order_operate_history` */

CREATE TABLE `oms_order_operate_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` bigint(20) DEFAULT NULL COMMENT '订单id',
  `operate_man` varchar(100) DEFAULT NULL COMMENT '操作人[用户；系统；后台管理员]',
  `create_time` datetime DEFAULT NULL COMMENT '操作时间',
  `order_status` tinyint(4) DEFAULT NULL COMMENT '订单状态【0->待付款；1->待发货；2->已发货；3->已完成；4->已关闭；5->无效订单】',
  `note` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单操作历史记录';

/*Data for the table `oms_order_operate_history` */

/*Table structure for table `oms_order_return_apply` */

CREATE TABLE `oms_order_return_apply` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` bigint(20) DEFAULT NULL COMMENT 'order_id',
  `sku_id` bigint(20) DEFAULT NULL COMMENT '退货商品id',
  `order_sn` char(64) DEFAULT NULL COMMENT '订单编号',
  `create_time` datetime DEFAULT NULL COMMENT '申请时间',
  `member_username` varchar(64) DEFAULT NULL COMMENT '会员用户名',
  `return_amount` decimal(18,4) DEFAULT NULL COMMENT '退款金额',
  `return_name` varchar(100) DEFAULT NULL COMMENT '退货人姓名',
  `return_phone` varchar(20) DEFAULT NULL COMMENT '退货人电话',
  `status` tinyint(1) DEFAULT NULL COMMENT '申请状态[0->待处理；1->退货中；2->已完成；3->已拒绝]',
  `handle_time` datetime DEFAULT NULL COMMENT '处理时间',
  `sku_img` varchar(500) DEFAULT NULL COMMENT '商品图片',
  `sku_name` varchar(200) DEFAULT NULL COMMENT '商品名称',
  `sku_brand` varchar(200) DEFAULT NULL COMMENT '商品品牌',
  `sku_attrs_vals` varchar(500) DEFAULT NULL COMMENT '商品销售属性(JSON)',
  `sku_count` int(11) DEFAULT NULL COMMENT '退货数量',
  `sku_price` decimal(18,4) DEFAULT NULL COMMENT '商品单价',
  `sku_real_price` decimal(18,4) DEFAULT NULL COMMENT '商品实际支付单价',
  `reason` varchar(200) DEFAULT NULL COMMENT '原因',
  `description述` varchar(500) DEFAULT NULL COMMENT '描述',
  `desc_pics` varchar(2000) DEFAULT NULL COMMENT '凭证图片，以逗号隔开',
  `handle_note` varchar(500) DEFAULT NULL COMMENT '处理备注',
  `handle_man` varchar(200) DEFAULT NULL COMMENT '处理人员',
  `receive_man` varchar(100) DEFAULT NULL COMMENT '收货人',
  `receive_time` datetime DEFAULT NULL COMMENT '收货时间',
  `receive_note` varchar(500) DEFAULT NULL COMMENT '收货备注',
  `receive_phone` varchar(20) DEFAULT NULL COMMENT '收货电话',
  `company_address` varchar(500) DEFAULT NULL COMMENT '公司收货地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单退货申请';

/*Data for the table `oms_order_return_apply` */

/*Table structure for table `oms_order_return_reason` */

CREATE TABLE `oms_order_return_reason` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(200) DEFAULT NULL COMMENT '退货原因名',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `status` tinyint(1) DEFAULT NULL COMMENT '启用状态',
  `create_time` datetime DEFAULT NULL COMMENT 'create_time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='退货原因';

/*Data for the table `oms_order_return_reason` */

/*Table structure for table `oms_order_setting` */

CREATE TABLE `oms_order_setting` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `flash_order_overtime` int(11) DEFAULT NULL COMMENT '秒杀订单超时关闭时间(分)',
  `normal_order_overtime` int(11) DEFAULT NULL COMMENT '正常订单超时时间(分)',
  `confirm_overtime` int(11) DEFAULT NULL COMMENT '发货后自动确认收货时间（天）',
  `finish_overtime` int(11) DEFAULT NULL COMMENT '自动完成交易时间，不能申请退货（天）',
  `comment_overtime` int(11) DEFAULT NULL COMMENT '订单完成后自动好评时间（天）',
  `member_level` tinyint(2) DEFAULT NULL COMMENT '会员等级【0-不限会员等级，全部通用；其他-对应的其他会员等级】',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单配置信息';

/*Data for the table `oms_order_setting` */

/*Table structure for table `oms_payment_info` */

CREATE TABLE `oms_payment_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_sn` char(64) DEFAULT NULL COMMENT '订单号（对外业务号）',
  `order_id` bigint(20) DEFAULT NULL COMMENT '订单id',
  `alipay_trade_no` varchar(50) DEFAULT NULL COMMENT '支付宝交易流水号',
  `total_amount` decimal(18,4) DEFAULT NULL COMMENT '支付总金额',
  `subject` varchar(200) DEFAULT NULL COMMENT '交易内容',
  `payment_status` varchar(20) DEFAULT NULL COMMENT '支付状态',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `confirm_time` datetime DEFAULT NULL COMMENT '确认时间',
  `callback_content` varchar(4000) DEFAULT NULL COMMENT '回调内容',
  `callback_time` datetime DEFAULT NULL COMMENT '回调时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1388355145137500163 DEFAULT CHARSET=utf8mb4 COMMENT='支付信息表';

/*Data for the table `oms_payment_info` */

insert  into `oms_payment_info`(`id`,`order_sn`,`order_id`,`alipay_trade_no`,`total_amount`,`subject`,`payment_status`,`create_time`,`confirm_time`,`callback_content`,`callback_time`) values (1388353058957697026,'202105011241544931388352959254896642',NULL,'2021050122001441740505017654','6808.0000','订单名称【测试】','TRADE_SUCCESS','2021-05-01 12:42:09',NULL,NULL,'2021-05-01 12:42:18');
insert  into `oms_payment_info`(`id`,`order_sn`,`order_id`,`alipay_trade_no`,`total_amount`,`subject`,`payment_status`,`create_time`,`confirm_time`,`callback_content`,`callback_time`) values (1388355145137500162,'202105011250171611388355067601596417',NULL,'2021050122001441740505017829','6808.0000','订单名称【测试】','TRADE_SUCCESS','2021-05-01 12:50:29',NULL,NULL,'2021-05-01 12:50:36');

/*Table structure for table `oms_refund_info` */

CREATE TABLE `oms_refund_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_return_id` bigint(20) DEFAULT NULL COMMENT '退款的订单',
  `refund` decimal(18,4) DEFAULT NULL COMMENT '退款金额',
  `refund_sn` varchar(64) DEFAULT NULL COMMENT '退款交易流水号',
  `refund_status` tinyint(1) DEFAULT NULL COMMENT '退款状态',
  `refund_channel` tinyint(4) DEFAULT NULL COMMENT '退款渠道[1-支付宝，2-微信，3-银联，4-汇款]',
  `refund_content` varchar(5000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='退款信息';

/*Data for the table `oms_refund_info` */

/*Table structure for table `pms_attr` */

CREATE TABLE `pms_attr` (
  `attr_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '属性id',
  `attr_name` char(30) DEFAULT NULL COMMENT '属性名',
  `search_type` tinyint(4) DEFAULT NULL COMMENT '是否需要检索[0-不需要，1-需要]',
  `icon` varchar(255) DEFAULT NULL COMMENT '属性图标',
  `value_select` char(255) DEFAULT NULL COMMENT '可选值列表[用逗号分隔]',
  `attr_type` tinyint(4) DEFAULT NULL COMMENT '属性类型[0-销售属性，1-基本属性，2-既是销售属性又是基本属性]',
  `enable` bigint(20) DEFAULT NULL COMMENT '启用状态[0 - 禁用，1 - 启用]',
  `catelog_id` bigint(20) DEFAULT NULL COMMENT '所属分类',
  `show_desc` tinyint(4) DEFAULT NULL COMMENT '快速展示【是否展示在介绍上；0-否 1-是】，在sku中仍然可以调整',
  PRIMARY KEY (`attr_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COMMENT='商品属性';

/*Data for the table `pms_attr` */

insert  into `pms_attr`(`attr_id`,`attr_name`,`search_type`,`icon`,`value_select`,`attr_type`,`enable`,`catelog_id`,`show_desc`) values (18,'入网型号',1,'ruwang','NOH-AN00;NOH-AN01',1,1,225,1);
insert  into `pms_attr`(`attr_id`,`attr_name`,`search_type`,`icon`,`value_select`,`attr_type`,`enable`,`catelog_id`,`show_desc`) values (19,'上市月份',0,'shangshi','10月;11月',1,1,225,0);
insert  into `pms_attr`(`attr_id`,`attr_name`,`search_type`,`icon`,`value_select`,`attr_type`,`enable`,`catelog_id`,`show_desc`) values (20,'机身长度',0,'jishenchangdu','162.9mm',1,1,225,0);
insert  into `pms_attr`(`attr_id`,`attr_name`,`search_type`,`icon`,`value_select`,`attr_type`,`enable`,`catelog_id`,`show_desc`) values (21,'机身材质工艺',1,'cailiaogongyi','其他',1,1,225,0);
insert  into `pms_attr`(`attr_id`,`attr_name`,`search_type`,`icon`,`value_select`,`attr_type`,`enable`,`catelog_id`,`show_desc`) values (22,'CPU类型',0,'cpu','海思（Hisilicon）',0,1,225,0);
insert  into `pms_attr`(`attr_id`,`attr_name`,`search_type`,`icon`,`value_select`,`attr_type`,`enable`,`catelog_id`,`show_desc`) values (23,'运行内存',0,'neichun','8G;16G',0,1,225,0);
insert  into `pms_attr`(`attr_id`,`attr_name`,`search_type`,`icon`,`value_select`,`attr_type`,`enable`,`catelog_id`,`show_desc`) values (24,'机身颜色',0,'jishenyanse','亮黑色;柚白色',0,1,225,0);

/*Table structure for table `pms_attr_attrgroup_relation` */

CREATE TABLE `pms_attr_attrgroup_relation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `attr_id` bigint(20) DEFAULT NULL COMMENT '属性id',
  `attr_group_id` bigint(20) DEFAULT NULL COMMENT '属性分组id',
  `attr_sort` int(11) DEFAULT NULL COMMENT '属性组内排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COMMENT='属性&属性分组关联';

/*Data for the table `pms_attr_attrgroup_relation` */

insert  into `pms_attr_attrgroup_relation`(`id`,`attr_id`,`attr_group_id`,`attr_sort`) values (24,18,4,NULL);
insert  into `pms_attr_attrgroup_relation`(`id`,`attr_id`,`attr_group_id`,`attr_sort`) values (25,19,4,NULL);
insert  into `pms_attr_attrgroup_relation`(`id`,`attr_id`,`attr_group_id`,`attr_sort`) values (26,20,5,NULL);
insert  into `pms_attr_attrgroup_relation`(`id`,`attr_id`,`attr_group_id`,`attr_sort`) values (27,21,5,NULL);
insert  into `pms_attr_attrgroup_relation`(`id`,`attr_id`,`attr_group_id`,`attr_sort`) values (28,22,NULL,NULL);
insert  into `pms_attr_attrgroup_relation`(`id`,`attr_id`,`attr_group_id`,`attr_sort`) values (29,23,NULL,NULL);
insert  into `pms_attr_attrgroup_relation`(`id`,`attr_id`,`attr_group_id`,`attr_sort`) values (30,24,NULL,NULL);

/*Table structure for table `pms_attr_group` */

CREATE TABLE `pms_attr_group` (
  `attr_group_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '分组id',
  `attr_group_name` char(20) DEFAULT NULL COMMENT '组名',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `descript` varchar(255) DEFAULT NULL COMMENT '描述',
  `icon` varchar(255) DEFAULT NULL COMMENT '组图标',
  `catelog_id` bigint(20) DEFAULT NULL COMMENT '所属分类id',
  PRIMARY KEY (`attr_group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COMMENT='属性分组';

/*Data for the table `pms_attr_group` */

insert  into `pms_attr_group`(`attr_group_id`,`attr_group_name`,`sort`,`descript`,`icon`,`catelog_id`) values (4,'主体',1,'主体信息','zhuti',225);
insert  into `pms_attr_group`(`attr_group_id`,`attr_group_name`,`sort`,`descript`,`icon`,`catelog_id`) values (5,'基本信息',1,'基本信息','jiben',225);

/*Table structure for table `pms_banner` */

CREATE TABLE `pms_banner` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `img_url` varchar(500) DEFAULT NULL COMMENT '图片路径',
  `title` varchar(500) DEFAULT NULL COMMENT '标题',
  `display_order` int(11) DEFAULT NULL COMMENT '排序',
  `show_status` tinyint(4) DEFAULT NULL COMMENT '是否显示[0-不显示，1显示]',
  `render_url` varchar(500) DEFAULT NULL COMMENT '跳转路径',
  `del_flag` tinyint(1) DEFAULT '0' COMMENT '删除标记（0-正常，1-删除）',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COMMENT='商品-广告表';

/*Data for the table `pms_banner` */

insert  into `pms_banner`(`id`,`img_url`,`title`,`display_order`,`show_status`,`render_url`,`del_flag`,`create_time`,`update_time`) values (1,'https://img12.360buyimg.com/babel/s590x470_jfs/t1/155762/17/8690/172191/60191674E602f8c07/1740a38b23092d79.jpg.webp','年货不断',2,1,'https://pro.jd.com/mall/active/2oARmAErS3DXEUyFtdxzhnh5NqfH/index.html?babelChannel=ttt12',0,'2021-02-03 21:13:33','2021-02-03 21:13:33');
insert  into `pms_banner`(`id`,`img_url`,`title`,`display_order`,`show_status`,`render_url`,`del_flag`,`create_time`,`update_time`) values (2,'https://imgcps.jd.com/ling4/100012043978/5paw5bm05aW96LSn5LiT5Zy6/54iG5qy-5aW96LSn5L2O5Lu356eS5p2A/p-5bd8253082acdd181d02f9df/93617739/cr/s/q.jpg','茅台专场',3,1,'https://pro.jd.com/mall/active/3voCC98MkfttrGEBxvrCJSkEmh6b/index.html?innerAnchor=100012043978&focus=4',0,'2021-02-03 21:14:42','2021-02-03 21:14:42');
insert  into `pms_banner`(`id`,`img_url`,`title`,`display_order`,`show_status`,`render_url`,`del_flag`,`create_time`,`update_time`) values (3,'https://img10.360buyimg.com/da/s590x470_jfs/t1/129986/5/12356/79602/5f8687ffEcb0a615a/9ea5c2fa4c1a9f0b.jpg.webp','希捷移动硬盘',1,0,'https://item.jd.com/2280952.html?extension_id=eyJhZCI6IjM1MDMiLCJjaCI6IjIiLCJza3UiOiIyMjgwOTUyIiwidHMiOiIxNjEyMzU5MDcwIiwidW5pcWlkIjoie1wiY2xpY2tfaWRcIjpcIjBlZDJmNjIzLWZjYTAtNDZkZi1iOTg1LWY0MjliYWUyN2M2ZFwiLFwibWF0ZXJpYWxfaWRcIjpcIjMyNjU2Mjg3NDRcIixcInBvc19pZFwiOlwiMzUwM1wiLFwic2lkXCI6XCI3YTBkNWNhZS1hYjU5LTRmMjItODhiOS1kNDZmNTgzOTVjOWRcIn0ifQ==&jd_pop=0ed2f623-fca0-46df-b985-f429bae27c6d&abt=0',0,'2021-02-03 21:33:14','2021-02-03 21:33:14');
insert  into `pms_banner`(`id`,`img_url`,`title`,`display_order`,`show_status`,`render_url`,`del_flag`,`create_time`,`update_time`) values (4,'https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-02-04//62ff8464-714d-4974-81a0-24cf0f57df51_春节不打烊.jpg','春节不打烊',1,1,'https://pages.tmall.com/wow/a/act/tmall/tmc/29196/4057/wupr?spm=a21bo.2017.201862-1.d201405060011.5af911d96FGhDa&wh_pid=industry-231700&disableNav=YES&status_bar_transparent=true',0,'2021-02-04 10:53:46','2021-02-04 10:53:46');
insert  into `pms_banner`(`id`,`img_url`,`title`,`display_order`,`show_status`,`render_url`,`del_flag`,`create_time`,`update_time`) values (5,'https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-02-28//07365825-1419-4007-836b-5a81cdb102a8_hot-air-balloon-736879_960_720.webp','ceshi',1,0,'https://www.tobing.top',0,'2021-02-28 11:24:26','2021-02-28 11:24:26');

/*Table structure for table `pms_brand` */

CREATE TABLE `pms_brand` (
  `brand_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '品牌id',
  `name` char(50) DEFAULT NULL COMMENT '品牌名',
  `logo` varchar(2000) DEFAULT NULL COMMENT '品牌logo地址',
  `descript` longtext COMMENT '介绍',
  `show_status` tinyint(4) DEFAULT NULL COMMENT '显示状态[0-不显示；1-显示]',
  `first_letter` char(1) DEFAULT NULL COMMENT '检索首字母',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`brand_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COMMENT='品牌';

/*Data for the table `pms_brand` */

insert  into `pms_brand`(`brand_id`,`name`,`logo`,`descript`,`show_status`,`first_letter`,`sort`) values (1,'奇虎360','https://p4.ssl.qhimg.com/t01fcaa9d8a4d24b5f1.png','360公司致力于成为中国领先的互联网和安全服务提供商。公司创立于2005年，是互联网免费安全的首倡者，先后推出360安全卫士、360手机卫士、360安全浏览器等安全产品。随着全社会、全行业数字化程度的深化，“大安全”时代加速到来，360以“让世界更安全更美好”为使命，致力于实现“不断创造黑科技，做全方位守护者”的愿景。',1,'q',1);
insert  into `pms_brand`(`brand_id`,`name`,`logo`,`descript`,`show_status`,`first_letter`,`sort`) values (2,'小米','https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3674094246,189210166&fm=26&gp=0.jpg','小米科技有限责任公司成立于2010年3月3日 [1]  ，是一家专注于智能硬件和电子产品研发的全球化移动互联网企业 [2]  ，同时也是一家专注于高端智能手机、互联网电视及智能家居生态链建设的创新型科技企业。',1,'x',2);
insert  into `pms_brand`(`brand_id`,`name`,`logo`,`descript`,`show_status`,`first_letter`,`sort`) values (4,'荣耀','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-02-04//2918e480-41cf-47d3-8456-8788784f9417_honor.jpeg','一家知名手机厂商，以前属于华为集团',1,'r',1);
insert  into `pms_brand`(`brand_id`,`name`,`logo`,`descript`,`show_status`,`first_letter`,`sort`) values (5,'OPPO','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-02-04//0c0f418f-8d64-45f3-805d-fb61e5d61af4_oppo.jpeg','一家手机互联网厂商，与VIVO有点关系',1,'o',1);
insert  into `pms_brand`(`brand_id`,`name`,`logo`,`descript`,`show_status`,`first_letter`,`sort`) values (6,'锤子','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-02-04//d9f3337c-59f2-4690-8bb4-158bff5ba470_锤子.jpeg','锤子手机',1,'c',1);
insert  into `pms_brand`(`brand_id`,`name`,`logo`,`descript`,`show_status`,`first_letter`,`sort`) values (7,'努比亚','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-02-04//57bdb395-2e9d-41f1-85b6-2d71fdec815d_努比亚.jpeg','努比亚手机',1,'n',1);
insert  into `pms_brand`(`brand_id`,`name`,`logo`,`descript`,`show_status`,`first_letter`,`sort`) values (8,'苹果','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-03-08//fc211b55-2585-4a49-85cc-094c01706ced_Apple_logo_black.svg.webp','苹果公司（英语：Apple Inc.），原称苹果电脑公司（英语：Apple Computer, Inc.），是总部位于美国加州库比蒂诺的跨国科技公司，与亚马逊，谷歌、微软和Facebook一起被认为是五大技术公司之一，合称为FAAMG。现时的业务包括设计、开发和销售消费电子、计算机软件、在线服务和个人计算机。',1,'A',1);
insert  into `pms_brand`(`brand_id`,`name`,`logo`,`descript`,`show_status`,`first_letter`,`sort`) values (9,'华为','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-03-09//9de6c2b0-6f9c-4244-8355-206add357bee_9f510fb30f2442a7d933129f2409ba4bd11373f0a4fc.jfif','华为技术有限公司，成立于1987年，总部位于广东省深圳市龙岗区。 [1]  华为是全球领先的信息与通信技术（ICT）解决方案供应商，专注于ICT领域，坚持稳健经营、持续创新、开放合作，在电信运营商、企业、终端和云计算等领域构筑了端到端的解决方案优势，为运营商客户、企业客户和消费者提供有竞争力的ICT解决方案、产品和服务，并致力于实现未来信息社会、构建更美好的全联接世界。2013年，华为首超全球第一大电信设备商爱立信，排名《财富》世界500强第315位。华为的产品和解决方案已经应用于全球170多个国家，服务全球运营商50强中的45家及全球1/3的人口。',1,'H',1);

/*Table structure for table `pms_category` */

CREATE TABLE `pms_category` (
  `cat_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `name` char(50) DEFAULT NULL COMMENT '分类名称',
  `parent_cid` bigint(20) DEFAULT NULL COMMENT '父分类id',
  `cat_level` int(11) DEFAULT NULL COMMENT '层级',
  `show_status` tinyint(4) DEFAULT NULL COMMENT '是否显示[0-不显示，1显示]',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `icon` char(255) DEFAULT NULL COMMENT '图标地址',
  `product_unit` char(50) DEFAULT NULL COMMENT '计量单位',
  `product_count` int(11) DEFAULT NULL COMMENT '商品数量',
  `keywords` varchar(255) DEFAULT NULL COMMENT '关键字',
  `description` text COMMENT '描述',
  PRIMARY KEY (`cat_id`),
  KEY `parent_cid` (`parent_cid`)
) ENGINE=InnoDB AUTO_INCREMENT=1425 DEFAULT CHARSET=utf8mb4 COMMENT='商品三级分类';

/*Data for the table `pms_category` */

insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1,'图书、音像、电子书刊',0,1,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (2,'手机',0,1,1,0,'aaa',NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (3,'家用电器',0,1,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (4,'数码',0,1,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (5,'家居家装',0,1,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (6,'电脑办公',0,1,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (7,'厨具',0,1,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (8,'个护化妆',0,1,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (9,'服饰内衣',0,1,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (10,'钟表',0,1,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (11,'鞋靴',0,1,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (12,'母婴',0,1,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (13,'礼品箱包',0,1,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (14,'食品饮料、保健食品',0,1,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (15,'珠宝',0,1,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (16,'汽车用品',0,1,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (17,'运动健康',0,1,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (18,'玩具乐器',0,1,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (19,'彩票、旅行、充值、票务',0,1,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (20,'生鲜',0,1,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (21,'整车',0,1,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (22,'电子书刊',1,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (23,'音像',1,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (24,'英文原版',1,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (25,'文艺',1,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (26,'少儿',1,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (27,'人文社科',1,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (28,'经管励志',1,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (29,'生活',1,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (30,'科技',1,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (31,'教育',1,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (32,'港台图书',1,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (33,'其他',1,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (34,'手机通讯',2,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (35,'运营商',2,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (36,'手机配件',2,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (37,'大 家 电',3,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (38,'厨卫大电',3,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (39,'厨房小电',3,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (40,'生活电器',3,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (41,'个护健康',3,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (42,'五金家装',3,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (43,'摄影摄像',4,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (44,'数码配件',4,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (45,'智能设备',4,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (46,'影音娱乐',4,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (47,'电子教育',4,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (48,'虚拟商品',4,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (49,'家纺',5,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (50,'灯具',5,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (51,'生活日用',5,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (52,'家装软饰',5,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (53,'宠物生活',5,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (54,'电脑整机',6,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (55,'电脑配件',6,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (56,'外设产品',6,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (57,'游戏设备',6,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (58,'网络产品',6,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (59,'办公设备',6,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (60,'文具/耗材',6,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (61,'服务产品',6,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (62,'烹饪锅具',7,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (63,'刀剪菜板',7,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (64,'厨房配件',7,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (65,'水具酒具',7,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (66,'餐具',7,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (67,'酒店用品',7,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (68,'茶具/咖啡具',7,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (69,'清洁用品',8,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (70,'面部护肤',8,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (71,'身体护理',8,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (72,'口腔护理',8,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (73,'女性护理',8,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (74,'洗发护发',8,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (75,'香水彩妆',8,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (76,'女装',9,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (77,'男装',9,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (78,'内衣',9,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (79,'洗衣服务',9,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (80,'服饰配件',9,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (81,'钟表',10,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (82,'流行男鞋',11,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (83,'时尚女鞋',11,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (84,'奶粉',12,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (85,'营养辅食',12,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (86,'尿裤湿巾',12,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (87,'喂养用品',12,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (88,'洗护用品',12,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (89,'童车童床',12,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (90,'寝居服饰',12,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (91,'妈妈专区',12,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (92,'童装童鞋',12,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (93,'安全座椅',12,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (94,'潮流女包',13,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (95,'精品男包',13,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (96,'功能箱包',13,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (97,'礼品',13,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (98,'奢侈品',13,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (99,'婚庆',13,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (100,'进口食品',14,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (101,'地方特产',14,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (102,'休闲食品',14,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (103,'粮油调味',14,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (104,'饮料冲调',14,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (105,'食品礼券',14,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (106,'茗茶',14,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (107,'时尚饰品',15,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (108,'黄金',15,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (109,'K金饰品',15,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (110,'金银投资',15,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (111,'银饰',15,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (112,'钻石',15,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (113,'翡翠玉石',15,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (114,'水晶玛瑙',15,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (115,'彩宝',15,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (116,'铂金',15,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (117,'木手串/把件',15,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (118,'珍珠',15,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (119,'维修保养',16,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (120,'车载电器',16,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (121,'美容清洗',16,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (122,'汽车装饰',16,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (123,'安全自驾',16,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (124,'汽车服务',16,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (125,'赛事改装',16,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (126,'运动鞋包',17,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (127,'运动服饰',17,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (128,'骑行运动',17,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (129,'垂钓用品',17,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (130,'游泳用品',17,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (131,'户外鞋服',17,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (132,'户外装备',17,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (133,'健身训练',17,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (134,'体育用品',17,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (135,'适用年龄',18,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (136,'遥控/电动',18,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (137,'毛绒布艺',18,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (138,'娃娃玩具',18,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (139,'模型玩具',18,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (140,'健身玩具',18,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (141,'动漫玩具',18,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (142,'益智玩具',18,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (143,'积木拼插',18,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (144,'DIY玩具',18,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (145,'创意减压',18,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (146,'乐器',18,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (147,'彩票',19,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (148,'机票',19,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (149,'酒店',19,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (150,'旅行',19,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (151,'充值',19,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (152,'游戏',19,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (153,'票务',19,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (154,'产地直供',20,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (155,'水果',20,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (156,'猪牛羊肉',20,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (157,'海鲜水产',20,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (158,'禽肉蛋品',20,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (159,'冷冻食品',20,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (160,'熟食腊味',20,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (161,'饮品甜品',20,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (162,'蔬菜',20,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (163,'全新整车',21,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (164,'二手车',21,2,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (165,'电子书',22,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (166,'网络原创',22,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (167,'数字杂志',22,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (168,'多媒体图书',22,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (169,'音乐',23,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (170,'影视',23,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (171,'教育音像',23,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (172,'少儿',24,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (173,'商务投资',24,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (174,'英语学习与考试',24,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (175,'文学',24,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (176,'传记',24,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (177,'励志',24,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (178,'小说',25,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (179,'文学',25,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (180,'青春文学',25,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (181,'传记',25,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (182,'艺术',25,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (183,'少儿',26,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (184,'0-2岁',26,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (185,'3-6岁',26,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (186,'7-10岁',26,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (187,'11-14岁',26,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (188,'历史',27,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (189,'哲学',27,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (190,'国学',27,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (191,'政治/军事',27,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (192,'法律',27,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (193,'人文社科',27,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (194,'心理学',27,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (195,'文化',27,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (196,'社会科学',27,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (197,'经济',28,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (198,'金融与投资',28,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (199,'管理',28,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (200,'励志与成功',28,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (201,'生活',29,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (202,'健身与保健',29,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (203,'家庭与育儿',29,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (204,'旅游',29,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (205,'烹饪美食',29,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (206,'工业技术',30,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (207,'科普读物',30,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (208,'建筑',30,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (209,'医学',30,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (210,'科学与自然',30,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (211,'计算机与互联网',30,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (212,'电子通信',30,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (213,'中小学教辅',31,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (214,'教育与考试',31,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (215,'外语学习',31,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (216,'大中专教材',31,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (217,'字典词典',31,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (218,'艺术/设计/收藏',32,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (219,'经济管理',32,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (220,'文化/学术',32,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (221,'少儿',32,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (222,'工具书',33,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (223,'杂志/期刊',33,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (224,'套装书',33,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (225,'手机',34,3,1,0,NULL,'件',0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (226,'对讲机',34,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (227,'合约机',35,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (228,'选号中心',35,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (229,'装宽带',35,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (230,'办套餐',35,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (231,'移动电源',36,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (232,'电池/移动电源',36,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (233,'蓝牙耳机',36,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (234,'充电器/数据线',36,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (235,'苹果周边',36,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (236,'手机耳机',36,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (237,'手机贴膜',36,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (238,'手机存储卡',36,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (239,'充电器',36,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (240,'数据线',36,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (241,'手机保护套',36,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (242,'车载配件',36,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (243,'iPhone 配件',36,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (244,'手机电池',36,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (245,'创意配件',36,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (246,'便携/无线音响',36,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (247,'手机饰品',36,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (248,'拍照配件',36,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (249,'手机支架',36,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (250,'平板电视',37,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (251,'空调',37,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (252,'冰箱',37,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (253,'洗衣机',37,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (254,'家庭影院',37,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (255,'DVD/电视盒子',37,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (256,'迷你音响',37,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (257,'冷柜/冰吧',37,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (258,'家电配件',37,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (259,'功放',37,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (260,'回音壁/Soundbar',37,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (261,'Hi-Fi专区',37,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (262,'电视盒子',37,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (263,'酒柜',37,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (264,'燃气灶',38,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (265,'油烟机',38,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (266,'热水器',38,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (267,'消毒柜',38,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (268,'洗碗机',38,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (269,'料理机',39,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (270,'榨汁机',39,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (271,'电饭煲',39,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (272,'电压力锅',39,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (273,'豆浆机',39,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (274,'咖啡机',39,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (275,'微波炉',39,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (276,'电烤箱',39,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (277,'电磁炉',39,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (278,'面包机',39,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (279,'煮蛋器',39,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (280,'酸奶机',39,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (281,'电炖锅',39,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (282,'电水壶/热水瓶',39,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (283,'电饼铛',39,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (284,'多用途锅',39,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (285,'电烧烤炉',39,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (286,'果蔬解毒机',39,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (287,'其它厨房电器',39,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (288,'养生壶/煎药壶',39,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (289,'电热饭盒',39,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (290,'取暖电器',40,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (291,'净化器',40,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (292,'加湿器',40,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (293,'扫地机器人',40,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (294,'吸尘器',40,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (295,'挂烫机/熨斗',40,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (296,'插座',40,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (297,'电话机',40,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (298,'清洁机',40,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (299,'除湿机',40,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (300,'干衣机',40,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (301,'收录/音机',40,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (302,'电风扇',40,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (303,'冷风扇',40,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (304,'其它生活电器',40,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (305,'生活电器配件',40,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (306,'净水器',40,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (307,'饮水机',40,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (308,'剃须刀',41,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (309,'剃/脱毛器',41,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (310,'口腔护理',41,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (311,'电吹风',41,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (312,'美容器',41,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (313,'理发器',41,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (314,'卷/直发器',41,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (315,'按摩椅',41,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (316,'按摩器',41,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (317,'足浴盆',41,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (318,'血压计',41,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (319,'电子秤/厨房秤',41,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (320,'血糖仪',41,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (321,'体温计',41,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (322,'其它健康电器',41,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (323,'计步器/脂肪检测仪',41,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (324,'电动工具',42,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (325,'手动工具',42,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (326,'仪器仪表',42,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (327,'浴霸/排气扇',42,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (328,'灯具',42,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (329,'LED灯',42,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (330,'洁身器',42,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (331,'水槽',42,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (332,'龙头',42,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (333,'淋浴花洒',42,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (334,'厨卫五金',42,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (335,'家具五金',42,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (336,'门铃',42,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (337,'电气开关',42,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (338,'插座',42,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (339,'电工电料',42,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (340,'监控安防',42,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (341,'电线/线缆',42,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (342,'数码相机',43,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (343,'单电/微单相机',43,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (344,'单反相机',43,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (345,'摄像机',43,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (346,'拍立得',43,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (347,'运动相机',43,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (348,'镜头',43,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (349,'户外器材',43,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (350,'影棚器材',43,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (351,'冲印服务',43,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (352,'数码相框',43,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (353,'存储卡',44,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (354,'读卡器',44,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (355,'滤镜',44,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (356,'闪光灯/手柄',44,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (357,'相机包',44,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (358,'三脚架/云台',44,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (359,'相机清洁/贴膜',44,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (360,'机身附件',44,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (361,'镜头附件',44,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (362,'电池/充电器',44,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (363,'移动电源',44,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (364,'数码支架',44,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (365,'智能手环',45,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (366,'智能手表',45,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (367,'智能眼镜',45,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (368,'运动跟踪器',45,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (369,'健康监测',45,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (370,'智能配饰',45,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (371,'智能家居',45,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (372,'体感车',45,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (373,'其他配件',45,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (374,'智能机器人',45,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (375,'无人机',45,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (376,'MP3/MP4',46,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (377,'智能设备',46,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (378,'耳机/耳麦',46,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (379,'便携/无线音箱',46,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (380,'音箱/音响',46,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (381,'高清播放器',46,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (382,'收音机',46,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (383,'MP3/MP4配件',46,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (384,'麦克风',46,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (385,'专业音频',46,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (386,'苹果配件',46,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (387,'学生平板',47,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (388,'点读机/笔',47,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (389,'早教益智',47,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (390,'录音笔',47,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (391,'电纸书',47,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (392,'电子词典',47,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (393,'复读机',47,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (394,'延保服务',48,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (395,'杀毒软件',48,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (396,'积分商品',48,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (397,'桌布/罩件',49,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (398,'地毯地垫',49,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (399,'沙发垫套/椅垫',49,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (400,'床品套件',49,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (401,'被子',49,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (402,'枕芯',49,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (403,'床单被罩',49,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (404,'毯子',49,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (405,'床垫/床褥',49,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (406,'蚊帐',49,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (407,'抱枕靠垫',49,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (408,'毛巾浴巾',49,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (409,'电热毯',49,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (410,'窗帘/窗纱',49,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (411,'布艺软饰',49,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (412,'凉席',49,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (413,'台灯',50,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (414,'节能灯',50,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (415,'装饰灯',50,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (416,'落地灯',50,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (417,'应急灯/手电',50,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (418,'LED灯',50,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (419,'吸顶灯',50,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (420,'五金电器',50,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (421,'筒灯射灯',50,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (422,'吊灯',50,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (423,'氛围照明',50,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (424,'保暖防护',51,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (425,'收纳用品',51,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (426,'雨伞雨具',51,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (427,'浴室用品',51,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (428,'缝纫/针织用品',51,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (429,'洗晒/熨烫',51,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (430,'净化除味',51,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (431,'相框/照片墙',52,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (432,'装饰字画',52,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (433,'节庆饰品',52,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (434,'手工/十字绣',52,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (435,'装饰摆件',52,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (436,'帘艺隔断',52,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (437,'墙贴/装饰贴',52,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (438,'钟饰',52,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (439,'花瓶花艺',52,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (440,'香薰蜡烛',52,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (441,'创意家居',52,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (442,'宠物主粮',53,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (443,'宠物零食',53,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (444,'医疗保健',53,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (445,'家居日用',53,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (446,'宠物玩具',53,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (447,'出行装备',53,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (448,'洗护美容',53,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (449,'笔记本',54,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (450,'超极本',54,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (451,'游戏本',54,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (452,'平板电脑',54,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (453,'平板电脑配件',54,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (454,'台式机',54,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (455,'服务器/工作站',54,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (456,'笔记本配件',54,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (457,'一体机',54,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (458,'CPU',55,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (459,'主板',55,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (460,'显卡',55,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (461,'硬盘',55,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (462,'SSD固态硬盘',55,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (463,'内存',55,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (464,'机箱',55,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (465,'电源',55,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (466,'显示器',55,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (467,'刻录机/光驱',55,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (468,'散热器',55,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (469,'声卡/扩展卡',55,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (470,'装机配件',55,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (471,'组装电脑',55,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (472,'移动硬盘',56,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (473,'U盘',56,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (474,'鼠标',56,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (475,'键盘',56,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (476,'鼠标垫',56,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (477,'摄像头',56,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (478,'手写板',56,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (479,'硬盘盒',56,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (480,'插座',56,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (481,'线缆',56,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (482,'UPS电源',56,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (483,'电脑工具',56,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (484,'游戏设备',56,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (485,'电玩',56,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (486,'电脑清洁',56,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (487,'网络仪表仪器',56,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (488,'游戏机',57,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (489,'游戏耳机',57,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (490,'手柄/方向盘',57,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (491,'游戏软件',57,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (492,'游戏周边',57,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (493,'路由器',58,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (494,'网卡',58,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (495,'交换机',58,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (496,'网络存储',58,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (497,'4G/3G上网',58,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (498,'网络盒子',58,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (499,'网络配件',58,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (500,'投影机',59,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (501,'投影配件',59,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (502,'多功能一体机',59,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (503,'打印机',59,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (504,'传真设备',59,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (505,'验钞/点钞机',59,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (506,'扫描设备',59,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (507,'复合机',59,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (508,'碎纸机',59,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (509,'考勤机',59,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (510,'收款/POS机',59,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (511,'会议音频视频',59,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (512,'保险柜',59,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (513,'装订/封装机',59,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (514,'安防监控',59,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (515,'办公家具',59,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (516,'白板',59,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (517,'硒鼓/墨粉',60,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (518,'墨盒',60,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (519,'色带',60,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (520,'纸类',60,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (521,'办公文具',60,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (522,'学生文具',60,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (523,'财会用品',60,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (524,'文件管理',60,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (525,'本册/便签',60,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (526,'计算器',60,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (527,'笔类',60,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (528,'画具画材',60,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (529,'刻录碟片/附件',60,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (530,'上门安装',61,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (531,'延保服务',61,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (532,'维修保养',61,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (533,'电脑软件',61,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (534,'京东服务',61,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (535,'炒锅',62,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (536,'煎锅',62,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (537,'压力锅',62,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (538,'蒸锅',62,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (539,'汤锅',62,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (540,'奶锅',62,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (541,'锅具套装',62,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (542,'煲类',62,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (543,'水壶',62,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (544,'火锅',62,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (545,'菜刀',63,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (546,'剪刀',63,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (547,'刀具套装',63,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (548,'砧板',63,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (549,'瓜果刀/刨',63,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (550,'多功能刀',63,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (551,'保鲜盒',64,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (552,'烘焙/烧烤',64,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (553,'饭盒/提锅',64,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (554,'储物/置物架',64,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (555,'厨房DIY/小工具',64,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (556,'塑料杯',65,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (557,'运动水壶',65,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (558,'玻璃杯',65,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (559,'陶瓷/马克杯',65,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (560,'保温杯',65,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (561,'保温壶',65,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (562,'酒杯/酒具',65,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (563,'杯具套装',65,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (564,'餐具套装',66,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (565,'碗/碟/盘',66,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (566,'筷勺/刀叉',66,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (567,'一次性用品',66,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (568,'果盘/果篮',66,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (569,'自助餐炉',67,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (570,'酒店餐具',67,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (571,'酒店水具',67,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (572,'整套茶具',68,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (573,'茶杯',68,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (574,'茶壶',68,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (575,'茶盘茶托',68,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (576,'茶叶罐',68,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (577,'茶具配件',68,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (578,'茶宠摆件',68,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (579,'咖啡具',68,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (580,'其他',68,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (581,'纸品湿巾',69,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (582,'衣物清洁',69,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (583,'清洁工具',69,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (584,'驱虫用品',69,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (585,'家庭清洁',69,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (586,'皮具护理',69,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (587,'一次性用品',69,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (588,'洁面',70,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (589,'乳液面霜',70,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (590,'面膜',70,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (591,'剃须',70,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (592,'套装',70,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (593,'精华',70,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (594,'眼霜',70,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (595,'卸妆',70,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (596,'防晒',70,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (597,'防晒隔离',70,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (598,'T区护理',70,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (599,'眼部护理',70,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (600,'精华露',70,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (601,'爽肤水',70,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (602,'沐浴',71,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (603,'润肤',71,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (604,'颈部',71,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (605,'手足',71,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (606,'纤体塑形',71,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (607,'美胸',71,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (608,'套装',71,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (609,'精油',71,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (610,'洗发护发',71,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (611,'染发/造型',71,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (612,'香薰精油',71,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (613,'磨砂/浴盐',71,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (614,'手工/香皂',71,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (615,'洗发',71,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (616,'护发',71,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (617,'染发',71,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (618,'磨砂膏',71,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (619,'香皂',71,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (620,'牙膏/牙粉',72,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (621,'牙刷/牙线',72,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (622,'漱口水',72,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (623,'套装',72,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (624,'卫生巾',73,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (625,'卫生护垫',73,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (626,'私密护理',73,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (627,'脱毛膏',73,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (628,'其他',73,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (629,'洗发',74,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (630,'护发',74,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (631,'染发',74,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (632,'造型',74,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (633,'假发',74,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (634,'套装',74,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (635,'美发工具',74,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (636,'脸部护理',74,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (637,'香水',75,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (638,'底妆',75,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (639,'腮红',75,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (640,'眼影',75,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (641,'唇部',75,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (642,'美甲',75,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (643,'眼线',75,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (644,'美妆工具',75,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (645,'套装',75,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (646,'防晒隔离',75,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (647,'卸妆',75,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (648,'眉笔',75,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (649,'睫毛膏',75,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (650,'T恤',76,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (651,'衬衫',76,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (652,'针织衫',76,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (653,'雪纺衫',76,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (654,'卫衣',76,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (655,'马甲',76,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (656,'连衣裙',76,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (657,'半身裙',76,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (658,'牛仔裤',76,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (659,'休闲裤',76,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (660,'打底裤',76,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (661,'正装裤',76,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (662,'小西装',76,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (663,'短外套',76,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (664,'风衣',76,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (665,'毛呢大衣',76,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (666,'真皮皮衣',76,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (667,'棉服',76,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (668,'羽绒服',76,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (669,'大码女装',76,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (670,'中老年女装',76,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (671,'婚纱',76,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (672,'打底衫',76,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (673,'旗袍/唐装',76,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (674,'加绒裤',76,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (675,'吊带/背心',76,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (676,'羊绒衫',76,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (677,'短裤',76,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (678,'皮草',76,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (679,'礼服',76,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (680,'仿皮皮衣',76,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (681,'羊毛衫',76,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (682,'设计师/潮牌',76,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (683,'衬衫',77,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (684,'T恤',77,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (685,'POLO衫',77,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (686,'针织衫',77,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (687,'羊绒衫',77,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (688,'卫衣',77,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (689,'马甲/背心',77,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (690,'夹克',77,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (691,'风衣',77,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (692,'毛呢大衣',77,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (693,'仿皮皮衣',77,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (694,'西服',77,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (695,'棉服',77,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (696,'羽绒服',77,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (697,'牛仔裤',77,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (698,'休闲裤',77,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (699,'西裤',77,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (700,'西服套装',77,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (701,'大码男装',77,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (702,'中老年男装',77,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (703,'唐装/中山装',77,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (704,'工装',77,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (705,'真皮皮衣',77,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (706,'加绒裤',77,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (707,'卫裤/运动裤',77,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (708,'短裤',77,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (709,'设计师/潮牌',77,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (710,'羊毛衫',77,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (711,'文胸',78,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (712,'女式内裤',78,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (713,'男式内裤',78,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (714,'睡衣/家居服',78,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (715,'塑身美体',78,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (716,'泳衣',78,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (717,'吊带/背心',78,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (718,'抹胸',78,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (719,'连裤袜/丝袜',78,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (720,'美腿袜',78,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (721,'商务男袜',78,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (722,'保暖内衣',78,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (723,'情侣睡衣',78,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (724,'文胸套装',78,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (725,'少女文胸',78,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (726,'休闲棉袜',78,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (727,'大码内衣',78,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (728,'内衣配件',78,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (729,'打底裤袜',78,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (730,'打底衫',78,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (731,'秋衣秋裤',78,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (732,'情趣内衣',78,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (733,'服装洗护',79,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (734,'太阳镜',80,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (735,'光学镜架/镜片',80,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (736,'围巾/手套/帽子套装',80,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (737,'袖扣',80,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (738,'棒球帽',80,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (739,'毛线帽',80,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (740,'遮阳帽',80,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (741,'老花镜',80,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (742,'装饰眼镜',80,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (743,'防辐射眼镜',80,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (744,'游泳镜',80,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (745,'女士丝巾/围巾/披肩',80,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (746,'男士丝巾/围巾',80,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (747,'鸭舌帽',80,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (748,'贝雷帽',80,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (749,'礼帽',80,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (750,'真皮手套',80,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (751,'毛线手套',80,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (752,'防晒手套',80,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (753,'男士腰带/礼盒',80,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (754,'女士腰带/礼盒',80,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (755,'钥匙扣',80,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (756,'遮阳伞/雨伞',80,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (757,'口罩',80,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (758,'耳罩/耳包',80,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (759,'假领',80,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (760,'毛线/布面料',80,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (761,'领带/领结/领带夹',80,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (762,'男表',81,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (763,'瑞表',81,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (764,'女表',81,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (765,'国表',81,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (766,'日韩表',81,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (767,'欧美表',81,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (768,'德表',81,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (769,'儿童手表',81,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (770,'智能手表',81,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (771,'闹钟',81,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (772,'座钟挂钟',81,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (773,'钟表配件',81,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (774,'商务休闲鞋',82,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (775,'正装鞋',82,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (776,'休闲鞋',82,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (777,'凉鞋/沙滩鞋',82,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (778,'男靴',82,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (779,'功能鞋',82,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (780,'拖鞋/人字拖',82,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (781,'雨鞋/雨靴',82,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (782,'传统布鞋',82,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (783,'鞋配件',82,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (784,'帆布鞋',82,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (785,'增高鞋',82,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (786,'工装鞋',82,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (787,'定制鞋',82,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (788,'高跟鞋',83,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (789,'单鞋',83,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (790,'休闲鞋',83,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (791,'凉鞋',83,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (792,'女靴',83,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (793,'雪地靴',83,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (794,'拖鞋/人字拖',83,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (795,'踝靴',83,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (796,'筒靴',83,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (797,'帆布鞋',83,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (798,'雨鞋/雨靴',83,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (799,'妈妈鞋',83,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (800,'鞋配件',83,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (801,'特色鞋',83,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (802,'鱼嘴鞋',83,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (803,'布鞋/绣花鞋',83,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (804,'马丁靴',83,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (805,'坡跟鞋',83,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (806,'松糕鞋',83,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (807,'内增高',83,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (808,'防水台',83,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (809,'婴幼奶粉',84,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (810,'孕妈奶粉',84,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (811,'益生菌/初乳',85,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (812,'米粉/菜粉',85,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (813,'果泥/果汁',85,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (814,'DHA',85,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (815,'宝宝零食',85,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (816,'钙铁锌/维生素',85,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (817,'清火/开胃',85,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (818,'面条/粥',85,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (819,'婴儿尿裤',86,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (820,'拉拉裤',86,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (821,'婴儿湿巾',86,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (822,'成人尿裤',86,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (823,'奶瓶奶嘴',87,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (824,'吸奶器',87,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (825,'暖奶消毒',87,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (826,'儿童餐具',87,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (827,'水壶/水杯',87,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (828,'牙胶安抚',87,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (829,'围兜/防溅衣',87,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (830,'辅食料理机',87,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (831,'食物存储',87,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (832,'宝宝护肤',88,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (833,'洗发沐浴',88,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (834,'奶瓶清洗',88,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (835,'驱蚊防晒',88,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (836,'理发器',88,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (837,'洗澡用具',88,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (838,'婴儿口腔清洁',88,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (839,'洗衣液/皂',88,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (840,'日常护理',88,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (841,'座便器',88,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (842,'婴儿推车',89,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (843,'餐椅摇椅',89,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (844,'婴儿床',89,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (845,'学步车',89,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (846,'三轮车',89,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (847,'自行车',89,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (848,'电动车',89,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (849,'扭扭车',89,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (850,'滑板车',89,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (851,'婴儿床垫',89,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (852,'婴儿外出服',90,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (853,'婴儿内衣',90,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (854,'婴儿礼盒',90,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (855,'婴儿鞋帽袜',90,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (856,'安全防护',90,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (857,'家居床品',90,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (858,'睡袋/抱被',90,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (859,'爬行垫',90,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (860,'妈咪包/背婴带',91,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (861,'产后塑身',91,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (862,'文胸/内裤',91,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (863,'防辐射服',91,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (864,'孕妈装',91,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (865,'孕期营养',91,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (866,'孕妇护肤',91,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (867,'待产护理',91,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (868,'月子装',91,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (869,'防溢乳垫',91,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (870,'套装',92,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (871,'上衣',92,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (872,'裤子',92,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (873,'裙子',92,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (874,'内衣/家居服',92,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (875,'羽绒服/棉服',92,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (876,'亲子装',92,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (877,'儿童配饰',92,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (878,'礼服/演出服',92,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (879,'运动鞋',92,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (880,'皮鞋/帆布鞋',92,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (881,'靴子',92,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (882,'凉鞋',92,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (883,'功能鞋',92,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (884,'户外/运动服',92,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (885,'提篮式',93,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (886,'安全座椅',93,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (887,'增高垫',93,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (889,'手拿包',94,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (890,'单肩包',94,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (891,'双肩包',94,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (892,'手提包',94,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (893,'斜挎包',94,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (894,'钥匙包',94,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (895,'卡包/零钱包',94,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (896,'男士钱包',95,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (897,'男士手包',95,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (898,'卡包名片夹',95,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (899,'商务公文包',95,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (900,'双肩包',95,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (901,'单肩/斜挎包',95,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (902,'钥匙包',95,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (903,'电脑包',96,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (904,'拉杆箱',96,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (905,'旅行包',96,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (906,'旅行配件',96,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (907,'休闲运动包',96,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (908,'拉杆包',96,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (909,'登山包',96,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (910,'妈咪包',96,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (911,'书包',96,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (912,'相机包',96,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (913,'腰包/胸包',96,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (914,'火机烟具',97,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (915,'礼品文具',97,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (916,'军刀军具',97,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (917,'收藏品',97,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (918,'工艺礼品',97,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (919,'创意礼品',97,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (920,'礼盒礼券',97,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (921,'鲜花绿植',97,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (922,'婚庆节庆',97,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (923,'京东卡',97,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (924,'美妆礼品',97,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (925,'礼品定制',97,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (926,'京东福卡',97,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (927,'古董文玩',97,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (928,'箱包',98,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (929,'钱包',98,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (930,'服饰',98,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (931,'腰带',98,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (932,'太阳镜/眼镜框',98,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (933,'配件',98,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (934,'鞋靴',98,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (935,'饰品',98,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (936,'名品腕表',98,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (937,'高档化妆品',98,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (938,'婚嫁首饰',99,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (939,'婚纱摄影',99,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (940,'婚纱礼服',99,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (941,'婚庆服务',99,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (942,'婚庆礼品/用品',99,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (943,'婚宴',99,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (944,'饼干蛋糕',100,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (945,'糖果/巧克力',100,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (946,'休闲零食',100,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (947,'冲调饮品',100,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (948,'粮油调味',100,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (949,'牛奶',100,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (950,'其他特产',101,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (951,'新疆',101,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (952,'北京',101,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (953,'山西',101,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (954,'内蒙古',101,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (955,'福建',101,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (956,'湖南',101,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (957,'四川',101,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (958,'云南',101,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (959,'东北',101,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (960,'休闲零食',102,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (961,'坚果炒货',102,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (962,'肉干肉脯',102,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (963,'蜜饯果干',102,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (964,'糖果/巧克力',102,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (965,'饼干蛋糕',102,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (966,'无糖食品',102,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (967,'米面杂粮',103,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (968,'食用油',103,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (969,'调味品',103,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (970,'南北干货',103,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (971,'方便食品',103,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (972,'有机食品',103,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (973,'饮用水',104,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (974,'饮料',104,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (975,'牛奶乳品',104,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (976,'咖啡/奶茶',104,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (977,'冲饮谷物',104,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (978,'蜂蜜/柚子茶',104,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (979,'成人奶粉',104,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (980,'月饼',105,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (981,'大闸蟹',105,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (982,'粽子',105,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (983,'卡券',105,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (984,'铁观音',106,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (985,'普洱',106,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (986,'龙井',106,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (987,'绿茶',106,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (988,'红茶',106,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (989,'乌龙茶',106,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (990,'花草茶',106,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (991,'花果茶',106,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (992,'养生茶',106,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (993,'黑茶',106,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (994,'白茶',106,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (995,'其它茶',106,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (996,'项链',107,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (997,'手链/脚链',107,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (998,'戒指',107,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (999,'耳饰',107,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1000,'毛衣链',107,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1001,'发饰/发卡',107,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1002,'胸针',107,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1003,'饰品配件',107,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1004,'婚庆饰品',107,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1005,'黄金吊坠',108,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1006,'黄金项链',108,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1007,'黄金转运珠',108,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1008,'黄金手镯/手链/脚链',108,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1009,'黄金耳饰',108,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1010,'黄金戒指',108,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1011,'K金吊坠',109,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1012,'K金项链',109,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1013,'K金手镯/手链/脚链',109,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1014,'K金戒指',109,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1015,'K金耳饰',109,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1016,'投资金',110,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1017,'投资银',110,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1018,'投资收藏',110,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1019,'银吊坠/项链',111,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1020,'银手镯/手链/脚链',111,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1021,'银戒指',111,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1022,'银耳饰',111,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1023,'足银手镯',111,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1024,'宝宝银饰',111,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1025,'裸钻',112,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1026,'钻戒',112,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1027,'钻石项链/吊坠',112,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1028,'钻石耳饰',112,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1029,'钻石手镯/手链',112,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1030,'项链/吊坠',113,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1031,'手镯/手串',113,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1032,'戒指',113,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1033,'耳饰',113,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1034,'挂件/摆件/把件',113,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1035,'玉石孤品',113,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1036,'项链/吊坠',114,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1037,'耳饰',114,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1038,'手镯/手链/脚链',114,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1039,'戒指',114,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1040,'头饰/胸针',114,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1041,'摆件/挂件',114,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1042,'琥珀/蜜蜡',115,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1043,'碧玺',115,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1044,'红宝石/蓝宝石',115,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1045,'坦桑石',115,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1046,'珊瑚',115,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1047,'祖母绿',115,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1048,'葡萄石',115,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1049,'其他天然宝石',115,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1050,'项链/吊坠',115,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1051,'耳饰',115,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1052,'手镯/手链',115,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1053,'戒指',115,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1054,'铂金项链/吊坠',116,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1055,'铂金手镯/手链/脚链',116,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1056,'铂金戒指',116,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1057,'铂金耳饰',116,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1058,'小叶紫檀',117,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1059,'黄花梨',117,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1060,'沉香木',117,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1061,'金丝楠',117,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1062,'菩提',117,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1063,'其他',117,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1064,'橄榄核/核桃',117,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1065,'檀香',117,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1066,'珍珠项链',118,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1067,'珍珠吊坠',118,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1068,'珍珠耳饰',118,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1069,'珍珠手链',118,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1070,'珍珠戒指',118,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1071,'珍珠胸针',118,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1072,'机油',119,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1073,'正时皮带',119,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1074,'添加剂',119,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1075,'汽车喇叭',119,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1076,'防冻液',119,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1077,'汽车玻璃',119,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1078,'滤清器',119,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1079,'火花塞',119,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1080,'减震器',119,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1081,'柴机油/辅助油',119,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1082,'雨刷',119,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1083,'车灯',119,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1084,'后视镜',119,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1085,'轮胎',119,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1086,'轮毂',119,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1087,'刹车片/盘',119,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1088,'维修配件',119,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1089,'蓄电池',119,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1090,'底盘装甲/护板',119,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1091,'贴膜',119,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1092,'汽修工具',119,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1093,'改装配件',119,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1094,'导航仪',120,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1095,'安全预警仪',120,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1096,'行车记录仪',120,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1097,'倒车雷达',120,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1098,'蓝牙设备',120,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1099,'车载影音',120,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1100,'净化器',120,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1101,'电源',120,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1102,'智能驾驶',120,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1103,'车载电台',120,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1104,'车载电器配件',120,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1105,'吸尘器',120,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1106,'智能车机',120,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1107,'冰箱',120,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1108,'汽车音响',120,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1109,'车载生活电器',120,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1110,'车蜡',121,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1111,'补漆笔',121,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1112,'玻璃水',121,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1113,'清洁剂',121,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1114,'洗车工具',121,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1115,'镀晶镀膜',121,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1116,'打蜡机',121,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1117,'洗车配件',121,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1118,'洗车机',121,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1119,'洗车水枪',121,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1120,'毛巾掸子',121,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1121,'脚垫',122,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1122,'座垫',122,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1123,'座套',122,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1124,'后备箱垫',122,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1125,'头枕腰靠',122,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1126,'方向盘套',122,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1127,'香水',122,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1128,'空气净化',122,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1129,'挂件摆件',122,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1130,'功能小件',122,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1131,'车身装饰件',122,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1132,'车衣',122,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1133,'安全座椅',123,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1134,'胎压监测',123,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1135,'防盗设备',123,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1136,'应急救援',123,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1137,'保温箱',123,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1138,'地锁',123,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1139,'摩托车',123,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1140,'充气泵',123,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1141,'储物箱',123,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1142,'自驾野营',123,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1143,'摩托车装备',123,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1144,'清洗美容',124,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1145,'功能升级',124,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1146,'保养维修',124,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1147,'油卡充值',124,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1148,'车险',124,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1149,'加油卡',124,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1150,'ETC',124,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1151,'驾驶培训',124,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1152,'赛事服装',125,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1153,'赛事用品',125,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1154,'制动系统',125,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1155,'悬挂系统',125,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1156,'进气系统',125,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1157,'排气系统',125,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1158,'电子管理',125,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1159,'车身强化',125,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1160,'赛事座椅',125,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1161,'跑步鞋',126,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1162,'休闲鞋',126,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1163,'篮球鞋',126,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1164,'板鞋',126,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1165,'帆布鞋',126,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1166,'足球鞋',126,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1167,'乒羽网鞋',126,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1168,'专项运动鞋',126,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1169,'训练鞋',126,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1170,'拖鞋',126,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1171,'运动包',126,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1172,'羽绒服',127,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1173,'棉服',127,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1174,'运动裤',127,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1175,'夹克/风衣',127,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1176,'卫衣/套头衫',127,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1177,'T恤',127,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1178,'套装',127,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1179,'乒羽网服',127,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1180,'健身服',127,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1181,'运动背心',127,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1182,'毛衫/线衫',127,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1183,'运动配饰',127,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1184,'折叠车',128,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1185,'山地车/公路车',128,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1186,'电动车',128,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1187,'其他整车',128,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1188,'骑行服',128,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1189,'骑行装备',128,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1190,'平衡车',128,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1191,'鱼竿鱼线',129,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1192,'浮漂鱼饵',129,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1193,'钓鱼桌椅',129,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1194,'钓鱼配件',129,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1195,'钓箱鱼包',129,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1196,'其它',129,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1197,'泳镜',130,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1198,'泳帽',130,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1199,'游泳包防水包',130,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1200,'女士泳衣',130,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1201,'男士泳衣',130,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1202,'比基尼',130,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1203,'其它',130,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1204,'冲锋衣裤',131,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1205,'速干衣裤',131,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1206,'滑雪服',131,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1207,'羽绒服/棉服',131,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1208,'休闲衣裤',131,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1209,'抓绒衣裤',131,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1210,'软壳衣裤',131,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1211,'T恤',131,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1212,'户外风衣',131,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1213,'功能内衣',131,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1214,'军迷服饰',131,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1215,'登山鞋',131,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1216,'雪地靴',131,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1217,'徒步鞋',131,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1218,'越野跑鞋',131,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1219,'休闲鞋',131,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1220,'工装鞋',131,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1221,'溯溪鞋',131,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1222,'沙滩/凉拖',131,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1223,'户外袜',131,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1224,'帐篷/垫子',132,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1225,'睡袋/吊床',132,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1226,'登山攀岩',132,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1227,'户外配饰',132,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1228,'背包',132,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1229,'户外照明',132,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1230,'户外仪表',132,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1231,'户外工具',132,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1232,'望远镜',132,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1233,'旅游用品',132,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1234,'便携桌椅床',132,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1235,'野餐烧烤',132,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1236,'军迷用品',132,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1237,'救援装备',132,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1238,'滑雪装备',132,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1239,'极限户外',132,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1240,'冲浪潜水',132,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1241,'综合训练器',133,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1242,'其他大型器械',133,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1243,'哑铃',133,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1244,'仰卧板/收腹机',133,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1245,'其他中小型器材',133,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1246,'瑜伽舞蹈',133,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1247,'甩脂机',133,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1248,'踏步机',133,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1249,'武术搏击',133,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1250,'健身车/动感单车',133,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1251,'跑步机',133,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1252,'运动护具',133,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1253,'羽毛球',134,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1254,'乒乓球',134,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1255,'篮球',134,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1256,'足球',134,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1257,'网球',134,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1258,'排球',134,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1259,'高尔夫',134,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1260,'台球',134,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1261,'棋牌麻将',134,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1262,'轮滑滑板',134,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1263,'其他',134,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1264,'0-6个月',135,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1265,'6-12个月',135,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1266,'1-3岁',135,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1267,'3-6岁',135,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1268,'6-14岁',135,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1269,'14岁以上',135,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1270,'遥控车',136,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1271,'遥控飞机',136,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1272,'遥控船',136,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1273,'机器人',136,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1274,'轨道/助力',136,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1275,'毛绒/布艺',137,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1276,'靠垫/抱枕',137,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1277,'芭比娃娃',138,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1278,'卡通娃娃',138,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1279,'智能娃娃',138,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1280,'仿真模型',139,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1281,'拼插模型',139,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1282,'收藏爱好',139,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1283,'炫舞毯',140,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1284,'爬行垫/毯',140,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1285,'户外玩具',140,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1286,'戏水玩具',140,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1287,'电影周边',141,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1288,'卡通周边',141,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1289,'网游周边',141,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1290,'摇铃/床铃',142,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1291,'健身架',142,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1292,'早教启智',142,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1293,'拖拉玩具',142,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1294,'积木',143,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1295,'拼图',143,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1296,'磁力棒',143,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1297,'立体拼插',143,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1298,'手工彩泥',144,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1299,'绘画工具',144,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1300,'情景玩具',144,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1301,'减压玩具',145,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1302,'创意玩具',145,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1303,'钢琴',146,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1304,'电子琴/电钢琴',146,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1305,'吉他/尤克里里',146,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1306,'打击乐器',146,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1307,'西洋管弦',146,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1308,'民族管弦乐器',146,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1309,'乐器配件',146,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1310,'电脑音乐',146,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1311,'工艺礼品乐器',146,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1312,'口琴/口风琴/竖笛',146,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1313,'手风琴',146,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1314,'双色球',147,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1315,'大乐透',147,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1316,'福彩3D',147,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1317,'排列三',147,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1318,'排列五',147,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1319,'七星彩',147,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1320,'七乐彩',147,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1321,'竞彩足球',147,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1322,'竞彩篮球',147,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1323,'新时时彩',147,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1324,'国内机票',148,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1325,'国内酒店',149,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1326,'酒店团购',149,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1327,'度假',150,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1328,'景点',150,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1329,'租车',150,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1330,'火车票',150,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1331,'旅游团购',150,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1332,'手机充值',151,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1333,'游戏点卡',152,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1334,'QQ充值',152,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1335,'电影票',153,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1336,'演唱会',153,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1337,'话剧歌剧',153,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1338,'音乐会',153,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1339,'体育赛事',153,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1340,'舞蹈芭蕾',153,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1341,'戏曲综艺',153,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1342,'东北',154,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1343,'华北',154,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1344,'西北',154,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1345,'华中',154,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1346,'华东',154,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1347,'华南',154,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1348,'西南',154,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1349,'苹果',155,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1350,'橙子',155,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1351,'奇异果/猕猴桃',155,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1352,'车厘子/樱桃',155,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1353,'芒果',155,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1354,'蓝莓',155,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1355,'火龙果',155,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1356,'葡萄/提子',155,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1357,'柚子',155,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1358,'香蕉',155,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1359,'牛油果',155,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1360,'梨',155,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1361,'菠萝/凤梨',155,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1362,'桔/橘',155,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1363,'柠檬',155,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1364,'草莓',155,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1365,'桃/李/杏',155,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1366,'更多水果',155,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1367,'水果礼盒/券',155,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1368,'牛肉',156,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1369,'羊肉',156,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1370,'猪肉',156,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1371,'内脏类',156,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1372,'鱼类',157,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1373,'虾类',157,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1374,'蟹类',157,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1375,'贝类',157,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1376,'海参',157,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1377,'海产干货',157,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1378,'其他水产',157,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1379,'海产礼盒',157,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1380,'鸡肉',158,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1381,'鸭肉',158,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1382,'蛋类',158,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1383,'其他禽类',158,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1384,'水饺/馄饨',159,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1385,'汤圆/元宵',159,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1386,'面点',159,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1387,'火锅丸串',159,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1388,'速冻半成品',159,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1389,'奶酪黄油',159,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1390,'熟食',160,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1391,'腊肠/腊肉',160,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1392,'火腿',160,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1393,'糕点',160,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1394,'礼品卡券',160,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1395,'冷藏果蔬汁',161,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1396,'冰激凌',161,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1397,'其他',161,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1398,'叶菜类',162,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1399,'茄果瓜类',162,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1400,'根茎类',162,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1401,'鲜菌菇',162,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1402,'葱姜蒜椒',162,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1403,'半加工蔬菜',162,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1404,'微型车',163,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1405,'小型车',163,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1406,'紧凑型车',163,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1407,'中型车',163,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1408,'中大型车',163,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1409,'豪华车',163,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1410,'MPV',163,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1411,'SUV',163,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1412,'跑车',163,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1413,'微型车（二手）',164,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1414,'小型车（二手）',164,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1415,'紧凑型车（二手）',164,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1416,'中型车（二手）',164,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1417,'中大型车（二手）',164,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1418,'豪华车（二手）',164,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1419,'MPV（二手）',164,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1420,'SUV（二手）',164,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1421,'跑车（二手）',164,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1422,'皮卡（二手）',164,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1423,'面包车（二手）',164,3,1,0,NULL,NULL,0,NULL,NULL);
insert  into `pms_category`(`cat_id`,`name`,`parent_cid`,`cat_level`,`show_status`,`sort`,`icon`,`product_unit`,`product_count`,`keywords`,`description`) values (1424,'智能手机',34,3,1,0,'','台',NULL,NULL,NULL);

/*Table structure for table `pms_category_brand_relation` */

CREATE TABLE `pms_category_brand_relation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `brand_id` bigint(20) DEFAULT NULL COMMENT '品牌id',
  `catelog_id` bigint(20) DEFAULT NULL COMMENT '分类id',
  `brand_name` varchar(255) DEFAULT NULL,
  `catelog_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COMMENT='品牌分类关联';

/*Data for the table `pms_category_brand_relation` */

insert  into `pms_category_brand_relation`(`id`,`brand_id`,`catelog_id`,`brand_name`,`catelog_name`) values (5,1,225,'奇虎360','手机');
insert  into `pms_category_brand_relation`(`id`,`brand_id`,`catelog_id`,`brand_name`,`catelog_name`) values (6,1,264,'奇虎360','燃气灶');
insert  into `pms_category_brand_relation`(`id`,`brand_id`,`catelog_id`,`brand_name`,`catelog_name`) values (7,2,250,'小米','平板电视');
insert  into `pms_category_brand_relation`(`id`,`brand_id`,`catelog_id`,`brand_name`,`catelog_name`) values (8,2,251,'小米','空调');
insert  into `pms_category_brand_relation`(`id`,`brand_id`,`catelog_id`,`brand_name`,`catelog_name`) values (9,2,253,'小米','洗衣机');
insert  into `pms_category_brand_relation`(`id`,`brand_id`,`catelog_id`,`brand_name`,`catelog_name`) values (10,6,225,'锤子','手机');
insert  into `pms_category_brand_relation`(`id`,`brand_id`,`catelog_id`,`brand_name`,`catelog_name`) values (11,4,225,'荣耀','手机');
insert  into `pms_category_brand_relation`(`id`,`brand_id`,`catelog_id`,`brand_name`,`catelog_name`) values (12,5,225,'OPPO','手机');
insert  into `pms_category_brand_relation`(`id`,`brand_id`,`catelog_id`,`brand_name`,`catelog_name`) values (13,7,225,'努比亚','手机');
insert  into `pms_category_brand_relation`(`id`,`brand_id`,`catelog_id`,`brand_name`,`catelog_name`) values (14,1,493,'奇虎360','路由器');
insert  into `pms_category_brand_relation`(`id`,`brand_id`,`catelog_id`,`brand_name`,`catelog_name`) values (15,2,225,'小米','手机');
insert  into `pms_category_brand_relation`(`id`,`brand_id`,`catelog_id`,`brand_name`,`catelog_name`) values (16,8,225,'苹果','手机');
insert  into `pms_category_brand_relation`(`id`,`brand_id`,`catelog_id`,`brand_name`,`catelog_name`) values (17,9,225,'华为','手机');

/*Table structure for table `pms_comment_replay` */

CREATE TABLE `pms_comment_replay` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `comment_id` bigint(20) DEFAULT NULL COMMENT '评论id',
  `reply_id` bigint(20) DEFAULT NULL COMMENT '回复id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品评价回复关系';

/*Data for the table `pms_comment_replay` */

/*Table structure for table `pms_product_attr_value` */

CREATE TABLE `pms_product_attr_value` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `spu_id` bigint(20) DEFAULT NULL COMMENT '商品id',
  `attr_id` bigint(20) DEFAULT NULL COMMENT '属性id',
  `attr_name` varchar(200) DEFAULT NULL COMMENT '属性名',
  `attr_value` varchar(200) DEFAULT NULL COMMENT '属性值',
  `attr_sort` int(11) DEFAULT NULL COMMENT '顺序',
  `quick_show` tinyint(4) DEFAULT NULL COMMENT '快速展示【是否展示在介绍上；0-否 1-是】',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COMMENT='spu属性值';

/*Data for the table `pms_product_attr_value` */

insert  into `pms_product_attr_value`(`id`,`spu_id`,`attr_id`,`attr_name`,`attr_value`,`attr_sort`,`quick_show`) values (1,9,18,'入网型号','A2404',NULL,1);
insert  into `pms_product_attr_value`(`id`,`spu_id`,`attr_id`,`attr_name`,`attr_value`,`attr_sort`,`quick_show`) values (2,9,19,'上市月份','10月',NULL,0);
insert  into `pms_product_attr_value`(`id`,`spu_id`,`attr_id`,`attr_name`,`attr_value`,`attr_sort`,`quick_show`) values (3,9,20,'机身长度','162.9mm',NULL,0);
insert  into `pms_product_attr_value`(`id`,`spu_id`,`attr_id`,`attr_name`,`attr_value`,`attr_sort`,`quick_show`) values (4,9,21,'机身材质工艺','其他',NULL,0);
insert  into `pms_product_attr_value`(`id`,`spu_id`,`attr_id`,`attr_name`,`attr_value`,`attr_sort`,`quick_show`) values (5,10,18,'入网型号','NOH-AN00',NULL,1);
insert  into `pms_product_attr_value`(`id`,`spu_id`,`attr_id`,`attr_name`,`attr_value`,`attr_sort`,`quick_show`) values (6,10,19,'上市月份','10月',NULL,0);
insert  into `pms_product_attr_value`(`id`,`spu_id`,`attr_id`,`attr_name`,`attr_value`,`attr_sort`,`quick_show`) values (7,10,20,'机身长度','162.9mm',NULL,0);
insert  into `pms_product_attr_value`(`id`,`spu_id`,`attr_id`,`attr_name`,`attr_value`,`attr_sort`,`quick_show`) values (8,10,21,'机身材质工艺','其他',NULL,0);

/*Table structure for table `pms_sku_images` */

CREATE TABLE `pms_sku_images` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `sku_id` bigint(20) DEFAULT NULL COMMENT 'sku_id',
  `img_url` varchar(255) DEFAULT NULL COMMENT '图片地址',
  `img_sort` int(11) DEFAULT NULL COMMENT '排序',
  `default_img` int(11) DEFAULT NULL COMMENT '默认图[0 - 不是默认图，1 - 是默认图]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8mb4 COMMENT='sku图片';

/*Data for the table `pms_sku_images` */

insert  into `pms_sku_images`(`id`,`sku_id`,`img_url`,`img_sort`,`default_img`) values (93,23,'https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0382fc61-adb3-4720-8611-0c5ae700a8b2_iPhone_hongse_zheng.jpg',NULL,1);
insert  into `pms_sku_images`(`id`,`sku_id`,`img_url`,`img_sort`,`default_img`) values (94,23,'https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/be730c73-2b72-40aa-82fb-ad5712c66b33_iPhone_hongse_peizhi.jpg',NULL,0);
insert  into `pms_sku_images`(`id`,`sku_id`,`img_url`,`img_sort`,`default_img`) values (95,23,'https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/75e7a557-6113-4794-82ff-66837eb0b9fe_iPhone_hongse_peizhi.sexiangtong.jpg',NULL,0);
insert  into `pms_sku_images`(`id`,`sku_id`,`img_url`,`img_sort`,`default_img`) values (96,24,'https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/b2ef173e-4344-4002-8b5a-b766f7a37f64_iPhone_baise.jpg',NULL,1);
insert  into `pms_sku_images`(`id`,`sku_id`,`img_url`,`img_sort`,`default_img`) values (97,24,'https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/20b1cec2-36fb-4b51-8ecc-4c36772b882a_iPhone_baise_peizhi.jpg',NULL,0);
insert  into `pms_sku_images`(`id`,`sku_id`,`img_url`,`img_sort`,`default_img`) values (98,24,'https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/14af5acb-2a82-47c6-8e6b-df9071a145b3_iPhone_baise_sexiangtou.jpg',NULL,0);
insert  into `pms_sku_images`(`id`,`sku_id`,`img_url`,`img_sort`,`default_img`) values (99,25,'https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0382fc61-adb3-4720-8611-0c5ae700a8b2_iPhone_hongse_zheng.jpg',NULL,1);
insert  into `pms_sku_images`(`id`,`sku_id`,`img_url`,`img_sort`,`default_img`) values (100,25,'https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/be730c73-2b72-40aa-82fb-ad5712c66b33_iPhone_hongse_peizhi.jpg',NULL,0);
insert  into `pms_sku_images`(`id`,`sku_id`,`img_url`,`img_sort`,`default_img`) values (101,25,'https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/75e7a557-6113-4794-82ff-66837eb0b9fe_iPhone_hongse_peizhi.sexiangtong.jpg',NULL,0);
insert  into `pms_sku_images`(`id`,`sku_id`,`img_url`,`img_sort`,`default_img`) values (102,26,'https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/b2ef173e-4344-4002-8b5a-b766f7a37f64_iPhone_baise.jpg',NULL,1);
insert  into `pms_sku_images`(`id`,`sku_id`,`img_url`,`img_sort`,`default_img`) values (103,26,'https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/20b1cec2-36fb-4b51-8ecc-4c36772b882a_iPhone_baise_peizhi.jpg',NULL,0);
insert  into `pms_sku_images`(`id`,`sku_id`,`img_url`,`img_sort`,`default_img`) values (104,26,'https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/14af5acb-2a82-47c6-8e6b-df9071a145b3_iPhone_baise_sexiangtou.jpg',NULL,0);
insert  into `pms_sku_images`(`id`,`sku_id`,`img_url`,`img_sort`,`default_img`) values (105,27,'https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0b9953b7-87f9-42a2-8fbf-ca7cfdd3364e_huawei_zhengmina_bai.jpg',NULL,1);
insert  into `pms_sku_images`(`id`,`sku_id`,`img_url`,`img_sort`,`default_img`) values (106,27,'https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/83778315-ebe0-42ff-80e8-02c63ec55239_huawei_cemian_bai.jpg',NULL,0);
insert  into `pms_sku_images`(`id`,`sku_id`,`img_url`,`img_sort`,`default_img`) values (107,27,'https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/841ed864-2708-4b9f-8f6e-426d85415374_huawei_cemian1.jpg',NULL,0);
insert  into `pms_sku_images`(`id`,`sku_id`,`img_url`,`img_sort`,`default_img`) values (108,28,'https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/6b4fd587-6293-4428-8673-c8751452a74b_huawei_zhengmian.jpg',NULL,1);
insert  into `pms_sku_images`(`id`,`sku_id`,`img_url`,`img_sort`,`default_img`) values (109,28,'https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/bfef5aca-987f-41ab-8b70-7eee9e23863a_huawei_beimian1.jpg',NULL,0);
insert  into `pms_sku_images`(`id`,`sku_id`,`img_url`,`img_sort`,`default_img`) values (110,28,'https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/841ed864-2708-4b9f-8f6e-426d85415374_huawei_cemian1.jpg',NULL,0);
insert  into `pms_sku_images`(`id`,`sku_id`,`img_url`,`img_sort`,`default_img`) values (111,29,'https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0b9953b7-87f9-42a2-8fbf-ca7cfdd3364e_huawei_zhengmina_bai.jpg',NULL,1);
insert  into `pms_sku_images`(`id`,`sku_id`,`img_url`,`img_sort`,`default_img`) values (112,29,'https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/83778315-ebe0-42ff-80e8-02c63ec55239_huawei_cemian_bai.jpg',NULL,0);
insert  into `pms_sku_images`(`id`,`sku_id`,`img_url`,`img_sort`,`default_img`) values (113,29,'https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/841ed864-2708-4b9f-8f6e-426d85415374_huawei_cemian1.jpg',NULL,0);
insert  into `pms_sku_images`(`id`,`sku_id`,`img_url`,`img_sort`,`default_img`) values (114,30,'https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/6b4fd587-6293-4428-8673-c8751452a74b_huawei_zhengmian.jpg',NULL,1);
insert  into `pms_sku_images`(`id`,`sku_id`,`img_url`,`img_sort`,`default_img`) values (115,30,'https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/bfef5aca-987f-41ab-8b70-7eee9e23863a_huawei_beimian1.jpg',NULL,0);
insert  into `pms_sku_images`(`id`,`sku_id`,`img_url`,`img_sort`,`default_img`) values (116,30,'https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/841ed864-2708-4b9f-8f6e-426d85415374_huawei_cemian1.jpg',NULL,0);

/*Table structure for table `pms_sku_info` */

CREATE TABLE `pms_sku_info` (
  `sku_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'skuId',
  `spu_id` bigint(20) DEFAULT NULL COMMENT 'spuId',
  `sku_name` varchar(255) DEFAULT NULL COMMENT 'sku名称',
  `sku_desc` varchar(2000) DEFAULT NULL COMMENT 'sku介绍描述',
  `catalog_id` bigint(20) DEFAULT NULL COMMENT '所属分类id',
  `brand_id` bigint(20) DEFAULT NULL COMMENT '品牌id',
  `sku_default_img` varchar(255) DEFAULT NULL COMMENT '默认图片',
  `sku_title` varchar(255) DEFAULT NULL COMMENT '标题',
  `sku_subtitle` varchar(2000) DEFAULT NULL COMMENT '副标题',
  `price` decimal(18,4) DEFAULT NULL COMMENT '价格',
  `sale_count` bigint(20) DEFAULT NULL COMMENT '销量',
  PRIMARY KEY (`sku_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COMMENT='sku信息';

/*Data for the table `pms_sku_info` */

insert  into `pms_sku_info`(`sku_id`,`spu_id`,`sku_name`,`sku_desc`,`catalog_id`,`brand_id`,`sku_default_img`,`sku_title`,`sku_subtitle`,`price`,`sale_count`) values (23,9,'Apple iPhone 12 Apple A14 256G 红色',NULL,225,8,'https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0382fc61-adb3-4720-8611-0c5ae700a8b2_iPhone_hongse_zheng.jpg','Apple iPhone 12 (A2404)支持移动联通电信5G 双卡双待手机 256G 红色','【领券立减600元！】加9元得价值149元20W原装充电头，加799元享价值1246元AirPods蓝牙耳机！惊喜直达查看>','7599.0000',0);
insert  into `pms_sku_info`(`sku_id`,`spu_id`,`sku_name`,`sku_desc`,`catalog_id`,`brand_id`,`sku_default_img`,`sku_title`,`sku_subtitle`,`price`,`sale_count`) values (24,9,'Apple iPhone 12 Apple A14 256G 白色',NULL,225,8,'https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/b2ef173e-4344-4002-8b5a-b766f7a37f64_iPhone_baise.jpg','Apple iPhone 12 (A2404)支持移动联通电信5G 双卡双待手机 256G 白色','【领券立减600元！】加9元得价值149元20W原装充电头，加799元享价值1246元AirPods蓝牙耳机！惊喜直达查看>','7599.0000',0);
insert  into `pms_sku_info`(`sku_id`,`spu_id`,`sku_name`,`sku_desc`,`catalog_id`,`brand_id`,`sku_default_img`,`sku_title`,`sku_subtitle`,`price`,`sale_count`) values (25,9,'Apple iPhone 12 Apple A14 128G 红色',NULL,225,8,'https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0382fc61-adb3-4720-8611-0c5ae700a8b2_iPhone_hongse_zheng.jpg','Apple iPhone 12 (A2404)支持移动联通电信5G 双卡双待手机 128G 红色','【领券立减600元！】加9元得价值149元20W原装充电头，加799元享价值1246元AirPods蓝牙耳机！惊喜直达查看>','6799.0000',0);
insert  into `pms_sku_info`(`sku_id`,`spu_id`,`sku_name`,`sku_desc`,`catalog_id`,`brand_id`,`sku_default_img`,`sku_title`,`sku_subtitle`,`price`,`sale_count`) values (26,9,'Apple iPhone 12 Apple A14 128G 白色',NULL,225,8,'https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/b2ef173e-4344-4002-8b5a-b766f7a37f64_iPhone_baise.jpg','Apple iPhone 12 (A2404)支持移动联通电信5G 双卡双待手机 128G 白色','【领券立减600元！】加9元得价值149元20W原装充电头，加799元享价值1246元AirPods蓝牙耳机！惊喜直达查看>','6799.0000',0);
insert  into `pms_sku_info`(`sku_id`,`spu_id`,`sku_name`,`sku_desc`,`catalog_id`,`brand_id`,`sku_default_img`,`sku_title`,`sku_subtitle`,`price`,`sale_count`) values (27,10,'华为 HUAWEI Mate 40 Pro 海思（Hisilicon） 8G+256G 柚白色',NULL,225,9,'https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0b9953b7-87f9-42a2-8fbf-ca7cfdd3364e_huawei_zhengmina_bai.jpg','华为 HUAWEI Mate 40 Pro麒麟9000 SoC芯片 超感知徕卡电影影像 有线无线双超级快充 5G全网通 8G+256G 柚白色','【华为Mate40Pro】5nm麒麟芯片!超感知徕卡电影影像!双线超级快充!隔空操控屏!!!限量抢购更多选择猛戳查看>','6999.0000',0);
insert  into `pms_sku_info`(`sku_id`,`spu_id`,`sku_name`,`sku_desc`,`catalog_id`,`brand_id`,`sku_default_img`,`sku_title`,`sku_subtitle`,`price`,`sale_count`) values (28,10,'华为 HUAWEI Mate 40 Pro 海思（Hisilicon） 8G+256G 亮黑色',NULL,225,9,'https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/6b4fd587-6293-4428-8673-c8751452a74b_huawei_zhengmian.jpg','华为 HUAWEI Mate 40 Pro麒麟9000 SoC芯片 超感知徕卡电影影像 有线无线双超级快充 5G全网通 8G+256G 亮黑色','【华为Mate40Pro】5nm麒麟芯片!超感知徕卡电影影像!双线超级快充!隔空操控屏!!!限量抢购更多选择猛戳查看>','6999.0000',0);
insert  into `pms_sku_info`(`sku_id`,`spu_id`,`sku_name`,`sku_desc`,`catalog_id`,`brand_id`,`sku_default_img`,`sku_title`,`sku_subtitle`,`price`,`sale_count`) values (29,10,'华为 HUAWEI Mate 40 Pro 海思（Hisilicon） 8G+128G 柚白色',NULL,225,9,'https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0b9953b7-87f9-42a2-8fbf-ca7cfdd3364e_huawei_zhengmina_bai.jpg','华为 HUAWEI Mate 40 Pro麒麟9000 SoC芯片 超感知徕卡电影影像 有线无线双超级快充 5G全网通 8G+128G 柚白色','【华为Mate40Pro】5nm麒麟芯片!超感知徕卡电影影像!双线超级快充!隔空操控屏!!!限量抢购更多选择猛戳查看>','6499.0000',0);
insert  into `pms_sku_info`(`sku_id`,`spu_id`,`sku_name`,`sku_desc`,`catalog_id`,`brand_id`,`sku_default_img`,`sku_title`,`sku_subtitle`,`price`,`sale_count`) values (30,10,'华为 HUAWEI Mate 40 Pro 海思（Hisilicon） 8G+128G 亮黑色',NULL,225,9,'https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/6b4fd587-6293-4428-8673-c8751452a74b_huawei_zhengmian.jpg','华为 HUAWEI Mate 40 Pro麒麟9000 SoC芯片 超感知徕卡电影影像 有线无线双超级快充 5G全网通 8G+128G 亮黑色','【华为Mate40Pro】5nm麒麟芯片!超感知徕卡电影影像!双线超级快充!隔空操控屏!!!限量抢购更多选择猛戳查看>','6499.0000',0);

/*Table structure for table `pms_sku_sale_attr_value` */

CREATE TABLE `pms_sku_sale_attr_value` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `sku_id` bigint(20) DEFAULT NULL COMMENT 'sku_id',
  `attr_id` bigint(20) DEFAULT NULL COMMENT 'attr_id',
  `attr_name` varchar(200) DEFAULT NULL COMMENT '销售属性名',
  `attr_value` varchar(200) DEFAULT NULL COMMENT '销售属性值',
  `attr_sort` int(11) DEFAULT NULL COMMENT '顺序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb4 COMMENT='sku销售属性&值';

/*Data for the table `pms_sku_sale_attr_value` */

insert  into `pms_sku_sale_attr_value`(`id`,`sku_id`,`attr_id`,`attr_name`,`attr_value`,`attr_sort`) values (61,23,22,'CPU类型','Apple A14',NULL);
insert  into `pms_sku_sale_attr_value`(`id`,`sku_id`,`attr_id`,`attr_name`,`attr_value`,`attr_sort`) values (62,23,23,'运行内存','256G',NULL);
insert  into `pms_sku_sale_attr_value`(`id`,`sku_id`,`attr_id`,`attr_name`,`attr_value`,`attr_sort`) values (63,23,24,'机身颜色','红色',NULL);
insert  into `pms_sku_sale_attr_value`(`id`,`sku_id`,`attr_id`,`attr_name`,`attr_value`,`attr_sort`) values (64,24,22,'CPU类型','Apple A14',NULL);
insert  into `pms_sku_sale_attr_value`(`id`,`sku_id`,`attr_id`,`attr_name`,`attr_value`,`attr_sort`) values (65,24,23,'运行内存','256G',NULL);
insert  into `pms_sku_sale_attr_value`(`id`,`sku_id`,`attr_id`,`attr_name`,`attr_value`,`attr_sort`) values (66,24,24,'机身颜色','白色',NULL);
insert  into `pms_sku_sale_attr_value`(`id`,`sku_id`,`attr_id`,`attr_name`,`attr_value`,`attr_sort`) values (67,25,22,'CPU类型','Apple A14',NULL);
insert  into `pms_sku_sale_attr_value`(`id`,`sku_id`,`attr_id`,`attr_name`,`attr_value`,`attr_sort`) values (68,25,23,'运行内存','128G',NULL);
insert  into `pms_sku_sale_attr_value`(`id`,`sku_id`,`attr_id`,`attr_name`,`attr_value`,`attr_sort`) values (69,25,24,'机身颜色','红色',NULL);
insert  into `pms_sku_sale_attr_value`(`id`,`sku_id`,`attr_id`,`attr_name`,`attr_value`,`attr_sort`) values (70,26,22,'CPU类型','Apple A14',NULL);
insert  into `pms_sku_sale_attr_value`(`id`,`sku_id`,`attr_id`,`attr_name`,`attr_value`,`attr_sort`) values (71,26,23,'运行内存','128G',NULL);
insert  into `pms_sku_sale_attr_value`(`id`,`sku_id`,`attr_id`,`attr_name`,`attr_value`,`attr_sort`) values (72,26,24,'机身颜色','白色',NULL);
insert  into `pms_sku_sale_attr_value`(`id`,`sku_id`,`attr_id`,`attr_name`,`attr_value`,`attr_sort`) values (73,27,22,'CPU类型','海思（Hisilicon）',NULL);
insert  into `pms_sku_sale_attr_value`(`id`,`sku_id`,`attr_id`,`attr_name`,`attr_value`,`attr_sort`) values (74,27,23,'运行内存','8G+256G',NULL);
insert  into `pms_sku_sale_attr_value`(`id`,`sku_id`,`attr_id`,`attr_name`,`attr_value`,`attr_sort`) values (75,27,24,'机身颜色','柚白色',NULL);
insert  into `pms_sku_sale_attr_value`(`id`,`sku_id`,`attr_id`,`attr_name`,`attr_value`,`attr_sort`) values (76,28,22,'CPU类型','海思（Hisilicon）',NULL);
insert  into `pms_sku_sale_attr_value`(`id`,`sku_id`,`attr_id`,`attr_name`,`attr_value`,`attr_sort`) values (77,28,23,'运行内存','8G+256G',NULL);
insert  into `pms_sku_sale_attr_value`(`id`,`sku_id`,`attr_id`,`attr_name`,`attr_value`,`attr_sort`) values (78,28,24,'机身颜色','亮黑色',NULL);
insert  into `pms_sku_sale_attr_value`(`id`,`sku_id`,`attr_id`,`attr_name`,`attr_value`,`attr_sort`) values (79,29,22,'CPU类型','海思（Hisilicon）',NULL);
insert  into `pms_sku_sale_attr_value`(`id`,`sku_id`,`attr_id`,`attr_name`,`attr_value`,`attr_sort`) values (80,29,23,'运行内存','8G+128G',NULL);
insert  into `pms_sku_sale_attr_value`(`id`,`sku_id`,`attr_id`,`attr_name`,`attr_value`,`attr_sort`) values (81,29,24,'机身颜色','柚白色',NULL);
insert  into `pms_sku_sale_attr_value`(`id`,`sku_id`,`attr_id`,`attr_name`,`attr_value`,`attr_sort`) values (82,30,22,'CPU类型','海思（Hisilicon）',NULL);
insert  into `pms_sku_sale_attr_value`(`id`,`sku_id`,`attr_id`,`attr_name`,`attr_value`,`attr_sort`) values (83,30,23,'运行内存','8G+128G',NULL);
insert  into `pms_sku_sale_attr_value`(`id`,`sku_id`,`attr_id`,`attr_name`,`attr_value`,`attr_sort`) values (84,30,24,'机身颜色','亮黑色',NULL);

/*Table structure for table `pms_spu_comment` */

CREATE TABLE `pms_spu_comment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `sku_id` bigint(20) DEFAULT NULL COMMENT 'sku_id',
  `spu_id` bigint(20) DEFAULT NULL COMMENT 'spu_id',
  `spu_name` varchar(255) DEFAULT NULL COMMENT '商品名字',
  `member_nick_name` varchar(255) DEFAULT NULL COMMENT '会员昵称',
  `star` tinyint(1) DEFAULT NULL COMMENT '星级',
  `member_ip` varchar(64) DEFAULT NULL COMMENT '会员ip',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `show_status` tinyint(1) DEFAULT NULL COMMENT '显示状态[0-不显示，1-显示]',
  `spu_attributes` varchar(255) DEFAULT NULL COMMENT '购买时属性组合',
  `likes_count` int(11) DEFAULT NULL COMMENT '点赞数',
  `reply_count` int(11) DEFAULT NULL COMMENT '回复数',
  `resources` varchar(1000) DEFAULT NULL COMMENT '评论图片/视频[json数据；[{type:文件类型,url:资源路径}]]',
  `content` text COMMENT '内容',
  `member_icon` varchar(255) DEFAULT NULL COMMENT '用户头像',
  `comment_type` tinyint(4) DEFAULT NULL COMMENT '评论类型[0 - 对商品的直接评论，1 - 对评论的回复]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品评价';

/*Data for the table `pms_spu_comment` */

/*Table structure for table `pms_spu_images` */

CREATE TABLE `pms_spu_images` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `spu_id` bigint(20) DEFAULT NULL COMMENT 'spu_id',
  `img_name` varchar(200) DEFAULT NULL COMMENT '图片名',
  `img_url` varchar(255) DEFAULT NULL COMMENT '图片地址',
  `img_sort` int(11) DEFAULT NULL COMMENT '顺序',
  `default_img` tinyint(4) DEFAULT NULL COMMENT '是否默认图',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COMMENT='spu图片';

/*Data for the table `pms_spu_images` */

insert  into `pms_spu_images`(`id`,`spu_id`,`img_name`,`img_url`,`img_sort`,`default_img`) values (32,9,'','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0382fc61-adb3-4720-8611-0c5ae700a8b2_iPhone_hongse_zheng.jpg',1,NULL);
insert  into `pms_spu_images`(`id`,`spu_id`,`img_name`,`img_url`,`img_sort`,`default_img`) values (33,9,'','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/be730c73-2b72-40aa-82fb-ad5712c66b33_iPhone_hongse_peizhi.jpg',1,NULL);
insert  into `pms_spu_images`(`id`,`spu_id`,`img_name`,`img_url`,`img_sort`,`default_img`) values (34,9,'','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/75e7a557-6113-4794-82ff-66837eb0b9fe_iPhone_hongse_peizhi.sexiangtong.jpg',1,NULL);
insert  into `pms_spu_images`(`id`,`spu_id`,`img_name`,`img_url`,`img_sort`,`default_img`) values (35,9,'','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/b2ef173e-4344-4002-8b5a-b766f7a37f64_iPhone_baise.jpg',1,NULL);
insert  into `pms_spu_images`(`id`,`spu_id`,`img_name`,`img_url`,`img_sort`,`default_img`) values (36,9,'','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/20b1cec2-36fb-4b51-8ecc-4c36772b882a_iPhone_baise_peizhi.jpg',1,NULL);
insert  into `pms_spu_images`(`id`,`spu_id`,`img_name`,`img_url`,`img_sort`,`default_img`) values (37,9,'','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/14af5acb-2a82-47c6-8e6b-df9071a145b3_iPhone_baise_sexiangtou.jpg',1,NULL);
insert  into `pms_spu_images`(`id`,`spu_id`,`img_name`,`img_url`,`img_sort`,`default_img`) values (38,10,'','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/6b4fd587-6293-4428-8673-c8751452a74b_huawei_zhengmian.jpg',1,NULL);
insert  into `pms_spu_images`(`id`,`spu_id`,`img_name`,`img_url`,`img_sort`,`default_img`) values (39,10,'','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/bfef5aca-987f-41ab-8b70-7eee9e23863a_huawei_beimian1.jpg',1,NULL);
insert  into `pms_spu_images`(`id`,`spu_id`,`img_name`,`img_url`,`img_sort`,`default_img`) values (40,10,'','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/0b9953b7-87f9-42a2-8fbf-ca7cfdd3364e_huawei_zhengmina_bai.jpg',1,NULL);
insert  into `pms_spu_images`(`id`,`spu_id`,`img_name`,`img_url`,`img_sort`,`default_img`) values (41,10,'','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/83778315-ebe0-42ff-80e8-02c63ec55239_huawei_cemian_bai.jpg',1,NULL);
insert  into `pms_spu_images`(`id`,`spu_id`,`img_name`,`img_url`,`img_sort`,`default_img`) values (42,10,'','https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/841ed864-2708-4b9f-8f6e-426d85415374_huawei_cemian1.jpg',1,NULL);

/*Table structure for table `pms_spu_info` */

CREATE TABLE `pms_spu_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '商品id',
  `spu_name` varchar(200) DEFAULT NULL COMMENT '商品名称',
  `spu_description` varchar(1000) DEFAULT NULL COMMENT '商品描述',
  `catalog_id` bigint(20) DEFAULT NULL COMMENT '所属分类id',
  `brand_id` bigint(20) DEFAULT NULL COMMENT '品牌id',
  `weight` decimal(18,4) DEFAULT NULL,
  `publish_status` tinyint(4) DEFAULT NULL COMMENT '上架状态[0 - 下架，1 - 上架]',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COMMENT='spu信息';

/*Data for the table `pms_spu_info` */

insert  into `pms_spu_info`(`id`,`spu_name`,`spu_description`,`catalog_id`,`brand_id`,`weight`,`publish_status`,`create_time`,`update_time`) values (9,'Apple iPhone 12','Apple iPhone 12',225,8,'0.3200',0,'2021-04-13 16:04:08','2021-04-13 16:04:08');
insert  into `pms_spu_info`(`id`,`spu_name`,`spu_description`,`catalog_id`,`brand_id`,`weight`,`publish_status`,`create_time`,`update_time`) values (10,'华为 HUAWEI Mate 40 Pro','华为 HUAWEI Mate 40 Pro',225,9,'0.2120',0,'2021-04-13 16:13:39','2021-04-13 16:13:39');

/*Table structure for table `pms_spu_info_desc` */

CREATE TABLE `pms_spu_info_desc` (
  `spu_id` bigint(20) NOT NULL COMMENT '商品id',
  `decript` longtext COMMENT '商品介绍',
  PRIMARY KEY (`spu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='spu信息介绍';

/*Data for the table `pms_spu_info_desc` */

insert  into `pms_spu_info_desc`(`spu_id`,`decript`) values (9,'https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/7de763bb-24aa-4c82-8029-99eeeb6df05c_iPhone_jianjie.jpg,https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/96c2c541-924b-4568-8863-f077d99d1db9_iPhone_jianjie2.jpg');
insert  into `pms_spu_info_desc`(`spu_id`,`decript`) values (10,'https://tobing-platform.oss-cn-shenzhen.aliyuncs.com/2021-04-13/7901c14e-be03-4ce2-8593-8898e71bd6da_huawei_jieshao.jpg');

/*Table structure for table `qrtz_blob_triggers` */

CREATE TABLE `qrtz_blob_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `BLOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `SCHED_NAME` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `qrtz_blob_triggers` */

/*Table structure for table `qrtz_calendars` */

CREATE TABLE `qrtz_calendars` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `CALENDAR_NAME` varchar(200) NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`CALENDAR_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `qrtz_calendars` */

/*Table structure for table `qrtz_cron_triggers` */

CREATE TABLE `qrtz_cron_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `CRON_EXPRESSION` varchar(120) NOT NULL,
  `TIME_ZONE_ID` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `qrtz_cron_triggers` */

insert  into `qrtz_cron_triggers`(`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`,`CRON_EXPRESSION`,`TIME_ZONE_ID`) values ('RenrenScheduler','TASK_1','DEFAULT','0 0/30 * * * ?','Asia/Shanghai');

/*Table structure for table `qrtz_fired_triggers` */

CREATE TABLE `qrtz_fired_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `ENTRY_ID` varchar(95) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `SCHED_TIME` bigint(13) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) NOT NULL,
  `JOB_NAME` varchar(200) DEFAULT NULL,
  `JOB_GROUP` varchar(200) DEFAULT NULL,
  `IS_NONCONCURRENT` varchar(1) DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`ENTRY_ID`),
  KEY `IDX_QRTZ_FT_TRIG_INST_NAME` (`SCHED_NAME`,`INSTANCE_NAME`),
  KEY `IDX_QRTZ_FT_INST_JOB_REQ_RCVRY` (`SCHED_NAME`,`INSTANCE_NAME`,`REQUESTS_RECOVERY`),
  KEY `IDX_QRTZ_FT_J_G` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_FT_JG` (`SCHED_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_FT_T_G` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_FT_TG` (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `qrtz_fired_triggers` */

/*Table structure for table `qrtz_job_details` */

CREATE TABLE `qrtz_job_details` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) NOT NULL,
  `IS_DURABLE` varchar(1) NOT NULL,
  `IS_NONCONCURRENT` varchar(1) NOT NULL,
  `IS_UPDATE_DATA` varchar(1) NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) NOT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_J_REQ_RECOVERY` (`SCHED_NAME`,`REQUESTS_RECOVERY`),
  KEY `IDX_QRTZ_J_GRP` (`SCHED_NAME`,`JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `qrtz_job_details` */

insert  into `qrtz_job_details`(`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`,`DESCRIPTION`,`JOB_CLASS_NAME`,`IS_DURABLE`,`IS_NONCONCURRENT`,`IS_UPDATE_DATA`,`REQUESTS_RECOVERY`,`JOB_DATA`) values ('RenrenScheduler','TASK_1','DEFAULT',NULL,'io.renren.modules.job.utils.ScheduleJob','0','0','0','0','��\0sr\0org.quartz.JobDataMap���迩��\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMap�����](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMap�.�(v\n�\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap���`�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0\rJOB_PARAM_KEYsr\0.io.renren.modules.job.entity.ScheduleJobEntity\0\0\0\0\0\0\0\0L\0beanNamet\0Ljava/lang/String;L\0\ncreateTimet\0Ljava/util/Date;L\0cronExpressionq\0~\0	L\0jobIdt\0Ljava/lang/Long;L\0paramsq\0~\0	L\0remarkq\0~\0	L\0statust\0Ljava/lang/Integer;xpt\0testTasksr\0java.util.Datehj�KYt\0\0xpw\0\0we�&�xt\00 0/30 * * * ?sr\0java.lang.Long;��̏#�\0J\0valuexr\0java.lang.Number������\0\0xp\0\0\0\0\0\0\0t\0renrent\0参数测试sr\0java.lang.Integer⠤���8\0I\0valuexq\0~\0\0\0\0\0x\0');

/*Table structure for table `qrtz_locks` */

CREATE TABLE `qrtz_locks` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `LOCK_NAME` varchar(40) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`LOCK_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `qrtz_locks` */

insert  into `qrtz_locks`(`SCHED_NAME`,`LOCK_NAME`) values ('RenrenScheduler','STATE_ACCESS');
insert  into `qrtz_locks`(`SCHED_NAME`,`LOCK_NAME`) values ('RenrenScheduler','TRIGGER_ACCESS');

/*Table structure for table `qrtz_paused_trigger_grps` */

CREATE TABLE `qrtz_paused_trigger_grps` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `qrtz_paused_trigger_grps` */

/*Table structure for table `qrtz_scheduler_state` */

CREATE TABLE `qrtz_scheduler_state` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`INSTANCE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `qrtz_scheduler_state` */

insert  into `qrtz_scheduler_state`(`SCHED_NAME`,`INSTANCE_NAME`,`LAST_CHECKIN_TIME`,`CHECKIN_INTERVAL`) values ('RenrenScheduler','7obing1619856235064',1619916851337,15000);

/*Table structure for table `qrtz_simple_triggers` */

CREATE TABLE `qrtz_simple_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `qrtz_simple_triggers` */

/*Table structure for table `qrtz_simprop_triggers` */

CREATE TABLE `qrtz_simprop_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `STR_PROP_1` varchar(512) DEFAULT NULL,
  `STR_PROP_2` varchar(512) DEFAULT NULL,
  `STR_PROP_3` varchar(512) DEFAULT NULL,
  `INT_PROP_1` int(11) DEFAULT NULL,
  `INT_PROP_2` int(11) DEFAULT NULL,
  `LONG_PROP_1` bigint(20) DEFAULT NULL,
  `LONG_PROP_2` bigint(20) DEFAULT NULL,
  `DEC_PROP_1` decimal(13,4) DEFAULT NULL,
  `DEC_PROP_2` decimal(13,4) DEFAULT NULL,
  `BOOL_PROP_1` varchar(1) DEFAULT NULL,
  `BOOL_PROP_2` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `qrtz_simprop_triggers` */

/*Table structure for table `qrtz_triggers` */

CREATE TABLE `qrtz_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) NOT NULL,
  `TRIGGER_TYPE` varchar(8) NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) DEFAULT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_T_J` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_T_JG` (`SCHED_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_T_C` (`SCHED_NAME`,`CALENDAR_NAME`),
  KEY `IDX_QRTZ_T_G` (`SCHED_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_T_STATE` (`SCHED_NAME`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_N_STATE` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_N_G_STATE` (`SCHED_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_NEXT_FIRE_TIME` (`SCHED_NAME`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_ST` (`SCHED_NAME`,`TRIGGER_STATE`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_ST_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_NFT_ST_MISFIRE_GRP` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `qrtz_triggers` */

insert  into `qrtz_triggers`(`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`,`JOB_NAME`,`JOB_GROUP`,`DESCRIPTION`,`NEXT_FIRE_TIME`,`PREV_FIRE_TIME`,`PRIORITY`,`TRIGGER_STATE`,`TRIGGER_TYPE`,`START_TIME`,`END_TIME`,`CALENDAR_NAME`,`MISFIRE_INSTR`,`JOB_DATA`) values ('RenrenScheduler','TASK_1','DEFAULT','TASK_1','DEFAULT',NULL,1619917200000,1619915400000,5,'WAITING','CRON',1612319586000,0,NULL,2,'��\0sr\0org.quartz.JobDataMap���迩��\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMap�����](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMap�.�(v\n�\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap���`�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0\rJOB_PARAM_KEYsr\0.io.renren.modules.job.entity.ScheduleJobEntity\0\0\0\0\0\0\0\0L\0beanNamet\0Ljava/lang/String;L\0\ncreateTimet\0Ljava/util/Date;L\0cronExpressionq\0~\0	L\0jobIdt\0Ljava/lang/Long;L\0paramsq\0~\0	L\0remarkq\0~\0	L\0statust\0Ljava/lang/Integer;xpt\0testTasksr\0java.util.Datehj�KYt\0\0xpw\0\0we�&�xt\00 0/30 * * * ?sr\0java.lang.Long;��̏#�\0J\0valuexr\0java.lang.Number������\0\0xp\0\0\0\0\0\0\0t\0renrent\0参数测试sr\0java.lang.Integer⠤���8\0I\0valuexq\0~\0\0\0\0\0x\0');

/*Table structure for table `schedule_job` */

CREATE TABLE `schedule_job` (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务id',
  `bean_name` varchar(200) DEFAULT NULL COMMENT 'spring bean名称',
  `params` varchar(2000) DEFAULT NULL COMMENT '参数',
  `cron_expression` varchar(100) DEFAULT NULL COMMENT 'cron表达式',
  `status` tinyint(4) DEFAULT NULL COMMENT '任务状态  0：正常  1：暂停',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='定时任务';

/*Data for the table `schedule_job` */

insert  into `schedule_job`(`job_id`,`bean_name`,`params`,`cron_expression`,`status`,`remark`,`create_time`) values (1,'testTask','renren','0 0/30 * * * ?',0,'参数测试','2021-02-03 10:31:40');

/*Table structure for table `schedule_job_log` */

CREATE TABLE `schedule_job_log` (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志id',
  `job_id` bigint(20) NOT NULL COMMENT '任务id',
  `bean_name` varchar(200) DEFAULT NULL COMMENT 'spring bean名称',
  `params` varchar(2000) DEFAULT NULL COMMENT '参数',
  `status` tinyint(4) NOT NULL COMMENT '任务状态    0：成功    1：失败',
  `error` varchar(2000) DEFAULT NULL COMMENT '失败信息',
  `times` int(11) NOT NULL COMMENT '耗时(单位：毫秒)',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`log_id`),
  KEY `job_id` (`job_id`)
) ENGINE=InnoDB AUTO_INCREMENT=267 DEFAULT CHARSET=utf8mb4 COMMENT='定时任务日志';

/*Data for the table `schedule_job_log` */

insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (1,1,'testTask','renren',0,NULL,0,'2021-02-03 11:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (2,1,'testTask','renren',0,NULL,1,'2021-02-03 11:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (3,1,'testTask','renren',0,NULL,0,'2021-02-03 20:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (4,1,'testTask','renren',0,NULL,0,'2021-02-03 21:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (5,1,'testTask','renren',0,NULL,0,'2021-02-03 21:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (6,1,'testTask','renren',0,NULL,0,'2021-02-03 22:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (7,1,'testTask','renren',0,NULL,0,'2021-02-03 22:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (8,1,'testTask','renren',0,NULL,1,'2021-02-03 23:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (9,1,'testTask','renren',0,NULL,1,'2021-02-03 23:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (10,1,'testTask','renren',0,NULL,7,'2021-02-04 00:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (11,1,'testTask','renren',0,NULL,0,'2021-02-04 10:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (12,1,'testTask','renren',0,NULL,1,'2021-02-04 10:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (13,1,'testTask','renren',0,NULL,1,'2021-02-04 11:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (14,1,'testTask','renren',0,NULL,1,'2021-02-04 11:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (15,1,'testTask','renren',0,NULL,1,'2021-02-04 12:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (16,1,'testTask','renren',0,NULL,0,'2021-02-04 12:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (17,1,'testTask','renren',0,NULL,0,'2021-02-04 13:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (18,1,'testTask','renren',0,NULL,1,'2021-02-04 13:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (19,1,'testTask','renren',0,NULL,1,'2021-02-04 14:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (20,1,'testTask','renren',0,NULL,1,'2021-02-04 14:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (21,1,'testTask','renren',0,NULL,0,'2021-02-04 15:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (22,1,'testTask','renren',0,NULL,1,'2021-02-04 15:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (23,1,'testTask','renren',0,NULL,1,'2021-02-04 16:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (24,1,'testTask','renren',0,NULL,1,'2021-02-04 16:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (25,1,'testTask','renren',0,NULL,1,'2021-02-04 17:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (26,1,'testTask','renren',0,NULL,1,'2021-02-04 18:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (27,1,'testTask','renren',0,NULL,1,'2021-02-04 18:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (28,1,'testTask','renren',0,NULL,1,'2021-02-04 19:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (29,1,'testTask','renren',0,NULL,1,'2021-02-04 19:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (30,1,'testTask','renren',0,NULL,1,'2021-02-04 20:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (31,1,'testTask','renren',0,NULL,1,'2021-02-04 20:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (32,1,'testTask','renren',0,NULL,2,'2021-02-04 21:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (33,1,'testTask','renren',0,NULL,1,'2021-02-04 21:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (34,1,'testTask','renren',0,NULL,0,'2021-02-04 22:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (35,1,'testTask','renren',0,NULL,1,'2021-02-05 09:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (36,1,'testTask','renren',0,NULL,2,'2021-02-05 10:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (37,1,'testTask','renren',0,NULL,1,'2021-02-05 10:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (38,1,'testTask','renren',0,NULL,1,'2021-02-05 11:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (39,1,'testTask','renren',0,NULL,0,'2021-02-05 11:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (40,1,'testTask','renren',0,NULL,1,'2021-02-05 12:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (41,1,'testTask','renren',0,NULL,1,'2021-02-05 12:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (42,1,'testTask','renren',0,NULL,1,'2021-02-05 13:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (43,1,'testTask','renren',0,NULL,1,'2021-02-05 13:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (44,1,'testTask','renren',0,NULL,0,'2021-02-05 14:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (45,1,'testTask','renren',0,NULL,2,'2021-02-05 14:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (46,1,'testTask','renren',0,NULL,1,'2021-02-05 15:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (47,1,'testTask','renren',0,NULL,1,'2021-02-05 15:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (48,1,'testTask','renren',0,NULL,1,'2021-02-05 16:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (49,1,'testTask','renren',0,NULL,1,'2021-02-06 10:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (50,1,'testTask','renren',0,NULL,0,'2021-02-06 10:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (51,1,'testTask','renren',0,NULL,1,'2021-02-06 11:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (52,1,'testTask','renren',0,NULL,1,'2021-02-06 11:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (53,1,'testTask','renren',0,NULL,0,'2021-02-06 12:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (54,1,'testTask','renren',0,NULL,1,'2021-02-06 12:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (55,1,'testTask','renren',0,NULL,1,'2021-02-06 13:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (56,1,'testTask','renren',0,NULL,0,'2021-02-06 13:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (57,1,'testTask','renren',0,NULL,1,'2021-02-06 14:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (58,1,'testTask','renren',0,NULL,0,'2021-02-06 14:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (59,1,'testTask','renren',0,NULL,0,'2021-02-06 15:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (60,1,'testTask','renren',0,NULL,1,'2021-02-06 15:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (61,1,'testTask','renren',0,NULL,0,'2021-02-06 16:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (62,1,'testTask','renren',0,NULL,0,'2021-02-12 14:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (63,1,'testTask','renren',0,NULL,2,'2021-02-12 15:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (64,1,'testTask','renren',0,NULL,1,'2021-02-12 15:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (65,1,'testTask','renren',0,NULL,2,'2021-02-12 16:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (66,1,'testTask','renren',0,NULL,1,'2021-02-12 16:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (67,1,'testTask','renren',0,NULL,1,'2021-02-12 17:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (68,1,'testTask','renren',0,NULL,1,'2021-02-12 17:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (69,1,'testTask','renren',0,NULL,1,'2021-02-15 14:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (70,1,'testTask','renren',0,NULL,0,'2021-02-15 14:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (71,1,'testTask','renren',0,NULL,1,'2021-02-15 15:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (72,1,'testTask','renren',0,NULL,1,'2021-02-15 15:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (73,1,'testTask','renren',0,NULL,2,'2021-02-15 16:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (74,1,'testTask','renren',0,NULL,3,'2021-02-15 16:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (75,1,'testTask','renren',0,NULL,3,'2021-02-15 17:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (76,1,'testTask','renren',0,NULL,1,'2021-02-15 17:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (77,1,'testTask','renren',0,NULL,0,'2021-02-21 20:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (78,1,'testTask','renren',0,NULL,1,'2021-02-21 21:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (79,1,'testTask','renren',0,NULL,1,'2021-02-21 21:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (80,1,'testTask','renren',0,NULL,1,'2021-02-21 22:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (81,1,'testTask','renren',0,NULL,1,'2021-02-21 22:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (82,1,'testTask','renren',0,NULL,1,'2021-02-21 23:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (83,1,'testTask','renren',0,NULL,2,'2021-02-21 23:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (84,1,'testTask','renren',0,NULL,5,'2021-02-22 00:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (85,1,'testTask','renren',0,NULL,1,'2021-02-22 00:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (86,1,'testTask','renren',0,NULL,1,'2021-02-25 15:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (87,1,'testTask','renren',0,NULL,1,'2021-02-25 16:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (88,1,'testTask','renren',0,NULL,2,'2021-02-25 16:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (89,1,'testTask','renren',0,NULL,2,'2021-02-25 17:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (90,1,'testTask','renren',0,NULL,2,'2021-02-25 17:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (91,1,'testTask','renren',0,NULL,1,'2021-02-25 18:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (92,1,'testTask','renren',0,NULL,1,'2021-02-25 18:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (93,1,'testTask','renren',0,NULL,1,'2021-02-25 19:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (94,1,'testTask','renren',0,NULL,1,'2021-02-26 09:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (95,1,'testTask','renren',0,NULL,1,'2021-02-26 10:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (96,1,'testTask','renren',0,NULL,1,'2021-02-26 10:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (97,1,'testTask','renren',0,NULL,1,'2021-02-26 11:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (98,1,'testTask','renren',0,NULL,0,'2021-02-26 11:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (99,1,'testTask','renren',0,NULL,1,'2021-02-26 12:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (100,1,'testTask','renren',0,NULL,1,'2021-02-26 12:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (101,1,'testTask','renren',0,NULL,0,'2021-02-26 13:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (102,1,'testTask','renren',0,NULL,1,'2021-02-26 13:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (103,1,'testTask','renren',0,NULL,1,'2021-02-26 14:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (104,1,'testTask','renren',0,NULL,0,'2021-02-26 14:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (105,1,'testTask','renren',0,NULL,0,'2021-02-26 15:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (106,1,'testTask','renren',0,NULL,1,'2021-03-02 10:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (107,1,'testTask','renren',0,NULL,1,'2021-03-02 11:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (108,1,'testTask','renren',0,NULL,0,'2021-03-02 11:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (109,1,'testTask','renren',0,NULL,1,'2021-03-02 12:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (110,1,'testTask','renren',0,NULL,0,'2021-03-06 22:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (111,1,'testTask','renren',0,NULL,1,'2021-03-07 21:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (112,1,'testTask','renren',0,NULL,1,'2021-03-07 21:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (113,1,'testTask','renren',0,NULL,1,'2021-03-07 22:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (114,1,'testTask','renren',0,NULL,1,'2021-03-07 22:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (115,1,'testTask','renren',0,NULL,1,'2021-03-08 12:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (116,1,'testTask','renren',0,NULL,1,'2021-03-08 22:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (117,1,'testTask','renren',0,NULL,1,'2021-03-08 22:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (118,1,'testTask','renren',0,NULL,0,'2021-03-09 10:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (119,1,'testTask','renren',0,NULL,2,'2021-03-09 10:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (120,1,'testTask','renren',0,NULL,0,'2021-03-09 11:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (121,1,'testTask','renren',0,NULL,1,'2021-03-09 11:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (122,1,'testTask','renren',0,NULL,1,'2021-03-09 12:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (123,1,'testTask','renren',0,NULL,1,'2021-03-09 12:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (124,1,'testTask','renren',0,NULL,0,'2021-03-09 17:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (125,1,'testTask','renren',0,NULL,1,'2021-03-09 18:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (126,1,'testTask','renren',0,NULL,1,'2021-03-25 22:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (127,1,'testTask','renren',0,NULL,1,'2021-03-29 16:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (128,1,'testTask','renren',0,NULL,1,'2021-03-29 17:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (129,1,'testTask','renren',0,NULL,1,'2021-03-29 17:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (130,1,'testTask','renren',0,NULL,1,'2021-03-29 18:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (131,1,'testTask','renren',0,NULL,1,'2021-03-29 19:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (132,1,'testTask','renren',0,NULL,1,'2021-03-29 20:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (133,1,'testTask','renren',0,NULL,1,'2021-03-29 20:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (134,1,'testTask','renren',0,NULL,1,'2021-03-29 21:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (135,1,'testTask','renren',0,NULL,0,'2021-03-29 21:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (136,1,'testTask','renren',0,NULL,1,'2021-03-29 22:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (137,1,'testTask','renren',0,NULL,0,'2021-03-29 22:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (138,1,'testTask','renren',0,NULL,1,'2021-03-30 10:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (139,1,'testTask','renren',0,NULL,1,'2021-03-30 11:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (140,1,'testTask','renren',0,NULL,1,'2021-03-30 11:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (141,1,'testTask','renren',0,NULL,1,'2021-03-30 12:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (142,1,'testTask','renren',0,NULL,0,'2021-03-30 12:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (143,1,'testTask','renren',0,NULL,1,'2021-03-30 16:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (144,1,'testTask','renren',0,NULL,1,'2021-03-30 16:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (145,1,'testTask','renren',0,NULL,1,'2021-03-30 17:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (146,1,'testTask','renren',0,NULL,1,'2021-03-30 17:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (147,1,'testTask','renren',0,NULL,0,'2021-03-30 18:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (148,1,'testTask','renren',0,NULL,1,'2021-04-01 10:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (149,1,'testTask','renren',0,NULL,1,'2021-04-01 10:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (150,1,'testTask','renren',0,NULL,1,'2021-04-01 11:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (151,1,'testTask','renren',0,NULL,1,'2021-04-01 11:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (152,1,'testTask','renren',0,NULL,1,'2021-04-01 12:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (153,1,'testTask','renren',0,NULL,0,'2021-04-01 12:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (154,1,'testTask','renren',0,NULL,0,'2021-04-03 12:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (155,1,'testTask','renren',0,NULL,0,'2021-04-03 12:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (156,1,'testTask','renren',0,NULL,1,'2021-04-03 13:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (157,1,'testTask','renren',0,NULL,0,'2021-04-06 19:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (158,1,'testTask','renren',0,NULL,1,'2021-04-06 20:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (159,1,'testTask','renren',0,NULL,1,'2021-04-06 20:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (160,1,'testTask','renren',0,NULL,1,'2021-04-06 21:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (161,1,'testTask','renren',0,NULL,1,'2021-04-06 21:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (162,1,'testTask','renren',0,NULL,1,'2021-04-06 22:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (163,1,'testTask','renren',0,NULL,1,'2021-04-06 22:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (164,1,'testTask','renren',0,NULL,0,'2021-04-07 12:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (165,1,'testTask','renren',0,NULL,0,'2021-04-07 12:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (166,1,'testTask','renren',0,NULL,0,'2021-04-07 16:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (167,1,'testTask','renren',0,NULL,1,'2021-04-09 12:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (168,1,'testTask','renren',0,NULL,3,'2021-04-09 12:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (169,1,'testTask','renren',0,NULL,1,'2021-04-09 18:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (170,1,'testTask','renren',0,NULL,1,'2021-04-09 18:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (171,1,'testTask','renren',0,NULL,1,'2021-04-09 19:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (172,1,'testTask','renren',0,NULL,0,'2021-04-09 19:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (173,1,'testTask','renren',0,NULL,0,'2021-04-09 20:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (174,1,'testTask','renren',0,NULL,1,'2021-04-09 20:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (175,1,'testTask','renren',0,NULL,1,'2021-04-09 21:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (176,1,'testTask','renren',0,NULL,0,'2021-04-09 21:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (177,1,'testTask','renren',0,NULL,0,'2021-04-09 22:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (178,1,'testTask','renren',0,NULL,1,'2021-04-09 22:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (179,1,'testTask','renren',0,NULL,2,'2021-04-09 23:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (180,1,'testTask','renren',0,NULL,1,'2021-04-10 15:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (181,1,'testTask','renren',0,NULL,1,'2021-04-10 15:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (182,1,'testTask','renren',0,NULL,0,'2021-04-10 16:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (183,1,'testTask','renren',0,NULL,1,'2021-04-10 16:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (184,1,'testTask','renren',0,NULL,0,'2021-04-10 17:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (185,1,'testTask','renren',0,NULL,1,'2021-04-10 17:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (186,1,'testTask','renren',0,NULL,0,'2021-04-10 18:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (187,1,'testTask','renren',0,NULL,1,'2021-04-10 18:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (188,1,'testTask','renren',0,NULL,0,'2021-04-10 19:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (189,1,'testTask','renren',0,NULL,1,'2021-04-10 19:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (190,1,'testTask','renren',0,NULL,4,'2021-04-10 20:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (191,1,'testTask','renren',0,NULL,1,'2021-04-10 20:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (192,1,'testTask','renren',0,NULL,0,'2021-04-10 21:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (193,1,'testTask','renren',0,NULL,1,'2021-04-10 21:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (194,1,'testTask','renren',0,NULL,2,'2021-04-10 22:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (195,1,'testTask','renren',0,NULL,1,'2021-04-10 22:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (196,1,'testTask','renren',0,NULL,3,'2021-04-10 23:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (197,1,'testTask','renren',0,NULL,1,'2021-04-11 13:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (198,1,'testTask','renren',0,NULL,0,'2021-04-11 18:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (199,1,'testTask','renren',0,NULL,1,'2021-04-11 18:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (200,1,'testTask','renren',0,NULL,1,'2021-04-11 19:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (201,1,'testTask','renren',0,NULL,1,'2021-04-11 19:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (202,1,'testTask','renren',0,NULL,1,'2021-04-11 20:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (203,1,'testTask','renren',0,NULL,1,'2021-04-11 20:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (204,1,'testTask','renren',0,NULL,1,'2021-04-11 21:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (205,1,'testTask','renren',0,NULL,1,'2021-04-11 21:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (206,1,'testTask','renren',0,NULL,1,'2021-04-11 22:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (207,1,'testTask','renren',0,NULL,0,'2021-04-11 22:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (208,1,'testTask','renren',0,NULL,1,'2021-04-12 16:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (209,1,'testTask','renren',0,NULL,2,'2021-04-12 17:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (210,1,'testTask','renren',0,NULL,0,'2021-04-12 17:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (211,1,'testTask','renren',0,NULL,1,'2021-04-12 18:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (212,1,'testTask','renren',0,NULL,0,'2021-04-12 18:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (213,1,'testTask','renren',0,NULL,0,'2021-04-13 10:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (214,1,'testTask','renren',0,NULL,0,'2021-04-13 11:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (215,1,'testTask','renren',0,NULL,1,'2021-04-13 11:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (216,1,'testTask','renren',0,NULL,0,'2021-04-13 12:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (217,1,'testTask','renren',0,NULL,2,'2021-04-13 12:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (218,1,'testTask','renren',0,NULL,1,'2021-04-13 15:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (219,1,'testTask','renren',0,NULL,2,'2021-04-13 15:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (220,1,'testTask','renren',0,NULL,1,'2021-04-13 16:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (221,1,'testTask','renren',0,NULL,1,'2021-04-13 16:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (222,1,'testTask','renren',0,NULL,0,'2021-04-13 17:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (223,1,'testTask','renren',0,NULL,1,'2021-04-13 17:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (224,1,'testTask','renren',0,NULL,98,'2021-04-13 18:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (225,1,'testTask','renren',0,NULL,1,'2021-04-13 18:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (226,1,'testTask','renren',0,NULL,0,'2021-04-13 19:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (227,1,'testTask','renren',0,NULL,0,'2021-04-13 19:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (228,1,'testTask','renren',0,NULL,1,'2021-04-13 20:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (229,1,'testTask','renren',0,NULL,0,'2021-04-13 20:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (230,1,'testTask','renren',0,NULL,1,'2021-04-13 21:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (231,1,'testTask','renren',0,NULL,0,'2021-04-13 21:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (232,1,'testTask','renren',0,NULL,1,'2021-04-13 22:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (233,1,'testTask','renren',0,NULL,1,'2021-04-13 22:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (234,1,'testTask','renren',0,NULL,0,'2021-05-01 16:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (235,1,'testTask','renren',0,NULL,1,'2021-05-01 17:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (236,1,'testTask','renren',0,NULL,1,'2021-05-01 17:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (237,1,'testTask','renren',0,NULL,1,'2021-05-01 18:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (238,1,'testTask','renren',0,NULL,1,'2021-05-01 18:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (239,1,'testTask','renren',0,NULL,1,'2021-05-01 19:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (240,1,'testTask','renren',0,NULL,1,'2021-05-01 19:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (241,1,'testTask','renren',0,NULL,1,'2021-05-01 20:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (242,1,'testTask','renren',0,NULL,1,'2021-05-01 20:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (243,1,'testTask','renren',0,NULL,1,'2021-05-01 21:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (244,1,'testTask','renren',0,NULL,1,'2021-05-01 21:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (245,1,'testTask','renren',0,NULL,1,'2021-05-01 22:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (246,1,'testTask','renren',0,NULL,1,'2021-05-01 22:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (247,1,'testTask','renren',0,NULL,1,'2021-05-01 23:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (248,1,'testTask','renren',0,NULL,1,'2021-05-01 23:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (249,1,'testTask','renren',0,NULL,6,'2021-05-02 00:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (250,1,'testTask','renren',0,NULL,2,'2021-05-02 00:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (251,1,'testTask','renren',0,NULL,1,'2021-05-02 01:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (252,1,'testTask','renren',0,NULL,1,'2021-05-02 01:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (253,1,'testTask','renren',0,NULL,0,'2021-05-02 02:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (254,1,'testTask','renren',0,NULL,1,'2021-05-02 02:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (255,1,'testTask','renren',0,NULL,1,'2021-05-02 03:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (256,1,'testTask','renren',0,NULL,0,'2021-05-02 03:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (257,1,'testTask','renren',0,NULL,1,'2021-05-02 04:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (258,1,'testTask','renren',0,NULL,1,'2021-05-02 04:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (259,1,'testTask','renren',0,NULL,1,'2021-05-02 05:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (260,1,'testTask','renren',0,NULL,1,'2021-05-02 05:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (261,1,'testTask','renren',0,NULL,1,'2021-05-02 06:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (262,1,'testTask','renren',0,NULL,1,'2021-05-02 06:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (263,1,'testTask','renren',0,NULL,1,'2021-05-02 07:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (264,1,'testTask','renren',0,NULL,1,'2021-05-02 07:30:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (265,1,'testTask','renren',0,NULL,1,'2021-05-02 08:00:00');
insert  into `schedule_job_log`(`log_id`,`job_id`,`bean_name`,`params`,`status`,`error`,`times`,`create_time`) values (266,1,'testTask','renren',0,NULL,0,'2021-05-02 08:30:00');

/*Table structure for table `sms_coupon` */

CREATE TABLE `sms_coupon` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `coupon_type` tinyint(1) DEFAULT NULL COMMENT '优惠卷类型[0->全场赠券；1->会员赠券；2->购物赠券；3->注册赠券]',
  `coupon_img` varchar(2000) DEFAULT NULL COMMENT '优惠券图片',
  `coupon_name` varchar(100) DEFAULT NULL COMMENT '优惠卷名字',
  `num` int(11) DEFAULT NULL COMMENT '数量',
  `amount` decimal(18,4) DEFAULT NULL COMMENT '金额',
  `per_limit` int(11) DEFAULT NULL COMMENT '每人限领张数',
  `min_point` decimal(18,4) DEFAULT NULL COMMENT '使用门槛',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `use_type` tinyint(1) DEFAULT NULL COMMENT '使用类型[0->全场通用；1->指定分类；2->指定商品]',
  `note` varchar(200) DEFAULT NULL COMMENT '备注',
  `publish_count` int(11) DEFAULT NULL COMMENT '发行数量',
  `use_count` int(11) DEFAULT NULL COMMENT '已使用数量',
  `receive_count` int(11) DEFAULT NULL COMMENT '领取数量',
  `enable_start_time` datetime DEFAULT NULL COMMENT '可以领取的开始日期',
  `enable_end_time` datetime DEFAULT NULL COMMENT '可以领取的结束日期',
  `code` varchar(64) DEFAULT NULL COMMENT '优惠码',
  `member_level` tinyint(1) DEFAULT NULL COMMENT '可以领取的会员等级[0->不限等级，其他-对应等级]',
  `publish` tinyint(1) DEFAULT NULL COMMENT '发布状态[0-未发布，1-已发布]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='优惠券信息';

/*Data for the table `sms_coupon` */

/*Table structure for table `sms_coupon_history` */

CREATE TABLE `sms_coupon_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `coupon_id` bigint(20) DEFAULT NULL COMMENT '优惠券id',
  `member_id` bigint(20) DEFAULT NULL COMMENT '会员id',
  `member_nick_name` varchar(64) DEFAULT NULL COMMENT '会员名字',
  `get_type` tinyint(1) DEFAULT NULL COMMENT '获取方式[0->后台赠送；1->主动领取]',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `use_type` tinyint(1) DEFAULT NULL COMMENT '使用状态[0->未使用；1->已使用；2->已过期]',
  `use_time` datetime DEFAULT NULL COMMENT '使用时间',
  `order_id` bigint(20) DEFAULT NULL COMMENT '订单id',
  `order_sn` bigint(20) DEFAULT NULL COMMENT '订单号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='优惠券领取历史记录';

/*Data for the table `sms_coupon_history` */

/*Table structure for table `sms_coupon_spu_category_relation` */

CREATE TABLE `sms_coupon_spu_category_relation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `coupon_id` bigint(20) DEFAULT NULL COMMENT '优惠券id',
  `category_id` bigint(20) DEFAULT NULL COMMENT '产品分类id',
  `category_name` varchar(64) DEFAULT NULL COMMENT '产品分类名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='优惠券分类关联';

/*Data for the table `sms_coupon_spu_category_relation` */

/*Table structure for table `sms_coupon_spu_relation` */

CREATE TABLE `sms_coupon_spu_relation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `coupon_id` bigint(20) DEFAULT NULL COMMENT '优惠券id',
  `spu_id` bigint(20) DEFAULT NULL COMMENT 'spu_id',
  `spu_name` varchar(255) DEFAULT NULL COMMENT 'spu_name',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='优惠券与产品关联';

/*Data for the table `sms_coupon_spu_relation` */

/*Table structure for table `sms_home_adv` */

CREATE TABLE `sms_home_adv` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(100) DEFAULT NULL COMMENT '名字',
  `pic` varchar(500) DEFAULT NULL COMMENT '图片地址',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `status` tinyint(1) DEFAULT NULL COMMENT '状态',
  `click_count` int(11) DEFAULT NULL COMMENT '点击数',
  `url` varchar(500) DEFAULT NULL COMMENT '广告详情连接地址',
  `note` varchar(500) DEFAULT NULL COMMENT '备注',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `publisher_id` bigint(20) DEFAULT NULL COMMENT '发布者',
  `auth_id` bigint(20) DEFAULT NULL COMMENT '审核者',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='首页轮播广告';

/*Data for the table `sms_home_adv` */

/*Table structure for table `sms_home_subject` */

CREATE TABLE `sms_home_subject` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(200) DEFAULT NULL COMMENT '专题名字',
  `title` varchar(255) DEFAULT NULL COMMENT '专题标题',
  `sub_title` varchar(255) DEFAULT NULL COMMENT '专题副标题',
  `status` tinyint(1) DEFAULT NULL COMMENT '显示状态',
  `url` varchar(500) DEFAULT NULL COMMENT '详情连接',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `img` varchar(500) DEFAULT NULL COMMENT '专题图片地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='首页专题表【jd首页下面很多专题，每个专题链接新的页面，展示专题商品信息】';

/*Data for the table `sms_home_subject` */

/*Table structure for table `sms_home_subject_spu` */

CREATE TABLE `sms_home_subject_spu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(200) DEFAULT NULL COMMENT '专题名字',
  `subject_id` bigint(20) DEFAULT NULL COMMENT '专题id',
  `spu_id` bigint(20) DEFAULT NULL COMMENT 'spu_id',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='专题商品';

/*Data for the table `sms_home_subject_spu` */

/*Table structure for table `sms_member_price` */

CREATE TABLE `sms_member_price` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `sku_id` bigint(20) DEFAULT NULL COMMENT 'sku_id',
  `member_level_id` bigint(20) DEFAULT NULL COMMENT '会员等级id',
  `member_level_name` varchar(100) DEFAULT NULL COMMENT '会员等级名',
  `member_price` decimal(18,4) DEFAULT NULL COMMENT '会员对应价格',
  `add_other` tinyint(1) DEFAULT NULL COMMENT '可否叠加其他优惠[0-不可叠加优惠，1-可叠加]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COMMENT='商品会员价格';

/*Data for the table `sms_member_price` */

insert  into `sms_member_price`(`id`,`sku_id`,`member_level_id`,`member_level_name`,`member_price`,`add_other`) values (58,NULL,1368562119284379600,'白银会员','7599.0000',NULL);
insert  into `sms_member_price`(`id`,`sku_id`,`member_level_id`,`member_level_name`,`member_price`,`add_other`) values (59,NULL,1368562348935106600,'黄金等级','7579.0000',NULL);
insert  into `sms_member_price`(`id`,`sku_id`,`member_level_id`,`member_level_name`,`member_price`,`add_other`) values (60,NULL,1368562490971017200,'砖石等级','7499.0000',NULL);

/*Table structure for table `sms_seckill_promotion` */

CREATE TABLE `sms_seckill_promotion` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `title` varchar(255) DEFAULT NULL COMMENT '活动标题',
  `start_time` datetime DEFAULT NULL COMMENT '开始日期',
  `end_time` datetime DEFAULT NULL COMMENT '结束日期',
  `status` tinyint(4) DEFAULT NULL COMMENT '上下线状态',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `user_id` bigint(20) DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='秒杀活动';

/*Data for the table `sms_seckill_promotion` */

/*Table structure for table `sms_seckill_session` */

CREATE TABLE `sms_seckill_session` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(200) DEFAULT NULL COMMENT '场次名称',
  `start_time` datetime DEFAULT NULL COMMENT '每日开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '每日结束时间',
  `status` tinyint(1) DEFAULT NULL COMMENT '启用状态',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='秒杀活动场次';

/*Data for the table `sms_seckill_session` */

insert  into `sms_seckill_session`(`id`,`name`,`start_time`,`end_time`,`status`,`create_time`) values (1,'10点场','2021-05-03 02:00:00','2021-05-03 03:00:00',1,'2021-05-01 08:29:38');
insert  into `sms_seckill_session`(`id`,`name`,`start_time`,`end_time`,`status`,`create_time`) values (2,'12点场','2021-05-03 03:00:00','2021-05-03 05:00:00',1,'2021-05-01 08:30:23');
insert  into `sms_seckill_session`(`id`,`name`,`start_time`,`end_time`,`status`,`create_time`) values (3,'19点场','2021-05-03 10:00:00','2021-05-04 23:00:00',1,'2021-05-02 19:25:19');

/*Table structure for table `sms_seckill_sku_notice` */

CREATE TABLE `sms_seckill_sku_notice` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `member_id` bigint(20) DEFAULT NULL COMMENT 'member_id',
  `sku_id` bigint(20) DEFAULT NULL COMMENT 'sku_id',
  `session_id` bigint(20) DEFAULT NULL COMMENT '活动场次id',
  `subcribe_time` datetime DEFAULT NULL COMMENT '订阅时间',
  `send_time` datetime DEFAULT NULL COMMENT '发送时间',
  `notice_type` tinyint(1) DEFAULT NULL COMMENT '通知方式[0-短信，1-邮件]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='秒杀商品通知订阅';

/*Data for the table `sms_seckill_sku_notice` */

/*Table structure for table `sms_seckill_sku_relation` */

CREATE TABLE `sms_seckill_sku_relation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `promotion_id` bigint(20) DEFAULT NULL COMMENT '活动id',
  `promotion_session_id` bigint(20) DEFAULT NULL COMMENT '活动场次id',
  `sku_id` bigint(20) DEFAULT NULL COMMENT '商品id',
  `seckill_price` decimal(10,0) DEFAULT NULL COMMENT '秒杀价格',
  `seckill_count` decimal(10,0) DEFAULT NULL COMMENT '秒杀总量',
  `seckill_limit` decimal(10,0) DEFAULT NULL COMMENT '每人限购数量',
  `seckill_sort` int(11) DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='秒杀活动商品关联';

/*Data for the table `sms_seckill_sku_relation` */

insert  into `sms_seckill_sku_relation`(`id`,`promotion_id`,`promotion_session_id`,`sku_id`,`seckill_price`,`seckill_count`,`seckill_limit`,`seckill_sort`) values (1,1,1,24,'1','1','1',1);
insert  into `sms_seckill_sku_relation`(`id`,`promotion_id`,`promotion_session_id`,`sku_id`,`seckill_price`,`seckill_count`,`seckill_limit`,`seckill_sort`) values (2,2,2,27,'2','2','2',2);
insert  into `sms_seckill_sku_relation`(`id`,`promotion_id`,`promotion_session_id`,`sku_id`,`seckill_price`,`seckill_count`,`seckill_limit`,`seckill_sort`) values (3,3,3,24,'1','22','1',3);
insert  into `sms_seckill_sku_relation`(`id`,`promotion_id`,`promotion_session_id`,`sku_id`,`seckill_price`,`seckill_count`,`seckill_limit`,`seckill_sort`) values (4,3,3,25,'1000','10','1',4);

/*Table structure for table `sms_sku_full_reduction` */

CREATE TABLE `sms_sku_full_reduction` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `sku_id` bigint(20) DEFAULT NULL COMMENT 'spu_id',
  `full_price` decimal(18,4) DEFAULT NULL COMMENT '满多少',
  `reduce_price` decimal(18,4) DEFAULT NULL COMMENT '减多少',
  `add_other` tinyint(1) DEFAULT NULL COMMENT '是否参与其他优惠',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品满减信息';

/*Data for the table `sms_sku_full_reduction` */

/*Table structure for table `sms_sku_ladder` */

CREATE TABLE `sms_sku_ladder` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `sku_id` bigint(20) DEFAULT NULL COMMENT 'spu_id',
  `full_count` int(11) DEFAULT NULL COMMENT '满几件',
  `discount` decimal(4,2) DEFAULT NULL COMMENT '打几折',
  `price` decimal(18,4) DEFAULT NULL COMMENT '折后价',
  `add_other` tinyint(1) DEFAULT NULL COMMENT '是否叠加其他优惠[0-不可叠加，1-可叠加]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品阶梯价格';

/*Data for the table `sms_sku_ladder` */

/*Table structure for table `sms_spu_bounds` */

CREATE TABLE `sms_spu_bounds` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `spu_id` bigint(20) DEFAULT NULL,
  `grow_bounds` decimal(18,4) DEFAULT NULL COMMENT '成长积分',
  `buy_bounds` decimal(18,4) DEFAULT NULL COMMENT '购物积分',
  `work` tinyint(1) DEFAULT NULL COMMENT '优惠生效情况[1111（四个状态位，从右到左）;0 - 无优惠，成长积分是否赠送;1 - 无优惠，购物积分是否赠送;2 - 有优惠，成长积分是否赠送;3 - 有优惠，购物积分是否赠送【状态位0：不赠送，1：赠送】]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COMMENT='商品spu积分设置';

/*Data for the table `sms_spu_bounds` */

insert  into `sms_spu_bounds`(`id`,`spu_id`,`grow_bounds`,`buy_bounds`,`work`) values (6,9,'100.0000','40.0000',NULL);
insert  into `sms_spu_bounds`(`id`,`spu_id`,`grow_bounds`,`buy_bounds`,`work`) values (7,10,'120.0000','40.0000',NULL);

/*Table structure for table `sys_captcha` */

CREATE TABLE `sys_captcha` (
  `uuid` char(36) NOT NULL COMMENT 'uuid',
  `code` varchar(6) NOT NULL COMMENT '验证码',
  `expire_time` datetime DEFAULT NULL COMMENT '过期时间',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统验证码';

/*Data for the table `sys_captcha` */

insert  into `sys_captcha`(`uuid`,`code`,`expire_time`) values ('027f016a-2f08-4697-841a-6ba4e8cc10b7','p468p','2021-02-15 13:47:21');
insert  into `sys_captcha`(`uuid`,`code`,`expire_time`) values ('2c6ab965-d7ba-4b10-82c9-b32f53aafe49','dfpxn','2021-03-07 22:21:27');
insert  into `sys_captcha`(`uuid`,`code`,`expire_time`) values ('35a6d7ef-6f27-4f41-8e1e-897a086ba7c7','4ap48','2021-02-03 23:34:34');
insert  into `sys_captcha`(`uuid`,`code`,`expire_time`) values ('4dbbcbf7-a317-4f61-8b4c-30accf07b840','6ewpm','2021-03-30 10:29:52');
insert  into `sys_captcha`(`uuid`,`code`,`expire_time`) values ('5e7a8f96-5634-44f2-8212-3d653a242e06','p8f2g','2021-02-03 20:20:47');
insert  into `sys_captcha`(`uuid`,`code`,`expire_time`) values ('66b69921-04a0-4c0a-8c44-511f067c1a52','2xa58','2021-03-07 22:19:35');
insert  into `sys_captcha`(`uuid`,`code`,`expire_time`) values ('730ac011-b749-4616-8970-aa8e2d556a95','gm77x','2021-02-03 23:34:53');
insert  into `sys_captcha`(`uuid`,`code`,`expire_time`) values ('9b7798d8-2250-41f7-8813-1c064fc8c27c','ypm6e','2021-02-12 15:09:48');
insert  into `sys_captcha`(`uuid`,`code`,`expire_time`) values ('a2b13855-2757-4d49-842d-16bc93e531ac','5xwbp','2021-03-07 22:25:45');
insert  into `sys_captcha`(`uuid`,`code`,`expire_time`) values ('a5a90b0d-a1d2-4a95-8330-b8f7bf9a6f80','ap7x6','2021-03-07 22:31:37');
insert  into `sys_captcha`(`uuid`,`code`,`expire_time`) values ('df10d4e1-7163-47e5-8381-ed399dfb5e32','pemwg','2021-04-04 23:02:15');
insert  into `sys_captcha`(`uuid`,`code`,`expire_time`) values ('eb04b0ba-0f84-49b9-8376-6172ef522575','7e2an','2021-04-06 22:18:53');
insert  into `sys_captcha`(`uuid`,`code`,`expire_time`) values ('fa72f1e2-7451-42ca-881e-0d91b6aaefd6','mgxcd','2021-05-01 16:11:55');

/*Table structure for table `sys_config` */

CREATE TABLE `sys_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `param_key` varchar(50) DEFAULT NULL COMMENT 'key',
  `param_value` varchar(2000) DEFAULT NULL COMMENT 'value',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态   0：隐藏   1：显示',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `param_key` (`param_key`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='系统配置信息表';

/*Data for the table `sys_config` */

insert  into `sys_config`(`id`,`param_key`,`param_value`,`status`,`remark`) values (1,'CLOUD_STORAGE_CONFIG_KEY','{\"aliyunAccessKeyId\":\"\",\"aliyunAccessKeySecret\":\"\",\"aliyunBucketName\":\"\",\"aliyunDomain\":\"\",\"aliyunEndPoint\":\"\",\"aliyunPrefix\":\"\",\"qcloudBucketName\":\"\",\"qcloudDomain\":\"\",\"qcloudPrefix\":\"\",\"qcloudSecretId\":\"\",\"qcloudSecretKey\":\"\",\"qiniuAccessKey\":\"NrgMfABZxWLo5B-YYSjoE8-AZ1EISdi1Z3ubLOeZ\",\"qiniuBucketName\":\"ios-app\",\"qiniuDomain\":\"http://7xqbwh.dl1.z0.glb.clouddn.com\",\"qiniuPrefix\":\"upload\",\"qiniuSecretKey\":\"uIwJHevMRWU0VLxFvgy0tAcOdGqasdtVlJkdy6vV\",\"type\":1}',0,'云存储配置信息');

/*Table structure for table `sys_log` */

CREATE TABLE `sys_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL COMMENT '用户名',
  `operation` varchar(50) DEFAULT NULL COMMENT '用户操作',
  `method` varchar(200) DEFAULT NULL COMMENT '请求方法',
  `params` varchar(5000) DEFAULT NULL COMMENT '请求参数',
  `time` bigint(20) NOT NULL COMMENT '执行时长(毫秒)',
  `ip` varchar(64) DEFAULT NULL COMMENT 'IP地址',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COMMENT='系统日志';

/*Data for the table `sys_log` */

insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (1,'admin','保存菜单','io.renren.modules.sys.controller.SysMenuController.save()','[{\"menuId\":31,\"parentId\":0,\"name\":\"商品管理\",\"url\":\"\",\"perms\":\"\",\"type\":0,\"icon\":\"sousuo\",\"orderNum\":0}]',10,'0:0:0:0:0:0:0:1','2021-02-03 10:35:42');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (2,'admin','保存菜单','io.renren.modules.sys.controller.SysMenuController.save()','[{\"menuId\":32,\"parentId\":31,\"name\":\"商品分类管理\",\"url\":\"product/category\",\"perms\":\"\",\"type\":1,\"icon\":\"menu\",\"orderNum\":0}]',5,'0:0:0:0:0:0:0:1','2021-02-03 10:36:43');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (3,'admin','保存菜单','io.renren.modules.sys.controller.SysMenuController.save()','[{\"menuId\":33,\"parentId\":31,\"name\":\"广告管理\",\"url\":\"/product/banner\",\"perms\":\"\",\"type\":1,\"icon\":\"menu\",\"orderNum\":0}]',6,'0:0:0:0:0:0:0:1','2021-02-03 21:12:09');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (4,'admin','修改菜单','io.renren.modules.sys.controller.SysMenuController.update()','[{\"menuId\":33,\"parentId\":31,\"name\":\"商品广告管理\",\"url\":\"/product/banner\",\"perms\":\"\",\"type\":1,\"icon\":\"menu\",\"orderNum\":0}]',10,'0:0:0:0:0:0:0:1','2021-02-03 23:44:31');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (5,'admin','保存菜单','io.renren.modules.sys.controller.SysMenuController.save()','[{\"menuId\":34,\"parentId\":31,\"name\":\"商品品牌管理\",\"url\":\"product/brand\",\"perms\":\"\",\"type\":1,\"icon\":\"editor\",\"orderNum\":0}]',9,'0:0:0:0:0:0:0:1','2021-02-04 09:48:13');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (6,'admin','保存菜单','io.renren.modules.sys.controller.SysMenuController.save()','[{\"menuId\":35,\"parentId\":31,\"name\":\"商品属性管理\",\"url\":\"product/attr\",\"perms\":\"\",\"type\":1,\"icon\":\"menu\",\"orderNum\":0}]',4,'0:0:0:0:0:0:0:1','2021-02-04 09:49:57');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (7,'admin','保存菜单','io.renren.modules.sys.controller.SysMenuController.save()','[{\"menuId\":36,\"parentId\":31,\"name\":\"商品属性组管理\",\"url\":\"product/attrgroup\",\"perms\":\"\",\"type\":1,\"icon\":\"menu\",\"orderNum\":0}]',6,'0:0:0:0:0:0:0:1','2021-02-04 11:16:20');
insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (8,'admin','保存菜单','io.renren.modules.sys.controller.SysMenuController.save()','[{\"menuId\":76,\"parentId\":31,\"name\":\"广告面板\",\"url\":\"/product/banner\",\"perms\":\"\",\"type\":1,\"icon\":\"menu\",\"orderNum\":0}]',7,'0:0:0:0:0:0:0:1','2021-02-05 11:25:02');

/*Table structure for table `sys_menu` */

CREATE TABLE `sys_menu` (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父菜单ID，一级菜单为0',
  `name` varchar(50) DEFAULT NULL COMMENT '菜单名称',
  `url` varchar(200) DEFAULT NULL COMMENT '菜单URL',
  `perms` varchar(500) DEFAULT NULL COMMENT '授权(多个用逗号分隔，如：user:list,user:create)',
  `type` int(11) DEFAULT NULL COMMENT '类型   0：目录   1：菜单   2：按钮',
  `icon` varchar(50) DEFAULT NULL COMMENT '菜单图标',
  `order_num` int(11) DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COMMENT='菜单管理';

/*Data for the table `sys_menu` */

insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (1,0,'系统管理',NULL,NULL,0,'system',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (2,1,'管理员列表','sys/user',NULL,1,'admin',1);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (3,1,'角色管理','sys/role',NULL,1,'role',2);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (4,1,'菜单管理','sys/menu',NULL,1,'menu',3);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (5,1,'SQL监控','http://localhost:8080/renren-fast/druid/sql.html',NULL,1,'sql',4);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (6,1,'定时任务','job/schedule',NULL,1,'job',5);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (7,6,'查看',NULL,'sys:schedule:list,sys:schedule:info',2,NULL,0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (8,6,'新增',NULL,'sys:schedule:save',2,NULL,0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (9,6,'修改',NULL,'sys:schedule:update',2,NULL,0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (10,6,'删除',NULL,'sys:schedule:delete',2,NULL,0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (11,6,'暂停',NULL,'sys:schedule:pause',2,NULL,0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (12,6,'恢复',NULL,'sys:schedule:resume',2,NULL,0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (13,6,'立即执行',NULL,'sys:schedule:run',2,NULL,0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (14,6,'日志列表',NULL,'sys:schedule:log',2,NULL,0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (15,2,'查看',NULL,'sys:user:list,sys:user:info',2,NULL,0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (16,2,'新增',NULL,'sys:user:save,sys:role:select',2,NULL,0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (17,2,'修改',NULL,'sys:user:update,sys:role:select',2,NULL,0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (18,2,'删除',NULL,'sys:user:delete',2,NULL,0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (19,3,'查看',NULL,'sys:role:list,sys:role:info',2,NULL,0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (20,3,'新增',NULL,'sys:role:save,sys:menu:list',2,NULL,0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (21,3,'修改',NULL,'sys:role:update,sys:menu:list',2,NULL,0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (22,3,'删除',NULL,'sys:role:delete',2,NULL,0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (23,4,'查看',NULL,'sys:menu:list,sys:menu:info',2,NULL,0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (24,4,'新增',NULL,'sys:menu:save,sys:menu:select',2,NULL,0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (25,4,'修改',NULL,'sys:menu:update,sys:menu:select',2,NULL,0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (26,4,'删除',NULL,'sys:menu:delete',2,NULL,0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (27,1,'参数管理','sys/config','sys:config:list,sys:config:info,sys:config:save,sys:config:update,sys:config:delete',1,'config',6);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (29,1,'系统日志','sys/log','sys:log:list',1,'log',7);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (30,1,'文件上传','oss/oss','sys:oss:all',1,'oss',6);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (31,0,'商品系统','','',0,'editor',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (32,31,'分类维护','product/category','',1,'menu',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (34,31,'品牌管理','product/brand','',1,'editor',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (37,31,'平台属性','','',0,'system',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (38,37,'属性分组','product/attrgroup','',1,'tubiao',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (39,37,'规格参数','product/baseattr','',1,'log',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (40,37,'销售属性','product/saleattr','',1,'zonghe',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (41,31,'商品维护','product/spu','',0,'zonghe',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (42,0,'优惠营销','','',0,'mudedi',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (43,0,'库存系统','','',0,'shouye',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (44,0,'订单系统','','',0,'config',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (45,0,'用户系统','','',0,'admin',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (46,0,'内容管理','','',0,'sousuo',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (47,42,'优惠券管理','coupon/coupon','',1,'zhedie',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (48,42,'发放记录','coupon/history','',1,'sql',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (49,42,'专题活动','coupon/subject','',1,'tixing',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (50,42,'秒杀活动','coupon/seckill','',1,'daohang',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (51,42,'积分维护','coupon/bounds','',1,'geren',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (52,42,'满减折扣','coupon/full','',1,'shoucang',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (53,43,'仓库维护','ware/wareinfo','',1,'shouye',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (54,43,'库存工作单','ware/task','',1,'log',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (55,43,'商品库存','ware/sku','',1,'jiesuo',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (56,44,'订单查询','order/order','',1,'zhedie',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (57,44,'退货单处理','order/return','',1,'shanchu',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (58,44,'等级规则','order/settings','',1,'system',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (59,44,'支付流水查询','order/payment','',1,'job',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (60,44,'退款流水查询','order/refund','',1,'mudedi',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (61,45,'会员列表','member/member','',1,'geren',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (62,45,'会员等级','member/level','',1,'tubiao',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (63,45,'积分变化','member/growth','',1,'bianji',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (64,45,'统计信息','member/statistics','',1,'sql',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (65,46,'首页推荐','content/index','',1,'shouye',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (66,46,'分类热门','content/category','',1,'zhedie',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (67,46,'评论管理','content/comments','',1,'pinglun',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (68,41,'spu管理','product/spu','',1,'config',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (69,41,'发布商品','product/spuadd','',1,'bianji',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (70,43,'采购单维护','','',0,'tubiao',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (71,70,'采购需求','ware/purchaseitem','',1,'editor',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (72,70,'采购单','ware/purchase','',1,'menu',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (73,41,'商品管理','product/manager','',1,'zonghe',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (74,42,'会员价格','coupon/memberprice','',1,'admin',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (75,42,'每日秒杀','coupon/seckillsession','',1,'job',0);
insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (76,31,'广告面板','/product/banner','',1,'menu',0);

/*Table structure for table `sys_oss` */

CREATE TABLE `sys_oss` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `url` varchar(200) DEFAULT NULL COMMENT 'URL地址',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='文件上传';

/*Data for the table `sys_oss` */

/*Table structure for table `sys_role` */

CREATE TABLE `sys_role` (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(100) DEFAULT NULL COMMENT '角色名称',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建者ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色';

/*Data for the table `sys_role` */

/*Table structure for table `sys_role_menu` */

CREATE TABLE `sys_role_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
  `menu_id` bigint(20) DEFAULT NULL COMMENT '菜单ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色与菜单对应关系';

/*Data for the table `sys_role_menu` */

/*Table structure for table `sys_user` */

CREATE TABLE `sys_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(100) DEFAULT NULL COMMENT '密码',
  `salt` varchar(20) DEFAULT NULL COMMENT '盐',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `mobile` varchar(100) DEFAULT NULL COMMENT '手机号',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态  0：禁用   1：正常',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建者ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='系统用户';

/*Data for the table `sys_user` */

insert  into `sys_user`(`user_id`,`username`,`password`,`salt`,`email`,`mobile`,`status`,`create_user_id`,`create_time`) values (1,'admin','9ec9750e709431dad22365cabc5c625482e574c74adaebba7dd02f1129e4ce1d','YzcmCZNvbXocrsz9dm8e','root@renren.io','13612345678',1,1,'2016-11-11 11:11:11');

/*Table structure for table `sys_user_role` */

CREATE TABLE `sys_user_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户与角色对应关系';

/*Data for the table `sys_user_role` */

/*Table structure for table `sys_user_token` */

CREATE TABLE `sys_user_token` (
  `user_id` bigint(20) NOT NULL,
  `token` varchar(100) NOT NULL COMMENT 'token',
  `expire_time` datetime DEFAULT NULL COMMENT '过期时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统用户Token';

/*Data for the table `sys_user_token` */

insert  into `sys_user_token`(`user_id`,`token`,`expire_time`,`update_time`) values (1,'4094f266e8891fba784e447cea99ca63','2021-05-02 04:07:03','2021-05-01 16:07:03');

/*Table structure for table `tb_user` */

CREATE TABLE `tb_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `mobile` varchar(20) NOT NULL COMMENT '手机号',
  `password` varchar(64) DEFAULT NULL COMMENT '密码',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='用户';

/*Data for the table `tb_user` */

insert  into `tb_user`(`user_id`,`username`,`mobile`,`password`,`create_time`) values (1,'mark','13612345678','8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918','2017-03-23 22:37:41');

/*Table structure for table `ums_growth_change_history` */

CREATE TABLE `ums_growth_change_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `member_id` bigint(20) DEFAULT NULL COMMENT 'member_id',
  `create_time` datetime DEFAULT NULL COMMENT 'create_time',
  `change_count` int(11) DEFAULT NULL COMMENT '改变的值（正负计数）',
  `note` varchar(0) DEFAULT NULL COMMENT '备注',
  `source_type` tinyint(4) DEFAULT NULL COMMENT '积分来源[0-购物，1-管理员修改]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='成长值变化历史记录';

/*Data for the table `ums_growth_change_history` */

/*Table structure for table `ums_integration_change_history` */

CREATE TABLE `ums_integration_change_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `member_id` bigint(20) DEFAULT NULL COMMENT 'member_id',
  `create_time` datetime DEFAULT NULL COMMENT 'create_time',
  `change_count` int(11) DEFAULT NULL COMMENT '变化的值',
  `note` varchar(255) DEFAULT NULL COMMENT '备注',
  `source_tyoe` tinyint(4) DEFAULT NULL COMMENT '来源[0->购物；1->管理员修改;2->活动]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='积分变化历史记录';

/*Data for the table `ums_integration_change_history` */

/*Table structure for table `ums_member` */

CREATE TABLE `ums_member` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `level_id` bigint(20) DEFAULT NULL COMMENT '会员等级id',
  `username` char(64) DEFAULT NULL COMMENT '用户名',
  `password` varchar(64) DEFAULT NULL COMMENT '密码',
  `nickname` varchar(64) DEFAULT NULL COMMENT '昵称',
  `mobile` varchar(20) DEFAULT NULL COMMENT '手机号码',
  `email` varchar(64) DEFAULT NULL COMMENT '邮箱',
  `header` varchar(500) DEFAULT NULL COMMENT '头像',
  `gender` tinyint(4) DEFAULT NULL COMMENT '性别',
  `birth` date DEFAULT NULL COMMENT '生日',
  `city` varchar(500) DEFAULT NULL COMMENT '所在城市',
  `job` varchar(255) DEFAULT NULL COMMENT '职业',
  `sign` varchar(255) DEFAULT NULL COMMENT '个性签名',
  `source_type` tinyint(4) DEFAULT NULL COMMENT '用户来源',
  `integration` int(11) DEFAULT NULL COMMENT '积分',
  `growth` int(11) DEFAULT NULL COMMENT '成长值',
  `status` tinyint(4) DEFAULT NULL COMMENT '启用状态',
  `create_time` datetime DEFAULT NULL COMMENT '注册时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1383046426916814850 DEFAULT CHARSET=utf8mb4 COMMENT='会员';

/*Data for the table `ums_member` */

insert  into `ums_member`(`id`,`level_id`,`username`,`password`,`nickname`,`mobile`,`email`,`header`,`gender`,`birth`,`city`,`job`,`sign`,`source_type`,`integration`,`growth`,`status`,`create_time`) values (1383046426916814849,1368561814001963009,'tobingindex','$2a$10$Po8PE9ja1RjBuPE8gCdsi.AdtNg.4ugXjTmZduAjhpxekPjZ4VmoG',NULL,'15706694180',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,50,NULL,NULL,'2021-04-16 21:15:39');

/*Table structure for table `ums_member_collect_spu` */

CREATE TABLE `ums_member_collect_spu` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `member_id` bigint(20) DEFAULT NULL COMMENT '会员id',
  `spu_id` bigint(20) DEFAULT NULL COMMENT 'spu_id',
  `spu_name` varchar(500) DEFAULT NULL COMMENT 'spu_name',
  `spu_img` varchar(500) DEFAULT NULL COMMENT 'spu_img',
  `create_time` datetime DEFAULT NULL COMMENT 'create_time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='会员收藏的商品';

/*Data for the table `ums_member_collect_spu` */

/*Table structure for table `ums_member_collect_subject` */

CREATE TABLE `ums_member_collect_subject` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `subject_id` bigint(20) DEFAULT NULL COMMENT 'subject_id',
  `subject_name` varchar(255) DEFAULT NULL COMMENT 'subject_name',
  `subject_img` varchar(500) DEFAULT NULL COMMENT 'subject_img',
  `subject_urll` varchar(500) DEFAULT NULL COMMENT '活动url',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='会员收藏的专题活动';

/*Data for the table `ums_member_collect_subject` */

/*Table structure for table `ums_member_level` */

CREATE TABLE `ums_member_level` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(100) DEFAULT NULL COMMENT '等级名称',
  `growth_point` int(11) DEFAULT NULL COMMENT '等级需要的成长值',
  `default_status` tinyint(4) DEFAULT NULL COMMENT '是否为默认等级[0->不是；1->是]',
  `free_freight_point` decimal(18,4) DEFAULT NULL COMMENT '免运费标准',
  `comment_growth_point` int(11) DEFAULT NULL COMMENT '每次评价获取的成长值',
  `priviledge_free_freight` tinyint(4) DEFAULT NULL COMMENT '是否有免邮特权',
  `priviledge_member_price` tinyint(4) DEFAULT NULL COMMENT '是否有会员价格特权',
  `priviledge_birthday` tinyint(4) DEFAULT NULL COMMENT '是否有生日特权',
  `note` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1368562490971017218 DEFAULT CHARSET=utf8mb4 COMMENT='会员等级';

/*Data for the table `ums_member_level` */

insert  into `ums_member_level`(`id`,`name`,`growth_point`,`default_status`,`free_freight_point`,`comment_growth_point`,`priviledge_free_freight`,`priviledge_member_price`,`priviledge_birthday`,`note`) values (1368561814001963009,'普通会员',0,1,'199.0000',10,0,0,1,'普通会员');
insert  into `ums_member_level`(`id`,`name`,`growth_point`,`default_status`,`free_freight_point`,`comment_growth_point`,`priviledge_free_freight`,`priviledge_member_price`,`priviledge_birthday`,`note`) values (1368562119284379649,'白银会员',1000,0,'99.0000',20,0,1,1,'白银会员');
insert  into `ums_member_level`(`id`,`name`,`growth_point`,`default_status`,`free_freight_point`,`comment_growth_point`,`priviledge_free_freight`,`priviledge_member_price`,`priviledge_birthday`,`note`) values (1368562348935106561,'黄金等级',3000,0,'50.0000',30,0,1,1,'黄金等级');
insert  into `ums_member_level`(`id`,`name`,`growth_point`,`default_status`,`free_freight_point`,`comment_growth_point`,`priviledge_free_freight`,`priviledge_member_price`,`priviledge_birthday`,`note`) values (1368562490971017217,'砖石等级',6000,0,'0.0000',40,0,1,1,'砖石等级');

/*Table structure for table `ums_member_login_log` */

CREATE TABLE `ums_member_login_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `member_id` bigint(20) DEFAULT NULL COMMENT 'member_id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `ip` varchar(64) DEFAULT NULL COMMENT 'ip',
  `city` varchar(64) DEFAULT NULL COMMENT 'city',
  `login_type` tinyint(1) DEFAULT NULL COMMENT '登录类型[1-web，2-app]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='会员登录记录';

/*Data for the table `ums_member_login_log` */

/*Table structure for table `ums_member_receive_address` */

CREATE TABLE `ums_member_receive_address` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `member_id` bigint(20) DEFAULT NULL COMMENT 'member_id',
  `name` varchar(255) DEFAULT NULL COMMENT '收货人姓名',
  `phone` varchar(64) DEFAULT NULL COMMENT '电话',
  `post_code` varchar(64) DEFAULT NULL COMMENT '邮政编码',
  `province` varchar(100) DEFAULT NULL COMMENT '省份/直辖市',
  `city` varchar(100) DEFAULT NULL COMMENT '城市',
  `region` varchar(100) DEFAULT NULL COMMENT '区',
  `detail_address` varchar(255) DEFAULT NULL COMMENT '详细地址(街道)',
  `areacode` varchar(15) DEFAULT NULL COMMENT '省市区代码',
  `default_status` tinyint(1) DEFAULT NULL COMMENT '是否默认',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='会员收货地址';

/*Data for the table `ums_member_receive_address` */

insert  into `ums_member_receive_address`(`id`,`member_id`,`name`,`phone`,`post_code`,`province`,`city`,`region`,`detail_address`,`areacode`,`default_status`) values (1,1383046426916814849,'广东','12345311212','525100','广东省',NULL,NULL,'广东省化州市第一中学',NULL,NULL);
insert  into `ums_member_receive_address`(`id`,`member_id`,`name`,`phone`,`post_code`,`province`,`city`,`region`,`detail_address`,`areacode`,`default_status`) values (2,1383046426916814849,'四川','12131413241','610500','四川省',NULL,NULL,'四川省成都市新都区西南石油大学',NULL,NULL);

/*Table structure for table `ums_member_statistics_info` */

CREATE TABLE `ums_member_statistics_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `member_id` bigint(20) DEFAULT NULL COMMENT '会员id',
  `consume_amount` decimal(18,4) DEFAULT NULL COMMENT '累计消费金额',
  `coupon_amount` decimal(18,4) DEFAULT NULL COMMENT '累计优惠金额',
  `order_count` int(11) DEFAULT NULL COMMENT '订单数量',
  `coupon_count` int(11) DEFAULT NULL COMMENT '优惠券数量',
  `comment_count` int(11) DEFAULT NULL COMMENT '评价数',
  `return_order_count` int(11) DEFAULT NULL COMMENT '退货数量',
  `login_count` int(11) DEFAULT NULL COMMENT '登录次数',
  `attend_count` int(11) DEFAULT NULL COMMENT '关注数量',
  `fans_count` int(11) DEFAULT NULL COMMENT '粉丝数量',
  `collect_product_count` int(11) DEFAULT NULL COMMENT '收藏的商品数量',
  `collect_subject_count` int(11) DEFAULT NULL COMMENT '收藏的专题活动数量',
  `collect_comment_count` int(11) DEFAULT NULL COMMENT '收藏的评论数量',
  `invite_friend_count` int(11) DEFAULT NULL COMMENT '邀请的朋友数量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='会员统计信息';

/*Data for the table `ums_member_statistics_info` */

/*Table structure for table `undo_log` */

CREATE TABLE `undo_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `branch_id` bigint(20) NOT NULL,
  `xid` varchar(100) NOT NULL,
  `context` varchar(128) NOT NULL,
  `rollback_info` longblob NOT NULL,
  `log_status` int(11) NOT NULL,
  `log_created` datetime NOT NULL,
  `log_modified` datetime NOT NULL,
  `ext` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_undo_log` (`xid`,`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `undo_log` */

/*Table structure for table `wms_purchase` */

CREATE TABLE `wms_purchase` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '采购单id',
  `assignee_id` bigint(20) DEFAULT NULL COMMENT '采购人id',
  `assignee_name` varchar(255) DEFAULT NULL COMMENT '采购人名',
  `phone` char(13) DEFAULT NULL COMMENT '联系方式',
  `priority` int(4) DEFAULT NULL COMMENT '优先级',
  `status` int(4) DEFAULT NULL COMMENT '状态',
  `ware_id` bigint(20) DEFAULT NULL COMMENT '仓库id',
  `amount` decimal(18,4) DEFAULT NULL COMMENT '总金额',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `update_time` datetime DEFAULT NULL COMMENT '更新日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COMMENT='采购信息';

/*Data for the table `wms_purchase` */

insert  into `wms_purchase`(`id`,`assignee_id`,`assignee_name`,`phone`,`priority`,`status`,`ware_id`,`amount`,`create_time`,`update_time`) values (7,1,'admin','13612345678',NULL,3,NULL,NULL,'2021-04-13 16:33:54','2021-04-13 16:37:59');

/*Table structure for table `wms_purchase_detail` */

CREATE TABLE `wms_purchase_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `purchase_id` bigint(20) DEFAULT NULL COMMENT '采购单id',
  `sku_id` bigint(20) DEFAULT NULL COMMENT '采购商品id',
  `sku_num` int(11) DEFAULT NULL COMMENT '采购数量',
  `sku_price` decimal(18,4) DEFAULT NULL COMMENT '采购金额',
  `ware_id` bigint(20) DEFAULT NULL COMMENT '仓库id',
  `status` int(11) DEFAULT NULL COMMENT '状态[0新建，1已分配，2正在采购，3已完成，4采购失败]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4;

/*Data for the table `wms_purchase_detail` */

insert  into `wms_purchase_detail`(`id`,`purchase_id`,`sku_id`,`sku_num`,`sku_price`,`ware_id`,`status`) values (14,7,23,100,NULL,1,3);
insert  into `wms_purchase_detail`(`id`,`purchase_id`,`sku_id`,`sku_num`,`sku_price`,`ware_id`,`status`) values (15,7,24,44,NULL,1,3);
insert  into `wms_purchase_detail`(`id`,`purchase_id`,`sku_id`,`sku_num`,`sku_price`,`ware_id`,`status`) values (16,7,25,123,NULL,1,3);
insert  into `wms_purchase_detail`(`id`,`purchase_id`,`sku_id`,`sku_num`,`sku_price`,`ware_id`,`status`) values (17,7,26,122,NULL,1,3);
insert  into `wms_purchase_detail`(`id`,`purchase_id`,`sku_id`,`sku_num`,`sku_price`,`ware_id`,`status`) values (18,7,27,22,NULL,1,3);
insert  into `wms_purchase_detail`(`id`,`purchase_id`,`sku_id`,`sku_num`,`sku_price`,`ware_id`,`status`) values (19,7,28,112,NULL,1,3);
insert  into `wms_purchase_detail`(`id`,`purchase_id`,`sku_id`,`sku_num`,`sku_price`,`ware_id`,`status`) values (20,7,29,121,NULL,1,3);
insert  into `wms_purchase_detail`(`id`,`purchase_id`,`sku_id`,`sku_num`,`sku_price`,`ware_id`,`status`) values (21,7,30,31,NULL,1,3);

/*Table structure for table `wms_ware_info` */

CREATE TABLE `wms_ware_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) DEFAULT NULL COMMENT '仓库名',
  `address` varchar(255) DEFAULT NULL COMMENT '仓库地址',
  `areacode` varchar(20) DEFAULT NULL COMMENT '区域编码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='仓库信息';

/*Data for the table `wms_ware_info` */

insert  into `wms_ware_info`(`id`,`name`,`address`,`areacode`) values (1,'一号仓库','四川省成都市新都区','610500');
insert  into `wms_ware_info`(`id`,`name`,`address`,`areacode`) values (2,'二号仓库','广东省茂名市','525100');

/*Table structure for table `wms_ware_order_task` */

CREATE TABLE `wms_ware_order_task` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` bigint(20) DEFAULT NULL COMMENT 'order_id',
  `order_sn` varchar(255) NOT NULL COMMENT 'order_sn',
  `consignee` varchar(100) DEFAULT NULL COMMENT '收货人',
  `consignee_tel` char(15) DEFAULT NULL COMMENT '收货人电话',
  `delivery_address` varchar(500) DEFAULT NULL COMMENT '配送地址',
  `order_comment` varchar(200) DEFAULT NULL COMMENT '订单备注',
  `payment_way` tinyint(1) DEFAULT NULL COMMENT '付款方式【 1:在线付款 2:货到付款】',
  `task_status` tinyint(2) DEFAULT NULL COMMENT '任务状态',
  `order_body` varchar(255) DEFAULT NULL COMMENT '订单描述',
  `tracking_no` char(30) DEFAULT NULL COMMENT '物流单号',
  `create_time` datetime DEFAULT NULL COMMENT 'create_time',
  `ware_id` bigint(20) DEFAULT NULL COMMENT '仓库id',
  `task_comment` varchar(500) DEFAULT NULL COMMENT '工作单备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_sn` (`order_sn`)
) ENGINE=InnoDB AUTO_INCREMENT=1389134206151544834 DEFAULT CHARSET=utf8mb4 COMMENT='库存工作单';

/*Data for the table `wms_ware_order_task` */

insert  into `wms_ware_order_task`(`id`,`order_id`,`order_sn`,`consignee`,`consignee_tel`,`delivery_address`,`order_comment`,`payment_way`,`task_status`,`order_body`,`tracking_no`,`create_time`,`ware_id`,`task_comment`) values (1387766148983980034,NULL,'202104292150018061387766122916433922',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
insert  into `wms_ware_order_task`(`id`,`order_id`,`order_sn`,`consignee`,`consignee_tel`,`delivery_address`,`order_comment`,`payment_way`,`task_status`,`order_body`,`tracking_no`,`create_time`,`ware_id`,`task_comment`) values (1387776694672183298,NULL,'202104292231557421387776667124006913',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
insert  into `wms_ware_order_task`(`id`,`order_id`,`order_sn`,`consignee`,`consignee_tel`,`delivery_address`,`order_comment`,`payment_way`,`task_status`,`order_body`,`tracking_no`,`create_time`,`ware_id`,`task_comment`) values (1387779012608249858,NULL,'202104292241085991387778985978515457',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
insert  into `wms_ware_order_task`(`id`,`order_id`,`order_sn`,`consignee`,`consignee_tel`,`delivery_address`,`order_comment`,`payment_way`,`task_status`,`order_body`,`tracking_no`,`create_time`,`ware_id`,`task_comment`) values (1387981576440135682,NULL,'202104301206079851387981568286515202',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
insert  into `wms_ware_order_task`(`id`,`order_id`,`order_sn`,`consignee`,`consignee_tel`,`delivery_address`,`order_comment`,`payment_way`,`task_status`,`order_body`,`tracking_no`,`create_time`,`ware_id`,`task_comment`) values (1387988729141936129,NULL,'202104301234350771387988728349319170',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
insert  into `wms_ware_order_task`(`id`,`order_id`,`order_sn`,`consignee`,`consignee_tel`,`delivery_address`,`order_comment`,`payment_way`,`task_status`,`order_body`,`tracking_no`,`create_time`,`ware_id`,`task_comment`) values (1387994949777113089,NULL,'202104301259182291387994949135486978',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
insert  into `wms_ware_order_task`(`id`,`order_id`,`order_sn`,`consignee`,`consignee_tel`,`delivery_address`,`order_comment`,`payment_way`,`task_status`,`order_body`,`tracking_no`,`create_time`,`ware_id`,`task_comment`) values (1387995481669386241,NULL,'202104301301251201387995481342332929',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
insert  into `wms_ware_order_task`(`id`,`order_id`,`order_sn`,`consignee`,`consignee_tel`,`delivery_address`,`order_comment`,`payment_way`,`task_status`,`order_body`,`tracking_no`,`create_time`,`ware_id`,`task_comment`) values (1388043243840667649,NULL,'202104301611067031388043219178180610',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
insert  into `wms_ware_order_task`(`id`,`order_id`,`order_sn`,`consignee`,`consignee_tel`,`delivery_address`,`order_comment`,`payment_way`,`task_status`,`order_body`,`tracking_no`,`create_time`,`ware_id`,`task_comment`) values (1388112220386295809,NULL,'202104302045177271388112219769671681',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
insert  into `wms_ware_order_task`(`id`,`order_id`,`order_sn`,`consignee`,`consignee_tel`,`delivery_address`,`order_comment`,`payment_way`,`task_status`,`order_body`,`tracking_no`,`create_time`,`ware_id`,`task_comment`) values (1388304898713473026,NULL,'202105010930494401388304871341535234',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
insert  into `wms_ware_order_task`(`id`,`order_id`,`order_sn`,`consignee`,`consignee_tel`,`delivery_address`,`order_comment`,`payment_way`,`task_status`,`order_body`,`tracking_no`,`create_time`,`ware_id`,`task_comment`) values (1388305270928592897,NULL,'202105010932246431388305270597332994',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
insert  into `wms_ware_order_task`(`id`,`order_id`,`order_sn`,`consignee`,`consignee_tel`,`delivery_address`,`order_comment`,`payment_way`,`task_status`,`order_body`,`tracking_no`,`create_time`,`ware_id`,`task_comment`) values (1388351568423702529,NULL,'202105011236228041388351568021139457',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
insert  into `wms_ware_order_task`(`id`,`order_id`,`order_sn`,`consignee`,`consignee_tel`,`delivery_address`,`order_comment`,`payment_way`,`task_status`,`order_body`,`tracking_no`,`create_time`,`ware_id`,`task_comment`) values (1388352300023566338,NULL,'202105011239171861388352299461521410',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
insert  into `wms_ware_order_task`(`id`,`order_id`,`order_sn`,`consignee`,`consignee_tel`,`delivery_address`,`order_comment`,`payment_way`,`task_status`,`order_body`,`tracking_no`,`create_time`,`ware_id`,`task_comment`) values (1388352959766614018,NULL,'202105011241544931388352959254896642',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
insert  into `wms_ware_order_task`(`id`,`order_id`,`order_sn`,`consignee`,`consignee_tel`,`delivery_address`,`order_comment`,`payment_way`,`task_status`,`order_body`,`tracking_no`,`create_time`,`ware_id`,`task_comment`) values (1388355068318732290,NULL,'202105011250171611388355067601596417',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
insert  into `wms_ware_order_task`(`id`,`order_id`,`order_sn`,`consignee`,`consignee_tel`,`delivery_address`,`order_comment`,`payment_way`,`task_status`,`order_body`,`tracking_no`,`create_time`,`ware_id`,`task_comment`) values (1389080601281282050,NULL,'202105031253117231389080575498862594',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
insert  into `wms_ware_order_task`(`id`,`order_id`,`order_sn`,`consignee`,`consignee_tel`,`delivery_address`,`order_comment`,`payment_way`,`task_status`,`order_body`,`tracking_no`,`create_time`,`ware_id`,`task_comment`) values (1389081086570643458,NULL,'202105031255134401389081086012686337',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
insert  into `wms_ware_order_task`(`id`,`order_id`,`order_sn`,`consignee`,`consignee_tel`,`delivery_address`,`order_comment`,`payment_way`,`task_status`,`order_body`,`tracking_no`,`create_time`,`ware_id`,`task_comment`) values (1389081207194632194,NULL,'202105031255422711389081206900916226',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
insert  into `wms_ware_order_task`(`id`,`order_id`,`order_sn`,`consignee`,`consignee_tel`,`delivery_address`,`order_comment`,`payment_way`,`task_status`,`order_body`,`tracking_no`,`create_time`,`ware_id`,`task_comment`) values (1389134206151544833,NULL,'202105031626158551389134196030660609',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

/*Table structure for table `wms_ware_order_task_detail` */

CREATE TABLE `wms_ware_order_task_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `sku_id` bigint(20) DEFAULT NULL COMMENT 'sku_id',
  `sku_name` varchar(255) DEFAULT NULL COMMENT 'sku_name',
  `sku_num` int(11) DEFAULT NULL COMMENT '购买个数',
  `task_id` bigint(20) DEFAULT NULL COMMENT '工作单id',
  `ware_id` bigint(20) DEFAULT NULL COMMENT '仓库id',
  `lock_status` int(11) DEFAULT NULL COMMENT '1-锁定  2-解锁  3-扣减成功',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1389134206289956866 DEFAULT CHARSET=utf8mb4 COMMENT='库存工作单';

/*Data for the table `wms_ware_order_task_detail` */

insert  into `wms_ware_order_task_detail`(`id`,`sku_id`,`sku_name`,`sku_num`,`task_id`,`ware_id`,`lock_status`) values (1387766149025923074,28,NULL,5,1387766148983980034,1,2);
insert  into `wms_ware_order_task_detail`(`id`,`sku_id`,`sku_name`,`sku_num`,`task_id`,`ware_id`,`lock_status`) values (1387766149025923075,25,NULL,1,1387766148983980034,1,2);
insert  into `wms_ware_order_task_detail`(`id`,`sku_id`,`sku_name`,`sku_num`,`task_id`,`ware_id`,`lock_status`) values (1387766149025923076,23,NULL,1,1387766148983980034,1,2);
insert  into `wms_ware_order_task_detail`(`id`,`sku_id`,`sku_name`,`sku_num`,`task_id`,`ware_id`,`lock_status`) values (1387776694739292162,28,NULL,5,1387776694672183298,1,2);
insert  into `wms_ware_order_task_detail`(`id`,`sku_id`,`sku_name`,`sku_num`,`task_id`,`ware_id`,`lock_status`) values (1387776694739292163,25,NULL,1,1387776694672183298,1,2);
insert  into `wms_ware_order_task_detail`(`id`,`sku_id`,`sku_name`,`sku_num`,`task_id`,`ware_id`,`lock_status`) values (1387776694739292164,23,NULL,1,1387776694672183298,1,2);
insert  into `wms_ware_order_task_detail`(`id`,`sku_id`,`sku_name`,`sku_num`,`task_id`,`ware_id`,`lock_status`) values (1387779012620832770,28,NULL,5,1387779012608249858,1,2);
insert  into `wms_ware_order_task_detail`(`id`,`sku_id`,`sku_name`,`sku_num`,`task_id`,`ware_id`,`lock_status`) values (1387779012620832771,25,NULL,1,1387779012608249858,1,2);
insert  into `wms_ware_order_task_detail`(`id`,`sku_id`,`sku_name`,`sku_num`,`task_id`,`ware_id`,`lock_status`) values (1387779012620832772,23,NULL,1,1387779012608249858,1,2);
insert  into `wms_ware_order_task_detail`(`id`,`sku_id`,`sku_name`,`sku_num`,`task_id`,`ware_id`,`lock_status`) values (1387981576482078721,25,NULL,1,1387981576440135682,1,2);
insert  into `wms_ware_order_task_detail`(`id`,`sku_id`,`sku_name`,`sku_num`,`task_id`,`ware_id`,`lock_status`) values (1387981576482078722,28,NULL,5,1387981576440135682,1,2);
insert  into `wms_ware_order_task_detail`(`id`,`sku_id`,`sku_name`,`sku_num`,`task_id`,`ware_id`,`lock_status`) values (1387981576482078723,23,NULL,2,1387981576440135682,1,2);
insert  into `wms_ware_order_task_detail`(`id`,`sku_id`,`sku_name`,`sku_num`,`task_id`,`ware_id`,`lock_status`) values (1387988729141936130,28,NULL,5,1387988729141936129,1,2);
insert  into `wms_ware_order_task_detail`(`id`,`sku_id`,`sku_name`,`sku_num`,`task_id`,`ware_id`,`lock_status`) values (1387988729141936131,25,NULL,1,1387988729141936129,1,2);
insert  into `wms_ware_order_task_detail`(`id`,`sku_id`,`sku_name`,`sku_num`,`task_id`,`ware_id`,`lock_status`) values (1387988729141936132,23,NULL,2,1387988729141936129,1,2);
insert  into `wms_ware_order_task_detail`(`id`,`sku_id`,`sku_name`,`sku_num`,`task_id`,`ware_id`,`lock_status`) values (1387994949777113090,28,NULL,5,1387994949777113089,1,2);
insert  into `wms_ware_order_task_detail`(`id`,`sku_id`,`sku_name`,`sku_num`,`task_id`,`ware_id`,`lock_status`) values (1387994949777113091,25,NULL,1,1387994949777113089,1,2);
insert  into `wms_ware_order_task_detail`(`id`,`sku_id`,`sku_name`,`sku_num`,`task_id`,`ware_id`,`lock_status`) values (1387994949777113092,23,NULL,2,1387994949777113089,1,2);
insert  into `wms_ware_order_task_detail`(`id`,`sku_id`,`sku_name`,`sku_num`,`task_id`,`ware_id`,`lock_status`) values (1387995481669386242,28,NULL,5,1387995481669386241,1,2);
insert  into `wms_ware_order_task_detail`(`id`,`sku_id`,`sku_name`,`sku_num`,`task_id`,`ware_id`,`lock_status`) values (1387995481669386243,25,NULL,1,1387995481669386241,1,2);
insert  into `wms_ware_order_task_detail`(`id`,`sku_id`,`sku_name`,`sku_num`,`task_id`,`ware_id`,`lock_status`) values (1387995481669386244,23,NULL,2,1387995481669386241,1,2);
insert  into `wms_ware_order_task_detail`(`id`,`sku_id`,`sku_name`,`sku_num`,`task_id`,`ware_id`,`lock_status`) values (1388043243911970818,25,NULL,3,1388043243840667649,1,2);
insert  into `wms_ware_order_task_detail`(`id`,`sku_id`,`sku_name`,`sku_num`,`task_id`,`ware_id`,`lock_status`) values (1388112220453404673,25,NULL,3,1388112220386295809,1,2);
insert  into `wms_ware_order_task_detail`(`id`,`sku_id`,`sku_name`,`sku_num`,`task_id`,`ware_id`,`lock_status`) values (1388112220453404674,27,NULL,3,1388112220386295809,1,2);
insert  into `wms_ware_order_task_detail`(`id`,`sku_id`,`sku_name`,`sku_num`,`task_id`,`ware_id`,`lock_status`) values (1388304898801553410,25,NULL,3,1388304898713473026,1,2);
insert  into `wms_ware_order_task_detail`(`id`,`sku_id`,`sku_name`,`sku_num`,`task_id`,`ware_id`,`lock_status`) values (1388304898864467970,27,NULL,3,1388304898713473026,1,2);
insert  into `wms_ware_order_task_detail`(`id`,`sku_id`,`sku_name`,`sku_num`,`task_id`,`ware_id`,`lock_status`) values (1388305270928592898,25,NULL,3,1388305270928592897,1,2);
insert  into `wms_ware_order_task_detail`(`id`,`sku_id`,`sku_name`,`sku_num`,`task_id`,`ware_id`,`lock_status`) values (1388305270928592899,27,NULL,3,1388305270928592897,1,2);
insert  into `wms_ware_order_task_detail`(`id`,`sku_id`,`sku_name`,`sku_num`,`task_id`,`ware_id`,`lock_status`) values (1388351568490811393,25,NULL,3,1388351568423702529,1,2);
insert  into `wms_ware_order_task_detail`(`id`,`sku_id`,`sku_name`,`sku_num`,`task_id`,`ware_id`,`lock_status`) values (1388351568490811394,27,NULL,3,1388351568423702529,1,2);
insert  into `wms_ware_order_task_detail`(`id`,`sku_id`,`sku_name`,`sku_num`,`task_id`,`ware_id`,`lock_status`) values (1388352300023566339,25,NULL,3,1388352300023566338,1,2);
insert  into `wms_ware_order_task_detail`(`id`,`sku_id`,`sku_name`,`sku_num`,`task_id`,`ware_id`,`lock_status`) values (1388352300023566340,27,NULL,3,1388352300023566338,1,2);
insert  into `wms_ware_order_task_detail`(`id`,`sku_id`,`sku_name`,`sku_num`,`task_id`,`ware_id`,`lock_status`) values (1388352959766614019,25,NULL,1,1388352959766614018,1,2);
insert  into `wms_ware_order_task_detail`(`id`,`sku_id`,`sku_name`,`sku_num`,`task_id`,`ware_id`,`lock_status`) values (1388355068318732291,25,NULL,1,1388355068318732290,1,1);
insert  into `wms_ware_order_task_detail`(`id`,`sku_id`,`sku_name`,`sku_num`,`task_id`,`ware_id`,`lock_status`) values (1389080601394528257,24,NULL,1,1389080601281282050,1,2);
insert  into `wms_ware_order_task_detail`(`id`,`sku_id`,`sku_name`,`sku_num`,`task_id`,`ware_id`,`lock_status`) values (1389080601394528258,25,NULL,1,1389080601281282050,1,2);
insert  into `wms_ware_order_task_detail`(`id`,`sku_id`,`sku_name`,`sku_num`,`task_id`,`ware_id`,`lock_status`) values (1389081086633558017,24,NULL,1,1389081086570643458,1,2);
insert  into `wms_ware_order_task_detail`(`id`,`sku_id`,`sku_name`,`sku_num`,`task_id`,`ware_id`,`lock_status`) values (1389081086633558018,25,NULL,1,1389081086570643458,1,2);
insert  into `wms_ware_order_task_detail`(`id`,`sku_id`,`sku_name`,`sku_num`,`task_id`,`ware_id`,`lock_status`) values (1389081207194632195,24,NULL,1,1389081207194632194,1,2);
insert  into `wms_ware_order_task_detail`(`id`,`sku_id`,`sku_name`,`sku_num`,`task_id`,`ware_id`,`lock_status`) values (1389081207194632196,25,NULL,1,1389081207194632194,1,2);
insert  into `wms_ware_order_task_detail`(`id`,`sku_id`,`sku_name`,`sku_num`,`task_id`,`ware_id`,`lock_status`) values (1389134206277373954,24,NULL,1,1389134206151544833,1,2);
insert  into `wms_ware_order_task_detail`(`id`,`sku_id`,`sku_name`,`sku_num`,`task_id`,`ware_id`,`lock_status`) values (1389134206289956865,25,NULL,1,1389134206151544833,1,2);

/*Table structure for table `wms_ware_sku` */

CREATE TABLE `wms_ware_sku` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `sku_id` bigint(20) DEFAULT NULL COMMENT 'sku_id',
  `ware_id` bigint(20) DEFAULT NULL COMMENT '仓库id',
  `stock` int(11) DEFAULT NULL COMMENT '库存数',
  `sku_name` varchar(200) DEFAULT NULL COMMENT 'sku_name',
  `stock_locked` int(11) DEFAULT '0' COMMENT '锁定库存',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COMMENT='商品库存';

/*Data for the table `wms_ware_sku` */

insert  into `wms_ware_sku`(`id`,`sku_id`,`ware_id`,`stock`,`sku_name`,`stock_locked`) values (20,23,1,100,NULL,0);
insert  into `wms_ware_sku`(`id`,`sku_id`,`ware_id`,`stock`,`sku_name`,`stock_locked`) values (21,24,1,100,NULL,0);
insert  into `wms_ware_sku`(`id`,`sku_id`,`ware_id`,`stock`,`sku_name`,`stock_locked`) values (22,25,1,100,NULL,1);
insert  into `wms_ware_sku`(`id`,`sku_id`,`ware_id`,`stock`,`sku_name`,`stock_locked`) values (23,26,1,100,NULL,0);
insert  into `wms_ware_sku`(`id`,`sku_id`,`ware_id`,`stock`,`sku_name`,`stock_locked`) values (24,27,1,100,NULL,0);
insert  into `wms_ware_sku`(`id`,`sku_id`,`ware_id`,`stock`,`sku_name`,`stock_locked`) values (25,28,1,100,NULL,0);
insert  into `wms_ware_sku`(`id`,`sku_id`,`ware_id`,`stock`,`sku_name`,`stock_locked`) values (26,29,1,100,NULL,0);
insert  into `wms_ware_sku`(`id`,`sku_id`,`ware_id`,`stock`,`sku_name`,`stock_locked`) values (27,30,1,100,NULL,0);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
