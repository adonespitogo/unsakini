env = process.env.NODE_ENV || 'development'
databaseConfig = require("../../config/#{env}/database.json")
helper = require('./helper')
Sequelize = require('sequelize')
sequelize = null

dbConfig = databaseConfig[env]
dbEnvName = dbConfig.use_env_variable
if (typeof dbEnvName is 'string')
  if (typeof process.env[dbEnvName] is 'string')
    sequelize = new Sequelize(process.env[dbEnvName])
  else
    throw new Error "Environment variable #{dbEnvName} is null!"

else
  config = helper(dbConfig)
  sequelize = new Sequelize config.database, config.username, config.password,
                host: config.host
                dialect: config.dialect
                pool: dbConfig.pool

module.exports = sequelize