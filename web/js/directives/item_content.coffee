window.App.directive 'itemContent', [
  'CryptoService'
  '$uibModal'
  (CryptoService, $uibModal) ->

    restrict: 'AE'
    scope:
      item: '=itemContent'
    link: ($scope, elem, attrs) ->

      $scope.title = CryptoService.decrypt($scope.item.title)
      $scope.content = CryptoService.decrypt($scope.item.content)
      $scope.content = markdown.toHTML($scope.content)

      elem.click ->
        $uibModal.open
          templateUrl: 'directives/item-content.html'
          scope: $scope

]