config = require '../../config'
Schema = config.Schema

Address = new Schema
  primary:
    type: Boolean
    default: false
  name:
    type: String
    required: true
  street:
    type: String
    required: true
  extra: String
  postralcode:
    type: String
    required: true
  city:
    type: String
    required: true
  country:
    type: Schema.ObjectId
    ref: 'Country'
    required: true

#Address.statics = 
#Address.methods = 


module.exports = config.mongoose.model "Address", Address