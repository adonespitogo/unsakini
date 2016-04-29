window.App.controller 'HeaderCtrl', [
  '$scope'
  'PassphraseService'
  ($scope, PassphraseService) ->

    console.log 'HeaderCtrl'

    @resetPassphrase = ->
      console.log 'open!!'
      PassphraseService.open()

    return

]