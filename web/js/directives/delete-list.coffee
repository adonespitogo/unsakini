window.App.directive 'deleteList', [
  'ListService'
  '$uibModal'
  '$state'
  (ListService, $uibModal, $state) ->

    restrict: 'AE'
    scope:
      list: '=deleteList'
    link: ($scope, elem) ->

      elem.click ->
        modal = $uibModal.open
          templateUrl: 'confirm.html'

        modal.result.then ->
          ListService.delete($scope.list.id)
          .then ->
            $state.go('list')

]