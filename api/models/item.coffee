Sequelize = require('sequelize')
sequelize = require('../config/sequelize')
CryptoJS = require('crypto-js')
cryptoConfig = require('../config/crypto')

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
      val.title = CryptoJS.AES.decrypt(val.title, cryptoConfig.passphrase, {iv: cryptoConfig.iv}).toString(CryptoJS.enc.Utf8)
      val.content = CryptoJS.AES.decrypt(val.content, cryptoConfig.passphrase, {iv: cryptoConfig.iv}).toString(CryptoJS.enc.Utf8)
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
  item.title = CryptoJS.AES.encrypt(item.title, cryptoConfig.passphrase, {iv: cryptoConfig.iv}).toString()
  item.content = CryptoJS.AES.encrypt(item.content, cryptoConfig.passphrase, {iv: cryptoConfig.iv}).toString()
  cb(null, options)

Item.hook 'beforeCreate', encrypt
Item.hook 'beforeUpdate', encrypt
Item.hook 'beforeSave', encrypt

module.exports = Item