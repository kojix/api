# logger
log = require('debug') 'kojix:api_router'

module.exports =  (app, config)->

  # api routes
  ###
  lvl1 = config.damnutils.ModuleUtil.requireFolder config.path.join __dirname, 'routes/lvl1'
  for router in lvl1
    log 'Use '+router+' Router for API'
    app.use '/api', lvl1[router]

  lvl2 = config.damnutils.ModuleUtil.requireFolder config.path.join __dirname, 'routes/lvl2'
  for router of lvl2
    log 'Use '+router+' Router for API'
    app.use '/api', lvl2[router]

  lvl3 = config.damnutils.ModuleUtil.requireFolder config.path.join __dirname, 'routes/lvl3'
  for router of lvl3
    log 'Use '+router+' Router for API'
    app.use '/api', lvl3[router]

  lvl4 = config.damnutils.ModuleUtil.requireFolder config.path.join __dirname, 'routes/lvl4'
  for router of lvl4
    log 'Use '+router+' Router for API'
    app.use '/api', lvl4[router]
  ###

  # static routes
  app.use '/login',       require './routes/login'
  app.use '/logout',      require './routes/logout'
  app.use '/register',    require './routes/register'
  app.use '/activation',  require './routes/activation'
  app.use '/forgetpass',  require './routes/forgetpass'
  app.use '/stats',       require './routes/stats'
  app.use '/',            require './routes/default'

  app.use (req, res)->
    res.send 404, 'Not Found'