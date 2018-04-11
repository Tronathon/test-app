import { getCookie, setCookie } from 'tiny-cookie';

const defaults = {
	notice: document.getElementById('ckntc'),
	allowButton: document.getElementById('ckntc-y'),
	disallowButton: document.getElementById('ckntc-n'),

	classList: 'is-visible',
	cookieName: 'cookie_consent',
	dataAttribute: 'data-cookie-consent',
};

/**
 * Cookie Consent
 *
 * @param {Object} opts The configuration object
 */
export default function CookieConsent(opts) {
	let consented = false;

	const config = {};

	Object.assign(config, defaults, opts);

	let elements = [...document.querySelectorAll(`[${config.dataAttribute}]`)];

	config.allowButton.addEventListener('click', allow);
	config.disallowButton.addEventListener('click', disallow);

	switch (getCookie(config.cookieName)) {
		case 'true':
			hide();
			loadContent();
			consented = true;
			break;
		case 'false':
			hide();
			break;
		default:
			show();
	}

	function allow() {
		hide();
		loadContent();
		setConsentCookie(true);

		if (typeof dataLayer !== 'undefined') {
			// Fire Google Tag Manager event
			dataLayer.push({ 'event': 'cookie_consent_given' });
		}
	}

	function disallow() {
		hide();
		setConsentCookie(false);
	}

	/**
	 * Show the cookie notice
	 */
	function show() {
		config.notice.classList.add(config.classList);
	}

	/**
	 * Hide the cookie notice
	 */
	function hide() {
		config.notice.classList.remove(config.classList);
	}

	/**
	 * Set the consent cookie
	 *
	 * @param {Boolean} allow
	 */
	function setConsentCookie(allow) {
		setCookie(config.cookieName, allow, { expires: '12M' });
	}

	/**
	 * Load scripts, iframes etc that require consent
	 */
	function loadContent() {
		elements.forEach(elem => {
			const tagName = elem.tagName;
			const attrValue = elem.getAttribute(config.dataAttribute);

			if (attrValue && (tagName === 'SCRIPT' || tagName === 'IFRAME')) {
				// External scripts and iframes
				elem.src = attrValue;
			} else if (tagName === 'SCRIPT' && elem.type === 'text/plain' ) {
				// Inline scripts
				var s = document.createElement('script');
				s.innerHTML = elem.innerHTML;
				elem.parentNode.insertBefore(s, elem);
				elem.remove();
			}

			elem.removeAttribute(config.dataAttribute);
		});
	}
}
