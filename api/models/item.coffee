Sequelize = require('sequelize')
sequelize = require('../config/sequelize')
crypto = require('../services/crypto')

tableConfig =
  # // add the timestamp attributes (updatedAt, createdAt)
  timestamps: true
  # // don't delete database entries but set the newly added attribute deletedAt
  # // to the current date (when deletion was done). paranoid will only work if
  # // timestamps are enabled
  paranoid: false
  # // don't use camelcase for automatically added attributes but underscore style
  # // so updatedAt will be updated_at
  underscored: true
  # custom table name
  tableName: 'items'

  instanceMethods:
    toJSON: ->
      val = @get(plain: true)
      list = null
      if @list
        list = @list.toJSON()
      val.title = crypto.decrypt(val.title)
      val.content = crypto.decrypt(val.content)
      val.list = list
      val

Item = sequelize.define('item', {
  title:
    type: Sequelize.STRING
  content:
    type: Sequelize.TEXT
  list_id:
    type: Sequelize.INTEGER
}, tableConfig)

encrypt = (item, options, cb) ->
  item.title = crypto.encrypt(item.title)
  item.content = crypto.encrypt(item.content)
  cb(null, options)

Item.hook 'beforeCreate', encrypt
Item.hook 'beforeUpdate', encrypt
Item.hook 'beforeSave', encrypt

module.exports = Item