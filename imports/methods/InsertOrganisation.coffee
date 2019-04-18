import faker from 'faker';
import '/imports/collections/Organisation.coffee';

Meteor.methods InsertOrganisation: ->
  Organisation.insert name: faker.random.word()
  return
