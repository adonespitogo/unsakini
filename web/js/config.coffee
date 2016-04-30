window.App.run([
  '$rootScope'
  '$http'
  'LoginPop'
  'PassphraseService'
  ($rootScope, $http, LoginPop, PassphraseService) ->

    $rootScope.$on 'event:auth-loginRequired', (e) ->
      LoginPop.open()

    PassphraseService.open()


])