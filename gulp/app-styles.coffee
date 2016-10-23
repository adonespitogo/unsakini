gulp = require('gulp')
concat = require('gulp-concat')
cssnano = require('gulp-cssnano')
sass = require('gulp-sass')

vendor_css_files = [
  "node_modules/bootstrap/dist/css/bootstrap.css"
  "node_modules/bootstrap/dist/css/bootstrap-theme.css"
  "web/css/app/dashboard.css"
  "web/css/app/ie10-viewport-bug-workaround.css"
]

gulp.task 'app:styles', ["clean"], ->
  stream = gulp.src(vendor_css_files)
      .pipe(concat('application.css'))

  if process.env.NODE_ENV is 'production'
    stream.pipe(cssnano())

  return stream.pipe(gulp.dest('public/css'))