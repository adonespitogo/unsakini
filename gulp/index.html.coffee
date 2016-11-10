# init the index html using the config vars

defaults =
  robots: 'index, follow'
  name: 'Unsakini'
  description: 'Your personal application for storing passwords, tokens, and licenses and many other sensitive data.'
  base_url: 'https://www.unsakini.com'

getConfigVal = (field, val) ->
  return val if !val
  if typeof val['use_env_variable'] is 'string'
    envVal = process.env[val.use_env_variable]
    if !envVal
      throw new Error "Environment variable #{val['use_env_variable'] } is null!"
    else
      val = process.env[val.use_env_variable]
  if val is 'false'
    val = false
  if val is 'true'
    val = true
  val

getConfig = (envConfig) ->
  config = {}
  for f, v of envConfig
    config[f] = getConfigVal(f, v)

  config

env = process.env.NODE_ENV or 'development'
gulp = require('gulp')
_ = require('lodash')
replace = require('gulp-replace')
rename = require('gulp-rename')
options = getConfig(require("../config/#{env}/application"))
config = _.merge(defaults, options)

gulp.task 'init:index.html', ->
  gulp.src('src/index.html.sample')
      .pipe rename (path) ->
        path.extname = ''

      .pipe replace 'SITE_ROBOTS', config.robots
      .pipe replace 'SITE_NAME', config.name
      .pipe replace 'SITE_DESCRIPTION', config.description
      .pipe replace 'SITE_URL', config.base_url

      .pipe gulp.dest './src'