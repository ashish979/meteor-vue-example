import { Meteor } from 'meteor/meteor'
import { Users } from '../collection.coffee'

Meteor.publish 'organisationUsers', ->
  loggedInUser = Meteor.users.findOne(@userId)
  unless loggedInUser?.currentOrganisationId() and (loggedInUser.isSuperAdmin() or loggedInUser.isOrganisationAdmin())
    return @ready()
  Meteor.users.find({organisationId: loggedInUser.currentOrganisationId()},
    fields:
      emails: 1
      profile: 1
      roles: 1
      organisationId: 1
      organisationRoleIds: 1
      completedDevelopmentActivityList: 1
      mobilePhoneNumber: 1
      achievements: 1
      recommendedDevelopmentActivityList: 1
      depersonalized: 1
      forcePasswordChange: 1
  )

Meteor.publish 'loggedInUser', ->
  return @ready() unless @userId

  Meteor.users.find({_id: @userId},
    fields:
      organisationId: 1
      selectedOrganisationId: 1
      completedDevelopmentActivityList: 1
      organisationRoleIds: 1
      mobilePhoneNumber: 1
      achievements: 1
      recommendedDevelopmentActivityList: 1
      notificationPreferences: 1
      hasAcceptedTermsOfUse: 1
      depersonalized: 1
      forcePasswordChange: 1
  )
