import { Organisation } from '/imports/collections/Organisation.coffee'

Meteor.publish('Organisation',() ->
  Organisation.find({})
)
