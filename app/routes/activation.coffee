config = require '../config'

router = config.express.Router()

User = config.mongoose.model 'User'

JWTHandler = require '../helpers/JWTHandler'

router.post '/', (req, res)->

  User.findOne _id: req.body.id, (err, user)->
    return res.json 500, err if err
    if user.status.activationKey is req.body.activationKey
      User.findByIdAndUpdate user._id,
        'status.confirmedMail': true
        , {}, (err, user)->
          return res.json 500, err if err
          res.json
            status: true
    else
      res.json
        status: false

router.get '/send', JWTHandler.isAuthenticated, (req, res)->
  user = req.token.user
  user.sendActivationMail
    # Here link to life site
    link: 'http://localhost:3000/activation/'+user._id+'/'+user.status.activationKey
    kojix: 'http://www.kojix.com'
    , (err, result)->
      return req.json 500, err if err
      res.json
        status: true

module.exports = router