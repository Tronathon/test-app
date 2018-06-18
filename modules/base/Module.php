<?php
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
        Craft::setAlias('@modules/base', $this->getBasePath());

        if (Craft::$app->getRequest()->getIsSiteRequest()) {
            // Add in our Twig extension
            Craft::$app->getView()->registerTwigExtension(new TwigExtension());
        }

        parent::init();
    }
}
