window.App.controller 'NewListCtrl', [
  '$scope'
  'ListService'
  '$state'
  'CryptoService'
  ($scope, ListService, $state, CryptoService) ->

    $scope.list = {}

    @create = (list) ->
      list.name = CryptoService.encrypt(list.name)
      ListService.create(list)
      .then (resp) ->
        alert('list successfully created!')
        $state.go('list.show', {id: resp.data.id}, {reload: true})
      .catch (resp) ->
        console.log resp


    null
]