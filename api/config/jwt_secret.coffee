env = process.env.NODE_ENV || 'development'
config = require('../../config/security')[env]['jwt']

if typeof config['use_env_variable'] is 'string'
  config = process.env[config['use_env_variable']]

module.exports = config || 'secret'