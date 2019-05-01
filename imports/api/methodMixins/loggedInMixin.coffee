import { _ } from 'lodash'

LoggedInMixin = (methodOptions) ->
  oldRunFunction = methodOptions.run
  methodOptions.run = ->
    @currentUser = Meteor.users.findOne(@userId)
    unless @currentUser
      throw new Meteor.Error("#{methodOptions.name}", 'You need to login')
    oldRunFunction.call(@, arguments...)
  methodOptions

module.exports.LoggedInMixin = LoggedInMixin

