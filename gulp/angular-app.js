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
 * typescript:transpile TypeScript sources and create sourcemaps in public directory.
 */
gulp.task("typescript:transpile", ["tslint", "clean"], () => {
  let tsResult = gulp.src("web/ng-app/**/*.ts")
    .pipe(sourcemaps.init())
    .pipe(tsProject());
  return tsResult.js
    .pipe(sourcemaps.write(".", {
      sourceRoot: '/web'
    }))
    .pipe(gulp.dest("public/js/app"));
});

/**
 * Copy all required libraries into public directory.
 */
gulp.task("ng:libs", ["clean"], () => {
  return gulp.src([
      'rxjs/**/*.js',
      // 'zone.js/dist/**',
      '@angular/**/bundles/**',
    ], {
      cwd: "node_modules/**"
    }) /* Glob required here. */
    .pipe(gulp.dest("public/js/app/libs"));
});

/**
 * public the views to pulic dir.
 */
gulp.task("ng:views", ['typescript:transpile', 'ng:libs', "clean"], () => {
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
gulp.task("ng:styles", ['typescript:transpile', 'ng:libs', "clean"], () => {
  return gulp.src([
      'web/ng-app/**/*.css'
    ])
    .pipe(gulp.dest('public/css'))
});

/**
 * public the project.
 */
gulp.task("ng:typescript", ['typescript:transpile', 'ng:libs', 'ng:views', 'ng:styles'], () => {
});


