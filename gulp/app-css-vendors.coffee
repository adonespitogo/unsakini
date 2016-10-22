gulp = require('gulp')
concat = require('gulp-concat')
cssnano = require('gulp-cssnano')
sass = require('gulp-sass')

vendor_css_files = [
  "node_modules/bootstrap/dist/css/bootstrap.css"
  "node_modules/bootstrap/dist/css/bootstrap-theme.css"
]

gulp.task 'app:css:vendor', ["clean"], ->
  stream = gulp.src(vendor_css_files)
      .pipe(concat('app-vendor.css'))

  if process.env.NODE_ENV is 'production'
    stream.pipe(cssnano())

  return stream.pipe(gulp.dest('public/css'))