window.App.run([
  '$rootScope'
  '$http'
  'LoginPop'
  'PassphraseService'
  '$timeout'
  'UserService'
  ($rootScope, $http, LoginPop, PassphraseService, $timeout, UserService) ->

    $rootScope.$on 'event:auth-loginRequired', (e) ->
      LoginPop.open()

    $timeout ->
      key = $.jStorage.get 'passphrase'
      PassphraseService.open() if !key
    , 500

    UserService.get().then (resp) ->
      $rootScope.current_user = resp.data


]);