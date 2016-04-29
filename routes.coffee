controllers = require('require-dir')('./app/controllers/')
Auth = require('./app/middlewares/auth')

module.exports = (app) ->
  app.get '/lists', Auth, controllers.list_controller.index
  app.post '/lists', Auth, controllers.list_controller.create
  app.get '/lists/:id', Auth, controllers.list_controller.show
  app.put '/lists/:id', Auth, controllers.list_controller.update
  app.delete '/lists/:id', Auth, controllers.list_controller.destroy

  app.get '/lists/:id/items', Auth, controllers.item_controller.index
  app.get '/items/:id', Auth, controllers.item_controller.show
  app.post '/items', Auth, controllers.item_controller.create
  app.put '/items/:id', Auth, controllers.item_controller.update
  app.delete '/items/:id', Auth, controllers.item_controller.destroy

  app.post '/login', controllers.auth_controller.index
  app.post '/users', controllers.user_controller.create