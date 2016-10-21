gulp = require('gulp')
concat = require('gulp-concat')
uglify = require('gulp-uglify')

app_vendor_files = [
  './node_modules/jquery/dist/jquery.js'
  './node_modules/jstorage/jstorage.js'
  './node_modules/js-crypto-lib/lib/cryptojs/cryptojs.js'
]

landing_files = [
  './node_modules/jquery/dist/jquery.js'
  './node_modules/jstorage/jstorage.js'
  'web/js/**/*.js'
]

gulp.task 'app:vendor', ->
  stream = gulp.src(app_vendor_files)
                .pipe(concat('vendor.js'))

  if process.env.NODE_ENV is 'production'
    stream.pipe(uglify())

  stream.pipe(gulp.dest('public/js/app'))

gulp.task 'landing:js', ->
  gulp.src(landing_files)
      .pipe(concat('landing.js'))
      .pipe(gulp.dest('public/js/'))


