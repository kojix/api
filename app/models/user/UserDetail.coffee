mongoose = require 'mongoose'
extend = require 'mongoose-schema-extend'
Schema = mongoose.Schema

Base = require '../Base'
AddressSchema = require('./Address').schema
ContactSchema = require('./Contact').schema

UserDetail = Base.extend
  salutation: String
  title: String
  firstName: String
  lastName: String

  birthday: Date

  phone: String
  mobile: String
  fax: String

  addresses:[AddressSchema]
  contacts: [ContactSchema]

  
module.exports = UserDetail