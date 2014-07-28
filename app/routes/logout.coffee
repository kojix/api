config = require '../config'

router = config.express.Router()

JWTHandler = require '../helpers/JWTHandler'

router.get '/', JWTHandler.isAuthenticated, (req, res)->
  console.log req.token
  req.token.remove (err, token)->
    return res.send 401, 'Token not exist' if err
    res.clearCookie 'auth'
    res.json
      logout: true

module.exports = router