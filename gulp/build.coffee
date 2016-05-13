gulp = require('gulp')
del = require('del')
watch = require('gulp-watch')
batch = require('gulp-batch')

gulp.task 'clean:tmp', ->
  del(['.tmp/**/*'])

gulp.task 'build', ['clean:tmp', 'js:concat', 'uglify', 'app:css'], ->
  gulp.src('.tmp/app/js/uglify/**/*')
      .pipe(gulp.dest('public/js'))

gulp.task 'default', ['build'], ->
  files_to_delete = ['.tmp/**/*']
#  if process.env.NODE_ENV is 'production'
#    files_to_delete.push('bower_components/**/*')
  del(files_to_delete)

gulp.task 'watch', ->
  watch [
    './web/js/**/*'
    './web/views/**/*'
  ], batch (events, done) ->
    gulp.start 'default', done

