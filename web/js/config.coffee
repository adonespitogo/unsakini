window.App.run([
  '$rootScope'
  '$http'
  'LoginPop'
  'PassphraseService'
  '$timeout'
  'UserService'
  'toastr'
  ($rootScope, $http, LoginPop, PassphraseService, $timeout, UserService, toastr) ->

    $rootScope.$on 'event:auth-loginRequired', (e) ->
      LoginPop.open()

    $rootScope.$on 'event:auth-forbidden', (e) ->
      toastr.error 'Action is forbidden. (Error 403)'

    $timeout ->
      key = $.jStorage.get 'passphrase'
      PassphraseService.open() if !key
    , 500

    UserService.get().then (resp) ->
      $rootScope.current_user = resp.data


]);