models = require('../models')
User = models.User
jwToken = require('../services/jsonwebtoken')

exports.get = (req, res, next) ->
  User.findById(req.user.id).then (db_user) ->
    if !db_user
      res.sendStatus 404
    else
      res.json db_user

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

exports.update = (req, res, next) ->

  updateUser = (db_user) ->
    db_user.setDataValue 'name', req.body.name
    db_user.setDataValue 'email', req.body.email
    db_user.save()
    .then ->
      return res.json(db_user)
    .catch (err) ->
      return res.status(500).json err

  models.User.findById(req.user.id).then((db_user) ->
    db_user.comparePassword req.body.old_password, (err, match) ->
      if !match
        return res.status(403).json [{message: 'Invalid password.'}]
      if !!err
        return res.sendStatus(403).json [{message: 'Invalid password.'}]

      if !!req.body.new_password and (req.body.new_password is req.body.confirm_password)
        db_user.setPassword(req.body.new_password)
        .then (db_user) ->
          updateUser(db_user)
        .catch (err) ->
          res.status(500).json err
      else
        updateUser(db_user)


  ).catch (err) ->
    res.status(403).json(err)
