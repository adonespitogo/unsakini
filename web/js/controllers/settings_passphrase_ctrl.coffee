window.App.controller 'SettingsPassphraseCtrl', [
  '$scope'
  'PassphraseService'
  'toastr'
  ($scope, PassphraseService, toastr) ->
    $scope.passphrase = $.jStorage.get 'passphrase', null
    $scope.update_db = false

    @submit = ->
      old_key = $.jStorage.get 'passphrase'

      if !$scope.update_db
        $.jStorage.set 'passphrase', $scope.passphrase
        toastr.success 'Passphrase updated.'
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
            toastr.success 'Passphrase updated.'

    null
]