Sequelize = require('sequelize')
sequelize = require('../config/sequelize')


tableConfig =
  # // add the timestamp attributes (updatedAt, createdAt)
  timestamps: false
  # // don't delete database entries but set the newly added attribute deletedAt
  # // to the current date (when deletion was done). paranoid will only work if
  # // timestamps are enabled
  paranoid: false
  # // don't use camelcase for automatically added attributes but underscore style
  # // so updatedAt will be updated_at
  underscored: true
  # custom table name
  tableName: 'lists'

List = sequelize.define('list', {
  name:
    type: Sequelize.STRING
  user_id:
    type: Sequelize.INTEGER
}, tableConfig)

# List.sync(force: false)

module.exports = List