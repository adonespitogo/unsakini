"use strict";

var gulp = require("gulp");
var del = require("del");
var tsc = require("gulp-typescript");
var tsProject = tsc.createProject("tsconfig.json");
var sourcemaps = require('gulp-sourcemaps');
var tslint = require('gulp-tslint');
var swallowError = require('./helpers').swallowError
var htmlmin = require('gulp-htmlmin');
var concat = require('gulp-concat');
var uglify = require('gulp-uglify');
var replace = require('gulp-replace');

/**
 * Lint all custom TypeScript files.
 */
gulp.task('tslint', () => {
  return gulp.src("web/ng-app/**/*.ts")
    .pipe(tslint({
      formatter: 'prose'
    }))
    .pipe(tslint.report());
});

/**
 * ts:transpile TypeScript sources and create sourcemaps in public directory.
 */
gulp.task("ts:transpile", ["tslint", "clean"], () => {
  var tsResult;


  if (process.env.NODE_ENV === 'production') {
    // enable ng production mode
    var prodStr = "import {enableProdMode} from '@angular/core';\nenableProdMode();\n";
    tsResult = tsProject.src("web/ng-app/**/*.ts")
                          .pipe(replace('//PRODUCTION_MODE_PLACEHOLDER', prodStr))
                          .pipe(sourcemaps.init())
                          .pipe(tsProject());
  } else {
    tsResult = tsProject.src("web/ng-app/**/*.ts")
                          .pipe(sourcemaps.init())
                          .pipe(tsProject());
  }

  if (process.env.NODE_ENV === 'production') {
    return tsResult.js
      .pipe(uglify())
      .pipe(sourcemaps.write(".", {
        sourceRoot: '/web/ng-app'
      }))
      .pipe(gulp.dest("public/js/app"));
  } else {
  return tsResult.js
    .pipe(sourcemaps.write(".", {
      sourceRoot: '/web/ng-app'
    }))
    .pipe(gulp.dest("public/js/app"));
  }
});

/**
 * Copy all required libraries into public directory.
 */
gulp.task("ng:libs", ["clean"], () => {
  var stream = gulp.src([
    'rxjs/**/*.js',
    '@angular/**/bundles/**/*.{js,map}',
  ], {
    cwd: "node_modules/**"
  }); /* Glob required here. */
  return stream.pipe(gulp.dest("public/js/app/libs"));
});

/**
 * public the views to pulic dir.
 */
gulp.task("ng:views", ['ts:transpile', 'ng:libs', "clean"], () => {
  return gulp.src([
      'web/ng-app/**/*.html'
    ])
    .pipe(htmlmin({
      collapseWhitespace: true,
      removeComments: true,
      caseSensitive: true
    }))
    .pipe(gulp.dest('public/views'))
});

/**
 * public the component styles to pulic dir.
 */
gulp.task("ng:styles", ['ts:transpile', 'ng:libs', "clean"], () => {
  return gulp.src([
      'web/ng-app/**/*.css'
    ])
    .pipe(gulp.dest('public/css'))
});

/**
 * public the project.
 */
gulp.task("ng:typescript", ['ts:transpile', 'ng:libs', 'ng:views', 'ng:styles'], () => {
});


