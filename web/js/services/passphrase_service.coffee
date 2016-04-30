window.App.controller 'PassphrasePopupCtrl', [
  '$scope'
  '$uibModalInstance'
  ($scope, $uibModalInstance) ->

    $scope.passphrase = $.jStorage.get 'passphrase', null

    @submit = ->
      $.jStorage.set 'passphrase', $scope.passphrase
      $uibModalInstance.dismiss()
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

]