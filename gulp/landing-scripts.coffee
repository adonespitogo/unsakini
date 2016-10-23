gulp = require('gulp')
concat = require('gulp-concat')
uglify = require('gulp-uglify')

landing_files = [
  './node_modules/jquery/dist/jquery.js'
  './node_modules/jstorage/jstorage.js'
  'web/js/landing/**/*.js'
]

gulp.task 'landing:js', ['clean'], ->
  stream = gulp.src(landing_files)
                .pipe(concat('landing.js'))

  if process.env.NODE_ENV is 'production'
    stream.pipe(uglify())

  stream.pipe(gulp.dest('public/js'))


