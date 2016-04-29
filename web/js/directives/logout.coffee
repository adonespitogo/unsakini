window.App.directive 'logout', [
  '$uibModal'
  ($uibModal) ->
    restrict: 'AE'
    link: ($scope, elem) ->
      elem.click ->
        $scope.title = 'Are you sure you want to logout?'
        modal = $uibModal.open
          templateUrl: 'confirm.html'
          scope: $scope

        modal.result.then ->
          $.jStorage.deleteKey 'auth_token'
          window.location.assign('/')
]