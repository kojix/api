log = require('debug') 'kojix:Helper_createDefaultUsers'

config = require '../config'

module.exports = ->
  log 'trying to create default User'
  config.models.User.createWithActivity
    # changed in production mode - this only works in development / test mode
    email: "n@gkngbr.de"
    password: "2welcome"
    , (err, u)->
      if err? 
        return log 'default user already exists' if err.code is 11000
        return throw err
    
