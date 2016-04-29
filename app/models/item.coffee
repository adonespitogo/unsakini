Sequelize = require('sequelize')
sequelize = require('../config/sequelize')

tableConfig =
  # // add the timestamp attributes (updatedAt, createdAt)
  timestamps: true
  # // don't delete database entries but set the newly added attribute deletedAt
  # // to the current date (when deletion was done). paranoid will only work if
  # // timestamps are enabled
  paranoid: true
  # // don't use camelcase for automatically added attributes but underscore style
  # // so updatedAt will be updated_at
  underscored: true
  # custom table name
  tableName: 'items'

Item = sequelize.define('item', {
  title:
    type: Sequelize.STRING
  content:
    type: Sequelize.TEXT
  list_id:
    type: Sequelize.INTEGER
}, tableConfig)

Item.sync(force: false)

module.exports = Item