gulp = require('gulp')
del = require('del')
watch = require('gulp-watch')
batch = require('gulp-batch')

gulp.task 'clean:tmp', ->
  del(['.tmp/**/*'])

gulp.task 'default', ['clean:tmp', 'js:concat', 'uglify'], ->
  gulp.src('.tmp/app/js/uglify/**/*')
      .pipe(gulp.dest('public/js'))


gulp.task 'watch', ->
  watch [
    './web/js/**/*'
    './web/views/**/*'
  ], batch (events, done) ->
    gulp.start 'default', done

