express = require 'express'
router = express.Router()
pkg = require '../../package.json'

JWTHandler = require '../helpers/JWTHandler'

router.get '/', JWTHandler.isAuthenticated, (req, res)->
  res.json
    status: true
    version: pkg.version

    api:
      v1: false
      v2: false

    modules: pkg.dependencies
    devModules: pkg.devDependencies

    stats:
      UserManagment: true
      TokenManagment: true
      ProductManagment: false
      OrderManagment: false
      PaymentManagment: false
      TicketManagment: false
      ContentManagment: false
      SyncManagement: false


module.exports = router