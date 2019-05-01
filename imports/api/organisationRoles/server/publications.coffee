import { Meteor } from 'meteor/meteor'
import { OrganisationRoles } from '../collection.coffee'

Meteor.publish 'organisationRoles', ->
  loggedInUser = Meteor.users.findOne(@userId)
  unless loggedInUser?.currentOrganisationId()
    return @ready()
  OrganisationRoles.find({organisationId: loggedInUser.currentOrganisationId()})
