window.App.controller 'PassphrasePopupCtrl', [
  '$scope'
  '$uibModalInstance'
  '$http'
  'CryptoService'
  '$rootScope'
  ($scope, $uibModalInstance, $http, CryptoService, $rootScope) ->

    $scope.passphrase = $.jStorage.get 'passphrase', null
    $scope.update_db = false

    setPassphrase = ->
      $.jStorage.set 'passphrase', $scope.passphrase
      $rootScope.$broadcast 'passphrase:updated'
      $uibModalInstance.close()

    @submit = ->
      old_key = $.jStorage.get 'passphrase'

      if !$scope.update_db
        setPassphrase()
      else
        $http.get('/passphrase/update').then (resp) ->
          new_data = _.map resp.data, (list) ->

            list.name = CryptoService.encrypt(CryptoService.decrypt(list.name, old_key), $scope.passphrase )
            list.items = _.map list.items, (item) ->
              item.title = CryptoService.encrypt(CryptoService.decrypt(item.title), $scope.passphrase )
              item.content = CryptoService.encrypt(CryptoService.decrypt(item.content), $scope.passphrase )
              item

            list

          $http.put('/passphrase/update', new_data).then ->
            setPassphrase()

    null
]


window.App.factory 'PassphraseService', [
  '$uibModal'
  ($uibModal) ->

    open: ->
      modalOpts =
        templateUrl: 'passphrase-popup.html'
        controller: 'PassphrasePopupCtrl as PassphrasePopupCtrl'

      key = $.jStorage.get 'passphrase', null
      if !key
        modalOpts.backdrop = 'static'
        modalOpts.keyboard = false

      $uibModal.open(modalOpts)

    getKey: ->
      $.jStorage.get 'passphrase'

    setKey: (key) ->
      $.jStorage.set 'passphrase', key

]