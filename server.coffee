express = require('express')
app = express()
routes = require('./routes')
controllers = require('require-dir')('app/controllers')
app.use(express.static('web/public'))
routes(app)

app.listen 3000, ->
  console.log "Express running on port #{3000}"