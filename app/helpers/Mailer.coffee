log = require('debug') 'kojix:Helper_Mailer'
# exports = module.exports

# exports.init = (mailerConfig)->
#   transport = nodemailer.createTransport mailerConfig.transport, mailerConfig.options

# exports.sendUserActivationMail = (user)->
#   return log 'Do not send activation mail for user '+user._id if user.status.confirmedMail
#   log 'send activation mail for user '+user._id
#   @send config.email, user.email, {}, 'lksdfjlsdf', ''

# exports.send = (options, callback)->
#   transport.sendMail options, callback


emailer = require 'nodemailer'
fs      = require 'fs'
path    = require 'path'
_       = require 'underscore'
config  = require '../config'

class Emailer

  options: {}

  data: {}

  # Define attachments here
  attachments: [
    fileName: "logo.png"
    filePath: "./public/images/email/logo.png"
    cid: "logo@kojix"
  ]

  constructor: (@options, @data)->

  send: (callback)->
    html = @getHtml(@options.template, @data)
    attachments = @getAttachments(html)
    messageData =
      to: "'#{@options.to.name} #{@options.to.surname}' <#{@options.to.email}>"
      from: "info@kojix.com"
      subject: @options.subject
      html: html
      generateTextFromHTML: true
      attachments: attachments
    transport = @getTransport()
    transport.sendMail messageData, callback

  getTransport: ()->
    
    emailer.createTransport config.mailer.transport,
      config.mailer.options

  getHtml: (templateName, data)->
    templatePath = "./app/views/emails/#{templateName}.html"
    templateContent = fs.readFileSync(templatePath, "utf8")
    _.template templateContent, data, {interpolate: /\{\{(.+?)\}\}/g}

  getAttachments: (html)->
    attachments = []
    for attachment in @attachments
      attachments.push(attachment) if html.search("cid:#{attachment.cid}") > -1
    attachments

exports = module.exports = Emailer