env = process.env.NODE_ENV || 'development'
config = require("../../config/#{env}/security")['jwt']
secret = ''

if typeof config['use_env_variable'] is 'string'
  secret = process.env[config['use_env_variable']]
  if !secret
    throw new Error "Environment variable #{config['use_env_variable']} is null!"

module.exports = config || 'secret'