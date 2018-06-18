<?php
/**
 * @link https://nixondesign.com
 * @copyright Copyright (c) Nixon Design Ltd
 */

namespace modules\iubenda;

use modules\iubenda\services\Iubenda;

use Craft;
use craft\web\twig\variables\CraftVariable;
use yii\base\Event;

/**
 * Module class.
 */
class Module extends \yii\base\Module
{
    /**
     * Initializes the module.
     */
    public function init()
    {
        Craft::setAlias('@modules/iubenda', $this->getBasePath());

        Event::on(CraftVariable::class, CraftVariable::EVENT_INIT, function(Event $e) {
            /** @var CraftVariable $variable */
            $variable = $e->sender;

            // Attach a service:
            $variable->set('iubenda', Iubenda::class);
        });

        parent::init();
    }
}
