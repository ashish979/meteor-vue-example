Meteor.publish('Organisation', function () {
  return Organisation.find({});
});
