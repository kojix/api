should = require 'should'
mongoose = require 'mongoose'

describe 'Model Test: Base', ->
  Base = require '../../app/models/Base'
  
  it 'should exist a Base model', (done) ->
    should.exist Base
    done()

  it 'should be an instanceOf mongoose Schema', ->
    Base.should.be.an.instanceOf mongoose.Schema


  it 'should have a creation date', (done) ->
    should.exist Base.paths.createdAt
    done()

  it 'should have a updated date', (done) ->
    should.exist Base.paths.updatedAt    
    done()