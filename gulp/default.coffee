gulp = require('gulp')
rename = require('gulp-rename');

# copy config files
gulp.task 'init:config', ->
  gulp.src('./config/**/*.sample')
      .pipe(rename( (path) ->
        path.extname = ''
      ))
      .pipe(gulp.dest('./config'))

gulp.task 'default', ['build'], (done) ->
  done()
