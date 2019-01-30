<?php
namespace modules\base\services;

use craft\elements\Asset;
use yii\base\Component;

class ImageService extends Component
{
    /**
     * Creates a string that can be used in an img elements srcset attribute
     *
     * @param Asset
     * @param array|null The desired widths
     * @return string
     */
    function srcset(Asset $asset, array $widths = [], $ratio = null, array $transforms = [])
    {
        $candidates = [];

        if (count($widths) == 0) {
            return null;
        }

        asort($widths);

        foreach ($widths as &$width) {
            $url = $asset->getUrl(array_merge([
                'width' => $width,
                'height' => $width * $ratio,
            ], array_filter($transforms)));

            $candidates[$width] = $url;
        }

        return $this->createSrcsetString($candidates);
    }

    /**
     * Creates a string that can be used in the srcset attribute.
     *
     * @param array $array
     * @return string
     */
    private function createSrcsetString(array $array = [])
    {
        array_walk($array, function(&$value, $key) {
            $value = "{$value} {$key}w";
        });

        return implode(', ', $array);
    }
}
