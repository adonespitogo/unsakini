gulp = require('gulp')
concat = require('gulp-concat')
uglify = require('gulp-uglify')

app_vendor_files = [
  './node_modules/jquery/dist/jquery.js'
  './node_modules/jstorage/jstorage.js'
  './node_modules/js-crypto-lib/lib/cryptojs/cryptojs.js'
  './node_modules/core-js/client/shim.min.js'
  './node_modules/systemjs/dist/system-polyfills.js'
  './node_modules/systemjs/dist/system.src.js'
  './node_modules/reflect-metadata/Reflect.js'
]

gulp.task 'app:js:vendor', ["clean"] , ->
  stream = gulp.src(app_vendor_files)
                .pipe(concat('app-vendor.js'))

  if process.env.NODE_ENV is 'production'
    stream.pipe(uglify())

  stream.pipe(gulp.dest('public/js'))


