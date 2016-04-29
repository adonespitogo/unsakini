app = window.App

app.factory 'Auth', [
  '$http'
  '$window'
  ($http, $window) ->

    logout: ->
      $http.post('/logout').then ->
        $.jStorage.deleteKey 'auth_token'

]

app.factory 'AuthToken', [
  ->
    request: (config) ->
      access_token = $.jStorage.get('auth_token', null)
      if access_token
        config.headers.Authorization = "Bearer #{access_token}"

      config

]

app.config [
  '$httpProvider'
  ($httpProvider) ->
    $httpProvider.interceptors.push('AuthToken')
]
