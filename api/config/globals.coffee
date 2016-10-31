appconfig = require('../../config/application')
envConfig = appconfig[process.env.NODE_ENV || 'development']

module.exports = {
  base_url: envConfig['base_url'] or 'http://localhost:3000'
}
