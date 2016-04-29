window.App.factory 'CryptoService', [
  'PassphraseService'
  (PassphraseService) ->

    encrypt: (string) ->
      key = PassphraseService.getKey()
      encryptedAES = CryptoJS.AES.encrypt(string, key)
      encryptedAES.toString()

    decrypt: (encryptedAESString) ->
      key = PassphraseService.getKey()
      decrypted = CryptoJS.AES.decrypt(encryptedAESString, key)
      decrypted.toString(CryptoJS.enc.Utf8)

]