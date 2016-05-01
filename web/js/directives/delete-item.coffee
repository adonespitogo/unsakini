window.App.directive 'deleteItem', [
  'ItemService'
  '$uibModal'
  '$state'
  'toastr'
  (ItemService, $uibModal, $state, toastr) ->

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
            toastr.success 'Item deleted.'
]