window.App.filter 'decrypt', [
  'CryptoService'
  (CryptoService) ->

    (input) ->
      return input if !input
      text = CryptoService.decrypt(input)
      return (if !text then input else text)

]