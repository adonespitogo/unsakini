models = require('../models/')
Item = models.Item

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