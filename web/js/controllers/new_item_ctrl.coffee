App = window.App

App.controller 'NewItemCtrl', [
  '$scope'
  'ItemService'
  '$stateParams'
  '$state'
  'toastr'
  ($scope, ItemService, $stateParams, $state, toastr) ->

    $scope.item = {list_id: $stateParams.id}

    @create = (item) ->
      ItemService.create(item)
      .then (resp) ->
        toastr.success 'Item added.'
        $state.go('dashboard.list_items', {id: item.list_id})
      .catch (err) ->
        console.log err

    return

]