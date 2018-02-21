# Starter Files

## Prerequisites

* [Node.js](https://nodejs.org/en/)
* [gulp](https://github.com/gulpjs/gulp)

## Getting Started

```
$ npm install
```

## Build

All src files should live in `src`, no files should **ever** be manually added to `dest` as this directory and it's contents are removed on every build.

### Tasks

Gulp is used as the underlying build tool and exports the following tasks.

| Task  | Description                                                  |
|-------|--------------------------------------------------------------|
| build | Cleans the output directory and builds all src files         |
| watch | Watch files and rebuild on change                            |
| serve | Starts a new BrowserSync server and rebuilds files on change |
