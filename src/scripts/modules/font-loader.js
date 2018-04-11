/**
 * Async font loading via FontFaceObserver
 */

import FontFaceObserver from 'fontfaceobserver';
import { getCookie, setCookie } from 'tiny-cookie';

const typefaces = {};

export default function init() {
	if (getCookie('fonts-loaded')) {
		return false;
	}

	loadFonts().then(function() {
		document.documentElement.classList.add('fonts-loaded');
		setCookie('fonts-loaded', '1', { expires: 7, secure: true });
	});
};

function loadFonts() {
	const fonts = [];

	Object.keys(typefaces).forEach(family => {
		typefaces[family].map(variant => {
			const loader = new FontFaceObserver(family, variant);
			fonts.push(loader.load());
		});
	});

	return Promise.all(fonts);
}
