App = window.App

App.controller 'NewItemCtrl', [
  '$scope'
  'ItemService'
  '$stateParams'
  '$state'
  ($scope, ItemService, $stateParams, $state) ->

    $scope.item = {list_id: $stateParams.id}

    @create = (item) ->
      ItemService.create(item)
      .then (resp) ->
        $state.go('list.items', {id: $stateParams.id})
      .catch (err) ->
        console.log err

    return

]