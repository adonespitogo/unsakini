gulp = require('gulp')
concat = require('gulp-concat')
uglify = require('gulp-uglify')

landing_files = [
  './node_modules/jquery/dist/jquery.js'
  './node_modules/jstorage/jstorage.js'
  'web/js/**/*.js'
]

gulp.task 'landing:js', ->
  gulp.src(landing_files)
      .pipe(concat('landing.js'))
      .pipe(gulp.dest('public/js/'))


