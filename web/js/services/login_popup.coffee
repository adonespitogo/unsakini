window.App.controller 'LoginPopCtrl', [
  '$scope'
  '$http'
  '$uibModalInstance'
  ($scope, $http, $uibModalInstance) ->

    $scope.user = {}

    $scope.login = ->
      $http.post('/login', $scope.user)
      .then (resp) ->
        $.jStorage.set 'auth_token', resp.data.token
        $uibModalInstance.dismiss()
      .catch (resp) ->
        alert(resp.data)

]


window.App.factory 'LoginPop', [
  '$uibModal'
  ($uibModal) ->

    open: ->
      $uibModal.open
        animation: true
        templateUrl: 'login-popup.html'
        controller: 'LoginPopCtrl as LoginPopCtrl'
]