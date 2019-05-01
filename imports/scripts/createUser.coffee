{ Meteor } = require 'meteor/meteor'
{ Accounts } = require 'meteor/accounts-base'
{ Organisations } = require '/imports/api/organisations/collection.coffee'

module.exports.createUser = (userNumber, organisationId, userEmail, password) ->
  userEmail = userEmail || "testUser#{userNumber}@gmail.com"
  password ||= 'password'
  unless organisationId
    organisation = Organisations.findOne({name: 'Test Organisation'})
    if organisation
      organisationId = organisation._id
    else
      organisationId = Organisations.insert({name: 'Test Organisation'})
  userId = Accounts.createUser(email: userEmail, password: 'password')
  Meteor.users.update(userId, {$set: {organisationId: organisationId}})
  console.log("Created User with email #{userEmail} and password password")
  Meteor.users.findOne(userId)
