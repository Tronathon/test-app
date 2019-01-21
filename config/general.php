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
        'defaultCpLanguage' => 'en-GB',
        'omitScriptNameInUrls' => true,
        'siteUrl' => getenv('SITE_URL'),
        'useProjectConfigFile' => true,
    ],

    'dev' => [
        'devMode' => true,
    ],

    'staging' => [
		'allowAdminChanges' => false,
    ],

    'production' => [
		'allowAdminChanges' => false,
    ],
];
