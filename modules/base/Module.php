<?php
namespace modules;

use Craft;

/**
 * Custom module class.
 *
 * This class will be available throughout the system via:
 * `Craft::$app->getModule('my-module')`.
 *
 * You can change its module ID ("my-module") to something else from
 * config/app.php.
 *
 * If you want the module to get loaded on every request, uncomment this line
 * in config/app.php:
 *
 *     'bootstrap' => ['my-module']
 *
 * Learn more about Yii module development in Yii's documentation:
 * http://www.yiiframework.com/doc-2.0/guide-structure-modules.html
 */

namespace modules\base;

use modules\base\twigextensions\TwigExtension;

use Craft;
use yii\base\Event;
use craft\web\twig\variables\CraftVariable;

class Module extends \yii\base\Module
{
    /**
     * Initializes the module.
     */
    public function init()
    {
        Craft::setAlias('@modules', __DIR__);
        parent::init();

        if (Craft::$app->getRequest()->getIsSiteRequest()) {
            // Add in our Twig extension
            Craft::$app->getView()->registerTwigExtension(new TwigExtension());
        }
    }
}
