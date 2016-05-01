
App.config [
  '$stateProvider'
  '$urlRouterProvider'
  ($stateProvider, $urlRouterProvider) ->

    $urlRouterProvider.otherwise '/dashboard'

    $stateProvider
    .state 'list',
      url: '/dashboard'
      templateUrl: 'home.html'
      ncyBreadcrumb:
        label: 'Dashboard'

    .state 'list.new',
      url: '/new'
      templateUrl: 'list/new.html'
      controller: 'NewListCtrl as NewListCtrl'
      ncyBreadcrumb:
        label: 'New List'

    .state 'list.items',
      url: '/:id'
      templateUrl: 'item/index.html'
      controller: 'ShowListCtrl as ShowListCtrl'
      ncyBreadcrumb:
        label: 'List Items'

    .state 'list.new_item',
      url: '/:id/new'
      templateUrl: 'item/new.html'
      controller: 'NewItemCtrl as NewItemCtrl'
      ncyBreadcrumb:
        label: 'New Item'

    .state 'list.edit_item',
      url: '/:list_id/item/:item_id/edit'
      templateUrl: 'item/edit.html'
      controller: 'EditItemCtrl as EditItemCtrl'
      ncyBreadcrumb:
        label: 'Edit Item'

    .state 'settings',
      url: '/settings'
      templateUrl: 'settings/index.html'
      ncyBreadcrumb:
        label: 'Settings'

    .state 'settings.profile',
      url: '/profile'
      templateUrl: 'settings/profile.html'
      controller: 'ProfileCtrl as ProfileCtrl'
      ncyBreadcrumb:
        label: 'Profile'

]