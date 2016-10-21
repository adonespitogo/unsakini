jwToken = require('../services/jsonwebtoken')
Users = require('../models/user')

module.exports =
  index: (req, res, next) ->
    email = req.body['email']
    password = req.body['password']
    if !email or !password
      res.status( 401).send err: 'Email and password required'
      return
    Users.findOne(where: email: email).then((user) ->
      user.comparePassword password, (err, match) ->
        if !match
          res.status(401).send 'Invalid password'
          return
        if err
          return next(err)
        res.send
          user: user
          token: jwToken.issue(id: user.id)
        next()
      return
    ).catch (err) ->
      res.status(403).send 'User with email ' + email + ' does not exist'
      next()
    return
  verify: (req, res, next) ->
    res.sendStatus 200
    next()