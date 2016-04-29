window.App.factory 'CryptoService', [
  'PassphraseService'
  (PassphraseService) ->

    encrypt: (string) ->
      key = PassphraseService.getKey()
      return string if !key
      encryptedAES = CryptoJS.AES.encrypt(string, key)
      encryptedAES.toString()

    decrypt: (encryptedAESString) ->
      return null if !encryptedAESString
      key = PassphraseService.getKey()
      decrypted = CryptoJS.AES.decrypt(encryptedAESString, key)
      decrypted.toString(CryptoJS.enc.Utf8)

]