window.App.controller 'ShowListCtrl', [
  '$scope'
  'ListService'
  'ItemService'
  '$stateParams'
  'CryptoService'
  ($scope, ListService, ItemService, $stateParams, CryptoService) ->

    fetchListItems =  ->
      ListService.get($stateParams.id)
      .then (resp) ->
        $scope.list = resp.data

    fetchListItems()

    $scope.$on 'item:deleted', fetchListItems
    $scope.$on 'item:added', fetchListItems
    $scope.$on 'passphrase:updated', (e) ->
      $scope.list = angular.copy($scope.list)
      # $scope.list.name = CryptoService.decrypt($scope.list.name)

]