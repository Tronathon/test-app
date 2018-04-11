# Cookie notice

## Google Tag Manager

Where possible scripts should be loaded using Google Tag Manger. The default GTM configuration file loads Google Analytics, Hotjar and Facebook Pixel based on the presence of either the cookie_consent cookie or the `cookie_consent_given` event.

## Inline scripts

Inline scripts require the following:

- `data-cookie-consent` attribute
- `type` attribute to be set to `text/plain`

```html
<script type="text/plain" data-cookie-consent>
	console.log('Cookies!');
</script>
```

## Elements with `src` attribute

Elements such external scripts and iframes require that the value of the `src` attribute is moved to the `data-cookie-consent` attribute.

```html
<iframe data-cookie-consent="https://cdn.example.com"></iframe>

<script data-cookie-consent="https://cdn.example.com/script.js"></script>
```

## Twig

A `cookieConsent` variable is available accross all templates.

```twig
{% if not cookieConsent %}
	<p>Consent needs to be given in order to view this content</p>
{% endif %}

<iframe {{ not cookieConsent ? "data-cookie-consent" : "src" }}="https://example.com"></iframe>
```
