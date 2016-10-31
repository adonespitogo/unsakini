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
    if req.body.password.length < 6
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
          token: crypto.createHmac('sha1', req.body.password).update("#{user.id}#{user.email}#{Math.random()}").digest('hex')
        })
        .then (acct_token) ->
          app.mailer.send 'mails/confirm-account', {
            # to: user.email
            to: if process.env.NODE_ENV is 'production' then user.email else 'no-reply@unsakini.com'
            subject: 'Confirm Your Account'
            user: user
            token: acct_token.token
            globals: globals
          },
          (err, message) ->
            if (err)
              user.destroy()
              .then ->
                res.status(422).send([message: message])

              .catch (err) ->
                res.status(422).send(err)
            else
              # If user created successfuly we return user and token as response
              res.send user: user
              next()
        .catch (err) ->
          user.destroy()
          .then ->
            return res.status(422).send (err)

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
      return res.send(db_user)
    .catch (err) ->
      return res.status(500).send err

  models.User.findById(req.user.id).then((db_user) ->
    db_user.comparePassword req.body.old_password, (err, match) ->
      if !match
        return res.status(422).send [{message: 'Current password is invalid'}]
      if !!err
        return res.status(422).send [{message: 'Current password is invalid'}]

      if !!req.body.new_password
        # lets validate new password
        if (req.body.new_password isnt req.body.confirm_password)
          return res.status(422).send [message: 'Confirm password did not match password']
        if (req.body.new_password.length < 6)
          return res.status(422).send [message: 'Password must be at least 6 characters']
        db_user.setPassword(req.body.new_password)
        .then (db_user) ->
          updateUser(db_user)
        .catch (err) ->
          res.status(500).send err
      else
        updateUser(db_user)


  ).catch (err) ->
    res.status(500).send(err)

exports.confirmAccount = (req, res, next) ->
  AcctConf.findOne({
    where:
      token: req.params.token
  })
  .then (acct_conf) ->
    if (acct_conf)
      User.update({
        confirmed: true
      },{
        where:
          id: acct_conf.user_id
      })
      .then (db_users) ->
        AcctConf.destroy({
          where:
            user_id: acct_conf.user_id
        })
        .then ->
          res.render 'account-confirmed-success'
        .catch (err) ->
          res.status(500).send err
      .catch (err) ->
        res.status(500).send err
    else
      res.render 'account-confirmed-failed'

  .catch ->
    res.render 'account-confirmed-failed'
