Meteor.publish('OrganisationData', function (organisationIds) {
  console.log(organisationIds.length);
  console.log('publication called');
});
