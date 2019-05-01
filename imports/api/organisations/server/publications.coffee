import { Meteor } from 'meteor/meteor'
import { Organisations } from '../collection.coffee'

Meteor.publish 'organisations', ->
  loggedInUser = Meteor.users.findOne(@userId)
  unless loggedInUser.isSuperAdmin()
    return @ready()
  Organisations.find()

Meteor.publish 'myOrganisation', ->
  loggedInUser = Meteor.users.findOne(@userId)
  unless loggedInUser?.currentOrganisationId()
    return @ready()
  loggedInUser.findCurrentOrganisation()
