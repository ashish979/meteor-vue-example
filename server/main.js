import { Meteor } from 'meteor/meteor';

import '/imports/collections/Time';
import '/imports/collections/Organisation';

import '/imports/methods/UpdateTime';
import '/imports/methods/InsertOrganisation';

import '/imports/publications/Time';
import '/imports/publications/Organisation';
import '/imports/publications/OrganisationData';

Meteor.startup(() => {
  // Update the current time
  Meteor.call('UpdateTime');
  // Add a new doc on each start.
  Time.insert({ time: new Date() });
  // Print the current time from the database
  console.log(`The time is now ${Time.findOne().time}`);

  // Seed organisation data
  Organisation.insert({name: 'Microsoft'})
  Organisation.insert({name: 'Apple'})
  Organisation.insert({name: 'Amazon'})
  Organisation.insert({name: 'Facebook'})
  Organisation.insert({name: 'Google'})
});
