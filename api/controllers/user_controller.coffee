jwToken = require('../services/jsonwebtoken')
globals = require('../config/globals')
models = require('../models')
crypto = require('crypto')

User = models.User
AcctConf = models.AccountConfirmation

exports.get = (req, res, next) ->
  User.findById(req.user.id).then (db_user) ->
    if !db_user
      res.status(404).send()
    else
      res.json db_user

exports.create = (req, res, next) ->
  if !req.body.email
    res.status(422).json [message: 'Email is required']
    return
  if !req.body.password
    res.status(422).json [message: 'Password is required']
    return
  if req.body.password.length < 6
    res.status(422).json [message: 'Password must be at least 6 characters']
    return
  if req.body.password != req.body.password_confirmation
    res.status(422).json [message: 'Passwords didn\'t match.']
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
        res.app.mailer.send 'mails/confirm-account', {
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
              res.status(422).json([message: message])

            .catch (err) ->
              res.status(422).json(err)
          else
            # If user created successfuly we return user and token as response
            res.json user: user
            next()
      .catch (err) ->
        user.destroy()
        .then ->
          return res.status(422).json (err)

    .catch (err) ->
      err = err.errors or err
      res.status(422).json err
  )
  .catch (err) ->
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
        return res.status(422).json [{message: 'Current password is invalid'}]
      if !!err
        return res.status(422).json [{message: 'Current password is invalid'}]

      if !!req.body.new_password
        # lets validate new password
        if (req.body.new_password isnt req.body.confirm_password)
          return res.status(422).json [message: 'Confirm password did not match password']
        if (req.body.new_password.length < 6)
          return res.status(422).json [message: 'Password must be at least 6 characters']
        db_user.setPassword(req.body.new_password)
        .then (db_user) ->
          updateUser(db_user)
        .catch (err) ->
          res.status(500).json err
      else
        updateUser(db_user)


  ).catch (err) ->
    res.status(500).json(err)

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
          res.status(500).json err
      .catch (err) ->
        res.status(500).json err
    else
      res.render 'account-confirmed-failed'

  .catch ->
    res.render 'account-confirmed-failed'
