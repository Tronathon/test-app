<?php

/**
 * General Configuration
 *
 * All of your system's general configuration settings go in here.
 * You can see a list of the default settings in craft/app/etc/config/defaults/general.php
 */

define('URI_SCHEME', (isset($_SERVER['HTTPS'] ) ) ? "https://" : "http://");
define('SITE_URL', URI_SCHEME . $_SERVER['SERVER_NAME']);
define('BASEPATH', realpath(dirname(__FILE__) . '/../') . '/');

return array(

	'*' => array(
		'omitScriptNameInUrls' => true,
		'useEmailAsUsername' => true,
		'environmentVariables' => array(
			'basePath' => BASEPATH,
			'siteUrl' => SITE_URL
		),
	)

);
