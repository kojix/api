mongoose = require 'mongoose'
extend = require 'mongoose-schema-extend'
Schema = mongoose.Schema

Base = require('../Base')

Group = Base.extend
  name:
    type: String
    required: true
    unique: true

  description: String
  users: [{
    type: Schema.ObjectId
    ref: 'User'
  }]
  status:
    active:
      type: Boolean
      default: true
    permissions: [{
      type: Schema.ObjectId
      ref: 'Permission'
    }]
  
module.exports = mongoose.model "Group", Group