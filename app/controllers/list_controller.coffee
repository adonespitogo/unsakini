List = require('../models/list')

exports.index = (req, res, next) ->

  List.findAll({
    where:
      user_id: req.user.id
  })
  .then (result) ->
    res.send result
    next()
  .catch (err) ->
    res.send err
    next()

exports.create = (req, res, next) ->
  List.create({
    user_id: req.user.id
    name: req.body.name
  })
  .then (db_list) ->
    res.send db_list
  .catch (err) ->
    res.status(422).send(err)

exports.show = (req, res, next) ->
  List.findById(req.params.id)
  .then (db_list) ->
    res.send db_list
  .catch (err) ->
    res.status(422).send(err)