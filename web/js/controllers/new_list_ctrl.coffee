window.App.controller 'NewListCtrl', [
  '$scope'
  'ListService'
  '$state'
  ($scope, ListService, $state) ->

    $scope.list = {}

    @create = (list) ->
      ListService.create(list)
      .then (resp) ->
        alert('list successfully created!')
        $state.go('list.show', {id: resp.data.id})
      .catch (resp) ->
        console.log resp


    null
]