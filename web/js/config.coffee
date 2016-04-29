window.App.run([
  '$rootScope'
  '$http'
  'LoginPop'
  ($rootScope, $http, LoginPop) ->

    $rootScope.$on 'event:auth-loginRequired', (e) ->
      console.log e
      LoginPop.open()


])