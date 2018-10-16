# Base Module

This is the Base Module and serves as an easy place to put all little bits of site specific logic and the stuff we share across sites.

## Twig

In addition to standard filters and functions offered by Twig and Craft, we provide the following additions.

### Filters

#### `ordinalize`

Converts number to its ordinal English form. For example, converts 13 to 13th, 2 to 2nd.

```twig
{{ 13|ordinalize }} {# 13th #}
```

#### `pluralize`

Converts a word to its plural form. For example, 'apple' will become 'apples', and 'child' will become 'children'.

```twig
{{ 'apple'|pluralize }} {# apples #}
```

An optional number can be passed in as a second parameter, which will cause it to only pluralize the word if the number is not `1`/

```twig
{{ 'apple'|pluralize(1) }} {# apple #}
```

#### `singularize`

Converts a word to its singular form. For example, 'apples' will become 'apple', and 'children' will become 'child'.

```twig
{{ 'children'|singularize }} {# child #}
```

An optional number can be passed in as a second parameter, which will cause it to only pluralize the word if the number is `1`.

```twig
{{ 'children'|singularize(2) }} {# children #}
```

### Globals

- `doNotTrack` - Boolean indicating if the DNT header is set.
