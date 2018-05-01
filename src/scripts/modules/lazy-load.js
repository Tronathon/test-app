const defaults = {
	root: null,
	rootMargin: '15%',
	threshold: 0,

	srcAttr: 'data-src',
	srcsetAttr: 'data-srcset',
	selector: '[data-src], [data-srcset]',

	onLoad: elem => elem.classList.add('has-loaded'),
	onError: elem => elem.classList.add('has-errored'),
};

function Lazy(options) {
	const config = Object.assign({}, defaults, options);

	const io = new IntersectionObserver(onIntersection, {
		root: config.root,
		rootMargin: config.rootMargin,
		threshold: config.threshold,
	});

	let elems;

	document.addEventListener('DOMContentLoaded', () => update());

	function getElements() {
		return [...document.querySelectorAll(config.selector)];
	}

	function update() {
		elems = getElements();
		elems.forEach(elem => io.observe(elem));
	}

	function onIntersection(entries) {
		entries
			.filter(entry => entry.isIntersecting)
			.map(entry => load(entry.target));
	}

	function load(elem) {
		const index = elems.indexOf(elem);
		const { srcAttr, srcsetAttr } = config;

		elem.onload = () => config.onLoad(elem);
		elem.onerror = () => config.onError(elem);

		// srcset
		if (elem.hasAttribute(srcsetAttr)) {
			elem.srcset = elem.getAttribute(srcsetAttr);
			elem.removeAttribute(srcsetAttr);
		}

		// src
		if (elem.hasAttribute(srcAttr)) {
			elem.src = elem.getAttribute(srcAttr);
			elem.removeAttribute(srcAttr);
		}

		io.unobserve(elem);
		elems.splice(index, 1);
	}

	return { elements: elems, update, load };
}

export default Lazy();
