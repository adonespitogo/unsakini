Sequelize = require('sequelize')
sequelize = require('../config/sequelize')
CryptoJS = require('crypto-js')
cryptoConfig = require('../config/crypto')


modelConfig =
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

  instanceMethods:
    toJSON: ->
      items = []
      if (@items)
        for item in @items
          items.push(item.toJSON())
      val = @get(plain: true)
      val.name = CryptoJS.AES.decrypt(val.name, cryptoConfig.passphrase, {iv: cryptoConfig.iv}).toString(CryptoJS.enc.Utf8)
      val.items = items
      val

List = sequelize.define('list', {
  name:
    type: Sequelize.STRING
  user_id:
    type: Sequelize.INTEGER
}, modelConfig)

encrypt = (list, options, cb) ->
  list.name = CryptoJS.AES.encrypt(list.name, cryptoConfig.passphrase, {iv: cryptoConfig.iv}).toString()
  cb(null, options)

List.hook 'beforeCreate', encrypt
List.hook 'beforeUpdate', encrypt
List.hook 'beforeSave', encrypt

module.exports = List