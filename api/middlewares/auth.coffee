User = require('../models/user')

module.exports = (req, res, next) ->
  User.findById(req.user?.id)
  .then (user) ->
    if !user
      res.status(401).send 'UNAUTHORIZED'
      return
    else
      if (!user.confirmed)
        res.status(401).send 'NEEDS_CONFIRMATION'
        return
      req.current_user = user
      next()
  .catch (err) ->
    console.log err
    res.status(401).send 'UNAUTHORIZED'
    return
