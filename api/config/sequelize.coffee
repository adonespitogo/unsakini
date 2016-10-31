env = process.env.NODE_ENV || 'development'
databaseConfig = require("../../config/#{env}/database.json")
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
  sequelize = new Sequelize dbConfig.database, dbConfig.username, dbConfig.password,
                host: dbConfig.host
                dialect: dbConfig.dialect
                pool: dbConfig.pool

module.exports = sequelize