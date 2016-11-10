require('shelljs/global');
env = process.env.NODE_ENV || 'development'
gulp = require('gulp')

gulp.task 'build', ['init:index.html'], (done) ->
  exec("ng build #{if env is 'production' then '--prod' else ''}", null, done)
