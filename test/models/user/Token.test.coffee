should = require 'should'
config = require '../../../app/config'
config.models = config.damnutils.ModuleUtil.requireFolder config.path.join __dirname, '../../../app/models'
config.helpers = config.damnutils.ModuleUtil.requireFolder config.path.join __dirname, '../../../app/helpers'

describe 'Model Test: Token', ->
  before (done)->
    config.helpers.Database config, (err)->
      should.not.exist err
      done()

  it.skip 'should have a empty db', ->

  it.skip 'should be possible to generate a token', ->

  it.skip 'should be possible to save a token', ->

  it.skip 'should not be possible to generate the same token', ->

  it.skip 'should be possible to get the token until it is not expired', ->

  it.skip 'should not be possible to get the token for different apps', ->

  it.skip 'should not be possible to use the token from different place', ->
