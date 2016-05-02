app = window.App

app.factory 'Auth', [
  '$http'
  '$window'
  ($http, $window) ->

    logout: ->
      $.jStorage.deleteKey 'auth_token'
      $.jStorage.deleteKey 'passphrase'
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
