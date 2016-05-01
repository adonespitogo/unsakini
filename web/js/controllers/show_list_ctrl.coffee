window.App.controller 'ShowListCtrl', [
  '$scope'
  'ListService'
  'ItemService'
  '$stateParams'
  ($scope, ListService, ItemService, $stateParams) ->

    fetchListItems =  ->
      ListService.get($stateParams.id)
      .then (resp) ->
        $scope.list = resp.data

    fetchListItems()

    $scope.$on 'item:deleted', fetchListItems
    $scope.$on 'item:added', fetchListItems

]