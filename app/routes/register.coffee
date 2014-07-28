config = require '../config'

router = config.express.Router()
User = config.mongoose.model 'User'

JWTHandler = require '../helpers/JWTHandler'
Cookies = config.Cookies


router.get '/', (req, res)->
  res.send 401

router.post '/', JWTHandler.isNotAuthenticated, (req, res)->
  req.body.config = {}
  req.body.config.status = {}
  # GENERATE HER THE ACTIONKEY
  req.body.config.status.activationKey = config.uuid.v1()

  User.createWithActivity req.body, (err, user)->
    return res.json err if err?
    return req.send 400 unless user
    user.sendActivationMail
      link: 'http://localhost:3000/activation/'+user._id+'/'+user.config.status.activationKey
      kojix: 'http://www.kojix.com'
      , (err, result)->
        return res.json err if err
        return res.json 500, 'Error with Mailer' unless result
        console.log result
        JWTHandler.getToken user, req.ip, (err, token)->
            return res.send 500, error if err
            if token?
              cookies = new Cookies req, res
              cookies.set 'auth', token.token,
                expires: token.expires
                secure: config.token.secure
              res.json 
                token: token.token
                expires: token.expires
                user: user.secureJSON()
            else
              res.send 500, 'Authentication error'

module.exports = router