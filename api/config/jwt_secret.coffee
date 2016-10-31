env = process.env.NODE_ENV || 'development'
config = require("../../config/#{env}/security")['jwt']
helper = require('./helper')

secret = helper({jwt: config}).jwt

if typeof config['use_env_variable'] is 'string'
  secret = process.env[config['use_env_variable']]
  if !secret
    throw new Error "Environment variable #{config['use_env_variable']} is null!"
else
  secret = config

module.exports = secret || 'secret'