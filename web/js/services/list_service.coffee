window.App.factory 'ListService', [
  '$http'
  'CryptoService'
  '$rootScope'
  ($http, CryptoService, $rootScope) ->

    fetch: ->
      $http.get '/lists'

    create: (data) ->
      data.name = CryptoService.encrypt(data.name)
      promise = $http.post('/lists', data)
      promise.then (resp) ->
        $rootScope.$broadcast 'list:created', resp.data

      return promise


    get: (id) ->
      $http.get("/lists/#{id}")

    update: (data) ->
      data.name = CryptoService.encrypt(data.name)
      promise = $http.put("/lists/#{data.id}", data)
      promise.then (resp) ->
        $rootScope.$broadcast 'list:updated', resp.data
      return promise

    delete: (id) ->
      promise = $http.delete "/lists/#{id}"
      promise.then (resp) ->
        $rootScope.$broadcast 'list:deleted'
      return promise

]