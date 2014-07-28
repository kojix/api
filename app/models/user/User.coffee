config = require '../../config'
Schema = config.Schema
UserDetail = require './UserDetail'

###
User Schema
###
User = UserDetail.extend
  email: 
    type: String
    required: true
    unique: true

  password: 
    type: String
    required: true
    select: false

  accountNumber:
    type: String
    unique: true

  config:
    resetKey: String
    resetTime: Date

    credit:
      bico:
        type: Number
        default: 0
      real:
        type: Number
        default: 0
      commendation:
        type: Number
        default: 0
      free:
        type: Number
        default: 0

    recommender: 
      type: Schema.ObjectId
      ref: 'User'

    organizations: [{
      organization:
        type: Schema.ObjectId
        ref: 'Organization'
      role:
        type: Schema.ObjectId
        ref: 'Role'
    }]

    status:
      active:
        type: Boolean
        default: true
      activationKey: String
      confirmedMail: 
        type: Boolean
        default: false
      isSuperAdmin:
        type: Boolean
        default: false
      permissions: [{
        type: Schema.ObjectId
        ref: 'Permission'
      }]
      groups: [{
        type: Schema.ObjectId
        ref: 'Group'
      }]

# PRE SAVE
User.pre "save", (next) ->
  user = @
  if @isNew
    # GENERATE HERE THE ACCOUNT NUMBER
    generateAccountNumber @

  if @isModified 'config'
    console.log 'Config Modified!!!'

  return next()  unless @isModified("password")
  bcrypt = config.bcrypt
  bcrypt.genSalt config.SALT, (err, salt) ->
    return next(err)  if err
    bcrypt.hash user.password, salt, (err, hash) ->
      return next(err)  if err
      user.password = hash
      next()

###
Private
###
generateAccountNumber = (user)->
  config.models.User.find (err, users) ->
    throw err if err
    val = if users.length > 0 then users.length+1 else 1 
    user.accountNumber = "" + new Date().getFullYear()
    user.accountNumber += config.damnutils.StringUtil.str_pad val, 7, '0', config.damnutils.StringUtil.STR_PAD_LEFT

###
ACL
###

###
Statics
###
User.statics = 
  load: (id, cb)->
    @findOne
      _id: id
    .exec(cb);
  loadWithConfig: (id, cb)->
    @findOne
      _id: id
    .populate('userConfig')
    .exec(cb);

  createWithActivity: (doc, callback)->
    @create doc, (userError, data)->
      return callback userError, data if userError
      return callback userError, data unless data
      config.models.Activity.create 
        title: 'user creation'
        description: 'Create user with email: '+data.email
        user: data._id
        , (activityError, activity)->
          return callback activityError, data if activityError
          unless activity
            log 'could not create activity for id '+data._id 

          callback userError, data

###
Methods
###
User.methods =
  generateRandomToken: ->
    user = @
    chars = "_!abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
    token = new Date().getTime() + '_'

    for x in [0...15]
      i = Math.floor Math.random() * 62
      token += chars.charAt i

    return token

  comparePassword: (candidatePassword, cb)->
    config.bcrypt.compare candidatePassword, @password, (err, isMatch)->
      return cb err if err
      cb null, isMatch

  secureJSON: ->
    _id: @_id
    __t: @__t
    email: @email
    accountNumber: @accountNumber

  sendActivationMail: (data, cb) ->
    options = 
      to: 
        email: @email
      subject: "Account Activation"
      template: 'activation'
    
    mailer = new config.helpers.Mailer options, data
    mailer.send cb

  sendForgetPassMail: (data, cb) ->
    options = 
      to: 
        email: @email
      subject: "Forget Password"
      template: 'forgetpass'
    
    mailer = new config.helpers.Mailer options, data
    mailer.send cb

  sendChangedPassMail: (data, cb) ->
    options = 
      to: 
        email: @email
      subject: "Changed Password"
      template: 'changedpass'
    
    mailer = new config.helpers.Mailer options, data
    mailer.send cb
      
# Module
module.exports = config.mongoose.model "User", User