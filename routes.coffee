controllers = require('require-dir')('./app/controllers/')
mdw = require('require-dir')('./app/middlewares')
Auth = mdw.auth
AC = mdw.access_control

module.exports = (app) ->

  app.get '/', controllers.public_controller.index
  app.get '/login', controllers.public_controller.login
  app.get '/app', controllers.public_controller.app
  app.get '/auth/verify', controllers.auth_controller.verify
  app.post '/login', controllers.auth_controller.index
  app.post '/users', controllers.user_controller.create

  app.get '/lists',
          Auth,
          controllers.list_controller.index

  app.post '/lists',
          Auth,
          controllers.list_controller.create

  app.get '/lists/:id',
          Auth,
          AC.is_list_owner,
          controllers.list_controller.show

  app.put '/lists/:id',
          Auth,
          AC.is_list_owner,
          controllers.list_controller.update

  app.delete '/lists/:id',
          Auth, AC.is_list_owner,
          controllers.list_controller.destroy

  app.get '/lists/:id/items',
          Auth,
          AC.is_list_owner,
          controllers.item_controller.index

  app.get '/items/:id',
          Auth,
          AC.is_item_owner,
          controllers.item_controller.show

  app.post '/items',
          Auth,
          controllers.item_controller.create

  app.put '/items/:id',
          Auth,
          AC.is_item_owner,
          controllers.item_controller.update

  app.delete '/items/:id',
          Auth, AC.is_item_owner,
          controllers.item_controller.destroy

  app.get '/passphrase/update',
          Auth,
          controllers.passphrase_controller.get

  app.put '/passphrase/update',
          Auth,
          controllers.passphrase_controller.update