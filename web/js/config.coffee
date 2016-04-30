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
      PassphraseService.open()
    , 500


])