Meteor.publish('OrganisationData', function (organisationIds) {
  console.log(organisationIds && organisationIds.length);
  console.log('publication called');
  return Organisation.find({});
});
