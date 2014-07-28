mongoose = require 'mongoose'
Schema = mongoose.Schema

BaseSchema = new Schema
  createdAt:
    type: Date
    required: true
    default: Date.now

  updatedAt:
    type: Date
    required: true
    default: Date.now

module.exports = BaseSchema