<?php

namespace modules\base\twigextensions;

use yii\helpers\Inflector;

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
        return [
            new \Twig_SimpleFilter('ordinalize', [$this, 'ordinalize']),
            new \Twig_SimpleFilter('pluralize', [$this, 'pluralize']),
            new \Twig_SimpleFilter('singularize', [$this, 'singularize']),
        ];
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

    /**
     * Converts number to its ordinal form.
     *
     * @param int $number
     *
     * @return string
     */
    public function ordinalize(int $number): string
    {
        return Inflector::ordinalize($number);
    }

    /**
     * Converts a word to its plural form.
     *
     * @param string $word
     * @param int    $number
     *
     * @return string
     */
    public function pluralize(string $word, int $number = 2): string
    {
        return abs($number) === 1 ? $word : Inflector::pluralize($word);
    }

    /**
     * Converts a word to its singular form.
     *
     * @param string $word
     * @param int    $number
     *
     * @return string
     */
    public function singularize(string $word, int $number = 1): string
    {
        return abs($number) === 1 ? Inflector::singularize($word) : $word;
    }
}
