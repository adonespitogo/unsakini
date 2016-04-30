window.App.controller('ListCtrl', [
  '$scope'
  'ListService'
  '$state'
  ($scope, ListService, $state) ->

    ListService.fetch()
    .then (resp) ->
      $scope.lists = resp.data
      if $scope.lists.length > 0 && $state.current.name is 'list'
        $state.go('list.items', {id: $scope.lists[0].id})

    .catch (err) ->
      console.log err

])