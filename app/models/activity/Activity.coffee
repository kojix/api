mongoose = require("mongoose")
extend = require('mongoose-schema-extend')
Schema = mongoose.Schema
BaseSchema = require '../Base'

Activity = BaseSchema.extend
  title:
    type: String
    required: true

  description: 
    type: String
    required: true

  user:
    type: Schema.ObjectId
    ref: 'User'


# Activity.methods =



module.exports = mongoose.model 'Activity', Activity