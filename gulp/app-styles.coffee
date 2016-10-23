gulp = require('gulp')
concat = require('gulp-concat')
cssnano = require('gulp-cssnano')
sass = require('gulp-sass')

# sass_files = [
#   "node_modules/font-awesome/**/font-awesome.scss"
# ]

# gulp.task 'app:sass', ["clean"], ->
#   gulp.src(sass_files)
#   .pipe(sass())
#   .pipe(gulp.dest('.tmp/css/app/scss'))

css_files = [
  "node_modules/font-awesome/css/font-awesome.css"
  "node_modules/bootstrap/dist/css/bootstrap.css"
  "node_modules/bootstrap/dist/css/bootstrap-theme.css"
  "web/css/app/dashboard.css"
  "web/css/app/ie10-viewport-bug-workaround.css"
]

gulp.task 'app:styles', ["clean"], ->
  stream = gulp.src(css_files)
      .pipe(concat('application.css'))

  if process.env.NODE_ENV is 'production'
    stream.pipe(cssnano())

  return stream.pipe(gulp.dest('public/css'))