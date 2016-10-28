mailer = require('express-mailer')
config = require('./mailer.config')

module.exports = (app) ->

  mailer.extend(app, {
    from: process.env.MAILER_FROM || config.from,
    host: process.env.MAILER_HOST || config.host, # hostname
    secureConnection: false, # use SSL
    port: process.env.MAILER_PORT || config.port, # port for secure SMTP
    transportMethod: process.env.MAILER_TRANSPORT_METHOD || config.transportMethod, # default is SMTP. Accepts anything that nodemailer accepts
    auth: {
      user: process.env.MAILER_USER || config.auth.user,
      pass: process.env.MAILER_PASS || config.auth.pass
    }
  })
