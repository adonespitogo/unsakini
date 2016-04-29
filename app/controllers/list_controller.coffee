models = require('../models/index')
List = models.List
Item = models.Item

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

  List.findOne({
    where:
      id: req.params.id
    include: [
      {model: Item}
    ]
  })
  .then (db_list) ->
    res.send db_list
  .catch (err) ->
    console.log err
    res.status(500).send(err)

exports.update = (req, res, next) ->
  List.update({
    name: req.body.name
  }, {

    where:
      id: req.params.id
  })
  .then (db_list) ->
    res.send
      name: req.body.name
  .catch (err) ->
    res.status(422).send(err)

exports.destroy = (req, res, next) ->
  List.destroy({where: id: req.params.id})
  .then ->
    res.status(200).send()
  .catch (err) ->
    res.status(422).send err