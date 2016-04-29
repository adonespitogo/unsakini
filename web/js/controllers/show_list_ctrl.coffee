window.App.controller 'ShowListCtrl', [
  '$scope'
  'ListService'
  'ItemService'
  '$stateParams'
  ($scope, ListService, ItemService, $stateParams) ->

    ListService.get($stateParams.id)
    .then (resp) ->
      $scope.list = resp.data

]