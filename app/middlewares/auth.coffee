jwt = require('express-jwt')
secret = require('../config/jwt_secret')

authMiddleware = jwt({
  secret: secret
  credentialsRequired: true
  getToken: (req) ->
    if req.headers.authorization and req.headers.authorization.split(' ')[0] == 'Bearer'
      return req.headers.authorization.split(' ')[1]
    else if req.query and req.query.token
      return req.query.token
})

module.exports = authMiddleware