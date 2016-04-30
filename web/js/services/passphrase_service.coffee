window.App.controller 'PassphrasePopupCtrl', [
  '$scope'
  '$uibModalInstance'
  '$http'
  'CryptoService'
  ($scope, $uibModalInstance, $http, CryptoService) ->

    $scope.passphrase = $.jStorage.get 'passphrase', null

    @submit = ->
      old_key = $.jStorage.get 'passphrase'

      if !old_key
        $.jStorage.set 'passphrase', $scope.passphrase
        window.location.reload()
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
            $.jStorage.set 'passphrase', $scope.passphrase
            window.location.reload()

    null
]


window.App.factory 'PassphraseService', [
  '$uibModal'
  ($uibModal) ->
    init: ->
      key = $.jStorage.get 'passphrase', null

      if !key
        @open()

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