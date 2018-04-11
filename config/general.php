<?php
/**
 * General Configuration
 *
 * All of your system's general configuration settings go in here. You can see a
 * list of the available settings in vendor/craftcms/cms/src/config/GeneralConfig.php.
 */

$httpHost = $_SERVER['HTTP_HOST'] ?? '';
$protocol = isset($_SERVER['HTTPS']) ? "https://" : "http://";

return [
    '*' => [
		'securityKey' => getenv('SECURITY_KEY'),
		'sendPoweredByHeader' => false,
		'siteUrl' => $protocol . $httpHost . '/',
		'useEmailAsUsername' => true,
        'cpTrigger' => 'admin',
        'enableCsrfProtection' => true,
        'omitScriptNameInUrls' => true,
    ],

    'dev' => [
        'devMode' => true,
    ],

    'staging' => [
		'allowUpdates' => false,
    ],

    'production' => [
		'allowUpdates' => false,
    ],
];
