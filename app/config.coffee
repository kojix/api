_ = require 'lodash'

env = process.env.NODE_ENV or 'development'
allConfig = require './config/all'
envConfig = require './config/'+env
module.exports =  _.merge allConfig, envConfig