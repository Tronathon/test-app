## Fonts

### Loading

To improve performance fonts should be loaded using the Font Face Observer. To do so include the font files and `@font-face` declarations as normal. Then define your fonts in `src/scripts/modules/font-loader.js`. For example

```js
const typefaces = {
	'Vollkorn': [
		{ weight: 400, style: 'normal' },
		{ weight: 400, style: 'italic' },
		{ weight: 700, style: 'normal' },
	],
	'Lato': [
		{ weight: 400, style: 'normal' },
		{ weight: 900, style: 'normal' },
	],
};
```

Font's will then be loaded asynchronously, once loaded the `fonts-loaded` class will be added to the `html` element. In order to benefit from this font loading strategy we now need to only ever apply a font once it's loaded, providing a fallback whilst we wait.

```css
p {
	font-family: sans-serif;
}

.fonts-loaded p {
	font-family: "Lato", sans-serif;
}
```

### Usage

A mixin is provided to help manage typography. To use it create a `$typography-map` variable in `src/styles/_variable.scss`.

```scss
$typography-map: (
	body: (
		1: ( "font-size": 16, "line-height": 18 ),
		2: ( "font-size": 18, "line-hight:": 20 ),
	),
	headings: (
		1: ( "font-size": 16, "line-height": 18 ),
		2: ( "font-size": 18, "line-hight:": 20 ),
	),
);
```

Each variant can define:

- font-size in px
- line-height in px,
- letter-spacing

The font-size will converted to rem's and the line height to relative unit.

The using the `typography` mixin we can declare font's like so:

```scss
.font-one {
	@include typography("heading", 1);
}
```

To make managing fonts easier we can break each font set into it's own mixin. 

```scss
@mixin heading($level) {
	@include typography("heading", $level);
	font-family: sans-serif;
	font-weight: 900;

	.fonts-loaded & {
		font-family: "Lato", sans-serif;
	}
}

.heading-one {
	@include heading(1);
	
	@include media(m) {
		@include heading(2);
	}
}
```

