User = require('../models/index').User
jwToken = require('../services/jsonwebtoken')

exports.create = (req, res, next) ->
  if !req.body.password
    res.send 401, 'Password is required!'
    return next()
  if req.body.password != req.body.confirm_password
    res.send 401, err: 'Password doesn\'t match.'
    return next()
  user = User.build(req.body)
  user.setPassword(req.body.password).then((user) ->
    user.save()
    .then (user) ->
      # If user created successfuly we return user and token as response
      res.send 200,
        user: user
        token: jwToken.issue(id: user.id)
      next()
    .catch (err) ->
      err = err.errors or err
      res.send 422, err
      next()
  ).catch (err) ->
    next err
