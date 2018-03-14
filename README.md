# Craft Starter

## Requirements

As per [Craft CMS Server Requirements](https://github.com/craftcms/docs/blob/v3/en/requirements.md). PHP 7 will need to available via the CLI in order to use the included `Craft` script.

## Prerequisites

- [Node.js](https://nodejs.org/en/)
- [Gulp](https://github.com/gulpjs/gulp)
- [Composer](https://getcomposer.org/)

## Getting Started

1. Clone repo
2. Run `npm install && composer install`
3. Run `./craft install`
4. Create database and import `db_dumps/craft.sql`

## Build

Gulp is used as the underlying build tool and exports the following tasks which also are aliased as npm scripts.

### Build Scripts

| Script | Description                                                  |
|--------|--------------------------------------------------------------|
| build  | Cleans the output directory and builds all src files         |
| watch  | Watch files and rebuild on change                            |
| serve  | Starts a new BrowserSync server and rebuilds files on change |

```
npm run serve
```

## Deployments

Both the vendor folder and built files are not committed to the repo, therefore need to be installed/built on the target server on deployment this can be done via [DeployHQ's "Build Process"](https://www.deployhq.com/support/manual/deployhq-build).

### Build Process

To set up the build process do the following:

1. Add the following commands to "Build Commands"
	
	```
	npm run build
	composer update
	```

2. Add the following to "Cached Build Files"

	```
	node_modules/**
	vendor/**
	```
