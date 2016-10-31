models = require('../models/')
Item = models.Item
List = models.List

exports.index = (req, res, next) ->
  list_id = req.params.id
  Item.findAll({
    where:
      list_id: list_id
  })
  .then (db_lists) ->
    res.send db_lists
  .catch (err) ->
    res.status(500).send(err)

exports.create = (req, res, next) ->
  Item.create({
    title: req.body.title
    content: req.body.content
    list_id: req.body.list_id
  })
  .then (db_item) ->
    res.send db_item
  .catch (err) ->
    res.status(422).send(err)

exports.show = (req, res, next) ->
  Item.findOne({
    where:
      id: req.params.id
    include: [
      {model: List}
    ]
  })
  .then (db_item) ->
    res.send db_item
  .catch (err) ->
    res.status(500).send(err)

exports.update = (req, res, next) ->
  Item.update({
    title: req.body.title
    content: req.body.content
  }, {
    where:
      id: req.params.id
    individualHooks: true
  })
  .then (result) ->
    res.send result
  .catch (err) ->
    res.status(422).send(err)

exports.destroy = (req, res, next) ->
  Item.destroy({where: id: req.params.id})
  .then ->
    res.status(200).send()
  .catch (err) ->
    res.status(422).send err
