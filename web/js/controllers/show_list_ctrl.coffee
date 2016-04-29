window.App.controller 'ShowListCtrl', [
  '$scope'
  'ListService'
  '$stateParams'
  ($scope, ListService, $stateParams) ->

    ListService.get($stateParams.id)
    .then (resp) ->
      $scope.list = resp.data

]