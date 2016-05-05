window.App.filter 'decrypt', [
  'CryptoService'
  (CryptoService) ->

    (input) ->
      return input if !input
      text = CryptoService.decrypt(input)
      text = (if !text then input else text)

]