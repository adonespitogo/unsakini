window.App.directive 'deleteList', [
  'ListService'
  '$uibModal'
  '$state'
  'toastr'
  (ListService, $uibModal, $state, toastr) ->

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
            $state.go('dashboard')
            toastr.success 'List deleted.'

]