jwToken = require('../services/jsonwebtoken')
Users = require('../models/user')

module.exports =
  index: (req, res, next) ->
    email = req.body['email']
    password = req.body['password']
    if !email or !password
      res.json 401, err: 'Email and password required'
      return next()
    Users.findOne(where: email: email).then((user) ->
      user.comparePassword password, (err, match) ->
        if !match
          res.send 401, 'Invalid password'
          return next()
        if err
          return next(err)
        res.json
          user: user
          token: jwToken.issue(id: user.id)
        next()
      return
    ).catch (err) ->
      res.json 404, 'User with email ' + email + ' does not exist'
      next()
    return
  verify: (req, res, next) ->
    res.send 200
    next()