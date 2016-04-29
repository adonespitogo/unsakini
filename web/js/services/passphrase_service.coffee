window.App.controller 'PassphrasePopupCtrl', [
  '$scope'
  '$uibModalInstance'
  ($scope, $uibModalInstance) ->

    $scope.passphrase = $.jStorage.get 'passphrase', null

    @submit = ->
      $.jStorage.set 'passphrase', $scope.passphrase
      $uibModalInstance.dismiss()

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
      $uibModal.open
        templateUrl: 'passphrase-popup.html'
        controller: 'PassphrasePopupCtrl as PassphrasePopupCtrl'

    getKey: ->
      $.jStorage.get 'passphrase'

]