gulp = require('gulp')
concat = require('gulp-concat')
cssnano = require('gulp-cssnano')
sass = require('gulp-sass')

vendor_css_files = [
  "node_modules/bootstrap/dist/css/bootstrap.css"
  "node_modules/bootstrap/dist/css/bootstrap-theme.css"
]

landing_css_files = [
  'web/css/**/*.css'
]

landing_sass_files = [
  'web/css/**/*.scss'
]

gulp.task 'landing:sass', ['clean'], ->
  gulp.src(landing_sass_files)
      .pipe(sass())
      .pipe(gulp.dest('.tmp/landing/sass'))


css_files = vendor_css_files.concat(landing_css_files)
css_files = css_files.concat('.tmp/landing/sass/**/*.css')

gulp.task 'landing:css', ['landing:sass', 'clean'], ->
  stream = gulp.src(css_files)
      .pipe(concat('landing.css'))

  if process.env.NODE_ENV is 'production'
    stream.pipe(cssnano())
      .pipe(gulp.dest('.tmp/landing/css/concat'))

  return stream.pipe(gulp.dest('public/css'))