<?php

namespace modules\base\twigextensions;

class TwigExtension extends \Twig_Extension implements \Twig_Extension_GlobalsInterface
{
    /**
     * @inheritdoc
     */
    public function getName(): string
    {
        return 'Base';
    }

    /**
     * @inheritdoc
     */
    public function getGlobals(): array
    {
        return [
            'doNotTrack' => $this->doNotTrackGlobal(),
        ];
    }

    /**
     * @inheritdoc
     */
    public function getFilters(): array
    {
        return [];
    }

    /**
     * @inheritdoc
     */
    public function getFunctions(): array
    {
        return [];
    }

    /**
     * Detect if the DNT header is set.
     *
     * @return bool
     */
    public function doNotTrackGlobal()
    {
        return isset($_SERVER['HTTP_DNT']) && $_SERVER['HTTP_DNT'] == 1;
    }
}
