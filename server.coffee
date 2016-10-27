express = require('express')
app = express()
bodyParser = require('body-parser')
routes = require('./routes')
forceSSL = require('express-sslify')
forceDomain = require('express-force-domain')

if(process.env.NODE_ENV is 'production')
  app.use( forceDomain('http://www.unsakini.com') )
  app.use(forceSSL.HTTPS({ trustProtoHeader: true }))

app.set('view engine', 'ejs')
app.set('views', "#{__dirname}/api/views")
app.use(express.static('./dist'))
if(process.env.NODE_ENV isnt 'production')
  app.disable('view cache')

app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: true }))
app.use(require('./api/middlewares/jwt'))
models = require('./api/models')

routes(app)

port = process.env.PORT || 3000
app.listen port, ->
  console.log "Express running on port #{port}"
