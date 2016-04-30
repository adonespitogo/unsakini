gulp = require('gulp')
concat = require('gulp-concat')
cssnano = require('gulp-cssnano')


gulp.task 'css:concat', ['clean:tmp'], ->
  gulp.src('web/css/**/*.css')
      .pipe(concat('application.css'))
      .pipe(gulp.dest('.tmp/app/css/concat'))

gulp.task 'css:nano', ['css:concat'], ->
  stream = gulp.src('.tmp/app/css/concat/application.css')
  if process.env.NODE_ENV is 'production'
    stream.pipe(cssnano())

  stream.pipe(gulp.dest('.tmp/app/css/nano'))

gulp.task 'app:css', ['css:nano', 'css:concat'], ->
  gulp.src('.tmp/app/css/nano/application.css')
      .pipe(gulp.dest('public/css/'))