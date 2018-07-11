<?php
/**
 * General Configuration
 *
 * All of your system's general configuration settings go in here. You can see a
 * list of the available settings in vendor/craftcms/cms/src/config/GeneralConfig.php.
 */

return [
    '*' => [
		'securityKey' => getenv('SECURITY_KEY'),
		'sendPoweredByHeader' => false,
		'useEmailAsUsername' => true,
        'cpTrigger' => 'admin',
        'enableCsrfProtection' => true,
        'omitScriptNameInUrls' => true,
    ],

    'dev' => [
        'devMode' => true,
		'siteUrl' => null,
    ],

    'staging' => [
		'allowUpdates' => false,
		'siteUrl' => null,
    ],

    'production' => [
		'allowUpdates' => false,
		'siteUrl' => null,
    ],
];
