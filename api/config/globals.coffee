env = process.env.NODE_ENV || 'development'
envConfig = require("../../config/#{env}/application")
config = {}

if (typeof envConfig['base_url']) is 'string'
  config['base_url'] = envConfig['base_url']
if (typeof envConfig['base_url']) is 'object'
  config['base_url'] = process.env[envConfig['base_url']['use_env_variable']]
  if !config.base_url
    throw new Error "Environment variable #{envConfig['base_url']['use_env_variable']} is null!"

module.exports = config
