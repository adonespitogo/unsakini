window.App.factory 'ListService', [
  '$http'
  ($http) ->

    fetch: ->
      $http.get '/lists'

    create: (data) ->
      $http.post('/lists', data)


    get: (id) ->
      $http.get("/lists/#{id}")


]