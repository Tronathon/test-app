<?php
/**
 * @link https://nixondesign.com
 * @copyright Copyright (c) Nixon Design Ltd
 */

namespace modules\iubenda\services;

use Craft;
use craft\helpers\Json;
use craft\helpers\Template;
use GuzzleHttp\Exception\ClientException;
use GuzzleHttp\Exception\RequestException;
use yii\base\Component;

/**
 * Iubenda service.
 *
 * @property \Twig_Markup|null $cookiePolicy
 * @property \Twig_Markup|null $privacyPolicy
 */
class Iubenda extends Component
{
    // Constants
    // =========================================================================

    const API_ENDPOINT = 'https://www.iubenda.com/api/';

    // Public Methods
    // =========================================================================

    /**
     * Gets the Cookie Policy
     *
     * @param integer $key The public id
     * @return \Twig_Markup|null
     * @throws \RequestException
     */
    public function getCookiePolicy(string $key = null)
    {
        $client = $this->createClient();
        $uri = 'privacy-policy/'.$key.'/cookie-policy/no-markup';

        try {
            $response = $client->request('GET', $uri);
            $content = Json::decode($response
                ->getBody()
                ->getContents()
            )['content'];

            return Template::raw($this->prepareHtml($content));
        } catch (RequestException $e) {
            $this->handleGuzzleException($e);
        }
    }

    /**
     * Gets the Privacy Policy
     *
     * @param integer $key The public id
     * @return \Twig_Markup|null
     * @throws \RequestException
     */
    public function getPrivacyPolicy(string $key = null)
    {
        $client = $this->createClient();
        $uri = 'privacy-policy/'.$key.'/no-markup';

        try {
            $response = $client->request('GET', $uri);
            $content = Json::decode($response
                ->getBody()
                ->getContents()
            )['content'];

            return Template::raw($this->prepareHtml($content));
        } catch (RequestException $e) {
            $this->handleGuzzleException($e);
        }
    }

    // Private Methods
    // =========================================================================

    /**
     * @param RequestException $e
     */
    private function handleGuzzleException(RequestException $e)
    {
        // Sometimes the API likes to return HTML error messages ¯\_(ツ)_/¯
        $message = Json::decodeIfJson($e
            ->getResponse()
            ->getBody()
            ->getContents()
        );

        if (is_array($message) && array_key_exists('error', $message)) {
            $message = $message['error'];
        }

        Craft::error($message, __METHOD__);
    }

    /**
     * Creates a Guzzle client configured for API endpoint
     *
     * @return GuzzleClient
     */
    private function createClient()
    {
        return Craft::createGuzzleClient([
            'base_uri' => self::API_ENDPOINT,
            'timeout' => 120,
            'connect_timeout' => 120,
            'headers' => [ 'Accept' => 'application/json' ],
        ]);
    }

    /**
     * @param string $html
     * @return \Twig_Markup|null
     */
    private function prepareHtml(string $html): string
    {
        // Replace Cookie Policy link with a link to the local Policy
        $pattern = '/\/\/www.iubenda.com\/private\/privacy-policy\/[0-9]+\/cookie-policy/';
        $replacement = '/cookie-policy';
        $html = preg_replace($pattern, $replacement, $html);

        // Remove id attributes
        $html = preg_replace('#\s(id|class)="[^"]+"#', '', $html);

        return $html;
    }
}
