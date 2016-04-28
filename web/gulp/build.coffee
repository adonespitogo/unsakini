gulp = require('gulp')

gulp.task 'default', ['js:concat'], ->
  gulp.src('.tmp/app/js/application.js')
      .pipe(gulp.dest('./public/js'))