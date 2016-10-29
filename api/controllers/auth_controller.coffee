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
          res.status(401).send err: 'Invalid password'
          return
        if err
          return next(err)
        if (!user.confirmed)
          res.status(401).send err: "Your account needs confirmation. Please click the confirmation link sent to your email #{user.email}."
          return
        res.send
          user: user
          token: jwToken.issue(id: user.id)
        next()
      return
    ).catch (err) ->
      res.status(403).send err: 'User with email ' + email + ' does not exist'
      next()
    return
  verify: (req, res, next) ->
    res.status( 202).send()
    next()
