mongoose = require 'mongoose'
extend = require 'mongoose-schema-extend'
Schema = mongoose.Schema

Base = require('../Base')

Contact = Base.extend
  user:
    type: Schema.ObjectId
    ref: 'User'
    
  firstName:
    type: String
    required: true
  lastName:
    type: String
    required: true

  addresses: [{
    type: Schema.ObjectId
    ref: 'Address'
  }]

  emailAddresses: [{
    type: Schema.ObjectId
    ref: 'EmailAddress'
  }]

  numbers: [{
    type: Schema.ObjectId
    ref: 'Number'
  }]
#Contact.statics = 
#Contact.methods = 


module.exports = mongoose.model "Contact", Contact