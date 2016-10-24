gulp = require('gulp')
concat = require('gulp-concat')
uglify = require('gulp-uglify')
sourcemaps = require('gulp-sourcemaps')

app_vendor_files = [
  # my libs
  './node_modules/jquery/dist/jquery.js'
  './node_modules/jstorage/jstorage.js'
  './node_modules/crypto-js/crypto-js.js'
  './node_modules/marked/lib/marked.js'
  './node_modules/lodash/lodash.js'
  # angular libs
  './node_modules/core-js/client/shim.min.js'
  './node_modules/systemjs/dist/system-polyfills.js'
  './node_modules/systemjs/dist/system.src.js'
  './node_modules/reflect-metadata/Reflect.js'
  './node_modules/zone.js/dist/zone.js'
  './web/js/app/systemjs.config.js'
  './web/js/app/systemjs.bootstrap.js'
]

gulp.task 'app:scripts', ["clean"] , ->
  stream = gulp.src(app_vendor_files)
                .pipe(sourcemaps.init())
                .pipe(concat('application.js'))

  if process.env.NODE_ENV is 'production'
    stream.pipe(uglify())

  stream
      .pipe(sourcemaps.write(".", {
        sourceRoot: '/node_modules'
      }))
      .pipe(gulp.dest('public/js'))


