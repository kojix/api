module.exports =
  mongodb: 'mongodb://localhost/kojix' or process.env.MONGODB
  cookie:
    secret: '1V3e86ETM3lSzb7V1Rr2O93I6T2Brbo1'
    auth:
      secure: false
  debug: 'kojix'
  d: 'kojix:'
  mailer:
    transport: 'Stub'
    options: {}
  env:
    DEBUG: 'kojix,kojix:*'