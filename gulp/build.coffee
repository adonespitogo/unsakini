gulp = require('gulp')
del = require('del')
watch = require('gulp-watch')
batch = require('gulp-batch')

gulp.task 'clean', (done) ->
  del(['.tmp/**/*', 'public/**/*']).then (paths) ->
    console.log 'Deleted tmp files'
    done()
  return null

gulp.task 'build', ['clean', 'typescript:build', 'landing:js', 'landing:css', 'app:js:vendor', 'app:css:vendor'], (cb) ->
  cb()

gulp.task 'default', ['build'], ->

gulp.task 'watch', ->
  watch [
    './web/**/*'
  ], batch (events, done) ->
    gulp.start 'default', done

