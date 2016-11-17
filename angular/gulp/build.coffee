require('shelljs/global');
env = process.env.NODE_ENV || 'development'
gulp = require('gulp')
del = require('del')

gulp.task 'ng:build', ['init:index.html'], (done) ->
  exec("ng build --base-href /app/ #{if env is 'production' then '--prod' else ''}", null, done)

gulp.task 'build', ['ng:build']

gulp.task 'default', ['build']