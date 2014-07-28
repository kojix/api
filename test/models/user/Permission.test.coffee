should = require 'should'
config = require '../../../app/config'
config.models = config.damnutils.ModuleUtil.requireFolder config.path.join __dirname, '../../../app/models'
config.helpers = config.damnutils.ModuleUtil.requireFolder config.path.join __dirname, '../../../app/helpers'

Permission = config.models.Permission
describe 'Model Test: Permission', ->
  before (done)->
    config.helpers.Database config, (err)->
      should.not.exist err
      done()