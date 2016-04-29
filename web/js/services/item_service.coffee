App = window.App

App.factory 'ItemService', [
  '$http'
  'CryptoService'
  ($http, CryptoService) ->

    create: (item) ->
      item.title = CryptoService.encrypt(item.title)
      item.content = CryptoService.encrypt(item.content)
      $http.post '/items', item

]