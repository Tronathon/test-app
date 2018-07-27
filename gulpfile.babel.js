import autoprefixer from 'autoprefixer';
import babelify from 'babelify';
import browserify from 'browserify';
import browserSync from 'browser-sync';
import buffer from 'vinyl-buffer';
import changed from 'gulp-changed';
import cssnano from 'cssnano';
import del from 'del';
import gulp from 'gulp';
import path from 'path';
import postcss from 'gulp-postcss';
import size from 'gulp-size';
import sass from 'gulp-sass';
import source from 'vinyl-source-stream';
import sourcemaps from 'gulp-sourcemaps';
import sprite from 'gulp-svg-sprite';
import stylelint from 'gulp-stylelint';
import uglify from 'gulp-uglify';
import yargs from 'yargs';
import dotenv from 'dotenv';
import watchify from 'watchify';

dotenv.config()

const publicDir = 'public';
const proxyDomain = process.env.SITE_URL;

const root = {
	src: './src',
	dest: `${publicDir}/assets`,
};

const paths = {
	fonts: {
		src: `${root.src}/fonts/**/*`,
		dest: `${root.dest}/fonts`,
	},

	icons: {
		src: `${root.src}/icons/**/*.svg`,
		dest: `${root.dest}/icons`,
	},

	images: {
		src: `${root.src}/images/**/*`,
		dest: `${root.dest}/images`,
	},

	scripts: {
		entry: `${root.src}/scripts/index.js`,
		src: `${root.src}/scripts/**/*.js`,
		dest: `${root.dest}/scripts`,
	},

	styles: {
		src: `${root.src}/styles/**/*.{scss, css}`,
		dest: `${root.dest}/styles`,
	},
};

const argv = yargs.argv;
const server = browserSync.create();

const clean = () => del(`${root.dest}`);

function reload(done) {
	server.reload();
	done();
}

function syncOnDelete(filepath) {
	const srcPath = path.relative(path.resolve(root.src), filepath);
	const destPath = path.resolve(root.dest, srcPath);
	del.sync(destPath);
}

function fonts() {
	return gulp.src(paths.fonts.src)
		.pipe(changed(paths.fonts.dest))
		.pipe(gulp.dest(paths.fonts.dest));
}

function images() {
	return gulp.src(paths.images.src)
		.pipe(changed(paths.images.dest))
		.pipe(gulp.dest(paths.images.dest));
}

function icons() {
	const config = {
		mode: {
			symbol: {
				dest: '',
				sprite: 'sprite.svg',
			},
		},
		svg: {
			xmlDeclaration: false,
			doctypeDeclaration: false,
		},
	};

	return gulp.src(paths.icons.src)
		.pipe(sprite(config))
		.pipe(gulp.dest(paths.icons.dest));
}

function lintstyles() {
	const config = {
		failAfterError: false,
		reporters: [{ formatter: 'string', console: true }]
	};

	return gulp.src(paths.styles.src).pipe(stylelint(config));
}

function styles() {
	return gulp.src(paths.styles.src)
		.pipe(sourcemaps.init())
		.pipe(sass({ precision: 10 })
		.on('error', sass.logError))
		.pipe(postcss([cssnano(), autoprefixer()]))
		.pipe(sourcemaps.write('./'))
		.pipe(gulp.dest(paths.styles.dest))
		.pipe(server.stream({ match: '**/*.css' }));
}

function scripts(watch = false) {
	const opts = {
		cache: {},
		debug: process.env.NODE_ENV === 'production',
		entries: paths.scripts.entry,
		packageCache: {},
		transform: [babelify],
	};

	const b = watch ? watchify(browserify(opts)) : browserify(opts);

	function bundle() {
		return b.bundle()
			.pipe(source('main.js'))
			.pipe(buffer())
			.pipe(sourcemaps.init({ loadMaps: true }))
			.pipe(uglify())
			.pipe(size({ gzip: true }))
			.pipe(sourcemaps.write('./'))
			.pipe(gulp.dest(paths.scripts.dest));
	}

	if (watch) {
		return b.on('update', bundle);
	}

	return bundle;
}

function startServer() {
	const config = {
		open: false,
		notify: false,
	};

	Object.assign(config, argv);

	if (proxyDomain) {
		config.proxy = proxyDomain;
	} else {
		config.public = publicDir;
	}

	return server.init(config);
}

export function watch() {
	gulp.watch(paths.styles.src, gulp.series(lintstyles, styles));
	gulp.watch(paths.icons.src, gulp.series(sprite, reload));
	gulp.watch(paths.scripts.src, gulp.series(scripts(true)));
	gulp.watch(paths.fonts.src, gulp.series(fonts, reload)).on('unlink', syncOnDelete);
	gulp.watch(paths.images.src, gulp.series(images, reload)).on('unlink', syncOnDelete);
}

export const serve = gulp.parallel(startServer, watch);

export const build = gulp.series(clean,
	gulp.series(lintstyles, fonts, icons, images, scripts(false), styles));

export default serve;
