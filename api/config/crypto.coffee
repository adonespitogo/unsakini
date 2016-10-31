security = require('../../config/security')
envConfig = security[process.env.NODE_ENV || 'development']

passphrase = ''
iv = ''

if typeof envConfig['passphrase'] is 'object'
  passphrase = process.env[envConfig['passphrase']['use_env_variable']]
  if !passphrase
    throw new Error "Environment variable #{envConfig['passphrase']['use_env_variable']} is null!"

if typeof envConfig['passphrase'] is 'string'
  passphrase = envConfig['passphrase']

if typeof envConfig['iv'] is 'object'
  iv = process.env[envConfig['iv']['use_env_variable']]
  if !iv
    throw new Error "Environment variable #{envConfig['iv']['use_env_variable']} is null!"

if typeof envConfig['iv'] is 'string'
  iv = envConfig['iv']

module.exports = {
  passphrase: passphrase || ''
  iv: iv || ''
}