window.App.run([
  '$rootScope'
  '$http'
  'LoginPop'
  'PassphraseService'
  '$timeout'
  ($rootScope, $http, LoginPop, PassphraseService, $timeout) ->

    $rootScope.$on 'event:auth-loginRequired', (e) ->
      LoginPop.open()

    $timeout ->
      console.log 'PassphraseService open !!!'
      key = $.jStorage.get 'passphrase'
      PassphraseService.open() if !key
    , 500


])