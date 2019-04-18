import { Organisation } from '/imports/collections/Organisation.coffee'

Meteor.publish('OrganisationData', (organisationIds) ->
  console.log(organisationIds && organisationIds.length)
  console.log('publication called')
  Organisation.find({})
)
