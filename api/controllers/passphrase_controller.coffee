models = require('../models')
async = require('async')

exports.get = (req, res, next) ->
  models.List.findAll({
    where: user_id: req.user.id
    include: [
      {model: models.Item}
    ]
  })
  .then (db_list) ->
    if !db_list
      return res.json([])
    else
      res.json db_list

  .catch (err) ->
    res.status(500).json(err)

exports.update = (req, res, next) ->

  validate_list = (list, cb) ->
    models.List.findOne({
      where:
        id: list.id
        user_id: req.user.id
      attributes: ['id']
    })
    .then (db_list) ->
      if !db_list
        cb(false)
      else
        cb(db_list)
    .catch ->
      cb false

  validate_item = (item, cb) ->
    models.Item.findOne({
      where:
        id: item.id
        list_id: item.list_id
      include: [
        {
          model: models.List
          where:
            user_id: req.user.id
          attributes: ['id']
        }
      ]
      attributes: ['id']
    })
    .then (db_item) ->
      if !db_item
        cb(false)
      else
        cb(db_item)
    .catch (error) ->
      cb false

  async.each req.body, (list, list_cb) ->

    validate_list list, (result) ->
      if result is false
        list_cb()
      else
        db_list = result
        db_list.update(name: list.name)
        .then ->
          console.log 'done saving list'
          async.each list.items, (item, item_cb) ->
            console.log 'start item'
            validate_item item, (result) ->
              console.log "item is valid? #{result}"
              if result is false
                item_cb()
              else
                db_item = result
                console.log item.title
                db_item.update({
                  title: item.title
                  content: item.content
                })
                .then ->
                  item_cb()
                .catch (err) ->
                  item_cb(err)
          , (err) ->
            if err
              list_cb err
            else
              list_cb()

        .catch (err) ->
          list_cb err

  , (err) ->
    if err
      return res.json(err)
    else
      return res.status(200).send()