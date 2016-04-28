
App.config [
  '$stateProvider'
  '$urlRouterProvider'
  ($stateProvider, $urlRouterProvider) ->
    $urlRouterProvider.otherwise '/home'
    $stateProvider.state 'home',
      url: '/home'
      templateUrl: 'home.html'
    return
]