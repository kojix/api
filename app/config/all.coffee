fs                = require 'fs'
os                = require 'os'
path              = require 'path'
express           = require 'express'
mongoose          = require 'mongoose'
Schema            = mongoose.Schema
extend            = require 'mongoose-schema-extend'

moment            = require 'moment'
bcrypt            = require 'bcrypt'
damnutils         = require 'damn-utils'
jwt               = require 'jwt-simple'

uuid              = require 'node-uuid'
generatePassword  = require 'password-generator'
circularjson      = require 'circular-json'

_                 = require 'lodash'

Cookies           = require 'cookies'

pkg               = require '../../package.json'

module.exports = 
  pkg: pkg
  port: process.env.PORT or 3000
  name: 'kojix'
  email: 'info@kojix.com'
  SALT: 10
  token:
    secret: 'tjLZqF5924ouC5001eWsO5tb0XS07NJF' or process.env.SECRET_TOKEN
    secure: false
    expireDateFromNow: ->
      return moment().add('days', 7).valueOf()

  fs: fs
  os: os
  path: path
  express: express
  mongoose: mongoose
  Schema: Schema
  extend: extend

  moment: moment
  bcrypt: bcrypt
  damnutils: damnutils
  jwt: jwt

  uuid: uuid
  generatePassword: generatePassword
  circularjson: circularjson 

  _: _

  Cookies: Cookies