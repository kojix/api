should = require('should')
Mailer = require('../../app/helpers/Mailer')
config = require '../../app/config'

describe "Mailer Test", ->
  it.skip "should send a mail", (done)->
    options = 
      to: 
        email: 'ninevillage@gmail.com'
        name: 'Matt'
        surname: 'Ninevillage'
      subject: "Testmail From kojix.com Mocha Test"
      template: 'test'

    data =
      name: "John"
      surname: "Doe"
      id: "31234_roflmao_test"

    mailer = new Mailer options, data
    mailer.send (err, result)->
      should.not.exist err
      should.exist result
      done()