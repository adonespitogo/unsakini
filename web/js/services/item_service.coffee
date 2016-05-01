window.App.factory 'ItemService', [
  '$http'
  'CryptoService'
  '$rootScope'
  ($http, CryptoService, $rootScope) ->

    create: (item) ->
      item.title = CryptoService.encrypt(item.title)
      item.content = CryptoService.encrypt(item.content)
      $http.post '/items', item

    get: (id) ->
      $http.get "/items/#{id}"

    update: (item) ->
      new_item =
        title: CryptoService.encrypt(item.title)
        content: CryptoService.encrypt(item.content)

      $http.put "/items/#{item.id}", new_item

    delete: (id) ->
      promise = $http.delete "/items/#{id}"
      promise.then ->
        $rootScope.$broadcast 'item:deleted'
      promise

]