window.App.factory 'ListService', [
  '$http'
  'CryptoService'
  ($http, CryptoService) ->

    fetch: ->
      $http.get '/lists'

    create: (data) ->
      data.name = CryptoService.encrypt(data.name)
      $http.post('/lists', data)


    get: (id) ->
      $http.get("/lists/#{id}")


]