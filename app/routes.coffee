controllers = require('require-dir')('./controllers/')
Auth = require('./middlewares/auth')

module.exports = (app) ->
  app.get '/list', Auth, controllers.list_controller.index
  app.post '/login', controllers.auth_controller.index
  app.post '/users', controllers.user_controller.create