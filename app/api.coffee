# logger
log = require('debug') 'kojix:api'

# requirements
log 'init requirements'
express = require 'express'
app = express()

# load config
config = require './config'
#config.models = config.damnutils.ModuleUtil.requireFolder config.path.join __dirname, 'models'
#config.helpers = config.damnutils.ModuleUtil.requireFolder config.path.join __dirname, 'helpers'
#config.controllers = config.damnutils.ModuleUtil.requireFolder config.path.join __dirname, 'controllers'

# jwt
log 'init jwt'
log 'jwt token: '+config.token.secret
app.set('jwtTokenSecret', config.token.secret);

# db
app.set 'db', require('./helpers/Database') config

# middleware
log 'init middleware'
bodyParser = require 'body-parser'
cookieParser = require 'cookie-parser'
morgan = require 'morgan'

# config
log 'configure api'
log 'set port ' + config.port
app.set 'port', config.port

app.enable 'trust proxy'
console.log 'TRUST PROXY: '+app.get('trust proxy')

app.set 'views', config.path.join __dirname, 'views'
log app.get 'views'
app.set 'view engine', 'jade'
app.set 'view options',
  layout: true

app.locals.pretty = true

app.use morgan 'dev'

app.use cookieParser config.cookie.secret
app.use bodyParser.json()
app.use bodyParser.urlencoded
  extended: true
  
app.use '/', express.static config.path.join __dirname, '../public'

# helper
require('./inits/createDefaultUsers')()

app.use (req, res, next)->
  console.log 'TRUST PROXY: '+app.get('trust proxy')
  console.log req.ip
  next()

require('./router') app, config

# liste
log 'try to listen on port ' + app.get 'port'
app.listen app.get 'port'
log 'api listen on port ' + app.get 'port'