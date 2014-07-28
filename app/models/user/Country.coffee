mongoose = require 'mongoose'
extend = require 'mongoose-schema-extend'
Schema = mongoose.Schema

Base = require('../Base')

Country = Base.extend
  name:
    type: String
    required: true

#Country.statics = 
#Country.methods = 


module.exports = mongoose.model "Country", Country