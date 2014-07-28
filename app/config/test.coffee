module.exports =
  mongodb: 'mongodb://localhost/kojixtest' or process.env.MONGODB
  cookie:
    secret: '1V3e86ETM3lSzb7V1Rr2O93I6T2Brbo1'
    auth:
      secure: false
  mailer:
    transport: 'Stub'
    options: {}