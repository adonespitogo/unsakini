
mailer = require('express-mailer')

config = {}

env = process.env.NODE_ENV || 'development'
envConfig = require('../../config/express-mail')[env];

getConfigVal = (field) ->
  val = envConfig[field]
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
  # console.log "#{field}: #{val}, type: #{typeof val}"
  val

fields = [
  'from', 'host', 'secureConnection', 'port', 'transportMethod', 'user', 'pass'
]

for f in fields by 1
  config[f] = getConfigVal(f)

module.exports = (app) ->
  mailer.extend(app, {
    from: config.from
    host: config.host
    secureConnection: config.secureConnection
    port: config.port
    transportMethod: config.transportMethod # default is SMTP. Accepts anything that nodemailer accepts
    auth: {
      user: config.user
      pass: config.pass
    }
  })
