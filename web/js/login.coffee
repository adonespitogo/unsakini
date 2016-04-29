App = angular.module('LoginApp', [])

App.controller 'LoginCtrl', [
  '$scope'
  '$http'
  ($scope, $http) ->

    $scope.user = {}

    $scope.login = ->
      $http.post('/login', $scope.user)
      .then (resp) ->
        $.jStorage.set 'auth_token', resp.data.token
        window.location.assign '/'
      .catch (resp) ->
        alert(resp.data)
]