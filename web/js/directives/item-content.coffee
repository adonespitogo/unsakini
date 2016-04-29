window.App.directive 'itemContent', [
  'CryptoService'
  '$uibModal'
  (CryptoService, $uibModal) ->

    restrict: 'AE'
    scope:
      item: '=itemContent'
    link: ($scope, elem, attrs) ->

      decrypted = CryptoService.decrypt($scope.item.content)
      $scope.title = CryptoService.decrypt($scope.item.title)
      $scope.plain_text = decrypted
      $scope.markdown = markdown.toHTML(decrypted)

      elem.click ->
        $uibModal.open
          templateUrl: 'directives/item-content.html'
          scope: $scope

]