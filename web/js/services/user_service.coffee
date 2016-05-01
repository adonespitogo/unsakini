window.App.factory 'UserService', [
  '$http'
  ($http) ->

    get: ->
      $http.get '/user'

    update: (user) ->
      $http.put('/user', user)
]