User = require('../models/user')

module.exports = (req, res, next) ->

  User.findOne(id: req.user?.id)
  .then (user) ->
    req.current_user = user
    next()
  .catch (err) ->
    console.log(err)
    next()
