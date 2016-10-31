env = process.env.NODE_ENV || 'development'
config = require('../../config/security')[env]['jwt']

if typeof config['use_env_variable'] is 'string'
  config = process.env[config['use_env_variable']]
  if !config
    throw new Error "Environment variable #{config['use_env_variable']} is null!"

module.exports = config || 'secret'