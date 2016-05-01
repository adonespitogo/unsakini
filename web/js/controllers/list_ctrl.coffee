window.App.controller('ListCtrl', [
  '$scope'
  'ListService'
  '$state'
  ($scope, ListService, $state) ->

    $scope.lists = []

    $scope.$on 'list:created', (e, list) ->
      updateLists()

    $scope.$on 'list:updated', (e, list) ->
      updateLists()

    updateLists = ->
      ListService.fetch()
      .then (resp) ->
        $scope.lists = resp.data
        if $scope.lists.length > 0 && $state.current.name is 'list'
          $state.go('list.items', {id: $scope.lists[0].id})

      .catch (err) ->
        console.log err

    updateLists()

])