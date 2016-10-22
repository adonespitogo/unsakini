"use strict";

var gulp = require("gulp");
var del = require("del");
var tsc = require("gulp-typescript");
var tsProject = tsc.createProject("tsconfig.json");
var sourcemaps = require('gulp-sourcemaps');
var tslint = require('gulp-tslint');
var swallowError = require('./helpers').swallowError

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
 * Compile TypeScript sources and create sourcemaps in public directory.
 */
gulp.task("compile", ["tslint"], () => {
  let tsResult = gulp.src("web/ng-app/**/*.ts")
    .pipe(sourcemaps.init())
    .pipe(tsProject());
  return tsResult.js
    .pipe(sourcemaps.write(".", {
      sourceRoot: '/web'
    }))
    .pipe(gulp.dest(".tmp/app/js"));
});

/**
 * Copy all required libraries into public directory.
 */
gulp.task("libs", () => {
  return gulp.src([
      'core-js/client/shim.min.js',
      'systemjs/dist/system-polyfills.js',
      'systemjs/dist/system.src.js',
      'reflect-metadata/Reflect.js',
      'rxjs/**/*.js',
      'zone.js/dist/**',
      '@angular/**/bundles/**',
    ], {
      cwd: "node_modules/**"
    }) /* Glob required here. */
    .pipe(gulp.dest(".tmp/app/js/libs"));
});

/**
 * public the views to pulic dir.
 */
gulp.task("ng:views", ['compile', 'libs'], () => {
  return gulp.src([
      'web/**/*.html'
    ])
    .pipe(gulp.dest('public/'))
});

/**
 * public the project.
 */
gulp.task("typescript:build", ['compile', 'libs', 'ng:views'], () => {
  return gulp.src([
      '.tmp/app/js/**',
      'web/ng-app/systemjs.config.js'
    ])
    .pipe(gulp.dest('public/js/app'))
});
