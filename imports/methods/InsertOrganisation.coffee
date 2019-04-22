import faker from 'faker';
import { Organisation } from '/imports/collections/Organisation.coffee';

Meteor.methods InsertOrganisation: ->
  Organisation.insert name: faker.random.word()
  return
