express = require('express')
app = express()
bodyParser = require('body-parser')
routes = require('./app/routes')

app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: true }))
app.use(express.static('web/public'))
routes(app)
models = require('./app/models/index')

app.listen 3000, ->
  console.log "Express running on port #{3000}"