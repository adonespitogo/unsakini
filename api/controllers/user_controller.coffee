jwToken = require('../services/jsonwebtoken')
globals = require('../config/globals')
models = require('../models')
crypto = require('crypto')

User = models.User
AcctConf = models.AccountConfirmation

exports.get = (req, res, next) ->
  User.findById(req.user.id).then (db_user) ->
    if !db_user
      res.sendStatus 404
    else
      res.json db_user

exports.create = (app) ->
  (req, res, next) ->
    if !req.body.email
      res.send 422, [message: 'Email is required']
    if !req.body.password
      res.send 422, [message: 'Password is required']
      return
    if req.body.password?.lenth < 6
      res.send 422, [message: 'Password must be at least 6 characters']
      return
    if req.body.password != req.body.password_confirmation
      res.send 422, [message: 'Passwords didn\'t match.']
      return
    user = User.build(req.body)
    user.setPassword(req.body.password).then((user) ->
      user.save()
      .then (user) ->
        # create confirmation token
        AcctConf.create({
          user_id: user.id
          token: crypto.createHash('md5').update("#{user.email}#{user.id}").digest('hex')
        }).then (acct_token) ->
          console.log(acct_token.token)
          app.mailer.send 'mails/confirm-account', {
            # to: user.email
            to: if process.env.NODE_ENV is 'production' then user.email else 'adonesp@live.com'
            subject: 'Confirm Your Account'
            user: user
            token: acct_token.token
            globals: globals
          },
          (err, message) ->
            if (err)
              res.status(500).send([message: message])
              return
            # If user created successfuly we return user and token as response
            res.send user: user
            next()

      .catch (err) ->
        console.log err
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
      return res.send(db_user)
    .catch (err) ->
      return res.status(500).send err

  models.User.findById(req.user.id).then((db_user) ->
    db_user.comparePassword req.body.old_password, (err, match) ->
      if !match
        return res.status(422).send [{message: 'Invalid password.'}]
      if !!err
        return res.status(422).send [{message: 'Invalid password.'}]

      if !!req.body.new_password and (req.body.new_password is req.body.confirm_password)
        db_user.setPassword(req.body.new_password)
        .then (db_user) ->
          updateUser(db_user)
        .catch (err) ->
          res.status(500).json err
      else
        updateUser(db_user)


  ).catch (err) ->
    res.status(500).send(err)
