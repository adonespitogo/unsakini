window.App.directive 'deleteItem', [
  'ItemService'
  '$uibModal'
  '$state'
  (ItemService, $uibModal, $state) ->

    restrict: 'AE'
    scope:
      item: '=deleteItem'

    link: ($scope, elem) ->

      elem.click ->
        modal = $uibModal.open
          templateUrl: 'confirm.html'

        modal.result
        .then ->
          ItemService.delete($scope.item.id)
          .then ->
            $state.go('list.items', {id: $scope.item.list_id}, {reload:true})
]