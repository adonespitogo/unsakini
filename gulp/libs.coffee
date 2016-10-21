gulp = require('gulp')
concat = require('gulp-concat')
uglify = require('gulp-uglify')

files = [
  './node_modules/jquery/dist/jquery.js'
  './node_modules/jstorage/jstorage.js'
  './node_modules/js-crypto-lib/lib/cryptojs/cryptojs.js'
]

gulp.task 'vendor', ->
  stream = gulp.src(files).pipe(concat('vendor.js'))
  if process.env.NODE_ENV is 'production'
    stream.pipe(uglify())

  stream.pipe(gulp.dest('public/js/app'))
