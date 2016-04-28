List = require('../models/list')

exports.index = (req, res, next) ->
  List.findAll()
  .then (result) ->
    res.send result
    next()
  .catch (err) ->
    res.send err
    next()