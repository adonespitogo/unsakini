window.App.controller('ListCtrl', [
  '$scope'
  'ListService'
  ($scope, ListService) ->

    ListService.fetch()
    .then (resp) ->
      $scope.lists = resp.data

    .catch (err) ->
      console.log err

])