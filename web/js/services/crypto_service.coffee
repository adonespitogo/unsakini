window.App.factory 'CryptoService', [
  'PassphraseService'
  (PassphraseService) ->

    encrypt: (string, key) ->
      key = key || PassphraseService.getKey()
      return string if !string or !key
      encryptedAES = CryptoJS.AES.encrypt(string, key)
      encryptedAES.toString()

    decrypt: (encryptedAESString, key) ->
      key = key || PassphraseService.getKey()
      return encryptedAESString if !encryptedAESString or !key
      decrypted = CryptoJS.AES.decrypt(encryptedAESString, key)
      decrypted.toString(CryptoJS.enc.Utf8)

]