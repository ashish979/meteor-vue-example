import { Meteor } from 'meteor/meteor'

import { Time } from '/imports/collections/Time.coffee'
import { Organisation } from '/imports/collections/Organisation.coffee'

import '/imports/methods/UpdateTime.coffee'
import '/imports/methods/InsertOrganisation.coffee'

import '/imports/publications/Time.coffee'
import '/imports/publications/Organisation.coffee'
import '/imports/publications/OrganisationData.coffee'

Meteor.startup(() =>
  Meteor.call('UpdateTime')
  Time.insert({ time: new Date() })

  Organisation.insert({name: 'Microsoft'})
  Organisation.insert({name: 'Apple'})
  Organisation.insert({name: 'Amazon'})
  Organisation.insert({name: 'Facebook'})
  Organisation.insert({name: 'Google'})
)
