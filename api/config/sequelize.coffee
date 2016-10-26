Sequelize = require('sequelize')
sequelize = null

if (process.env.DATABASE_URL)
  sequelize = new Sequelize(process.env.DATABASE_URL)
else
  sequelize = new Sequelize 'unsakini', 'root', '',
    host: '127.0.0.1'
    dialect: 'mysql'
    pool:
      max: 5
      min: 0
      idle: 10000

module.exports = sequelize