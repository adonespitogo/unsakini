window.App.controller 'NewListCtrl', [
  '$scope'
  'ListService'
  '$state'
  'CryptoService'
  ($scope, ListService, $state, CryptoService) ->

    $scope.list = {}

    @create = (list) ->
      ListService.create(list)
      .then (resp) ->
        alert('list successfully created!')
        $state.go('list.items', {id: resp.data.id}, {reload: true})
      .catch (resp) ->
        console.log resp


    null
]