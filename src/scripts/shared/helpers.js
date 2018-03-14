/**
 * Get the width of the native scrollbar
 *
 * @returns {Number}
 */
export function getScrollbarWidth() {
	const inner = document.createElement('p');
	const outer = document.createElement('div');

	inner.style.width = '100%';
	inner.style.height = '200px';

	outer.style.position = 'absolute';
	outer.style.top = '0px';
	outer.style.left = '0px';
	outer.style.visibility = 'hidden';
	outer.style.width = '200px';
	outer.style.height = '150px';
	outer.style.overflow = 'hidden';
	outer.appendChild(inner);

	document.body.appendChild(outer);
	var w1 = inner.offsetWidth;
	outer.style.overflow = 'scroll';
	var w2 = inner.offsetWidth;
	if (w1 == w2) w2 = outer.clientWidth;

	document.body.removeChild(outer);

	return (w1 - w2);
};
