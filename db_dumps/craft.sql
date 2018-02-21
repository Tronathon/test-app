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

 Date: 02/21/2018 15:43:51 PM
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `craft_assetindexdata`
-- ----------------------------
DROP TABLE IF EXISTS `craft_assetindexdata`;
CREATE TABLE `craft_assetindexdata` (
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
  KEY `craft_assetindexdata_sessionId_volumeId_idx` (`sessionId`,`volumeId`),
  KEY `craft_assetindexdata_volumeId_idx` (`volumeId`),
  CONSTRAINT `craft_assetindexdata_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `craft_volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9561 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `craft_assets`
-- ----------------------------
DROP TABLE IF EXISTS `craft_assets`;
CREATE TABLE `craft_assets` (
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
  UNIQUE KEY `craft_assets_filename_folderId_unq_idx` (`filename`,`folderId`),
  KEY `craft_assets_folderId_idx` (`folderId`),
  KEY `craft_assets_volumeId_idx` (`volumeId`),
  CONSTRAINT `craft_assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `craft_volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_assets_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `craft_volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `craft_assettransformindex`
-- ----------------------------
DROP TABLE IF EXISTS `craft_assettransformindex`;
CREATE TABLE `craft_assettransformindex` (
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
  KEY `craft_assettransformindex_volumeId_assetId_location_idx` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `craft_assettransforms`
-- ----------------------------
DROP TABLE IF EXISTS `craft_assettransforms`;
CREATE TABLE `craft_assettransforms` (
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
  UNIQUE KEY `craft_assettransforms_name_unq_idx` (`name`),
  UNIQUE KEY `craft_assettransforms_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `craft_categories`
-- ----------------------------
DROP TABLE IF EXISTS `craft_categories`;
CREATE TABLE `craft_categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_categories_groupId_idx` (`groupId`),
  CONSTRAINT `craft_categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_categories_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `craft_categorygroups`
-- ----------------------------
DROP TABLE IF EXISTS `craft_categorygroups`;
CREATE TABLE `craft_categorygroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_categorygroups_name_unq_idx` (`name`),
  UNIQUE KEY `craft_categorygroups_handle_unq_idx` (`handle`),
  KEY `craft_categorygroups_structureId_idx` (`structureId`),
  KEY `craft_categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `craft_categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `craft_structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `craft_categorygroups_sites`
-- ----------------------------
DROP TABLE IF EXISTS `craft_categorygroups_sites`;
CREATE TABLE `craft_categorygroups_sites` (
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
  UNIQUE KEY `craft_categorygroups_sites_groupId_siteId_unq_idx` (`groupId`,`siteId`),
  KEY `craft_categorygroups_sites_siteId_idx` (`siteId`),
  CONSTRAINT `craft_categorygroups_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_categorygroups_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `craft_content`
-- ----------------------------
DROP TABLE IF EXISTS `craft_content`;
CREATE TABLE `craft_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_metaTitle` text,
  `field_metaDescription` text,
  `field_googleAnalyticsId` text,
  `field_hotjarId` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `craft_content_siteId_idx` (`siteId`),
  KEY `craft_content_title_idx` (`title`),
  CONSTRAINT `craft_content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `craft_content`
-- ----------------------------
BEGIN;
INSERT INTO `craft_content` VALUES ('1', '1', '1', null, '2018-02-20 15:35:51', '2018-02-20 15:35:51', '72eea126-2989-4ebe-a319-dd8ea09772cd', null, null, null, null), ('2', '2', '1', 'Homepage', '2018-02-20 15:38:39', '2018-02-20 15:38:39', '410a043f-a4d5-44be-99b8-289f0e293a1c', null, null, null, null), ('3', '3', '1', 'Not Found', '2018-02-20 15:39:10', '2018-02-20 15:39:10', '37142cd3-6325-4d30-9780-97dfa83bd413', null, null, null, null), ('4', '4', '1', null, '2018-02-21 11:49:40', '2018-02-21 11:50:10', '0724180f-0410-4558-9ebd-8de6ce4937a5', null, null, null, null);
COMMIT;

-- ----------------------------
--  Table structure for `craft_craftidtokens`
-- ----------------------------
DROP TABLE IF EXISTS `craft_craftidtokens`;
CREATE TABLE `craft_craftidtokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_craftidtokens_userId_fk` (`userId`),
  CONSTRAINT `craft_craftidtokens_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `craft_deprecationerrors`
-- ----------------------------
DROP TABLE IF EXISTS `craft_deprecationerrors`;
CREATE TABLE `craft_deprecationerrors` (
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
  UNIQUE KEY `craft_deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `craft_elementindexsettings`
-- ----------------------------
DROP TABLE IF EXISTS `craft_elementindexsettings`;
CREATE TABLE `craft_elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `craft_elementindexsettings`
-- ----------------------------
BEGIN;
INSERT INTO `craft_elementindexsettings` VALUES ('1', 'craft\\elements\\Entry', '{\"sources\":{\"*\":{\"tableAttributes\":{\"1\":\"section\",\"2\":\"link\"}}}}', '2018-02-20 15:39:31', '2018-02-20 15:39:31', 'd826a402-2b47-4f2e-8a1d-468920e4704a');
COMMIT;

-- ----------------------------
--  Table structure for `craft_elements`
-- ----------------------------
DROP TABLE IF EXISTS `craft_elements`;
CREATE TABLE `craft_elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `craft_elements_type_idx` (`type`),
  KEY `craft_elements_enabled_idx` (`enabled`),
  KEY `craft_elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  CONSTRAINT `craft_elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `craft_elements`
-- ----------------------------
BEGIN;
INSERT INTO `craft_elements` VALUES ('1', null, 'craft\\elements\\User', '1', '0', '2018-02-20 15:35:51', '2018-02-20 15:35:51', '1c24934b-d6d1-44ae-91ed-92aae62c3bf4'), ('2', '1', 'craft\\elements\\Entry', '1', '0', '2018-02-20 15:38:39', '2018-02-20 15:38:39', '48c343a5-bbe7-4202-828e-f47c927864e3'), ('3', '2', 'craft\\elements\\Entry', '1', '0', '2018-02-20 15:39:10', '2018-02-20 15:39:10', '6d10bcdd-d215-41b4-b0e6-ea517b839d0f'), ('4', '3', 'craft\\elements\\GlobalSet', '1', '0', '2018-02-21 11:49:40', '2018-02-21 11:50:10', '76d8397d-a26a-4dda-8bcb-2f42001733ce');
COMMIT;

-- ----------------------------
--  Table structure for `craft_elements_sites`
-- ----------------------------
DROP TABLE IF EXISTS `craft_elements_sites`;
CREATE TABLE `craft_elements_sites` (
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
  UNIQUE KEY `craft_elements_sites_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  UNIQUE KEY `craft_elements_sites_uri_siteId_unq_idx` (`uri`,`siteId`),
  KEY `craft_elements_sites_siteId_idx` (`siteId`),
  KEY `craft_elements_sites_slug_siteId_idx` (`slug`,`siteId`),
  KEY `craft_elements_sites_enabled_idx` (`enabled`),
  CONSTRAINT `craft_elements_sites_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_elements_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `craft_elements_sites`
-- ----------------------------
BEGIN;
INSERT INTO `craft_elements_sites` VALUES ('1', '1', '1', null, null, '1', '2018-02-20 15:35:51', '2018-02-20 15:35:51', '538a1a80-2412-4c37-9e2e-d66d2a2d3c4e'), ('2', '2', '1', 'homepage', '__home__', '1', '2018-02-20 15:38:39', '2018-02-20 15:38:39', 'a8ef175f-db0b-4614-9388-cea5b5870df8'), ('3', '3', '1', 'not-found', '404', '1', '2018-02-20 15:39:10', '2018-02-20 15:39:10', '8bfb5754-c10c-439b-afb3-603249491d95'), ('4', '4', '1', null, null, '1', '2018-02-21 11:49:40', '2018-02-21 11:50:10', '80a197c8-b3dd-4824-b549-7a7804348dec');
COMMIT;

-- ----------------------------
--  Table structure for `craft_entries`
-- ----------------------------
DROP TABLE IF EXISTS `craft_entries`;
CREATE TABLE `craft_entries` (
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
  KEY `craft_entries_postDate_idx` (`postDate`),
  KEY `craft_entries_expiryDate_idx` (`expiryDate`),
  KEY `craft_entries_authorId_idx` (`authorId`),
  KEY `craft_entries_sectionId_idx` (`sectionId`),
  KEY `craft_entries_typeId_idx` (`typeId`),
  CONSTRAINT `craft_entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entries_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `craft_entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `craft_entries`
-- ----------------------------
BEGIN;
INSERT INTO `craft_entries` VALUES ('2', '1', '1', null, '2018-02-20 15:38:39', null, '2018-02-20 15:38:39', '2018-02-20 15:38:39', '9fbef5d9-fe59-4601-a2dc-5a4054cfcec9'), ('3', '2', '2', null, '2018-02-20 15:39:09', null, '2018-02-20 15:39:10', '2018-02-20 15:39:10', '21808d43-0d24-4832-8888-60bbe474421d');
COMMIT;

-- ----------------------------
--  Table structure for `craft_entrydrafts`
-- ----------------------------
DROP TABLE IF EXISTS `craft_entrydrafts`;
CREATE TABLE `craft_entrydrafts` (
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
  KEY `craft_entrydrafts_sectionId_idx` (`sectionId`),
  KEY `craft_entrydrafts_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `craft_entrydrafts_siteId_idx` (`siteId`),
  KEY `craft_entrydrafts_creatorId_idx` (`creatorId`),
  CONSTRAINT `craft_entrydrafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entrydrafts_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `craft_entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entrydrafts_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entrydrafts_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `craft_entrytypes`
-- ----------------------------
DROP TABLE IF EXISTS `craft_entrytypes`;
CREATE TABLE `craft_entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT '1',
  `titleLabel` varchar(255) DEFAULT 'Title',
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` tinyint(3) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_entrytypes_name_sectionId_unq_idx` (`name`,`sectionId`),
  UNIQUE KEY `craft_entrytypes_handle_sectionId_unq_idx` (`handle`,`sectionId`),
  KEY `craft_entrytypes_sectionId_idx` (`sectionId`),
  KEY `craft_entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `craft_entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `craft_entrytypes`
-- ----------------------------
BEGIN;
INSERT INTO `craft_entrytypes` VALUES ('1', '1', '1', 'Homepage', 'homepage', '0', null, '{section.name|raw}', '1', '2018-02-20 15:38:39', '2018-02-20 15:38:39', '8c47e0a1-3e84-4b17-afe1-8af26c6f725d'), ('2', '2', '2', 'Not Found', 'notFound', '0', null, '{section.name|raw}', '1', '2018-02-20 15:39:09', '2018-02-20 15:39:09', '7f4067df-dfae-44b7-bb74-49ac952562aa');
COMMIT;

-- ----------------------------
--  Table structure for `craft_entryversions`
-- ----------------------------
DROP TABLE IF EXISTS `craft_entryversions`;
CREATE TABLE `craft_entryversions` (
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
  KEY `craft_entryversions_sectionId_idx` (`sectionId`),
  KEY `craft_entryversions_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `craft_entryversions_siteId_idx` (`siteId`),
  KEY `craft_entryversions_creatorId_idx` (`creatorId`),
  CONSTRAINT `craft_entryversions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `craft_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_entryversions_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `craft_entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entryversions_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entryversions_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `craft_fieldgroups`
-- ----------------------------
DROP TABLE IF EXISTS `craft_fieldgroups`;
CREATE TABLE `craft_fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_fieldgroups_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `craft_fieldgroups`
-- ----------------------------
BEGIN;
INSERT INTO `craft_fieldgroups` VALUES ('1', 'Common', '2018-02-20 15:35:51', '2018-02-20 15:35:51', '9e13f53c-af2a-45a1-b508-97826477c8d3'), ('2', 'SEO', '2018-02-20 16:05:23', '2018-02-20 16:05:23', 'fdc8e48e-1fb4-4209-b7fb-b2eb1dde2db6'), ('3', 'Config', '2018-02-20 16:34:27', '2018-02-21 11:48:36', '3a6197a9-c853-4856-871c-14b521cda6bd'), ('4', 'Social Media', '2018-02-21 11:52:42', '2018-02-21 11:52:42', '3f123790-735a-4664-8d9f-93eea629aff4');
COMMIT;

-- ----------------------------
--  Table structure for `craft_fieldlayoutfields`
-- ----------------------------
DROP TABLE IF EXISTS `craft_fieldlayoutfields`;
CREATE TABLE `craft_fieldlayoutfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `sortOrder` tinyint(3) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `craft_fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `craft_fieldlayoutfields_tabId_idx` (`tabId`),
  KEY `craft_fieldlayoutfields_fieldId_idx` (`fieldId`),
  CONSTRAINT `craft_fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `craft_fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `craft_fieldlayoutfields`
-- ----------------------------
BEGIN;
INSERT INTO `craft_fieldlayoutfields` VALUES ('2', '3', '2', '3', '0', '1', '2018-02-21 11:50:10', '2018-02-21 11:50:10', '66c3cc08-374a-49be-985c-8f406c345548'), ('3', '3', '2', '4', '0', '2', '2018-02-21 11:50:10', '2018-02-21 11:50:10', '7bba8a72-e224-4c33-b5be-9c8e9c78e41c');
COMMIT;

-- ----------------------------
--  Table structure for `craft_fieldlayouts`
-- ----------------------------
DROP TABLE IF EXISTS `craft_fieldlayouts`;
CREATE TABLE `craft_fieldlayouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_fieldlayouts_type_idx` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `craft_fieldlayouts`
-- ----------------------------
BEGIN;
INSERT INTO `craft_fieldlayouts` VALUES ('1', 'craft\\elements\\Entry', '2018-02-20 15:38:39', '2018-02-20 15:38:39', '51bba78b-3d7a-426d-978b-6a873f411572'), ('2', 'craft\\elements\\Entry', '2018-02-20 15:39:09', '2018-02-20 15:39:09', 'e4270d87-6f59-484c-a0f0-1a004a57cde7'), ('3', 'craft\\elements\\GlobalSet', '2018-02-21 11:49:39', '2018-02-21 11:50:10', 'e900b578-314d-46b3-91f7-7283cfa4a336'), ('4', 'craft\\elements\\Asset', '2018-02-21 14:54:35', '2018-02-21 14:55:17', '26cd505f-870a-4878-a9e9-a767db2dd7ff');
COMMIT;

-- ----------------------------
--  Table structure for `craft_fieldlayouttabs`
-- ----------------------------
DROP TABLE IF EXISTS `craft_fieldlayouttabs`;
CREATE TABLE `craft_fieldlayouttabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sortOrder` tinyint(3) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `craft_fieldlayouttabs_layoutId_idx` (`layoutId`),
  CONSTRAINT `craft_fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `craft_fieldlayouttabs`
-- ----------------------------
BEGIN;
INSERT INTO `craft_fieldlayouttabs` VALUES ('2', '3', 'Tracking', '1', '2018-02-21 11:50:10', '2018-02-21 11:50:10', '2d8ad957-d4ed-4c04-99c3-7f06be26b798');
COMMIT;

-- ----------------------------
--  Table structure for `craft_fields`
-- ----------------------------
DROP TABLE IF EXISTS `craft_fields`;
CREATE TABLE `craft_fields` (
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
  UNIQUE KEY `craft_fields_handle_context_unq_idx` (`handle`,`context`),
  KEY `craft_fields_groupId_idx` (`groupId`),
  KEY `craft_fields_context_idx` (`context`),
  CONSTRAINT `craft_fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `craft_fields`
-- ----------------------------
BEGIN;
INSERT INTO `craft_fields` VALUES ('1', '2', 'Meta Title', 'metaTitle', 'global', '', 'none', null, 'craft\\fields\\PlainText', '{\"placeholder\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}', '2018-02-20 16:05:47', '2018-02-20 16:05:47', '9a67908f-52bb-48ef-8292-1ba0b7d3280b'), ('2', '2', 'Meta Description', 'metaDescription', 'global', '', 'none', null, 'craft\\fields\\PlainText', '{\"placeholder\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}', '2018-02-20 16:05:58', '2018-02-20 16:05:58', '46b9358e-d223-4da4-bb2a-d08e302e41c6'), ('3', '3', 'Google Analytics ID', 'googleAnalyticsId', 'global', '', 'none', null, 'craft\\fields\\PlainText', '{\"placeholder\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}', '2018-02-21 11:49:16', '2018-02-21 11:49:16', '7be805d5-9aa7-40a1-9a6c-f80d213ded98'), ('4', '3', 'Hotjar ID', 'hotjarId', 'global', '', 'none', null, 'craft\\fields\\PlainText', '{\"placeholder\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}', '2018-02-21 11:50:02', '2018-02-21 11:50:02', 'ae0b5929-332e-4044-81d7-aab4e0101bca');
COMMIT;

-- ----------------------------
--  Table structure for `craft_globalsets`
-- ----------------------------
DROP TABLE IF EXISTS `craft_globalsets`;
CREATE TABLE `craft_globalsets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_globalsets_name_unq_idx` (`name`),
  UNIQUE KEY `craft_globalsets_handle_unq_idx` (`handle`),
  KEY `craft_globalsets_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `craft_globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `craft_globalsets`
-- ----------------------------
BEGIN;
INSERT INTO `craft_globalsets` VALUES ('4', 'Config', 'config', '3', '2018-02-21 11:49:40', '2018-02-21 11:50:10', 'fe65c17b-9e8c-43fa-9e65-a2e1d5377a47');
COMMIT;

-- ----------------------------
--  Table structure for `craft_info`
-- ----------------------------
DROP TABLE IF EXISTS `craft_info`;
CREATE TABLE `craft_info` (
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
--  Records of `craft_info`
-- ----------------------------
BEGIN;
INSERT INTO `craft_info` VALUES ('1', '3.0.0-RC11', '3.0.83', '0', 'America/Los_Angeles', 'Craft', '1', '0', '9R7Q6Dh5da7G', '2018-02-20 15:35:51', '2018-02-21 15:05:54', '507c0ac7-b336-41ba-9ae3-8a8cc44df9db');
COMMIT;

-- ----------------------------
--  Table structure for `craft_matrixblocks`
-- ----------------------------
DROP TABLE IF EXISTS `craft_matrixblocks`;
CREATE TABLE `craft_matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `ownerSiteId` int(11) DEFAULT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` tinyint(3) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_matrixblocks_ownerId_idx` (`ownerId`),
  KEY `craft_matrixblocks_fieldId_idx` (`fieldId`),
  KEY `craft_matrixblocks_typeId_idx` (`typeId`),
  KEY `craft_matrixblocks_sortOrder_idx` (`sortOrder`),
  KEY `craft_matrixblocks_ownerSiteId_idx` (`ownerSiteId`),
  CONSTRAINT `craft_matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixblocks_ownerSiteId_fk` FOREIGN KEY (`ownerSiteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `craft_matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `craft_matrixblocktypes`
-- ----------------------------
DROP TABLE IF EXISTS `craft_matrixblocktypes`;
CREATE TABLE `craft_matrixblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` tinyint(3) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_matrixblocktypes_name_fieldId_unq_idx` (`name`,`fieldId`),
  UNIQUE KEY `craft_matrixblocktypes_handle_fieldId_unq_idx` (`handle`,`fieldId`),
  KEY `craft_matrixblocktypes_fieldId_idx` (`fieldId`),
  KEY `craft_matrixblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `craft_matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `craft_migrations`
-- ----------------------------
DROP TABLE IF EXISTS `craft_migrations`;
CREATE TABLE `craft_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pluginId` int(11) DEFAULT NULL,
  `type` enum('app','plugin','content') NOT NULL DEFAULT 'app',
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_migrations_pluginId_idx` (`pluginId`),
  KEY `craft_migrations_type_pluginId_idx` (`type`,`pluginId`),
  CONSTRAINT `craft_migrations_pluginId_fk` FOREIGN KEY (`pluginId`) REFERENCES `craft_plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `craft_migrations`
-- ----------------------------
BEGIN;
INSERT INTO `craft_migrations` VALUES ('1', null, 'app', 'Install', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', 'a422ecf9-5253-42fa-88b9-3c4445691892'), ('2', null, 'app', 'm150403_183908_migrations_table_changes', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', 'f59cbf7b-e70d-4510-9e4c-bf12c3d7f5a0'), ('3', null, 'app', 'm150403_184247_plugins_table_changes', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', 'db041baa-d0dd-4826-9dc5-027351f75d2c'), ('4', null, 'app', 'm150403_184533_field_version', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '96c80377-40a9-442c-a7ba-5ea1b55de528'), ('5', null, 'app', 'm150403_184729_type_columns', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', 'a8945521-95f2-44a0-a87b-02e0db77d4bb'), ('6', null, 'app', 'm150403_185142_volumes', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', 'd80a04c9-3911-4348-adea-90bf29e0505c'), ('7', null, 'app', 'm150428_231346_userpreferences', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', 'fbfe91b7-8100-4d3b-b8ee-a0786b3017c4'), ('8', null, 'app', 'm150519_150900_fieldversion_conversion', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '90bbdc1c-6f35-4548-976d-5837a611e08e'), ('9', null, 'app', 'm150617_213829_update_email_settings', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '97302707-f852-405d-813c-9b875f4a3cd6'), ('10', null, 'app', 'm150721_124739_templatecachequeries', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '9ea070d6-d03c-41e7-abf9-c55f43f07c28'), ('11', null, 'app', 'm150724_140822_adjust_quality_settings', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '313fcd55-6971-4bb1-b6cf-96d685405357'), ('12', null, 'app', 'm150815_133521_last_login_attempt_ip', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', 'c2210416-f8df-4b35-a23f-ce9e1da16469'), ('13', null, 'app', 'm151002_095935_volume_cache_settings', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', 'f475ad25-3166-40ab-bbb3-5f09b969f593'), ('14', null, 'app', 'm151005_142750_volume_s3_storage_settings', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', 'e7933911-97da-45a1-8b48-752212ecc108'), ('15', null, 'app', 'm151016_133600_delete_asset_thumbnails', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '4cde5fdd-b914-4a31-81e4-6713bd39b0d8'), ('16', null, 'app', 'm151209_000000_move_logo', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '93b1fb66-74e8-4f87-982f-c587ec4d114b'), ('17', null, 'app', 'm151211_000000_rename_fileId_to_assetId', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', 'c9f3afc8-5cb8-410e-8eb1-ea54e8cfd351'), ('18', null, 'app', 'm151215_000000_rename_asset_permissions', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', 'e7310495-d606-47c4-8ac8-10b56985bef7'), ('19', null, 'app', 'm160707_000001_rename_richtext_assetsource_setting', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '560c0ab6-1fab-4c1f-a9cb-a219c154e45b'), ('20', null, 'app', 'm160708_185142_volume_hasUrls_setting', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', 'c490b240-e4fb-4c46-9a99-bd540f019070'), ('21', null, 'app', 'm160714_000000_increase_max_asset_filesize', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '18f124ed-a0ae-4d28-b053-c0dcd965dc94'), ('22', null, 'app', 'm160727_194637_column_cleanup', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '57d71a47-6d76-4d1d-b5d7-36369b1c6ab0'), ('23', null, 'app', 'm160804_110002_userphotos_to_assets', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '0b5d4542-ec65-498a-9184-631482961de3'), ('24', null, 'app', 'm160807_144858_sites', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', 'c5dbebc7-369b-4458-a8b5-178314ada63f'), ('25', null, 'app', 'm160829_000000_pending_user_content_cleanup', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '828e37bb-5e72-4fa1-8807-f6537a0df5d1'), ('26', null, 'app', 'm160830_000000_asset_index_uri_increase', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '20d97cd4-1de7-4696-8be6-8da129e00dda'), ('27', null, 'app', 'm160912_230520_require_entry_type_id', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', 'e598df64-2694-4777-9205-fd6496145c47'), ('28', null, 'app', 'm160913_134730_require_matrix_block_type_id', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', 'd04a42b7-0d37-456f-8cdb-3b492b9e644e'), ('29', null, 'app', 'm160920_174553_matrixblocks_owner_site_id_nullable', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', 'f98589ff-9eb1-4034-85ad-872db98519b5'), ('30', null, 'app', 'm160920_231045_usergroup_handle_title_unique', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', 'dfdc80ab-75f6-4f5f-ae0e-8b5dd7180c2c'), ('31', null, 'app', 'm160925_113941_route_uri_parts', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '3ecfaca3-ce04-4ef9-8bec-ad6df25bc03d'), ('32', null, 'app', 'm161006_205918_schemaVersion_not_null', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', 'c31931a0-1ae6-458b-b750-50a89b8236e7'), ('33', null, 'app', 'm161007_130653_update_email_settings', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '138a8b75-6ab1-4b1b-98af-c4fc7241d916'), ('34', null, 'app', 'm161013_175052_newParentId', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '4ec0ec83-36e9-42cf-9ecc-2f9d24aea1e5'), ('35', null, 'app', 'm161021_102916_fix_recent_entries_widgets', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '99030fb3-1646-4771-8c0c-0f246d729af5'), ('36', null, 'app', 'm161021_182140_rename_get_help_widget', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', 'c25f357c-15fa-4e83-9f2f-4f03b3fbefd8'), ('37', null, 'app', 'm161025_000000_fix_char_columns', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', 'a7f96348-4703-43cc-8222-7c3d1f90f64a'), ('38', null, 'app', 'm161029_124145_email_message_languages', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '5d6de47c-9336-402e-8cb9-d254bc3444dc'), ('39', null, 'app', 'm161108_000000_new_version_format', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '54b7029b-ec86-4f00-918a-a9e73a442768'), ('40', null, 'app', 'm161109_000000_index_shuffle', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '55983b4e-3a79-41d6-b8dd-ce33c2a94afc'), ('41', null, 'app', 'm161122_185500_no_craft_app', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '840f7785-98b7-4cb7-b081-d19767a00461'), ('42', null, 'app', 'm161125_150752_clear_urlmanager_cache', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', 'f6ce8c09-3df4-41ae-85e8-d2f8def88ee3'), ('43', null, 'app', 'm161220_000000_volumes_hasurl_notnull', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', 'ce7cbafc-db4b-44e6-b924-f0a1986ba361'), ('44', null, 'app', 'm170114_161144_udates_permission', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', 'bdab53da-7aca-4919-9611-bba3d145c5ba'), ('45', null, 'app', 'm170120_000000_schema_cleanup', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '4f950057-4421-41a3-a939-bb3c8bcb5819'), ('46', null, 'app', 'm170126_000000_assets_focal_point', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '35416f49-ff1d-4219-81e5-8211dba70e66'), ('47', null, 'app', 'm170206_142126_system_name', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', 'b9c02d50-7c00-4fe9-ac8a-73fdfbbd3c74'), ('48', null, 'app', 'm170217_044740_category_branch_limits', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '5528b0f1-acc8-40a2-b71d-3c990410324f'), ('49', null, 'app', 'm170217_120224_asset_indexing_columns', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2871bc84-510b-4400-82e1-09aaf93bb8fc'), ('50', null, 'app', 'm170223_224012_plain_text_settings', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '8ee02866-49e6-4142-b36f-ddb425947a47'), ('51', null, 'app', 'm170227_120814_focal_point_percentage', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', 'd54e56f4-0d66-4ac0-9a58-ff91e1ec655c'), ('52', null, 'app', 'm170228_171113_system_messages', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '283555cb-d0a2-4670-aafa-44fcff33096f'), ('53', null, 'app', 'm170303_140500_asset_field_source_settings', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '1d4f975f-1778-4ca7-890b-e2455bcb1f30'), ('54', null, 'app', 'm170306_150500_asset_temporary_uploads', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', 'a8dd60bc-44a0-45dd-8899-41224db65aca'), ('55', null, 'app', 'm170414_162429_rich_text_config_setting', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', 'a55b5999-c41c-41c9-956c-9458ca13d553'), ('56', null, 'app', 'm170523_190652_element_field_layout_ids', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '64cd7b94-6c55-4322-a4d5-9d8d8d478d7c'), ('57', null, 'app', 'm170612_000000_route_index_shuffle', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '3a074c87-b03a-4623-8102-0bc4055e54ab'), ('58', null, 'app', 'm170621_195237_format_plugin_handles', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '13d28ec5-68ee-43c2-a807-e456ee334aaf'), ('59', null, 'app', 'm170630_161028_deprecation_changes', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2a449377-53ef-48a8-bc82-6d0844eb1c49'), ('60', null, 'app', 'm170703_181539_plugins_table_tweaks', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '6f35b443-5b00-49aa-96c3-80fb0de87222'), ('61', null, 'app', 'm170704_134916_sites_tables', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', 'e9229ed4-609c-40e1-ad99-5da967181e2e'), ('62', null, 'app', 'm170706_183216_rename_sequences', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '9a1aad05-14f4-45cc-8400-0b5beb336710'), ('63', null, 'app', 'm170707_094758_delete_compiled_traits', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '00745d16-34e1-44cd-80d8-f22dca80023d'), ('64', null, 'app', 'm170731_190138_drop_asset_packagist', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', 'c3f47561-a486-42ee-a3f4-e165ae2684d5'), ('65', null, 'app', 'm170810_201318_create_queue_table', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '4b65adaa-4324-44ae-a65a-92f685df8b86'), ('66', null, 'app', 'm170816_133741_delete_compiled_behaviors', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '19db4561-03f5-4cb9-9d32-1bacb93230bf'), ('67', null, 'app', 'm170821_180624_deprecation_line_nullable', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '7ace42d8-3853-4768-9321-97a557fd6394'), ('68', null, 'app', 'm170903_192801_longblob_for_queue_jobs', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', 'dabd3469-c4b2-48a9-8514-90141555a12a'), ('69', null, 'app', 'm170914_204621_asset_cache_shuffle', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '9215c541-730c-488d-a2df-9cdf2f93a246'), ('70', null, 'app', 'm171011_214115_site_groups', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '58d00b29-1886-4f76-8789-dd53f25d66af'), ('71', null, 'app', 'm171012_151440_primary_site', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '18efd80d-a69d-423d-9fd3-60da08009bc1'), ('72', null, 'app', 'm171013_142500_transform_interlace', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '761071d4-c841-4416-b3ae-e158e0dc0e5b'), ('73', null, 'app', 'm171016_092553_drop_position_select', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', 'a10403ac-8117-4e72-9ca2-a9969b2f1911'), ('74', null, 'app', 'm171016_221244_less_strict_translation_method', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '7c7089c6-7564-4845-9918-2360dcb5f225'), ('75', null, 'app', 'm171107_000000_assign_group_permissions', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', 'fa309ed4-2589-4fc2-a553-2d141eb28066'), ('76', null, 'app', 'm171117_000001_templatecache_index_tune', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '5d6e2a9f-b230-46ec-9915-6eca39c41d9c'), ('77', null, 'app', 'm171126_105927_disabled_plugins', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '3fe732a9-4c4d-4c97-85a7-834cadea3528'), ('78', null, 'app', 'm171130_214407_craftidtokens_table', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '328109be-a1e4-404d-823c-ab05194566c0'), ('79', null, 'app', 'm171202_004225_update_email_settings', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', 'a030b9be-e133-4c9b-bc8e-8d9786fd93df'), ('80', null, 'app', 'm171204_000001_templatecache_index_tune_deux', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', 'f65f0ceb-243f-47b1-8e0f-6ca43135c975'), ('81', null, 'app', 'm171205_130908_remove_craftidtokens_refreshtoken_column', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '902a43a8-e084-4950-9d17-60d647e7484a'), ('82', null, 'app', 'm171210_142046_fix_db_routes', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '28154bb5-fa13-4e9f-b653-31a98daea9c6'), ('83', null, 'app', 'm171218_143135_longtext_query_column', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', 'b5633fe5-7898-4bd3-a176-a7ceaba08c0f'), ('84', null, 'app', 'm171231_055546_environment_variables_to_aliases', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', 'c1d9b65c-8dd3-4d9f-9c96-e43d8c280e71'), ('85', null, 'app', 'm180113_153740_drop_users_archived_column', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', 'a72a91b7-c0c5-422d-9ca6-76ea55449ca8'), ('86', null, 'app', 'm180122_213433_propagate_entries_setting', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', 'fbff5031-4fd2-4c7b-8e7b-6bdb5b606e33'), ('87', null, 'app', 'm180124_230459_fix_propagate_entries_values', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '1703d7a9-901f-460d-b9e3-82a4d38e8b70'), ('88', null, 'app', 'm180128_235202_set_tag_slugs', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', 'd17ed4ed-ddd8-4752-9e04-aacd22a89042'), ('89', null, 'app', 'm180202_185551_fix_focal_points', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '6d305b19-4b2f-4e38-9bc0-0e3469ccc413'), ('91', null, 'app', 'm180217_172123_tiny_ints', '2018-02-21 15:05:54', '2018-02-21 15:05:54', '2018-02-21 15:05:54', '754794d6-dabf-45fa-a6ad-1107e1935618');
COMMIT;

-- ----------------------------
--  Table structure for `craft_plugins`
-- ----------------------------
DROP TABLE IF EXISTS `craft_plugins`;
CREATE TABLE `craft_plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKey` char(24) DEFAULT NULL,
  `licenseKeyStatus` enum('valid','invalid','mismatched','unknown') NOT NULL DEFAULT 'unknown',
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `settings` text,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_plugins_handle_unq_idx` (`handle`),
  KEY `craft_plugins_enabled_idx` (`enabled`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `craft_queue`
-- ----------------------------
DROP TABLE IF EXISTS `craft_queue`;
CREATE TABLE `craft_queue` (
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
  KEY `craft_queue_fail_timeUpdated_timePushed_idx` (`fail`,`timeUpdated`,`timePushed`),
  KEY `craft_queue_fail_timeUpdated_delay_idx` (`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `craft_relations`
-- ----------------------------
DROP TABLE IF EXISTS `craft_relations`;
CREATE TABLE `craft_relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `sourceSiteId` int(11) DEFAULT NULL,
  `targetId` int(11) NOT NULL,
  `sortOrder` tinyint(3) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_relations_fieldId_sourceId_sourceSiteId_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `craft_relations_sourceId_idx` (`sourceId`),
  KEY `craft_relations_targetId_idx` (`targetId`),
  KEY `craft_relations_sourceSiteId_idx` (`sourceSiteId`),
  CONSTRAINT `craft_relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_relations_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `craft_routes`
-- ----------------------------
DROP TABLE IF EXISTS `craft_routes`;
CREATE TABLE `craft_routes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) DEFAULT NULL,
  `uriParts` varchar(255) NOT NULL,
  `uriPattern` varchar(255) NOT NULL,
  `template` varchar(500) NOT NULL,
  `sortOrder` tinyint(3) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_routes_uriPattern_idx` (`uriPattern`),
  KEY `craft_routes_siteId_idx` (`siteId`),
  CONSTRAINT `craft_routes_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `craft_searchindex`
-- ----------------------------
DROP TABLE IF EXISTS `craft_searchindex`;
CREATE TABLE `craft_searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `craft_searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `craft_searchindex`
-- ----------------------------
BEGIN;
INSERT INTO `craft_searchindex` VALUES ('1', 'username', '0', '1', ' admin '), ('1', 'firstname', '0', '1', ''), ('1', 'lastname', '0', '1', ''), ('1', 'fullname', '0', '1', ''), ('1', 'email', '0', '1', ' webdev nixondesign com '), ('1', 'slug', '0', '1', ''), ('2', 'slug', '0', '1', ' homepage '), ('2', 'title', '0', '1', ' homepage '), ('3', 'slug', '0', '1', ' not found '), ('3', 'title', '0', '1', ' not found '), ('4', 'field', '3', '1', ''), ('4', 'slug', '0', '1', ''), ('4', 'field', '4', '1', '');
COMMIT;

-- ----------------------------
--  Table structure for `craft_sections`
-- ----------------------------
DROP TABLE IF EXISTS `craft_sections`;
CREATE TABLE `craft_sections` (
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
  UNIQUE KEY `craft_sections_handle_unq_idx` (`handle`),
  UNIQUE KEY `craft_sections_name_unq_idx` (`name`),
  KEY `craft_sections_structureId_idx` (`structureId`),
  CONSTRAINT `craft_sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `craft_structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `craft_sections`
-- ----------------------------
BEGIN;
INSERT INTO `craft_sections` VALUES ('1', null, 'Homepage', 'homepage', 'single', '0', '1', '2018-02-20 15:38:39', '2018-02-20 15:38:39', '14a39395-e815-4056-baaa-853406112541'), ('2', null, 'Not Found', 'notFound', 'single', '0', '1', '2018-02-20 15:39:09', '2018-02-20 15:39:09', '8af67641-9a73-4d42-84a9-a3bc62c248f3');
COMMIT;

-- ----------------------------
--  Table structure for `craft_sections_sites`
-- ----------------------------
DROP TABLE IF EXISTS `craft_sections_sites`;
CREATE TABLE `craft_sections_sites` (
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
  UNIQUE KEY `craft_sections_sites_sectionId_siteId_unq_idx` (`sectionId`,`siteId`),
  KEY `craft_sections_sites_siteId_idx` (`siteId`),
  CONSTRAINT `craft_sections_sites_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_sections_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `craft_sections_sites`
-- ----------------------------
BEGIN;
INSERT INTO `craft_sections_sites` VALUES ('1', '1', '1', '1', '__home__', 'index', '1', '2018-02-20 15:38:39', '2018-02-20 15:38:39', '63efbbc3-c499-4ab1-9462-33d2be8c8ee7'), ('2', '2', '1', '1', '404', '404', '1', '2018-02-20 15:39:09', '2018-02-20 15:39:09', 'ed272071-31f1-4e2b-b211-3e4e558999b2');
COMMIT;

-- ----------------------------
--  Table structure for `craft_sessions`
-- ----------------------------
DROP TABLE IF EXISTS `craft_sessions`;
CREATE TABLE `craft_sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_sessions_uid_idx` (`uid`),
  KEY `craft_sessions_token_idx` (`token`),
  KEY `craft_sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `craft_sessions_userId_idx` (`userId`),
  CONSTRAINT `craft_sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `craft_sessions`
-- ----------------------------
BEGIN;
INSERT INTO `craft_sessions` VALUES ('1', '1', 'M2R1ibHUYhGx5SDvWB8Pdt3e3DJvSgxdBLD1ogIEEH3fC_TBDhz7lqXUCkzsYAbuOtBXtBmdea9LXnMXARdWFOCX2ACrBXswfLCQ', '2018-02-21 11:30:10', '2018-02-21 12:17:41', 'a6d319af-c8fa-4ddd-81c7-e5be05580577'), ('2', '1', 'cjmjNYXgvxPzld-zfIDEme1SRvkjkK74oa8h04XuelqJfuJ6b9bLjMDZ322ITpDo4udQuWCiTBhMSa84urxSQeDjD0UlVeBG4Lv1', '2018-02-21 14:22:21', '2018-02-21 15:42:09', '0cc37693-cbd6-49be-99d7-6826d4878c69');
COMMIT;

-- ----------------------------
--  Table structure for `craft_shunnedmessages`
-- ----------------------------
DROP TABLE IF EXISTS `craft_shunnedmessages`;
CREATE TABLE `craft_shunnedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `craft_shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `craft_sitegroups`
-- ----------------------------
DROP TABLE IF EXISTS `craft_sitegroups`;
CREATE TABLE `craft_sitegroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_sitegroups_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `craft_sitegroups`
-- ----------------------------
BEGIN;
INSERT INTO `craft_sitegroups` VALUES ('1', 'Craft', '2018-02-20 15:35:51', '2018-02-20 15:35:51', '52476aed-3662-47e7-bc07-8a171dd540e9');
COMMIT;

-- ----------------------------
--  Table structure for `craft_sites`
-- ----------------------------
DROP TABLE IF EXISTS `craft_sites`;
CREATE TABLE `craft_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '0',
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` tinyint(3) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_sites_handle_unq_idx` (`handle`),
  KEY `craft_sites_sortOrder_idx` (`sortOrder`),
  KEY `craft_sites_groupId_fk` (`groupId`),
  CONSTRAINT `craft_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `craft_sites`
-- ----------------------------
BEGIN;
INSERT INTO `craft_sites` VALUES ('1', '1', '1', 'Craft', 'default', 'en-GB', '1', '', '1', '2018-02-20 15:35:51', '2018-02-20 15:52:45', '5bc7a9ea-513e-46dd-8b35-385dedb656fd');
COMMIT;

-- ----------------------------
--  Table structure for `craft_structureelements`
-- ----------------------------
DROP TABLE IF EXISTS `craft_structureelements`;
CREATE TABLE `craft_structureelements` (
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
  UNIQUE KEY `craft_structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `craft_structureelements_root_idx` (`root`),
  KEY `craft_structureelements_lft_idx` (`lft`),
  KEY `craft_structureelements_rgt_idx` (`rgt`),
  KEY `craft_structureelements_level_idx` (`level`),
  KEY `craft_structureelements_elementId_idx` (`elementId`),
  CONSTRAINT `craft_structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `craft_structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `craft_structures`
-- ----------------------------
DROP TABLE IF EXISTS `craft_structures`;
CREATE TABLE `craft_structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `craft_systemmessages`
-- ----------------------------
DROP TABLE IF EXISTS `craft_systemmessages`;
CREATE TABLE `craft_systemmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_systemmessages_key_language_unq_idx` (`key`,`language`),
  KEY `craft_systemmessages_language_idx` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `craft_systemsettings`
-- ----------------------------
DROP TABLE IF EXISTS `craft_systemsettings`;
CREATE TABLE `craft_systemsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(15) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_systemsettings_category_unq_idx` (`category`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `craft_systemsettings`
-- ----------------------------
BEGIN;
INSERT INTO `craft_systemsettings` VALUES ('1', 'email', '{\"fromEmail\":\"webdev@nixondesign.com\",\"fromName\":\"Craft\",\"transportType\":\"craft\\\\mail\\\\transportadapters\\\\Sendmail\"}', '2018-02-20 15:35:53', '2018-02-20 15:35:53', 'a8cf033b-3e44-4812-a3a2-7eef75229c4a');
COMMIT;

-- ----------------------------
--  Table structure for `craft_taggroups`
-- ----------------------------
DROP TABLE IF EXISTS `craft_taggroups`;
CREATE TABLE `craft_taggroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_taggroups_name_unq_idx` (`name`),
  UNIQUE KEY `craft_taggroups_handle_unq_idx` (`handle`),
  KEY `craft_taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `craft_taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `craft_tags`
-- ----------------------------
DROP TABLE IF EXISTS `craft_tags`;
CREATE TABLE `craft_tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_tags_groupId_idx` (`groupId`),
  CONSTRAINT `craft_tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_tags_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `craft_templatecacheelements`
-- ----------------------------
DROP TABLE IF EXISTS `craft_templatecacheelements`;
CREATE TABLE `craft_templatecacheelements` (
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  KEY `craft_templatecacheelements_cacheId_idx` (`cacheId`),
  KEY `craft_templatecacheelements_elementId_idx` (`elementId`),
  CONSTRAINT `craft_templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `craft_templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `craft_templatecachequeries`
-- ----------------------------
DROP TABLE IF EXISTS `craft_templatecachequeries`;
CREATE TABLE `craft_templatecachequeries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `craft_templatecachequeries_cacheId_idx` (`cacheId`),
  KEY `craft_templatecachequeries_type_idx` (`type`),
  CONSTRAINT `craft_templatecachequeries_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `craft_templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `craft_templatecaches`
-- ----------------------------
DROP TABLE IF EXISTS `craft_templatecaches`;
CREATE TABLE `craft_templatecaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) NOT NULL,
  `cacheKey` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `craft_templatecaches_cacheKey_siteId_expiryDate_path_idx` (`cacheKey`,`siteId`,`expiryDate`,`path`),
  KEY `craft_templatecaches_cacheKey_siteId_expiryDate_idx` (`cacheKey`,`siteId`,`expiryDate`),
  KEY `craft_templatecaches_siteId_idx` (`siteId`),
  CONSTRAINT `craft_templatecaches_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `craft_tokens`
-- ----------------------------
DROP TABLE IF EXISTS `craft_tokens`;
CREATE TABLE `craft_tokens` (
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
  UNIQUE KEY `craft_tokens_token_unq_idx` (`token`),
  KEY `craft_tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `craft_usergroups`
-- ----------------------------
DROP TABLE IF EXISTS `craft_usergroups`;
CREATE TABLE `craft_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_usergroups_handle_unq_idx` (`handle`),
  UNIQUE KEY `craft_usergroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `craft_usergroups_users`
-- ----------------------------
DROP TABLE IF EXISTS `craft_usergroups_users`;
CREATE TABLE `craft_usergroups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `craft_usergroups_users_userId_idx` (`userId`),
  CONSTRAINT `craft_usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `craft_userpermissions`
-- ----------------------------
DROP TABLE IF EXISTS `craft_userpermissions`;
CREATE TABLE `craft_userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `craft_userpermissions_usergroups`
-- ----------------------------
DROP TABLE IF EXISTS `craft_userpermissions_usergroups`;
CREATE TABLE `craft_userpermissions_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `craft_userpermissions_usergroups_groupId_idx` (`groupId`),
  CONSTRAINT `craft_userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `craft_userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `craft_userpermissions_users`
-- ----------------------------
DROP TABLE IF EXISTS `craft_userpermissions_users`;
CREATE TABLE `craft_userpermissions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `craft_userpermissions_users_userId_idx` (`userId`),
  CONSTRAINT `craft_userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `craft_userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `craft_userpreferences`
-- ----------------------------
DROP TABLE IF EXISTS `craft_userpreferences`;
CREATE TABLE `craft_userpreferences` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `preferences` text,
  PRIMARY KEY (`userId`),
  CONSTRAINT `craft_userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `craft_users`
-- ----------------------------
DROP TABLE IF EXISTS `craft_users`;
CREATE TABLE `craft_users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int(11) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `client` tinyint(1) NOT NULL DEFAULT '0',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `suspended` tinyint(1) NOT NULL DEFAULT '0',
  `pending` tinyint(1) NOT NULL DEFAULT '0',
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(3) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT '0',
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_users_username_unq_idx` (`username`),
  UNIQUE KEY `craft_users_email_unq_idx` (`email`),
  KEY `craft_users_uid_idx` (`uid`),
  KEY `craft_users_verificationCode_idx` (`verificationCode`),
  KEY `craft_users_photoId_fk` (`photoId`),
  CONSTRAINT `craft_users_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `craft_assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `craft_users`
-- ----------------------------
BEGIN;
INSERT INTO `craft_users` VALUES ('1', 'admin', null, null, null, 'webdev@nixondesign.com', '$2y$13$LShhBb.t1NZg3BucRbMSkewXr7a6THqSrTqxyu/1MsBYMwxQN/iG2', '1', '0', '0', '0', '0', '2018-02-21 14:22:21', '::1', null, null, null, null, null, null, null, '0', '2018-02-20 15:35:53', '2018-02-20 15:35:53', '2018-02-21 14:22:21', '09fb99dd-419c-403d-a790-05adc580ce75');
COMMIT;

-- ----------------------------
--  Table structure for `craft_volumefolders`
-- ----------------------------
DROP TABLE IF EXISTS `craft_volumefolders`;
CREATE TABLE `craft_volumefolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_volumefolders_name_parentId_volumeId_unq_idx` (`name`,`parentId`,`volumeId`),
  KEY `craft_volumefolders_parentId_idx` (`parentId`),
  KEY `craft_volumefolders_volumeId_idx` (`volumeId`),
  CONSTRAINT `craft_volumefolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `craft_volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_volumefolders_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `craft_volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1691 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `craft_volumefolders`
-- ----------------------------
BEGIN;
INSERT INTO `craft_volumefolders` VALUES ('2', null, null, 'Temporary source', null, '2018-02-21 14:54:39', '2018-02-21 14:54:39', 'ce9e7adb-3bac-4732-985f-e9a94d09690d'), ('3', '2', null, 'user_1', 'user_1/', '2018-02-21 14:54:39', '2018-02-21 14:54:39', 'baf0892a-4cf6-467a-aff8-54aecfd6dbd5');
COMMIT;

-- ----------------------------
--  Table structure for `craft_volumes`
-- ----------------------------
DROP TABLE IF EXISTS `craft_volumes`;
CREATE TABLE `craft_volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `url` varchar(255) DEFAULT NULL,
  `settings` text,
  `sortOrder` tinyint(3) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_volumes_name_unq_idx` (`name`),
  UNIQUE KEY `craft_volumes_handle_unq_idx` (`handle`),
  KEY `craft_volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `craft_volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `craft_widgets`
-- ----------------------------
DROP TABLE IF EXISTS `craft_widgets`;
CREATE TABLE `craft_widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` tinyint(3) unsigned DEFAULT NULL,
  `colspan` tinyint(1) NOT NULL DEFAULT '0',
  `settings` text,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_widgets_userId_idx` (`userId`),
  CONSTRAINT `craft_widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `craft_widgets`
-- ----------------------------
BEGIN;
INSERT INTO `craft_widgets` VALUES ('1', '1', 'craft\\widgets\\RecentEntries', '1', '0', '{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}', '1', '2018-02-20 15:35:54', '2018-02-20 15:35:54', '5afb4bdd-10dd-490e-9efd-2f939c4ffa2e'), ('2', '1', 'craft\\widgets\\CraftSupport', '2', '0', '[]', '1', '2018-02-20 15:35:54', '2018-02-20 15:35:54', 'c5dbe48f-96b7-42ad-8570-4cbb2a2e0a3b'), ('3', '1', 'craft\\widgets\\Updates', '3', '0', '[]', '1', '2018-02-20 15:35:54', '2018-02-20 15:35:54', '5b4bf904-c2f4-419b-b5fb-5a1b94ab73cf'), ('4', '1', 'craft\\widgets\\Feed', '4', '0', '{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}', '1', '2018-02-20 15:35:54', '2018-02-20 15:35:54', 'dcacbf99-fa80-48dc-a90f-a7f74b0e8bd6');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
