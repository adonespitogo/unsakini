env = process.env.NODE_ENV || 'development'
envConfig = require("../../config/#{env}/application")
helper = require('./helper')
config = helper(envConfig)

module.exports = config
