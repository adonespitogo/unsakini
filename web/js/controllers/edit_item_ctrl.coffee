window.App.controller 'EditItemCtrl', [
  '$scope'
  'ItemService'
  '$stateParams'
  '$state'
  'CryptoService'
  'toastr'
  ($scope, ItemService, $stateParams, $state, CryptoService, toastr) ->

    ItemService.get($stateParams.item_id)
    .then (resp) ->
      $scope.item = resp.data
      $scope.item.title = CryptoService.decrypt(resp.data.title)
      $scope.item.content = CryptoService.decrypt(resp.data.content)

    @update = (item) ->
      ItemService.update(item)
      .then (resp) ->
        $state.go('dashboard.list_items', {id: $stateParams.list_id})
        toastr.success 'Item updated.'
      .catch (err) ->
        console.log err

    return
]