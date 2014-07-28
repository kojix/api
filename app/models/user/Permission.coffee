mongoose = require 'mongoose'
extend = require 'mongoose-schema-extend'
Schema = mongoose.Schema

Base = require('../Base')

Permission = Base.extend
  description: String
  route: String
  method: String

Permission.pre 'save', (next)->
  permission = @
  # if @isNew

  
module.exports = mongoose.model "Permission", Permission