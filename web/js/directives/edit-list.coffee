window.App.controller 'EditListCtrl', [
  '$scope'
  '$uibModalInstance'
  'ListService'
  'CryptoService'
  'toastr'
  ($scope, $uibModalInstance, ListService, CryptoService, toastr) ->

    $scope.new_list = angular.copy($scope.list)
    $scope.new_list.name = CryptoService.decrypt($scope.list.name)

    $scope.close = ->
      $uibModalInstance.dismiss()

    $scope.update = (list) ->
      ListService.update(list)
      .then (resp) ->
        $scope.list.name = resp.data.name
        $uibModalInstance.dismiss()
        toastr.success 'List updated.'
      .catch (err) ->
        toastr.error 'Unable to update list.'


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