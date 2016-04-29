controllers = require('require-dir')('./app/controllers/')
Auth = require('./app/middlewares/auth')

module.exports = (app) ->
  app.get '/lists', Auth, controllers.list_controller.index
  app.post '/lists', Auth, controllers.list_controller.create
  app.get '/lists/:id', Auth, controllers.list_controller.show
  app.put '/lists/:id', Auth, controllers.list_controller.update

  app.get '/lists/:id/items', Auth, controllers.item_controller.index
  app.post '/items', Auth, controllers.item_controller.create

  app.post '/login', controllers.auth_controller.index
  app.post '/users', controllers.user_controller.create