window.App.filter 'decrypt', [
  'CryptoService'
  (CryptoService) ->

    (input) ->
      console.log input
      return input if !input
      CryptoService.decrypt(input)

]