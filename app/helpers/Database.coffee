log = require('debug') 'kojix:Helper_Database'
db = null
module.exports = (config, cb)->
  if db is null
    log 'init database'
    db = config.mongoose.connect config.mongodb, (err)->
      log 'sucessfully connected to database: '+config.mongodb unless err
      cb err if cb?
  else
    log 'find database connection'
    cb null if cb?
    return db