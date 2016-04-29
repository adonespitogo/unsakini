App = window.App

App.controller 'LoginPopCtrl', [
  '$scope'
  '$http'
  '$uibModalInstance'
  'authService'
  ($scope, $http, $uibModalInstance, authService) ->

    $scope.user = {}

    $scope.login = ->
      $http.post('/login', $scope.user)
      .then (resp) ->
        $.jStorage.set 'auth_token', resp.data.token
        $uibModalInstance.close()
        authService.loginConfirmed()
      .catch (resp) ->
        alert(resp.data)

]

App.factory 'LoginPop', [
  '$uibModal'
  ($uibModal) ->

    open: ->
      modal = $uibModal.open
        animation: true
        templateUrl: 'login-popup.html'
        controller: 'LoginPopCtrl as LoginPopCtrl'

      modal.result.catch ->
        window.location.assign '/'
]