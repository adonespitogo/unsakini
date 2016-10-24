gulp = require('gulp')
concat = require('gulp-concat')
uglify = require('gulp-uglify')
sourcemaps = require('gulp-sourcemaps')

landing_files = [
  './node_modules/jquery/dist/jquery.js'
  './node_modules/jstorage/jstorage.js'
  'web/js/landing/**/*.js'
]

gulp.task 'landing:js', ['clean'], ->
  stream = gulp.src(landing_files)
                .pipe(sourcemaps.init())
                .pipe(concat('landing.js'))

  if process.env.NODE_ENV is 'production'
    stream.pipe(uglify())

  stream
      .pipe(sourcemaps.write(".", {
        sourceRoot: '/web/landing'
      }))
      .pipe(gulp.dest('public/js'))


