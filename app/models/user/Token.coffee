mongoose = require 'mongoose'
extend = require 'mongoose-schema-extend'
Schema = mongoose.Schema

Base = require('../Base')

Token = Base.extend
  token:
    type: String
    required: true
    unique: true

  expires: 
    type: Date
    required: true

  ip:
    type: String
    required: true

  user: 
    type: Schema.ObjectId
    ref: 'User'


# Verfiy App? Browser/Desktop/etc.
# Auth with AuthCode from mobile App?
# TODO Clear expired Tokens
# TODO Token Clear if user logged out with a Token

  
module.exports = mongoose.model "Token", Token