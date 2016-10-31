
# encrypts and decrypts data

CryptoJS = require('crypto-js')
cryptoConfig = require('../config/crypto')

module.exports.encrypt = (text) ->
  CryptoJS.AES.encrypt(text, cryptoConfig.passphrase, {iv: cryptoConfig.iv}).toString()

module.exports.decrypt = (text) ->
  CryptoJS.AES.decrypt(text, cryptoConfig.passphrase, {iv: cryptoConfig.iv}).toString(CryptoJS.enc.Utf8)

