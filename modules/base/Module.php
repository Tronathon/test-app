<?php
namespace modules\base;

use modules\base\services\ImageService;
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

        parent::init();

        if (Craft::$app->getRequest()->getIsSiteRequest()) {
            // Add in our Twig extension
            Craft::$app->getView()->registerTwigExtension(new TwigExtension());
        }

        Event::on(CraftVariable::class, CraftVariable::EVENT_INIT, function(Event $e) {
            /** @var CraftVariable $variable */
            $variable = $e->sender;

            // Attach a service:
            $variable->set('image', ImageService::class);
        });

    }
}
