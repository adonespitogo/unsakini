# init the index html using the config vars

config =
  robots: 'index,follow'
  name: 'Unsakini'
  title: 'Unsakini | Secure Information Storage'
  description: 'Your personal application for storing passwords, tokens, and licenses and many other sensitive data.'
  base_url: 'https://www.unsakini.com'

env = process.env.NODE_ENV or 'development'
gulp = require('gulp')
replace = require('gulp-replace')
rename = require('gulp-rename')

gulp.task 'init:index.html', ->
  gulp.src('src/index.html.sample')
      .pipe rename (path) ->
        path.extname = ''

      .pipe replace 'SITE_ROBOTS', config.robots
      .pipe replace 'SITE_NAME', config.name
      .pipe replace 'SITE_TITLE', config.title
      .pipe replace 'SITE_DESCRIPTION', config.description
      .pipe replace 'SITE_URL', config.base_url
      .pipe gulp.dest './src'
