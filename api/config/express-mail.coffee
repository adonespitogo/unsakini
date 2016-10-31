
mailer = require('express-mailer')
env = process.env.NODE_ENV || 'development'
envConfig = require("../../config/#{env}/express-mail");
helper = require('./helper')
config = helper(envConfig)

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
