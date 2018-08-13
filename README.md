# Craft Starter

- [Craft ID](https://id.craftcms.com/account/licenses/cms)
- [Craft Documentation](https://docs.craftcms.com/v3/)

## Requirements

As per [Craft CMS Server Requirements](https://github.com/craftcms/docs/blob/v3/en/requirements.md). PHP 7 will need to available via the CLI in order to use the included `Craft` script.

## Prerequisites

- [Node.js](https://nodejs.org/en/)
- [Gulp CLI](https://github.com/gulpjs/gulp-cli)
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

## Further Documentation

- [Cookies](/docs/cookie-notice.md)
- [Deployment](/docs/deployment.md)
- [Twig Extensions](/docs/twig.md)
- [Fonts and Typography](/docs/fonts-and-typography)
