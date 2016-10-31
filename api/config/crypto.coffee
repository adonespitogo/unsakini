
environment = process.env.NODE_ENV || 'development'
security = require("../../config/#{environment}/security")

passphrase = ''
iv = ''

if typeof environment['passphrase'] is 'object'
  passphrase = process.env[environment['passphrase']['use_env_variable']]
  if !passphrase
    throw new Error "Environment variable #{environment['passphrase']['use_env_variable']} is null!"

if typeof environment['passphrase'] is 'string'
  passphrase = environment['passphrase']

if typeof environment['iv'] is 'object'
  iv = process.env[environment['iv']['use_env_variable']]
  if !iv
    throw new Error "Environment variable #{environment['iv']['use_env_variable']} is null!"

if typeof environment['iv'] is 'string'
  iv = environment['iv']

module.exports = {
  passphrase: passphrase || ''
  iv: iv || ''
}