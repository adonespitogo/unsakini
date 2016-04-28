ListController = require('./app/controllers/list_controller')

module.exports = (app) ->
  app.get '/list', ListController.index