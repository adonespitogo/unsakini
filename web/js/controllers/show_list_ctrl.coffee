window.App.controller 'ShowListCtrl', [
  '$scope'
  'ListService'
  '$stateParams'
  ($scope, ListService, $stateParams) ->

    ListService.get($stateParams.id)
    .then (resp) ->
      console.log resp
      $scope.list = resp.data

]