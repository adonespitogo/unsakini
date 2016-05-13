var App = angular.module('LoginApp', [])

App.controller( 'LoginCtrl', [
  '$scope',
  '$http',
  function ($scope, $http) {

    $scope.logging_in = false;

    $scope.login = function (user) {
      $scope.logging_in = true;
      $http.post('/login', user)
      .then(function (resp) {
        $.jStorage.set('auth_token', resp.data.token)
        $.jStorage.deleteKey('passphrase')
        window.location.assign('/app')
      })
      .catch(function (err) {
        $scope.error = err.data
      })
      .finally(function () {
        $scope.logging_in = false;
      });
    }



  }
])