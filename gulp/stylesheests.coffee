gulp = require('gulp')
concat = require('gulp-concat')
cssnano = require('gulp-cssnano')

vendor_css_files = [
  "bower_components/bootstrap/dist/css/bootstrap.css"
  "bower_components/bootstrap/dist/css/bootstrap-theme.css"
  "bower_components/angular-toastr/dist/angular-toastr.css"
]

app_css_files = [
  'web/css/**/*.css'
]

css_files = vendor_css_files.concat(app_css_files)

gulp.task 'css:concat', ['clean:tmp'], ->
  gulp.src(css_files)
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