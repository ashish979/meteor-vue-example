import { Meteor } from 'meteor/meteor'
import { Stocks } from '../collection.coffee'

Meteor.publish 'organisationStocks', ->
  loggedInUser = Meteor.users.findOne(@userId)
  unless loggedInUser?.currentOrganisationId() and (loggedInUser.isSuperAdmin() or loggedInUser.isOrganisationAdmin())
    return @ready()
  Stocks.find({organisationId: loggedInUser.currentOrganisationId()})

