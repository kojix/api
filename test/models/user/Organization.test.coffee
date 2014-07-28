should = require 'should'
root = process.cwd()
config = require root + '/app/config'
config.models = config.damnutils.ModuleUtil.requireFolder config.path.join root, 'app/models'
config.helpers = config.damnutils.ModuleUtil.requireFolder config.path.join root, 'app/helpers'

describe 'Model Test: Organization', ->
  before (done)->
    config.helpers.Database config, (err)->
      console.log err
      should.not.exist err
      done()

  it.skip 'should be possible to save a Organization', ->

  it.skip 'should not be possible save a second Organization', ->

  it.skip 'should', ->

  it.skip 'should not', ->