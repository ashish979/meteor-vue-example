import faker from 'faker';
import '/imports/collections/Organisation';

Meteor.methods({
  InsertOrganisation() {
    Organisation.insert({name: faker.random.word()});
  },
});
