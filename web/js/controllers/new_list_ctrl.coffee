window.App.controller 'NewListCtrl', [
  '$scope'
  'ListService'
  '$state'
  'CryptoService'
  'toastr'
  ($scope, ListService, $state, CryptoService, toastr) ->

    $scope.list = {}

    @create = (list) ->
      ListService.create(list)
      .then (resp) ->
        $state.go('list.items', {id: resp.data.id})
        toastr.success 'List created.'
      .catch (resp) ->
        console.log resp


    null
]