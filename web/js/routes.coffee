
App.config [
  '$stateProvider'
  '$urlRouterProvider'
  ($stateProvider, $urlRouterProvider) ->

    $urlRouterProvider.otherwise '/list'

    $stateProvider
    .state 'list',
      url: '/list'
      templateUrl: 'list/index.html'

    .state 'list.new',
      url: '/new'
      templateUrl: 'list/new.html'

    .state 'list.show',
      url: '/:id'
      templateUrl: 'list/show.html'

]