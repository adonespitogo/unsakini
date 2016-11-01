jwToken = require('../services/jsonwebtoken')
Users = require('../models/user')

module.exports =
  index: (req, res, next) ->
    email = req.body['email']
    password = req.body['password']
    if !email or !password
      res.status( 401).json err: 'Email and password required'
      return
    Users.findOne(where: email: email).then((user) ->
      user.comparePassword password, (err, match) ->
        if !match
          res.status(401).json err: 'Invalid password'
          return
        if err
          res.status(500).json err: err
          return
        if (!user.confirmed)
          res.status(401).json err: "Your account needs confirmation. Please click the confirmation link sent to your email #{user.email}."
          return
        res.json
          user: user
          token: jwToken.issue(id: user.id)
    )
    .catch (err) ->
      res.status(403).json err: 'User with email ' + email + ' does not exist'
  verify: (req, res, next) ->
    res.status( 202).send()
