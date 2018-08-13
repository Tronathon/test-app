# Deployments

Both the vendor folder and built files are not committed to the repo, therefore need to be installed/built on the target server on deployment this can be done via [DeployHQ's "Build Process"](https://www.deployhq.com/support/manual/deployhq-build).

## Build Process

To set up the build process do the following:

1. Add the following commands to "Build Commands"
	
	```
	npm run build
	composer install
	```

2. Add the following to "Cached Build Files"

	```
	node_modules/**
	vendor/**
	```

Once `composer install` has run `craft migrate/all` will be run to perform any pending database migrations.
