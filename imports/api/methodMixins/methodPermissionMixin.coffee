import { Meteor } from 'meteor/meteor'
import {  Roles } from 'meteor/alanning:roles'
import { check } from 'meteor/check'
import { LoggedInMixin } from './loggedInMixin.coffee'

MethodPermissionMixin = (methodOptions) ->
  check(methodOptions.roles, Array)
  oldRunFunction = methodOptions.run
  methodOptions.roles = _.uniq(methodOptions.roles)
  methodOptions.run = ->
    #TODO replace below hack for manager check
    hasPermission = Roles.userIsInRole(@currentUser._id, methodOptions.roles, @currentUser.organisationId)
    if !hasPermission && methodOptions.roles.indexOf('organisationUnitManager') >= 0
      hasPermission = @currentUser.isManagerOfAnOrgUnit()
    if hasPermission
      oldRunFunction.call(@, arguments...)
    else
      throw new Meteor.Error("#{methodOptions.name}", 'Permission denied')
  LoggedInMixin.call(@, methodOptions)

module.exports.MethodPermissionMixin = MethodPermissionMixin
