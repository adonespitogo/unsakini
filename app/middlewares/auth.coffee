User = require('../models/user')

module.exports = (req, res, next) ->
  User.findById(req.user?.id)
  .then (user) ->
    if !user
      res.status(401).send('Unauthorized')
    else
      req.current_user = user
      next()
  .catch (err) ->
    console.log err
    res.status(401)
    next()
