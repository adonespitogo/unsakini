window.App.controller 'EditListCtrl', [
  '$scope'
  '$uibModalInstance'
  'ListService'
  'CryptoService'
  ($scope, $uibModalInstance, ListService, CryptoService) ->

    $scope.new_list = angular.copy($scope.list)
    $scope.new_list.name = CryptoService.decrypt($scope.list.name)

    $scope.close = ->
      $uibModalInstance.dismiss()

    $scope.update = (list) ->
      ListService.update(list)
      .then (resp) ->
        console.log resp
        $scope.list.name = resp.data.name
        $uibModalInstance.dismiss()
      .catch (err) ->
        console.log err


    return

]

window.App.directive 'editList', [
  '$uibModal'
  ($uibModal) ->

    restrict: 'AE'
    scope:
      list: '=editList'
    link: ($scope, elem) ->

      elem.click ->
        $uibModal.open
          templateUrl: 'directives/edit-list.html'
          controller: 'EditListCtrl'
          scope: $scope


]