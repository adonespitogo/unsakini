exports.index = (req, res, next) ->
  res.render 'home'

exports.app = (req, res, next) ->
  res.render 'app'