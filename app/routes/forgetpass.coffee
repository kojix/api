config = require '../config'
router = config.express.Router()

User = config.mongoose.model 'User'

JWTHandler = require '../helpers/JWTHandler'
uuid = config.uuid
generatePassword = config.generatePassword


router.post '/', JWTHandler.isNotAuthenticated, (req, res)->
  return res.json 400, 'Bad Request' unless req.body.email
  User.findOneAndUpdate 
    email: req.body.email
  ,
    resetKey: uuid.v1()
    resetTime: new Date()
  , {}, (err, user)->
      return res.json 500, err if err
      console.log user
      user.sendForgetPassMail
        link: 'http://localhost:3000/forgetPass/'+user._id+'/'+user.resetKey
        kojix: 'http://www.kojix.com'
        , (err, result)->
          return req.json 500, err if err
          res.json
            status: true
    

router.post '/verify', JWTHandler.isNotAuthenticated, (req, res)->
  User.findOne _id: req.body.id, (err, user)->
    return res.json 500, err if err
    return res.json 400, 'Bad Reqest' unless user
    if user.resetKey is req.body.resetKey
      pass = generatePassword()
      user.password = pass
      user.save (err, user)->
        user.sendChangedPassMail
          email: user.email
          password: pass
          kojix: 'http://www.kojix.com'
          , (err, result)->
            return req.json 500, err if err
            res.json
              status: true
    else
      return res.json 400, 'Bad Request'

module.exports = router