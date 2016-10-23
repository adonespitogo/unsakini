gulp = require('gulp')

gulp.task 'copy:fonts', ["clean"], ->
  gulp.src([
    "node_modules/font-awesome/fonts/**"
    "node_modules/bootstrap/fonts/*"
  ])
  .pipe(gulp.dest('public/fonts'))