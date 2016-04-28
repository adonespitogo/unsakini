Sequelize = require('sequelize')
sequelize = require('../config/sequelize')

List = sequelize.define('list', {
  firstName:
    type: Sequelize.STRING
    field: 'first_name'
  lastName: type: Sequelize.STRING
}, freezeTableName: true)

List.sync(force: true).then ->
  # Table created
  List.create
    firstName: 'John'
    lastName: 'Hancock'

module.exports = List