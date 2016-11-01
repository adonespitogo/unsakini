
# encrypts and decrypts data

# References:
# http://stackoverflow.com/questions/29807108/derive-key-and-iv-from-string-for-aes-encryption-in-cryptojs-and-php
# http://stackoverflow.com/questions/23188593/cryptojs-check-if-aes-passphrase-is-correct
# http://stackoverflow.com/questions/27179685/how-to-encrypt-a-message-at-client-side-using-crypto-js-library-and-decrypt-it-a

CryptoJS = require('crypto-js')
cryptoConfig = require('../config/crypto')
iterations = 500
keySize = 256;
ivSize = 128;

module.exports.encrypt = (text) ->

  salt = CryptoJS.lib.WordArray.random(128/8)
  key = CryptoJS.PBKDF2(cryptoConfig.passphrase, salt, {
    keySize: keySize/32,
    iterations: iterations
  })

  iv = CryptoJS.PBKDF2(cryptoConfig.iv, salt, {
    keySize: ivSize/32,
    iterations: iterations
  })

  encrypted = CryptoJS.AES.encrypt(text, key, {
    iv: iv
    mode: CryptoJS.mode.CBC
    padding: CryptoJS.pad.Pkcs7
  })
  .toString()

  # salt will be hex 32 in length
  return salt.toString() + encrypted

module.exports.decrypt = (text) ->

  salt = CryptoJS.enc.Hex.parse(text.substr(0, 32))
  ciphertext = text.substr(32)

  key = CryptoJS.PBKDF2(cryptoConfig.passphrase, salt, {
    keySize: keySize/32,
    iterations: iterations
  })

  iv = CryptoJS.PBKDF2(cryptoConfig.iv, salt, {
    keySize: ivSize/32,
    iterations: iterations
  })

  CryptoJS.AES.decrypt(ciphertext, key, {
    iv: iv
    mode: CryptoJS.mode.CBC
    padding: CryptoJS.pad.Pkcs7
  })
  .toString(CryptoJS.enc.Utf8)

