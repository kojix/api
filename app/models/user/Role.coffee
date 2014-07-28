mongoose = require 'mongoose'
extend = require 'mongoose-schema-extend'
Schema = mongoose.Schema

Base = require('../Base')

Role = Base.extend
  identifier:
    type: String
    required: true
    unique: true
    
  name: 
    type: String
    required: true

  description: String

module.exports = mongoose.model "Role", Role