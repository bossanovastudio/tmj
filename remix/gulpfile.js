// Requires
var gulp = require('gulp');
var gutil = require('gulp-util');
var sass = require('gulp-sass');
var autoprefixer = require('gulp-autoprefixer');
var uglify = require('gulp-uglify');
var sourcemaps = require('gulp-sourcemaps');
var concat = require('gulp-concat');


// Variables
var dirs = {
  private: 'src',
  public: 'dist',
  bower: 'bower_components'
};
var vendor = {
  stylesheets: [],
  scripts: [
    dirs.bower + '/jquery/dist/jquery.js'
  ]
};
var app = {
  fonts: [dirs.private + '/fonts/**'],
  images: [dirs.private + '/images/**'],
  stylesheets: [dirs.private + '/stylesheets/**/*.scss'],
  scripts: [dirs.private + '/scripts/**/*.js'],
  templates: [dirs.private + '/**/*.html']
};
var configs = {
  sass: {
    outputStyle: 'compressed',
    includePaths: [dirs.bower + '/bootstrap-sass/assets/stylesheets']
  },
  uglify: {
    preserveComments: 'license'
  }
};

// Tasks
gulp.task('vendor', function() {
  if( vendor.stylesheets.length ) {
    gulp.src(vendor.stylesheets)
      .pipe(concat('vendors.css'))
      .pipe(gulp.dest(dirs.public + '/css'));
  }

  if( vendor.scripts.length ) {
    gulp.src(vendor.scripts)
      .pipe(concat('vendors.js'))
      .pipe(uglify(configs.uglify))
      .pipe(gulp.dest(dirs.public + '/js'));
  }
});

gulp.task('app:assets', function() {
  gulp.src(app.fonts)
    .pipe(gulp.dest(dirs.public + '/fonts'));

  gulp.src(app.images)
    .pipe(gulp.dest(dirs.public + '/img'));
});

gulp.task('app:stylesheets', function() {
  if( app.stylesheets.length ) {
    gulp.src(app.stylesheets)
      // .pipe(sourcemaps.init())
      .pipe(sass(configs.sass).on('error', sass.logError))
      // .pipe(sourcemaps.write())
      .pipe(autoprefixer())
      .pipe(gulp.dest(dirs.public + '/css'));
  }
});

gulp.task('app:scripts', function() {
  if( app.scripts.length ) {
    gulp.src(app.scripts)
      .pipe(uglify(configs.uglify))
      .pipe(gulp.dest(dirs.public + '/js'));
  }
});

gulp.task('app:templates', function() {
  gulp.src(app.templates)
    .pipe(gulp.dest(dirs.public));
});

gulp.task('once', ['vendor', 'app:assets', 'app:stylesheets', 'app:scripts', 'app:templates']);

gulp.task('default', ['once'], function() {
  gulp.watch([app.fonts, app.images], ['app:assets']);
  gulp.watch(app.stylesheets, ['app:stylesheets']);
  gulp.watch(app.scripts, ['app:scripts']);
  gulp.watch(app.templates, ['app:templates']);
});
