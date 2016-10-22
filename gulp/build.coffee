gulp = require('gulp')
del = require('del')
watch = require('gulp-watch')
batch = require('gulp-batch')

gulp.task 'clean:tmp', (done) ->
  del(['.tmp/**/*']).then (paths) ->
    console.log 'Deleted tmp files'
    done()
  return null

gulp.task 'build', ['clean:tmp', 'typescript:build', 'landing:js', 'landing:css', 'app:js:vendor', 'app:css:vendor'], (cb) ->
  cb()

gulp.task 'default', ['build'], ->
  files_to_delete = ['.tmp/**/*']
  del(files_to_delete)

gulp.task 'watch', ->
  watch [
    './web/js/**/*'
    './web/views/**/*'
  ], batch (events, done) ->
    gulp.start 'default', done

