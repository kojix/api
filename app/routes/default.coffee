express = require 'express'
router = express.Router()
pkg = require '../../package.json'

router.get '/', (req, res)->
  console.log "home"
  console.log req.xhr

  body = 
    status: true
    version: pkg.version

  return res.json body if req.xhr
  return res.render 'index', 
    json: body 
    env: process.env
  

module.exports = router