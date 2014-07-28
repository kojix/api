log = require('debug') 'kojix:Helper_JWTHandler'

config = require '../config'

jwt = config.jwt
moment = config.moment

mongoose = config.mongoose
Token = mongoose.model 'Token'
exports = module.exports

exports = module.exports

exports.generateToken = (user, cb)->
  log 'generate a new token for user with email: '+user.email

  # GENERATE NEW TOKEN
  expires = moment().add('days', 7).valueOf()
  token = jwt.encode
    iss: user.id
    exp: expires
    , config.token.secret

  return cb token, expires

exports.saveToken = (token, expires, ip, user, cb)->
  token = new Token
    token: token
    expires: expires
    ip: ip
    user: user._id

  token.save cb

exports.getToken = (user, ip, cb)->
  handler = @
  ip = ip or process.env.REMOTE_ADDR
  # More security here? Like Cookies and more
  Token.findOne 
    ip: ip
    user: user._id
    , (err, token)->
      cb err, null if err
      if token?
        return  cb null, token
      else
        handler.generateToken user, (token, expires)->
          # TODO METHODS TO SAVE TOKEN IN DATABASE FOR EVALUATING REQUESTS
          handler.saveToken token, expires, ip, user, (err, t)->
            return cb err, null if err
            return cb null, t




exports.destroyToken = (token, cb)->
  Token.findOne token: token, (err, t)->
    return cb err, t if err
    t.remove cb

exports.isAuthenticated = (req, res, next)->
  if req.cookies
    token = req.cookies.auth or req.get 'kojixToken'
  else
    return res.send 401, 'Unauthorized'
  if token
    Token.findOne
      ip: req.ip
      token: token
    .populate 'user'
    .exec (err, t)->
      return res.send 500, err if err
      return res.send 401, 'Unauthorized' unless t
      req.token = t
      next()
  else
    return res.send 401, 'Unauthorized'

exports.isNotAuthenticated = (req, res, next)->
  token = req.cookies.auth or req.get 'kojixToken'
  if token?
    return res.send 405, 'Method not allowed'
  else
    next()

exports.hasPermission = (req, res, next)->
  config.models.User.loadWithConfig req.token.user.id, (err, user)->
    return res.json 500, err if err
    return res.json 401, 'Unauthorized' unless user 
    console.log user
    # return res.json 401, 'Unauthorized' if user.userConfig.status.isSuperAdmin
    next()