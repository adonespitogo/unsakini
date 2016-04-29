
App.config [
  '$stateProvider'
  '$urlRouterProvider'
  ($stateProvider, $urlRouterProvider) ->

    $urlRouterProvider.otherwise '/list'

    $stateProvider
    .state 'list',
      url: '/list'
      templateUrl: 'list/index.html'
      controller: 'ListCtrl as ListCtrl'

    .state 'list.new',
      url: '/new'
      templateUrl: 'list/new.html'
      controller: 'NewListCtrl as NewListCtrl'

    .state 'list.items',
      url: '/:id'
      templateUrl: 'item/index.html'
      controller: 'ShowListCtrl as ShowListCtrl'

    .state 'list.new_item',
      url: '/:id/new'
      templateUrl: 'item/new.html'
      controller: 'NewItemCtrl as NewItemCtrl'

]