models = require('../models')

exports.is_list_owner = (req, res, next) ->
    models.List.findOne({
      where:
        id: req.params.id
        user_id: req.user.id
      attributes: ['id']
    })
    .then (db_list) ->
      if !db_list
        return res.status(404).send()
      else
        return next()
    .catch (err) ->
      res.status(404).send()

exports.is_item_owner = (req, res, next) ->
    models.Item.findOne({
      where:
        id: req.params.id
      attributes: ['id']
      include: [
        {
          model: models.List
          attributes: ['id']
          where:
            user_id: req.user.id
        }
      ]
    })
    .then (db_item) ->
      if !db_item
        return res.status(404).send()
      else
        return next()
    .catch (err) ->
      res.status(404).send()

