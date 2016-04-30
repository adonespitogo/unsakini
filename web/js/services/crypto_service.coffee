window.App.factory 'CryptoService', [
  'PassphraseService'
  '$filter'
  (PassphraseService, $filter) ->

    encrypt: (string, key) ->
      key = key || PassphraseService.getKey()
      return string if !string or !key
      encryptedAES = CryptoJS.AES.encrypt(string, key)
      encryptedAES.toString()

    decrypt: (encryptedAESString, key) ->
      key = key || PassphraseService.getKey()
      if !encryptedAESString or !key
        return encryptedAESString
      else
        decrypted = CryptoJS.AES.decrypt(encryptedAESString, key)
        try
          return decrypted.toString(CryptoJS.enc.Utf8)
        catch e
          return encryptedAESString

]