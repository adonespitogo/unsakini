models = require('../models/index')
List = models.List
Item = models.Item

exports.index = (req, res, next) ->

  List.findAll({
    where:
      user_id: req.user.id
    include: [
      {model: Item}
    ]
  })
  .then (result) ->
    res.json result
  .catch (err) ->
    res.status(500).json err

exports.create = (req, res, next) ->
  List.create({
    user_id: req.user.id
    name: req.body.name
  })
  .then (db_list) ->
    res.json db_list
  .catch (err) ->
    res.status(422).json(err)

exports.show = (req, res, next) ->

  List.findOne({
    where:
      id: req.params.id
    include: [
      {model: Item}
    ]
  })
  .then (db_list) ->
    res.json db_list
  .catch (err) ->
    res.status(500).json(err)

exports.update = (req, res, next) ->
  List.update({
    name: req.body.name
  }, {

    where:
      id: req.params.id
    individualHooks: true
  })
  .then (db_list) ->
    res.json
      id: req.params.id
      name: req.body.name
  .catch (err) ->
    res.status(422).json(err)

exports.destroy = (req, res, next) ->
  List.destroy({where: id: req.params.id})
  .then ->
    res.status(200).json()
  .catch (err) ->
    res.status(422).json err