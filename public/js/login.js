var App = angular.module('LoginApp', [])

App.controller( 'LoginCtrl', [
  '$scope',
  '$http',
  function ($scope, $http) {

    $scope.login = function (user) {
      $http.post('/login', user)
      .then(function (resp) {
        $.jStorage.set('auth_token', resp.data.token)
        window.location.assign('/app')
      })
      .catch(function (err) {
        $scope.error = err.data
      })
    }



  }
])