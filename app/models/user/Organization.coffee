mongoose = require 'mongoose'
extend = require 'mongoose-schema-extend'
Schema = mongoose.Schema

Base = require('../Base')

Organization = Base.extend
  organizationNumber:
    type: String
    unique: true

  name:
    type: String
    required: true

  companyForm:
    type: String
    required: true

  vatId: String

  emailAddresses: [{
    emailAddress:
      type: Schema.ObjectId
      ref: 'EmailAddress'
    primary:
      type: Boolean
      default: false
  }]

  addresses: [{
    address:
      type: Schema.ObjectId
      ref: 'Address'
    primary:
      type: Boolean
      default: false
  }]

  users: [{
    type: Schema.ObjectId
    ref: 'User'
  }]

  contacts: [{
    type: Schema.ObjectId
    ref: 'Contact'
  }]

  credit:
    bico:
      type: Number
      default: 0
    real:
      type: Number
      default: 0
    commendation:
      type: Number
      default: 0
    free:
      type: Number
      default: 0



module.exports = mongoose.model "Organization", Organization