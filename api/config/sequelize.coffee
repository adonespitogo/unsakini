databaseConfig = require('../../config/database.json')
Sequelize = require('sequelize')
sequelize = null

if (process.env.NODE_ENV is 'production')
  db_url = databaseConfig.production.use_env_variable
  if (db_url)
    sequelize = new Sequelize(process.env[db_url])
  else
    sequelize = configureSequelize('production')

else
  env = process.env.NODE_ENV || 'development'
  dbConfig = databaseConfig[env]
  sequelize = new Sequelize dbConfig.database, dbConfig.username, dbConfig.password,
                host: dbConfig.host
                dialect: dbConfig.dialect
                pool: dbConfig.pool

module.exports = sequelize