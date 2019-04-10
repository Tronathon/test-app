# Craft Starter

## Requirements

As per [Craft CMS Server Requirements](https://github.com/craftcms/docs/blob/v3/en/requirements.md). PHP 7 will need to available via the CLI in order to use the included `craft` script.

## Prerequisites

- [Node](https://nodejs.org/en/)
- [Gulp CLI](https://github.com/gulpjs/gulp-cli)
- [Composer](https://getcomposer.org/)

## Getting Started

Craft will use the `config/project-config.yml` to set up some basic sections, fields etc.

1. Clone repository.
2. Create a new host and database.
3. Create a new composer project via `$ composer create-project`.
4. Setup Craft via `$ ./craft setup`.
5. Update Craft via `$ ./craft update`.
6. Install npm dependencies via `$ npm install`.