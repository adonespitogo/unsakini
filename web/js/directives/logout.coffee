window.App.directive 'logout', [
  '$uibModal'
  'Auth'
  ($uibModal, Auth) ->
    restrict: 'AE'
    link: ($scope, elem) ->
      elem.click ->
        $scope.title = 'Are you sure you want to logout?'
        modal = $uibModal.open
          templateUrl: 'confirm.html'
          scope: $scope

        modal.result.then ->
          Auth.logout()
          window.location.assign('/')
]