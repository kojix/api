config = require '../config'
router = config.express.Router()

User = config.mongoose.model 'User'
JWTHandler = require '../helpers/JWTHandler'

Cookies = config.Cookies

router.get '/', (req, res)->
  res.json 401

router.post '/', (req, res)->
  return res.json(400, "missing credentials") unless req.body.email?
  return res.json(400, "missing credentials") unless req.body.password?
  User.findOne
    email: req.body.email
    ,
    '+password'
    , (err, user)->
      return res.json(401) if err
      return res.json(401, "wrong email") unless user

      user.comparePassword req.body.password, (err, isMatch)->
        return res.json(401) if err
        return res.json(401, "wrong password") unless isMatch
        # Check DB For Tokrn before generate a new one
        console.log 'IP: ' + req.ip
        JWTHandler.getToken user, req.ip, (err, token)->
          if err
            return res.json 500, err
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
            res.json 500, 'Authentication error'

module.exports = router