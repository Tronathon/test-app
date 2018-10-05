<?php

namespace modules\base\assets\redactor;

use craft\web\AssetBundle;
use craft\web\assets\cp\CpAsset;
use craft\redactor\assets\redactor\RedactorAsset;

class RedactorModifyAsset extends AssetBundle
{
    public function init()
    {
        $this->sourcePath = '@modules/base/assets/redactor';

        $this->depends = [
            CpAsset::class,
            RedactorAsset::class,
        ];

        $this->css = [
            'styles.css'
        ];

        parent::init();
    }
}
