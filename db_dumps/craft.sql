/*
 Navicat MySQL Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 50638
 Source Host           : localhost
 Source Database       : craft

 Target Server Type    : MySQL
 Target Server Version : 50638
 File Encoding         : utf-8

 Date: 08/16/2018 13:56:06 PM
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `assetindexdata`
-- ----------------------------
DROP TABLE IF EXISTS `assetindexdata`;
CREATE TABLE `assetindexdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) NOT NULL DEFAULT '',
  `volumeId` int(11) NOT NULL,
  `uri` text,
  `size` bigint(20) unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int(11) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT '0',
  `completed` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assetindexdata_sessionId_volumeId_idx` (`sessionId`,`volumeId`),
  KEY `assetindexdata_volumeId_idx` (`volumeId`),
  CONSTRAINT `assetindexdata_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `assets`
-- ----------------------------
DROP TABLE IF EXISTS `assets`;
CREATE TABLE `assets` (
  `id` int(11) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `folderId` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `assets_filename_folderId_unq_idx` (`filename`,`folderId`),
  KEY `assets_folderId_idx` (`folderId`),
  KEY `assets_volumeId_idx` (`volumeId`),
  CONSTRAINT `assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `assettransformindex`
-- ----------------------------
DROP TABLE IF EXISTS `assettransformindex`;
CREATE TABLE `assettransformindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetId` int(11) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT '0',
  `inProgress` tinyint(1) NOT NULL DEFAULT '0',
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assettransformindex_volumeId_assetId_location_idx` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `assettransforms`
-- ----------------------------
DROP TABLE IF EXISTS `assettransforms`;
CREATE TABLE `assettransforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int(11) DEFAULT NULL,
  `interlace` enum('none','line','plane','partition') NOT NULL DEFAULT 'none',
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `assettransforms_name_unq_idx` (`name`),
  UNIQUE KEY `assettransforms_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `categories`
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categories_groupId_idx` (`groupId`),
  CONSTRAINT `categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `categorygroups`
-- ----------------------------
DROP TABLE IF EXISTS `categorygroups`;
CREATE TABLE `categorygroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `categorygroups_name_unq_idx` (`name`),
  UNIQUE KEY `categorygroups_handle_unq_idx` (`handle`),
  KEY `categorygroups_structureId_idx` (`structureId`),
  KEY `categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `categorygroups_sites`
-- ----------------------------
DROP TABLE IF EXISTS `categorygroups_sites`;
CREATE TABLE `categorygroups_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `categorygroups_sites_groupId_siteId_unq_idx` (`groupId`,`siteId`),
  KEY `categorygroups_sites_siteId_idx` (`siteId`),
  CONSTRAINT `categorygroups_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categorygroups_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `content`
-- ----------------------------
DROP TABLE IF EXISTS `content`;
CREATE TABLE `content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_alt` text,
  `field_metaTitle` text,
  `field_metaDescription` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `content_siteId_idx` (`siteId`),
  KEY `content_title_idx` (`title`),
  CONSTRAINT `content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `content`
-- ----------------------------
BEGIN;
INSERT INTO `content` VALUES ('1', '1', '1', null, '2018-08-07 12:08:32', '2018-08-07 12:08:50', '6910b2f4-c0af-4ee3-9a60-758d2261d972', null, null, null), ('2', '2', '1', 'Homepage', '2018-08-07 12:16:42', '2018-08-07 12:16:42', '60124bc9-abc8-4730-87d5-cf9ed055f28f', null, null, null), ('3', '3', '1', '404', '2018-08-07 12:17:01', '2018-08-07 12:17:01', '96d0276e-fb35-43a8-9947-868d35277dec', null, null, null);
COMMIT;

-- ----------------------------
--  Table structure for `craftidtokens`
-- ----------------------------
DROP TABLE IF EXISTS `craftidtokens`;
CREATE TABLE `craftidtokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craftidtokens_userId_fk` (`userId`),
  CONSTRAINT `craftidtokens_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `deprecationerrors`
-- ----------------------------
DROP TABLE IF EXISTS `deprecationerrors`;
CREATE TABLE `deprecationerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint(6) unsigned DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `traces` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `elementindexsettings`
-- ----------------------------
DROP TABLE IF EXISTS `elementindexsettings`;
CREATE TABLE `elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `elementindexsettings`
-- ----------------------------
BEGIN;
INSERT INTO `elementindexsettings` VALUES ('1', 'craft\\elements\\Entry', '{\"sources\":{\"*\":{\"tableAttributes\":{\"1\":\"section\",\"2\":\"link\"}}}}', '2018-08-07 12:19:52', '2018-08-07 12:19:52', '4fc5d261-d6f8-4b6b-ac1a-cb98a9cb3e1d');
COMMIT;

-- ----------------------------
--  Table structure for `elements`
-- ----------------------------
DROP TABLE IF EXISTS `elements`;
CREATE TABLE `elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `elements_type_idx` (`type`),
  KEY `elements_enabled_idx` (`enabled`),
  KEY `elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  CONSTRAINT `elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `elements`
-- ----------------------------
BEGIN;
INSERT INTO `elements` VALUES ('1', null, 'craft\\elements\\User', '1', '0', '2018-08-07 12:08:32', '2018-08-07 12:08:50', 'b8907def-33e7-43a9-9c7a-99d36be1eda0'), ('2', '3', 'craft\\elements\\Entry', '1', '0', '2018-08-07 12:16:42', '2018-08-07 12:16:42', '79ed2631-fac4-4b58-9d08-a4ea90a2231b'), ('3', '4', 'craft\\elements\\Entry', '1', '0', '2018-08-07 12:17:01', '2018-08-07 12:17:01', '3c03d95f-d5be-41e7-b4f8-68ce0c858e62');
COMMIT;

-- ----------------------------
--  Table structure for `elements_sites`
-- ----------------------------
DROP TABLE IF EXISTS `elements_sites`;
CREATE TABLE `elements_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elements_sites_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  UNIQUE KEY `elements_sites_uri_siteId_unq_idx` (`uri`,`siteId`),
  KEY `elements_sites_siteId_idx` (`siteId`),
  KEY `elements_sites_slug_siteId_idx` (`slug`,`siteId`),
  KEY `elements_sites_enabled_idx` (`enabled`),
  CONSTRAINT `elements_sites_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `elements_sites`
-- ----------------------------
BEGIN;
INSERT INTO `elements_sites` VALUES ('1', '1', '1', null, null, '1', '2018-08-07 12:08:32', '2018-08-07 12:08:50', '05ca2b33-6713-4a53-8a10-43c10687081e'), ('2', '2', '1', 'homepage', '__home__', '1', '2018-08-07 12:16:42', '2018-08-07 12:16:42', '44d6ff83-255e-40cd-abed-2a7431ef3926'), ('3', '3', '1', '404', '404', '1', '2018-08-07 12:17:01', '2018-08-07 12:17:01', '0f9ce95c-feaa-43f5-b300-3976b36fd32d');
COMMIT;

-- ----------------------------
--  Table structure for `entries`
-- ----------------------------
DROP TABLE IF EXISTS `entries`;
CREATE TABLE `entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entries_postDate_idx` (`postDate`),
  KEY `entries_expiryDate_idx` (`expiryDate`),
  KEY `entries_authorId_idx` (`authorId`),
  KEY `entries_sectionId_idx` (`sectionId`),
  KEY `entries_typeId_idx` (`typeId`),
  CONSTRAINT `entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `entries`
-- ----------------------------
BEGIN;
INSERT INTO `entries` VALUES ('2', '1', '1', null, '2018-08-07 12:16:00', null, '2018-08-07 12:16:42', '2018-08-07 12:16:42', '8decec45-1678-4590-b909-62c5740738f6'), ('3', '2', '2', null, '2018-08-07 12:17:00', null, '2018-08-07 12:17:01', '2018-08-07 12:17:01', 'c9be06b5-9bcf-4b85-a88c-54c1fba68e96');
COMMIT;

-- ----------------------------
--  Table structure for `entrydrafts`
-- ----------------------------
DROP TABLE IF EXISTS `entrydrafts`;
CREATE TABLE `entrydrafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entrydrafts_sectionId_idx` (`sectionId`),
  KEY `entrydrafts_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `entrydrafts_siteId_idx` (`siteId`),
  KEY `entrydrafts_creatorId_idx` (`creatorId`),
  CONSTRAINT `entrydrafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `entrytypes`
-- ----------------------------
DROP TABLE IF EXISTS `entrytypes`;
CREATE TABLE `entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT '1',
  `titleLabel` varchar(255) DEFAULT 'Title',
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `entrytypes_name_sectionId_unq_idx` (`name`,`sectionId`),
  UNIQUE KEY `entrytypes_handle_sectionId_unq_idx` (`handle`,`sectionId`),
  KEY `entrytypes_sectionId_idx` (`sectionId`),
  KEY `entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `entrytypes`
-- ----------------------------
BEGIN;
INSERT INTO `entrytypes` VALUES ('1', '1', '3', 'Homepage', 'homepage', '0', null, '{section.name|raw}', '1', '2018-08-07 12:16:42', '2018-08-07 12:16:42', '406a0b1d-3f8b-44e2-ab43-97b963e731de'), ('2', '2', '4', '404', 'notFound', '0', null, '{section.name|raw}', '1', '2018-08-07 12:17:01', '2018-08-07 12:17:01', '22c70cd9-8d68-4057-b9cd-eb3711d0926c');
COMMIT;

-- ----------------------------
--  Table structure for `entryversions`
-- ----------------------------
DROP TABLE IF EXISTS `entryversions`;
CREATE TABLE `entryversions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `siteId` int(11) NOT NULL,
  `num` smallint(6) unsigned NOT NULL,
  `notes` text,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entryversions_sectionId_idx` (`sectionId`),
  KEY `entryversions_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `entryversions_siteId_idx` (`siteId`),
  KEY `entryversions_creatorId_idx` (`creatorId`),
  CONSTRAINT `entryversions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entryversions_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entryversions_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entryversions_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `fieldgroups`
-- ----------------------------
DROP TABLE IF EXISTS `fieldgroups`;
CREATE TABLE `fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldgroups_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `fieldgroups`
-- ----------------------------
BEGIN;
INSERT INTO `fieldgroups` VALUES ('1', 'Common', '2018-08-07 12:08:32', '2018-08-07 12:08:32', '070e10af-af0e-4ce9-a9c8-9c01404f5804');
COMMIT;

-- ----------------------------
--  Table structure for `fieldlayoutfields`
-- ----------------------------
DROP TABLE IF EXISTS `fieldlayoutfields`;
CREATE TABLE `fieldlayoutfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayoutfields_tabId_idx` (`tabId`),
  KEY `fieldlayoutfields_fieldId_idx` (`fieldId`),
  CONSTRAINT `fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `fieldlayoutfields`
-- ----------------------------
BEGIN;
INSERT INTO `fieldlayoutfields` VALUES ('19', '1', '14', '5', '0', '1', '2018-08-13 08:05:51', '2018-08-13 08:05:51', '8a0b30eb-4852-4f04-a284-420c99c25630'), ('20', '5', '15', '2', '1', '1', '2018-08-13 12:29:22', '2018-08-13 12:29:22', '91c41ed0-392d-4e1f-ae95-ba23ae2bd7a1'), ('21', '5', '15', '3', '1', '2', '2018-08-13 12:29:22', '2018-08-13 12:29:22', '3165dc95-6761-4d31-b34d-c7c0c6bbf131'), ('22', '6', '16', '4', '1', '1', '2018-08-13 12:29:22', '2018-08-13 12:29:22', '46095302-8b79-406f-a503-778565f6821f'), ('23', '7', '17', '6', '1', '1', '2018-08-13 12:29:22', '2018-08-13 12:29:22', '73e4e763-9eb3-454a-a061-807200859a0b'), ('24', '9', '18', '7', '1', '1', '2018-08-13 12:29:22', '2018-08-13 12:29:22', '8110252f-f734-4bce-8998-e5ec2508c5e5');
COMMIT;

-- ----------------------------
--  Table structure for `fieldlayouts`
-- ----------------------------
DROP TABLE IF EXISTS `fieldlayouts`;
CREATE TABLE `fieldlayouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouts_type_idx` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `fieldlayouts`
-- ----------------------------
BEGIN;
INSERT INTO `fieldlayouts` VALUES ('1', 'craft\\elements\\Asset', '2018-08-07 12:12:51', '2018-08-13 08:05:51', '15f4633d-e1ab-43be-a923-c40a4a2ca521'), ('2', 'craft\\elements\\Asset', '2018-08-07 12:13:35', '2018-08-07 12:16:13', 'b33af887-2043-4cf3-9ed0-01d0d8565fb7'), ('3', 'craft\\elements\\Entry', '2018-08-07 12:16:42', '2018-08-07 12:16:42', '5e777eb4-84a6-461c-946a-655eb4b9a5f4'), ('4', 'craft\\elements\\Entry', '2018-08-07 12:17:01', '2018-08-07 12:17:01', '13dde20c-3f92-4ad7-91a9-0fcdc3680f37'), ('5', 'craft\\elements\\MatrixBlock', '2018-08-07 12:18:20', '2018-08-13 12:29:22', '8c6deaf8-f287-49df-b3a4-cb39bba4a3a2'), ('6', 'craft\\elements\\MatrixBlock', '2018-08-07 12:18:50', '2018-08-13 12:29:22', 'b02904e7-1aa3-4244-a34a-8e6b232ac5cc'), ('7', 'craft\\elements\\MatrixBlock', '2018-08-07 12:22:12', '2018-08-13 12:29:22', '3adcada2-43eb-4a86-8306-4e63ef08acee'), ('8', 'craft\\elements\\Asset', '2018-08-13 08:05:43', '2018-08-13 08:06:45', '813f4996-2996-4fb6-9aee-d0c8e70a711b'), ('9', 'craft\\elements\\MatrixBlock', '2018-08-13 12:29:22', '2018-08-13 12:29:22', '08430f04-b750-40e9-a2f7-1836039f15f6');
COMMIT;

-- ----------------------------
--  Table structure for `fieldlayouttabs`
-- ----------------------------
DROP TABLE IF EXISTS `fieldlayouttabs`;
CREATE TABLE `fieldlayouttabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayouttabs_layoutId_idx` (`layoutId`),
  CONSTRAINT `fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `fieldlayouttabs`
-- ----------------------------
BEGIN;
INSERT INTO `fieldlayouttabs` VALUES ('14', '1', 'Content', '1', '2018-08-13 08:05:51', '2018-08-13 08:05:51', '52d82100-7240-4459-94a4-6f8122e6168b'), ('15', '5', 'Content', '1', '2018-08-13 12:29:22', '2018-08-13 12:29:22', 'e48d026f-b181-4328-bdd9-0416cc9440ef'), ('16', '6', 'Content', '1', '2018-08-13 12:29:22', '2018-08-13 12:29:22', '203d92fa-1cfa-48ce-a766-0735aafbb325'), ('17', '7', 'Content', '1', '2018-08-13 12:29:22', '2018-08-13 12:29:22', '4c5f8331-56d0-49b1-9704-017716bffb5d'), ('18', '9', 'Content', '1', '2018-08-13 12:29:22', '2018-08-13 12:29:22', '26cdf9a0-de8c-41ff-97d9-aa35d1eaa624');
COMMIT;

-- ----------------------------
--  Table structure for `fields`
-- ----------------------------
DROP TABLE IF EXISTS `fields`;
CREATE TABLE `fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `instructions` text,
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fields_handle_context_unq_idx` (`handle`,`context`),
  KEY `fields_groupId_idx` (`groupId`),
  KEY `fields_context_idx` (`context`),
  CONSTRAINT `fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `fields`
-- ----------------------------
BEGIN;
INSERT INTO `fields` VALUES ('1', '1', 'Body', 'body', 'global', '', 'site', null, 'craft\\fields\\Matrix', '{\"minBlocks\":\"\",\"maxBlocks\":\"\",\"localizeBlocks\":false}', '2018-08-07 12:18:20', '2018-08-13 12:29:22', '4701cac0-56a8-4760-a317-922e028d8051'), ('2', null, 'Level', 'hx', 'matrixBlockType:1', '', 'none', null, 'craft\\fields\\Dropdown', '{\"options\":[{\"label\":\"One\",\"value\":\"1\",\"default\":\"\"},{\"label\":\"Two\",\"value\":\"2\",\"default\":\"\"}]}', '2018-08-07 12:18:20', '2018-08-13 12:29:22', '0391e981-aea4-4cc3-a6d5-3a0e4f146ab3'), ('3', null, 'Heading', 'heading', 'matrixBlockType:1', '', 'none', null, 'craft\\fields\\PlainText', '{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}', '2018-08-07 12:18:32', '2018-08-13 12:29:22', '10622d2e-6e10-44e9-945d-55acc5e18e0c'), ('4', null, 'Text', 'text', 'matrixBlockType:2', '', 'none', null, 'craft\\redactor\\Field', '{\"redactorConfig\":\"Standard.json\",\"purifierConfig\":\"\",\"cleanupHtml\":\"1\",\"purifyHtml\":\"1\",\"columnType\":\"text\",\"availableVolumes\":\"*\",\"availableTransforms\":\"*\"}', '2018-08-07 12:18:50', '2018-08-13 12:29:22', 'a6a7812b-a171-4add-a0c7-44d045793a7b'), ('5', '1', 'Alt Text', 'alt', 'global', '', 'none', null, 'craft\\fields\\PlainText', '{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}', '2018-08-07 12:20:55', '2018-08-07 12:20:55', '876bf62c-cc2f-4150-b86a-c792508cdda1'), ('6', null, 'Image', 'image', 'matrixBlockType:3', '', 'site', null, 'craft\\fields\\Assets', '{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"folder:1\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"folder:1\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":[\"folder:1\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":\"large\",\"limit\":\"1\",\"selectionLabel\":\"Add an image\",\"localizeRelations\":false}', '2018-08-07 12:22:12', '2018-08-13 12:29:22', '17e17901-095a-4e7a-a712-eec0fb3635df'), ('7', null, 'Quote', 'quote', 'matrixBlockType:4', '', 'none', null, 'craft\\fields\\PlainText', '{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"1\",\"initialRows\":\"2\",\"charLimit\":\"\",\"columnType\":\"text\"}', '2018-08-13 12:29:22', '2018-08-13 12:29:22', 'c0d82766-a2d4-4360-8b2d-902c8a71b570'), ('8', '1', 'Meta Title', 'metaTitle', 'global', '', 'none', null, 'craft\\fields\\PlainText', '{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}', '2018-08-16 12:54:59', '2018-08-16 12:54:59', 'f4414932-9115-45ab-b6b0-599accb8091e'), ('9', '1', 'Meta Description', 'metaDescription', 'global', '', 'none', null, 'craft\\fields\\PlainText', '{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}', '2018-08-16 12:55:10', '2018-08-16 12:55:10', '666d6941-cba2-4dd0-b380-47f0dd333807');
COMMIT;

-- ----------------------------
--  Table structure for `globalsets`
-- ----------------------------
DROP TABLE IF EXISTS `globalsets`;
CREATE TABLE `globalsets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `globalsets_name_unq_idx` (`name`),
  UNIQUE KEY `globalsets_handle_unq_idx` (`handle`),
  KEY `globalsets_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `info`
-- ----------------------------
DROP TABLE IF EXISTS `info`;
CREATE TABLE `info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `edition` tinyint(3) unsigned NOT NULL,
  `timezone` varchar(30) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `on` tinyint(1) NOT NULL DEFAULT '0',
  `maintenance` tinyint(1) NOT NULL DEFAULT '0',
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `info`
-- ----------------------------
BEGIN;
INSERT INTO `info` VALUES ('1', '3.0.20', '3.0.91', '0', 'Europe/London', 'Craft', '1', '0', 'YVuJyuNaBcQL', '2018-08-07 12:08:32', '2018-08-16 12:55:10', '7d20e320-b209-4d59-8384-6a6eda76641b');
COMMIT;

-- ----------------------------
--  Table structure for `matrixblocks`
-- ----------------------------
DROP TABLE IF EXISTS `matrixblocks`;
CREATE TABLE `matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `ownerSiteId` int(11) DEFAULT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `matrixblocks_ownerId_idx` (`ownerId`),
  KEY `matrixblocks_fieldId_idx` (`fieldId`),
  KEY `matrixblocks_typeId_idx` (`typeId`),
  KEY `matrixblocks_sortOrder_idx` (`sortOrder`),
  KEY `matrixblocks_ownerSiteId_idx` (`ownerSiteId`),
  CONSTRAINT `matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerSiteId_fk` FOREIGN KEY (`ownerSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `matrixblocktypes`
-- ----------------------------
DROP TABLE IF EXISTS `matrixblocktypes`;
CREATE TABLE `matrixblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixblocktypes_name_fieldId_unq_idx` (`name`,`fieldId`),
  UNIQUE KEY `matrixblocktypes_handle_fieldId_unq_idx` (`handle`,`fieldId`),
  KEY `matrixblocktypes_fieldId_idx` (`fieldId`),
  KEY `matrixblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `matrixblocktypes`
-- ----------------------------
BEGIN;
INSERT INTO `matrixblocktypes` VALUES ('1', '1', '5', 'Heading', 'heading', '1', '2018-08-07 12:18:20', '2018-08-13 12:29:22', 'ff8cb7fb-b43b-453b-82c3-6886e8d405f2'), ('2', '1', '6', 'Text', 'text', '2', '2018-08-07 12:18:50', '2018-08-13 12:29:22', '9a3db7d5-17bc-4793-aee1-df78593f6079'), ('3', '1', '7', 'Image', 'image', '3', '2018-08-07 12:22:12', '2018-08-13 12:29:22', '759f4bc0-74ef-4455-a9d2-3fd3aeb990bc'), ('4', '1', '9', 'Blockquote', 'blockquote', '4', '2018-08-13 12:29:22', '2018-08-13 12:29:22', '4a6c2d26-17e1-42ce-864f-a1e6880d6548');
COMMIT;

-- ----------------------------
--  Table structure for `matrixcontent_body`
-- ----------------------------
DROP TABLE IF EXISTS `matrixcontent_body`;
CREATE TABLE `matrixcontent_body` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_heading_hx` varchar(255) DEFAULT NULL,
  `field_heading_heading` text,
  `field_text_text` text,
  `field_blockquote_quote` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixcontent_body_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `matrixcontent_body_siteId_fk` (`siteId`),
  CONSTRAINT `matrixcontent_body_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixcontent_body_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `migrations`
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pluginId` int(11) DEFAULT NULL,
  `type` enum('app','plugin','content') NOT NULL DEFAULT 'app',
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `migrations_pluginId_idx` (`pluginId`),
  KEY `migrations_type_pluginId_idx` (`type`,`pluginId`),
  CONSTRAINT `migrations_pluginId_fk` FOREIGN KEY (`pluginId`) REFERENCES `plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `migrations`
-- ----------------------------
BEGIN;
INSERT INTO `migrations` VALUES ('1', null, 'app', 'Install', '2018-08-07 12:08:34', '2018-08-07 12:08:34', '2018-08-07 12:08:34', 'c7530ff6-cc45-4f29-8cfc-cabbf1c64698'), ('2', null, 'app', 'm150403_183908_migrations_table_changes', '2018-08-07 12:08:34', '2018-08-07 12:08:34', '2018-08-07 12:08:34', 'ba47d635-7349-4cfd-bb80-fd4b94b99337'), ('3', null, 'app', 'm150403_184247_plugins_table_changes', '2018-08-07 12:08:34', '2018-08-07 12:08:34', '2018-08-07 12:08:34', 'fb65617c-f644-451c-84a4-7883ecb4ad9a'), ('4', null, 'app', 'm150403_184533_field_version', '2018-08-07 12:08:34', '2018-08-07 12:08:34', '2018-08-07 12:08:34', '18520b29-c8b0-4b98-ab05-08ef75dbc880'), ('5', null, 'app', 'm150403_184729_type_columns', '2018-08-07 12:08:34', '2018-08-07 12:08:34', '2018-08-07 12:08:34', '3e616f65-60f2-4d9b-913e-b90258a192e5'), ('6', null, 'app', 'm150403_185142_volumes', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', 'ec55d5d0-c798-4f0b-a231-ae2042e69102'), ('7', null, 'app', 'm150428_231346_userpreferences', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '6e44b72c-6e1c-4461-8c94-a83fdddfc000'), ('8', null, 'app', 'm150519_150900_fieldversion_conversion', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '043764d1-b311-4960-9484-3964ef443ee8'), ('9', null, 'app', 'm150617_213829_update_email_settings', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '9bd36b9c-8c02-4864-8251-a334e5bb0895'), ('10', null, 'app', 'm150721_124739_templatecachequeries', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '1a9ed3e3-4e21-43cb-92a1-b54b35905041'), ('11', null, 'app', 'm150724_140822_adjust_quality_settings', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '47cd20cc-0310-4435-acc9-bbea72f541d4'), ('12', null, 'app', 'm150815_133521_last_login_attempt_ip', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '27f36542-c125-4939-9d72-437b2ae9a463'), ('13', null, 'app', 'm151002_095935_volume_cache_settings', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '9c4ed731-175c-4062-9b7b-a688a88d5280'), ('14', null, 'app', 'm151005_142750_volume_s3_storage_settings', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', 'f3372c5d-1cbe-45a6-9789-9a29635de02f'), ('15', null, 'app', 'm151016_133600_delete_asset_thumbnails', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '3a9c3e1d-f9f7-43a3-b210-81a8fd756ea1'), ('16', null, 'app', 'm151209_000000_move_logo', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '584e096e-6457-4a69-a758-21d3407a9a02'), ('17', null, 'app', 'm151211_000000_rename_fileId_to_assetId', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '3955ac7e-5d52-40f0-94f3-f62dc282349c'), ('18', null, 'app', 'm151215_000000_rename_asset_permissions', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '15c6b0a3-fbea-47a2-bf8e-a8c8284c2811'), ('19', null, 'app', 'm160707_000001_rename_richtext_assetsource_setting', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', 'd2c19b1a-171c-48bc-a32b-2db6758e52b6'), ('20', null, 'app', 'm160708_185142_volume_hasUrls_setting', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '45a5e51c-dd4c-453f-b4a6-4bd2da023a78'), ('21', null, 'app', 'm160714_000000_increase_max_asset_filesize', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', 'f8453e29-c098-4845-b8f5-3cbf1a88da4a'), ('22', null, 'app', 'm160727_194637_column_cleanup', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '266dd246-e9bc-4395-a3f3-264d1c354dcd'), ('23', null, 'app', 'm160804_110002_userphotos_to_assets', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '390df307-8d9d-46cf-991e-238e32d47ab8'), ('24', null, 'app', 'm160807_144858_sites', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '40bfface-7eb8-408d-afa6-32759b98a3dc'), ('25', null, 'app', 'm160829_000000_pending_user_content_cleanup', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '399c6965-0b20-437e-ad34-3594b704f69d'), ('26', null, 'app', 'm160830_000000_asset_index_uri_increase', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', 'faa41e48-0cf9-4360-89f9-3366ebf59f89'), ('27', null, 'app', 'm160912_230520_require_entry_type_id', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '456e5ecf-043e-4af6-a1e1-56cdbef5286c'), ('28', null, 'app', 'm160913_134730_require_matrix_block_type_id', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '3bb102a6-72f1-42f1-bfc0-f58ff50c3a75'), ('29', null, 'app', 'm160920_174553_matrixblocks_owner_site_id_nullable', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '8f8290b6-32f1-4830-8abd-bfbf9bdbc613'), ('30', null, 'app', 'm160920_231045_usergroup_handle_title_unique', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', 'd926d5d8-af92-4fda-bbe6-a5dd3bd2e4ae'), ('31', null, 'app', 'm160925_113941_route_uri_parts', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', 'e1ecda4b-48c5-46df-b5fa-df0cffc41869'), ('32', null, 'app', 'm161006_205918_schemaVersion_not_null', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', 'd52eae97-445e-413f-bb66-3853d6c9d474'), ('33', null, 'app', 'm161007_130653_update_email_settings', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '96da2e10-9945-4cba-add4-1636c8b1da46'), ('34', null, 'app', 'm161013_175052_newParentId', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', 'cb8bcdbc-6f6f-436c-9c80-156ee69540be'), ('35', null, 'app', 'm161021_102916_fix_recent_entries_widgets', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '014f1cca-868a-4a07-be1d-7b2d6469e08d'), ('36', null, 'app', 'm161021_182140_rename_get_help_widget', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', 'f81df337-10a6-4ec3-9bc4-766f1ae9c45f'), ('37', null, 'app', 'm161025_000000_fix_char_columns', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '838866e4-071b-49aa-8dc1-2afbc4df633f'), ('38', null, 'app', 'm161029_124145_email_message_languages', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '76665fa0-507b-4cc5-bace-2567229fab38'), ('39', null, 'app', 'm161108_000000_new_version_format', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', 'f564774e-6289-4e65-bd0f-de3c96926dce'), ('40', null, 'app', 'm161109_000000_index_shuffle', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', 'a63e2e7e-578a-46df-8bab-ee84b799b53b'), ('41', null, 'app', 'm161122_185500_no_craft_app', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', 'ad9e9144-29f6-4efc-8aa2-51d2042e0df0'), ('42', null, 'app', 'm161125_150752_clear_urlmanager_cache', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', 'c7757066-95a1-4781-81d3-8e473ad19798'), ('43', null, 'app', 'm161220_000000_volumes_hasurl_notnull', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '5c257b34-9299-4db5-995b-9d575a16c36b'), ('44', null, 'app', 'm170114_161144_udates_permission', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '9f45b031-184f-4f95-a3e3-b7f3e026be0b'), ('45', null, 'app', 'm170120_000000_schema_cleanup', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', 'a5ffab76-f6a5-457a-96ae-c58cee88a6e7'), ('46', null, 'app', 'm170126_000000_assets_focal_point', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '9ed5fe2e-1669-496d-94a4-9621b5410dce'), ('47', null, 'app', 'm170206_142126_system_name', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '4a7528de-d5a7-48b3-ac60-fa78d24eb907'), ('48', null, 'app', 'm170217_044740_category_branch_limits', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '3063f3fe-2a33-4f21-b80b-91a216900559'), ('49', null, 'app', 'm170217_120224_asset_indexing_columns', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '9912c13e-a004-49b5-8cb4-ee1046b05d84'), ('50', null, 'app', 'm170223_224012_plain_text_settings', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '463241d9-139c-4ae5-8a3c-f5b42a186fd6'), ('51', null, 'app', 'm170227_120814_focal_point_percentage', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', 'ed827a83-c667-4ebf-aea9-a2a2ebede70d'), ('52', null, 'app', 'm170228_171113_system_messages', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', 'dd8d01ee-21b5-4755-8502-6406b3a994eb'), ('53', null, 'app', 'm170303_140500_asset_field_source_settings', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '078d0e2c-8c21-44bc-b724-d4669b137ada'), ('54', null, 'app', 'm170306_150500_asset_temporary_uploads', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', 'ee7c2484-75dd-4f30-9b84-c82c133c2a44'), ('55', null, 'app', 'm170414_162429_rich_text_config_setting', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '227706ab-b5eb-4aed-acd1-667e025b9af5'), ('56', null, 'app', 'm170523_190652_element_field_layout_ids', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '75f26b62-c163-4a03-8b29-88ba44d264e5'), ('57', null, 'app', 'm170612_000000_route_index_shuffle', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '1563333e-cb2f-4a05-88ec-de193d3da660'), ('58', null, 'app', 'm170621_195237_format_plugin_handles', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '598c76e5-da61-4a35-9bde-84f82c3200c1'), ('59', null, 'app', 'm170630_161028_deprecation_changes', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '70e2220d-1450-4d0a-ac68-f39f4b1336e3'), ('60', null, 'app', 'm170703_181539_plugins_table_tweaks', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '5afb556c-7bba-4fa6-bdb4-6b24d397a34b'), ('61', null, 'app', 'm170704_134916_sites_tables', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', 'e719178e-e75e-408d-91e6-bc886f220691'), ('62', null, 'app', 'm170706_183216_rename_sequences', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '23bcdd2b-7b7e-4010-b992-1af92e57d5ed'), ('63', null, 'app', 'm170707_094758_delete_compiled_traits', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '67307cca-254c-4187-a805-b1885713d830'), ('64', null, 'app', 'm170731_190138_drop_asset_packagist', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '48c8e699-9c95-4396-9d94-d88223a3be71'), ('65', null, 'app', 'm170810_201318_create_queue_table', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2f325426-4399-466a-bca7-d0d70212dca9'), ('66', null, 'app', 'm170816_133741_delete_compiled_behaviors', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '5706ebbf-b41e-4ec4-91cc-f909d13026a5'), ('67', null, 'app', 'm170821_180624_deprecation_line_nullable', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '601d9b94-9589-45e0-b84d-85a9f4da578a'), ('68', null, 'app', 'm170903_192801_longblob_for_queue_jobs', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', 'a5035e90-9964-43b0-bcc6-64c2268dea6b'), ('69', null, 'app', 'm170914_204621_asset_cache_shuffle', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', 'ba1cb67f-cea7-48d6-8cf4-594edf3beaa1'), ('70', null, 'app', 'm171011_214115_site_groups', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', 'f4afef3d-83ae-40a3-a993-032b40d9df18'), ('71', null, 'app', 'm171012_151440_primary_site', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', 'd707e6dd-1a17-444b-8d25-62b8ce0b1615'), ('72', null, 'app', 'm171013_142500_transform_interlace', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', 'f9cf1c36-29b5-481d-a152-f3a1594b254f'), ('73', null, 'app', 'm171016_092553_drop_position_select', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', 'ac1e21cc-db46-4110-ab71-d840c6673234'), ('74', null, 'app', 'm171016_221244_less_strict_translation_method', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', 'f3fdfaa1-4c6f-43a9-8480-08a89c412e77'), ('75', null, 'app', 'm171107_000000_assign_group_permissions', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '4ccc5890-27b3-4870-8960-fbc7c9118b7e'), ('76', null, 'app', 'm171117_000001_templatecache_index_tune', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', 'a11bc07f-5abd-4b83-9256-001165a1e802'), ('77', null, 'app', 'm171126_105927_disabled_plugins', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', 'e04f804d-d66c-4166-a792-e02d3309a4fd'), ('78', null, 'app', 'm171130_214407_craftidtokens_table', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', 'c717d238-af9a-4f43-a204-06844d820c67'), ('79', null, 'app', 'm171202_004225_update_email_settings', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '76645dbd-37c9-43b5-bd5d-d95a7af94f8d'), ('80', null, 'app', 'm171204_000001_templatecache_index_tune_deux', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '5ac76f97-8c2c-4810-940d-b9b37d889f08'), ('81', null, 'app', 'm171205_130908_remove_craftidtokens_refreshtoken_column', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '8d369d24-0fd1-4d1f-85e0-384a9106c25e'), ('82', null, 'app', 'm171218_143135_longtext_query_column', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '7aa38125-678d-46e0-868e-79bc09b9f974'), ('83', null, 'app', 'm171231_055546_environment_variables_to_aliases', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '6bc8f3ea-2cb2-4836-a2be-e986d61a37c1'), ('84', null, 'app', 'm180113_153740_drop_users_archived_column', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '537e68e0-0b0f-483a-9d01-f3e1f0034061'), ('85', null, 'app', 'm180122_213433_propagate_entries_setting', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '03c7fca8-d029-4de8-b3e8-b62d6809b7ce'), ('86', null, 'app', 'm180124_230459_fix_propagate_entries_values', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '49fa9b32-16c2-4fdc-8536-3508cfc8ab6d'), ('87', null, 'app', 'm180128_235202_set_tag_slugs', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '0d48c112-d694-4c43-8b2b-da7d3afd7ca2'), ('88', null, 'app', 'm180202_185551_fix_focal_points', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', 'becc7467-c9b0-45f2-9865-50a408595eae'), ('89', null, 'app', 'm180217_172123_tiny_ints', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2ce73b8f-bccd-481d-af32-d2cc61486fe1'), ('90', null, 'app', 'm180321_233505_small_ints', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '1bd17ab5-3237-4415-b15a-bf6749f9a66b'), ('91', null, 'app', 'm180328_115523_new_license_key_statuses', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '301128a9-4a10-4931-8269-b2359c9164af'), ('92', null, 'app', 'm180404_182320_edition_changes', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', 'd032248f-1c17-4bf0-afa5-bb1a5940990b'), ('93', null, 'app', 'm180411_102218_fix_db_routes', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '33baacb8-b0d4-45fb-b154-e8ffc2da7d80'), ('94', null, 'app', 'm180416_205628_resourcepaths_table', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', 'b48dabe8-b855-46a5-abf2-729d8ecf6edd'), ('95', null, 'app', 'm180418_205713_widget_cleanup', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '2018-08-07 12:08:35', '661fdae0-d9e9-40c0-b32d-62d6a0d5203f'), ('96', '3', 'plugin', 'm180430_204710_remove_old_plugins', '2018-08-07 13:33:51', '2018-08-07 13:33:51', '2018-08-07 13:33:51', 'f6860d2d-7781-475a-bf00-0ee299b5198a'), ('97', '3', 'plugin', 'Install', '2018-08-07 13:33:51', '2018-08-07 13:33:51', '2018-08-07 13:33:51', '7d80a6e5-6b4f-45cd-8605-7709e89ebdc4');
COMMIT;

-- ----------------------------
--  Table structure for `plugins`
-- ----------------------------
DROP TABLE IF EXISTS `plugins`;
CREATE TABLE `plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKey` char(24) DEFAULT NULL,
  `licenseKeyStatus` enum('valid','invalid','mismatched','astray','unknown') NOT NULL DEFAULT 'unknown',
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `settings` text,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `plugins_handle_unq_idx` (`handle`),
  KEY `plugins_enabled_idx` (`enabled`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `plugins`
-- ----------------------------
BEGIN;
INSERT INTO `plugins` VALUES ('1', 'assetrev', '6.0.1', '1.0.0', null, 'unknown', '1', null, '2018-08-07 13:00:02', '2018-08-07 13:00:02', '2018-08-16 12:54:33', '4bbbd43b-8721-40df-bfa5-ff91c672abd3'), ('2', 'cookies', '1.1.10', '1.0.0', null, 'unknown', '1', null, '2018-08-07 13:00:05', '2018-08-07 13:00:05', '2018-08-16 12:54:33', '5f8c3927-7e2b-4867-b12c-5418b8ad80cd'), ('3', 'redactor', '2.1.5', '2.0.0', null, 'unknown', '1', null, '2018-08-07 13:33:51', '2018-08-07 13:33:51', '2018-08-16 12:54:33', '2e60c607-6485-4b33-84b2-3bbd6a6bf9c0');
COMMIT;

-- ----------------------------
--  Table structure for `queue`
-- ----------------------------
DROP TABLE IF EXISTS `queue`;
CREATE TABLE `queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job` longblob NOT NULL,
  `description` text,
  `timePushed` int(11) NOT NULL,
  `ttr` int(11) NOT NULL,
  `delay` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) unsigned NOT NULL DEFAULT '1024',
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int(11) DEFAULT NULL,
  `progress` smallint(6) NOT NULL DEFAULT '0',
  `attempt` int(11) DEFAULT NULL,
  `fail` tinyint(1) DEFAULT '0',
  `dateFailed` datetime DEFAULT NULL,
  `error` text,
  PRIMARY KEY (`id`),
  KEY `queue_fail_timeUpdated_timePushed_idx` (`fail`,`timeUpdated`,`timePushed`),
  KEY `queue_fail_timeUpdated_delay_idx` (`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `relations`
-- ----------------------------
DROP TABLE IF EXISTS `relations`;
CREATE TABLE `relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `sourceSiteId` int(11) DEFAULT NULL,
  `targetId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `relations_fieldId_sourceId_sourceSiteId_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `relations_sourceId_idx` (`sourceId`),
  KEY `relations_targetId_idx` (`targetId`),
  KEY `relations_sourceSiteId_idx` (`sourceSiteId`),
  CONSTRAINT `relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `resourcepaths`
-- ----------------------------
DROP TABLE IF EXISTS `resourcepaths`;
CREATE TABLE `resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `resourcepaths`
-- ----------------------------
BEGIN;
INSERT INTO `resourcepaths` VALUES ('143633f', '@lib/selectize'), ('17eb5b9', '@app/web/assets/login/dist'), ('180d874a', '@app/web/assets/recententries/dist'), ('18e0c423', '@lib/datepicker-i18n'), ('19feb954', '@app/web/assets/recententries/dist'), ('1e78edec', '@app/web/assets/pluginstore/dist'), ('1f8bd3f2', '@app/web/assets/pluginstore/dist'), ('2053b749', '@craft/web/assets/plugins/dist'), ('26b7c524', '@app/web/assets/updateswidget/dist'), ('2744fb3a', '@app/web/assets/updateswidget/dist'), ('282569e5', '@app/web/assets/craftsupport/dist'), ('2935a31c', '@sproutbase/web/assets/cp/dist'), ('29d657fb', '@app/web/assets/craftsupport/dist'), ('3213a935', '@app/web/assets/generalsettings/dist'), ('34d07fc0', '@lib/timepicker'), ('36e2971b', '@app/web/assets/updater/dist'), ('37800678', '@sproutbase/app/seo/web/assets/general/dist'), ('3eed06f8', '@lib/jquery-ui'), ('3f1e38e6', '@lib/jquery-ui'), ('4b39ed9', '@app/web/assets/cp/dist'), ('4c628108', '@app/web/assets/matrixsettings/dist'), ('4d91bf16', '@app/web/assets/matrixsettings/dist'), ('4dd54f45', '@lib/fileupload'), ('4e5bc1d5', '@lib/element-resize-detector'), ('4fa8ffcb', '@lib/element-resize-detector'), ('52997279', '@lib/jquery-touch-events'), ('53ee52b9', '@app/web/assets/routes/dist'), ('540a0c7', '@app/web/assets/cp/dist'), ('553d4ebb', '@lib/picturefill'), ('581295c6', '@lib'), ('59e1abd8', '@lib'), ('5b986eea', '@lib/d3'), ('5eb73497', '@app/web/assets/editentry/dist'), ('6038543e', '@bower/jquery/dist'), ('61cb6a20', '@bower/jquery/dist'), ('61ec39e6', '@app/web/assets/updates/dist'), ('66c8dc48', '@app/web/assets/utilities/dist'), ('673be256', '@app/web/assets/utilities/dist'), ('6825796c', '@lib/garnishjs'), ('6c6332b5', '@lib/jquery.payment'), ('6d900cab', '@lib/jquery.payment'), ('6e118c09', '@app/web/assets/tablesettings/dist'), ('6fe2b217', '@app/web/assets/tablesettings/dist'), ('70449d5d', '@lib/velocity'), ('71b7a343', '@lib/velocity'), ('721dc3b2', '@sproutbase/app/seo/web/assets/globals/dist'), ('74ec9544', '@sproutbase/app/seo/web/assets/sitemaps/dist'), ('76a63345', '@sproutbase/app/seo/web/assets/redirects/dist'), ('7976d8d9', '@app/web/assets/fields/dist'), ('7c5beb79', '@app/web/assets/feed/dist'), ('7d63ad52', '@lib/fabric'), ('7da8d567', '@app/web/assets/feed/dist'), ('7e11f697', '@app/web/assets/dashboard/dist'), ('8486a398', '@app/web/assets/plugins/dist'), ('86b11ee4', '@lib/jquery-ui'), ('8c8c67dc', '@lib/timepicker'), ('8d7f59c2', '@lib/timepicker'), ('8d8ba7', '@app/web/assets/login/dist'), ('8df42cfe', '@sproutbase/app/fields/web/assets/selectother/dist'), ('8ebe8f07', '@app/web/assets/updater/dist'), ('907971f9', '@app/web/assets/craftsupport/dist'), ('965b95de', '@sproutbase/app/fields/web/assets/address/dist'), ('9eebdd38', '@app/web/assets/updateswidget/dist'), ('a0519f56', '@app/web/assets/recententries/dist'), ('a0bcdc3f', '@lib/datepicker-i18n'), ('a14fe221', '@lib/datepicker-i18n'), ('a624f5f0', '@app/web/assets/pluginstore/dist'), ('aec35e58', '@app/web/assets/edituser/dist'), ('b28001b7', '@lib/xregexp'), ('b2f27b5', '@lib/xregexp'), ('b3733fa9', '@lib/xregexp'), ('b64b6e17', '@craft/web/assets/pluginstore/dist'), ('b8ec453d', '@lib/selectize'), ('b91f7b23', '@lib/selectize'), ('b922ada5', '@app/web/assets/login/dist'), ('bd1cb8db', '@app/web/assets/cp/dist'), ('bf305e6a', '@craft/web/assets/cp/dist'), ('c0d9fedb', '@app/web/assets/fields/dist'), ('c12ac0c5', '@app/web/assets/fields/dist'), ('c407f365', '@app/web/assets/feed/dist'), ('c4cc8b50', '@lib/fabric'), ('c53fb54e', '@lib/fabric'), ('c64dee8b', '@app/web/assets/dashboard/dist'), ('c7bed095', '@app/web/assets/dashboard/dist'), ('c7d1fc8e', '@app/web/assets/deprecationerrors/dist'), ('c8188541', '@lib/velocity'), ('c90d042c', '@sproutbaselib'), ('d0796170', '@lib/garnishjs'), ('d18a5f6e', '@lib/garnishjs'), ('d43f2aa9', '@lib/jquery.payment'), ('d64d9415', '@app/web/assets/tablesettings/dist'), ('d8431fe4', '@app/web/assets/updates/dist'), ('d997723c', '@bower/jquery/dist'), ('d9b021fa', '@app/web/assets/updates/dist'), ('df67fa4a', '@app/web/assets/utilities/dist'), ('e1bdb3c4', '@lib'), ('e23748e8', '@lib/d3'), ('e3c476f6', '@lib/d3'), ('e4044918', '@sproutbase/app/seo/web/assets/base/dist'), ('e84360ec', '@lib/prismjs'), ('eac56a65', '@lib/jquery-touch-events'), ('eb36547b', '@lib/jquery-touch-events'), ('ec9268b9', '@lib/picturefill'), ('ed6156a7', '@lib/picturefill'), ('f0808705', '@app/web/assets/sites/dist'), ('f47a6947', '@lib/fileupload'), ('f5895759', '@lib/fileupload'), ('f5cda70a', '@app/web/assets/matrixsettings/dist'), ('f607d9c9', '@lib/element-resize-detector'), ('f8382dc3', '@sproutbase/app/fields/web/assets');
COMMIT;

-- ----------------------------
--  Table structure for `routes`
-- ----------------------------
DROP TABLE IF EXISTS `routes`;
CREATE TABLE `routes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) DEFAULT NULL,
  `uriParts` varchar(255) NOT NULL,
  `uriPattern` varchar(255) NOT NULL,
  `template` varchar(500) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `routes_uriPattern_idx` (`uriPattern`),
  KEY `routes_siteId_idx` (`siteId`),
  CONSTRAINT `routes_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `searchindex`
-- ----------------------------
DROP TABLE IF EXISTS `searchindex`;
CREATE TABLE `searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `searchindex`
-- ----------------------------
BEGIN;
INSERT INTO `searchindex` VALUES ('1', 'username', '0', '1', ' webdev nixondesign com '), ('1', 'firstname', '0', '1', ' admin '), ('1', 'lastname', '0', '1', ''), ('1', 'fullname', '0', '1', ' admin '), ('1', 'email', '0', '1', ' webdev nixondesign com '), ('1', 'slug', '0', '1', ''), ('2', 'slug', '0', '1', ' homepage '), ('2', 'title', '0', '1', ' homepage '), ('3', 'slug', '0', '1', ' 404 '), ('3', 'title', '0', '1', ' 404 ');
COMMIT;

-- ----------------------------
--  Table structure for `sections`
-- ----------------------------
DROP TABLE IF EXISTS `sections`;
CREATE TABLE `sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT '0',
  `propagateEntries` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sections_handle_unq_idx` (`handle`),
  UNIQUE KEY `sections_name_unq_idx` (`name`),
  KEY `sections_structureId_idx` (`structureId`),
  CONSTRAINT `sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `sections`
-- ----------------------------
BEGIN;
INSERT INTO `sections` VALUES ('1', null, 'Homepage', 'homepage', 'single', '0', '1', '2018-08-07 12:16:42', '2018-08-07 12:16:42', 'cd76d816-5b40-4793-914d-ea5fa32b924a'), ('2', null, '404', 'notFound', 'single', '0', '1', '2018-08-07 12:17:01', '2018-08-07 12:17:01', '217271a2-f3b2-4d0a-88c6-2540a903f800');
COMMIT;

-- ----------------------------
--  Table structure for `sections_sites`
-- ----------------------------
DROP TABLE IF EXISTS `sections_sites`;
CREATE TABLE `sections_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sections_sites_sectionId_siteId_unq_idx` (`sectionId`,`siteId`),
  KEY `sections_sites_siteId_idx` (`siteId`),
  CONSTRAINT `sections_sites_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sections_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `sections_sites`
-- ----------------------------
BEGIN;
INSERT INTO `sections_sites` VALUES ('1', '1', '1', '1', '__home__', 'index', '1', '2018-08-07 12:16:42', '2018-08-07 12:16:42', '944ac83d-268b-4681-ae57-78d871208a4d'), ('2', '2', '1', '1', '404', '404', '1', '2018-08-07 12:17:01', '2018-08-07 12:17:01', 'd40adf0e-fa9b-4ba7-886f-433ff7caf7a8');
COMMIT;

-- ----------------------------
--  Table structure for `sessions`
-- ----------------------------
DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sessions_uid_idx` (`uid`),
  KEY `sessions_token_idx` (`token`),
  KEY `sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `sessions_userId_idx` (`userId`),
  CONSTRAINT `sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `sessions`
-- ----------------------------
BEGIN;
INSERT INTO `sessions` VALUES ('1', '1', 'z_TqvM3ONUQKCnh4bKIjnm--NtMxfkIyct6ITBcoa__LikoSO0JTOpDGrAE4XkMRUWoCGBTl6jZzTmxmR9WBu78iBD2nuNog9bTL', '2018-08-07 15:51:24', '2018-08-07 16:19:18', 'bca94bed-3a9f-4b5f-a73e-e3b8f9fe96d4'), ('2', '1', 'ZDDrxxLOycqFmhI-KeqNZtmlVsTNy_uE90BGMDvJQMbZmbR_A8vMKWVvMdYMKXx9v33xEG5L-l3mhv-t_xOIGX5e5kyPg-KVuQtH', '2018-08-08 08:04:32', '2018-08-08 08:08:22', 'fa802eec-ad7a-4f09-b517-4c9c78aafb2f'), ('3', '1', 'L4RJik6sCZlCI83aS6Jxt-t8BXdKvC_IymTFCa-gtmhR0clLP1SBAed5gdPLz-wXP1fu-Ffb-AtvnN42LMT_ZZ8u82_xNeaFssao', '2018-08-13 12:23:28', '2018-08-13 12:50:28', 'fe7daad8-966a-4e32-bd93-aa398d83173c'), ('4', '1', 'rS8jZLv3rm84T4hkkbD0PIDaf-h0pSoHYts7hmKnT5xhQqly4M1rXQP7YTvloMNj6L7uUM10UwbNMO4wwUFfAGXSWkYM-tZjFQ8b', '2018-08-13 16:12:40', '2018-08-13 16:16:51', '859c55ab-96b9-4197-80f0-722af5850453'), ('5', '1', 'kvZ5AJHEWShyxVnlD02FjlN7ztMxl2SZV8YWmZN5FBYERg6zsce7eAMEwqJCogcoAJ-VN4XVMb1Yg0G7tlRjyqzCnRCfYHynnL4x', '2018-08-13 16:12:43', '2018-08-13 16:12:43', '6276cc49-2e40-46e2-b231-32fa8542dd62'), ('6', '1', '01oIk0MK6hGxim_anVfhlVMAMmVrAqxMOWmstg8LmKi-2WgG7TLKmoC_MC9q0MwCuayjhtdWhbbeajrAwKhAz5vHe0XNADlXoyTy', '2018-08-14 07:51:14', '2018-08-14 07:51:21', '54f1cdf2-ec96-48c4-9a4e-1a2145fde543'), ('7', '1', '_Y-N7iH0eVdfnZ7AjdYULALnGoxth_aq6gXFc_LDKRtHqkMpT5cbUuaMTes7ToQl15Cw7v1mtcKEQ-ZH2PIndAAVOulQ7Rjt-tfF', '2018-08-14 12:04:06', '2018-08-14 12:05:26', '1561e749-3e99-404e-b9a3-a627e59eb23a'), ('8', '1', 'AKPaVJ86LyD7TZz1jFxGk5RYBZVU0ARxIX7CIqFPb421C2Wht_Rl-U59xQIJ-dnMOuLoks1mabwd5PuinAQpoe5BbAIjZ3lrLWYV', '2018-08-15 14:57:06', '2018-08-15 15:11:04', '86d55eb4-89ce-4b58-8fff-7e4828c474b2'), ('9', '1', 'BoGm0zLg5Ix1TIqOVCeF8a9b-pWhIAH2tsf7OjPzFJXLQ9TG5DStAydCY3uQhplVVrdj8ICPp-vAvbSxpzIBG6ykd-9Y_NQjnpns', '2018-08-16 12:54:05', '2018-08-16 12:54:06', '33515d6b-73ac-436e-9942-df051723c198'), ('10', '1', 'Rtwd99va8_5bsZM_otIZ2LcQA5cwTi7Pw22WIx2c-LuUBmg05FBCFR69tNwah_1LdnQTgkXPKTnwf1nQZ2EU3fZqH4NkllvqtU-p', '2018-08-16 12:54:08', '2018-08-16 12:55:21', 'b990f8b1-ac75-4817-a4e7-ed5f691ab33a');
COMMIT;

-- ----------------------------
--  Table structure for `shunnedmessages`
-- ----------------------------
DROP TABLE IF EXISTS `shunnedmessages`;
CREATE TABLE `shunnedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `sitegroups`
-- ----------------------------
DROP TABLE IF EXISTS `sitegroups`;
CREATE TABLE `sitegroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sitegroups_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `sitegroups`
-- ----------------------------
BEGIN;
INSERT INTO `sitegroups` VALUES ('1', 'Craft', '2018-08-07 12:08:32', '2018-08-08 08:08:14', 'b002b451-ae28-4af6-a1ce-f337bafbab62');
COMMIT;

-- ----------------------------
--  Table structure for `sites`
-- ----------------------------
DROP TABLE IF EXISTS `sites`;
CREATE TABLE `sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '0',
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sites_handle_unq_idx` (`handle`),
  KEY `sites_sortOrder_idx` (`sortOrder`),
  KEY `sites_groupId_fk` (`groupId`),
  CONSTRAINT `sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `sites`
-- ----------------------------
BEGIN;
INSERT INTO `sites` VALUES ('1', '1', '1', 'Craft', 'default', 'en-GB', '1', '@web/', '1', '2018-08-07 12:08:32', '2018-08-08 08:08:04', '9978fe2d-72ad-43eb-9c84-d32117e99b69');
COMMIT;

-- ----------------------------
--  Table structure for `sproutfields_addresses`
-- ----------------------------
DROP TABLE IF EXISTS `sproutfields_addresses`;
CREATE TABLE `sproutfields_addresses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) DEFAULT NULL,
  `siteId` int(11) DEFAULT NULL,
  `fieldId` int(11) DEFAULT NULL,
  `countryCode` varchar(255) DEFAULT NULL,
  `administrativeArea` varchar(255) DEFAULT NULL,
  `locality` varchar(255) DEFAULT NULL,
  `dependentLocality` varchar(255) DEFAULT NULL,
  `postalCode` varchar(255) DEFAULT NULL,
  `sortingCode` varchar(255) DEFAULT NULL,
  `address1` varchar(255) DEFAULT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `structureelements`
-- ----------------------------
DROP TABLE IF EXISTS `structureelements`;
CREATE TABLE `structureelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `structureelements_root_idx` (`root`),
  KEY `structureelements_lft_idx` (`lft`),
  KEY `structureelements_rgt_idx` (`rgt`),
  KEY `structureelements_level_idx` (`level`),
  KEY `structureelements_elementId_idx` (`elementId`),
  CONSTRAINT `structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `structures`
-- ----------------------------
DROP TABLE IF EXISTS `structures`;
CREATE TABLE `structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `structures`
-- ----------------------------
BEGIN;
INSERT INTO `structures` VALUES ('1', '1', '2018-08-07 13:50:24', '2018-08-07 13:50:24', 'd1acef5c-9062-4b11-8d07-708a170bc4ab');
COMMIT;

-- ----------------------------
--  Table structure for `systemmessages`
-- ----------------------------
DROP TABLE IF EXISTS `systemmessages`;
CREATE TABLE `systemmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `systemmessages_key_language_unq_idx` (`key`,`language`),
  KEY `systemmessages_language_idx` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `systemsettings`
-- ----------------------------
DROP TABLE IF EXISTS `systemsettings`;
CREATE TABLE `systemsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(15) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `systemsettings_category_unq_idx` (`category`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `systemsettings`
-- ----------------------------
BEGIN;
INSERT INTO `systemsettings` VALUES ('1', 'email', '{\"fromEmail\":\"webdev@nixondesign.com\",\"fromName\":\"Www Craft\",\"transportType\":\"craft\\\\mail\\\\transportadapters\\\\Sendmail\"}', '2018-08-07 12:08:34', '2018-08-07 12:08:34', '3f89b377-eade-495d-8af3-d960ea3ac0db'), ('2', 'users', '{\"requireEmailVerification\":true,\"allowPublicRegistration\":false,\"defaultGroup\":null,\"photoVolumeId\":\"1\",\"photoSubpath\":\"\"}', '2018-08-07 12:14:22', '2018-08-07 12:15:44', '11714210-a27d-4289-8762-4b24b375b24a');
COMMIT;

-- ----------------------------
--  Table structure for `taggroups`
-- ----------------------------
DROP TABLE IF EXISTS `taggroups`;
CREATE TABLE `taggroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `taggroups_name_unq_idx` (`name`),
  UNIQUE KEY `taggroups_handle_unq_idx` (`handle`),
  KEY `taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `tags`
-- ----------------------------
DROP TABLE IF EXISTS `tags`;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `tags_groupId_idx` (`groupId`),
  CONSTRAINT `tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tags_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `templatecacheelements`
-- ----------------------------
DROP TABLE IF EXISTS `templatecacheelements`;
CREATE TABLE `templatecacheelements` (
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  KEY `templatecacheelements_cacheId_idx` (`cacheId`),
  KEY `templatecacheelements_elementId_idx` (`elementId`),
  CONSTRAINT `templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `templatecachequeries`
-- ----------------------------
DROP TABLE IF EXISTS `templatecachequeries`;
CREATE TABLE `templatecachequeries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecachequeries_cacheId_idx` (`cacheId`),
  KEY `templatecachequeries_type_idx` (`type`),
  CONSTRAINT `templatecachequeries_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `templatecaches`
-- ----------------------------
DROP TABLE IF EXISTS `templatecaches`;
CREATE TABLE `templatecaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) NOT NULL,
  `cacheKey` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_path_idx` (`cacheKey`,`siteId`,`expiryDate`,`path`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_idx` (`cacheKey`,`siteId`,`expiryDate`),
  KEY `templatecaches_siteId_idx` (`siteId`),
  CONSTRAINT `templatecaches_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `tokens`
-- ----------------------------
DROP TABLE IF EXISTS `tokens`;
CREATE TABLE `tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text,
  `usageLimit` tinyint(3) unsigned DEFAULT NULL,
  `usageCount` tinyint(3) unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tokens_token_unq_idx` (`token`),
  KEY `tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `usergroups`
-- ----------------------------
DROP TABLE IF EXISTS `usergroups`;
CREATE TABLE `usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_handle_unq_idx` (`handle`),
  UNIQUE KEY `usergroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `usergroups_users`
-- ----------------------------
DROP TABLE IF EXISTS `usergroups_users`;
CREATE TABLE `usergroups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `usergroups_users_userId_idx` (`userId`),
  CONSTRAINT `usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `userpermissions`
-- ----------------------------
DROP TABLE IF EXISTS `userpermissions`;
CREATE TABLE `userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `userpermissions_usergroups`
-- ----------------------------
DROP TABLE IF EXISTS `userpermissions_usergroups`;
CREATE TABLE `userpermissions_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `userpermissions_usergroups_groupId_idx` (`groupId`),
  CONSTRAINT `userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `userpermissions_users`
-- ----------------------------
DROP TABLE IF EXISTS `userpermissions_users`;
CREATE TABLE `userpermissions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `userpermissions_users_userId_idx` (`userId`),
  CONSTRAINT `userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `userpreferences`
-- ----------------------------
DROP TABLE IF EXISTS `userpreferences`;
CREATE TABLE `userpreferences` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `preferences` text,
  PRIMARY KEY (`userId`),
  CONSTRAINT `userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `userpreferences`
-- ----------------------------
BEGIN;
INSERT INTO `userpreferences` VALUES ('1', '{\"language\":\"en-GB\",\"weekStartDay\":\"0\",\"enableDebugToolbarForSite\":true,\"enableDebugToolbarForCp\":true}');
COMMIT;

-- ----------------------------
--  Table structure for `users`
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int(11) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `suspended` tinyint(1) NOT NULL DEFAULT '0',
  `pending` tinyint(1) NOT NULL DEFAULT '0',
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(3) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT '0',
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT '0',
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_username_unq_idx` (`username`),
  UNIQUE KEY `users_email_unq_idx` (`email`),
  KEY `users_uid_idx` (`uid`),
  KEY `users_verificationCode_idx` (`verificationCode`),
  KEY `users_photoId_fk` (`photoId`),
  CONSTRAINT `users_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `users`
-- ----------------------------
BEGIN;
INSERT INTO `users` VALUES ('1', 'webdev@nixondesign.com', null, 'Admin', '', 'webdev@nixondesign.com', '$2y$13$PPI/ddassnq.CV52Qcz18ujZB31X8VgKTsbK6/OagaNgolKUo51ia', '1', '0', '0', '0', '2018-08-16 12:54:08', '::1', null, null, null, null, '1', null, null, null, '0', '2018-08-07 12:08:34', '2018-08-07 12:08:34', '2018-08-16 12:54:08', 'c574fe83-4619-42e4-b6b7-3184335d42b5');
COMMIT;

-- ----------------------------
--  Table structure for `volumefolders`
-- ----------------------------
DROP TABLE IF EXISTS `volumefolders`;
CREATE TABLE `volumefolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `volumefolders_name_parentId_volumeId_unq_idx` (`name`,`parentId`,`volumeId`),
  KEY `volumefolders_parentId_idx` (`parentId`),
  KEY `volumefolders_volumeId_idx` (`volumeId`),
  CONSTRAINT `volumefolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `volumefolders_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `volumefolders`
-- ----------------------------
BEGIN;
INSERT INTO `volumefolders` VALUES ('1', null, '1', 'Images', '', '2018-08-07 12:12:51', '2018-08-07 12:12:51', '835ba824-18cb-4858-a144-22876c46f6c4'), ('2', null, '2', 'Documents', '', '2018-08-07 12:13:35', '2018-08-07 12:16:13', '3bcafb89-3480-4778-a00a-2aab8a5e8d52'), ('3', null, null, 'Temporary source', null, '2018-08-07 12:14:58', '2018-08-07 12:14:58', '853a1da5-6b02-4fa6-86b0-e18e67e86747'), ('4', '3', null, 'user_1', 'user_1/', '2018-08-07 12:14:58', '2018-08-07 12:14:58', '91f51408-4b52-4d7e-bc7a-3341576286b1'), ('5', null, '3', 'User Uploads', '', '2018-08-13 08:05:43', '2018-08-13 08:06:45', '676b6b81-0b59-48c3-a3aa-cd8196a7275a');
COMMIT;

-- ----------------------------
--  Table structure for `volumes`
-- ----------------------------
DROP TABLE IF EXISTS `volumes`;
CREATE TABLE `volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `url` varchar(255) DEFAULT NULL,
  `settings` text,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `volumes_name_unq_idx` (`name`),
  UNIQUE KEY `volumes_handle_unq_idx` (`handle`),
  KEY `volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `volumes`
-- ----------------------------
BEGIN;
INSERT INTO `volumes` VALUES ('1', '1', 'Images', 'images', 'craft\\volumes\\Local', '1', '@web/uploads/images', '{\"path\":\"@webroot/uploads/images\"}', '1', '2018-08-07 12:12:51', '2018-08-13 08:05:51', 'd7b8e190-9738-47af-adcb-5b14d94013fe'), ('2', '2', 'Documents', 'documents', 'craft\\volumes\\Local', '1', '@web/uploads/documents', '{\"path\":\"@webroot/uploads/documents\"}', '2', '2018-08-07 12:13:35', '2018-08-07 12:16:13', 'bd0dda93-4758-4d6a-a5cc-5e0546f22f98'), ('3', '8', 'User Uploads', 'users', 'craft\\volumes\\Local', '1', '@web/uploads/users', '{\"path\":\"@webroot/uploads/users\"}', '3', '2018-08-13 08:05:43', '2018-08-13 08:06:45', '07cce1d8-f65e-4ff7-b431-d24717453aba');
COMMIT;

-- ----------------------------
--  Table structure for `widgets`
-- ----------------------------
DROP TABLE IF EXISTS `widgets`;
CREATE TABLE `widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `colspan` tinyint(1) NOT NULL DEFAULT '0',
  `settings` text,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `widgets_userId_idx` (`userId`),
  CONSTRAINT `widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `widgets`
-- ----------------------------
BEGIN;
INSERT INTO `widgets` VALUES ('1', '1', 'craft\\widgets\\RecentEntries', '1', '0', '{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}', '1', '2018-08-07 12:08:36', '2018-08-07 12:08:36', 'dfc1e20a-de0c-4020-b5c8-9c9163396b34'), ('2', '1', 'craft\\widgets\\CraftSupport', '2', '0', '[]', '1', '2018-08-07 12:08:36', '2018-08-07 12:08:36', '46bb4410-9d7e-456f-9f38-84106201d0ce'), ('3', '1', 'craft\\widgets\\Updates', '3', '0', '[]', '1', '2018-08-07 12:08:36', '2018-08-07 12:08:36', 'b4fa4ace-e874-42fb-8bb4-04b4df14dabb'), ('4', '1', 'craft\\widgets\\Feed', '4', '0', '{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}', '1', '2018-08-07 12:08:36', '2018-08-07 12:08:36', 'e7fef810-88c1-4bbd-9cf7-0711869b7c00');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
