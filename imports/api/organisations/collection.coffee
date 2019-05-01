{ Mongo } = require 'meteor/mongo'
import SimpleSchema from 'simpl-schema'
{ Accounts } = require 'meteor/accounts-base'
{ Factory } = require 'meteor/dburles:factory'
faker = require 'faker'

Organisations = new Mongo.Collection('Organisations')

Organisations.schema = new SimpleSchema
  name:
    type: String
    label: 'Name'
    max: 250
    min: 1
    optional: false
  codeCounters:
    type: Object
    defaultValue: {}
    blackbox: true
,
  requiredByDefault: false

Organisations.attachSchema Organisations.schema

Organisations.helpers
  addUser: (userEmail)->
    user = Accounts.findUserByEmail userEmail
    unless user?
      throw new Meteor.Error('organisation.addUser.userDoesNotExist', "No user with email address: #{userEmail}")
    if user?.organisationId?
      throw new Meteor.Error('organisation.addUser.userInAnotherOrganisation', "Can't add user already in another Organisation")
    Meteor.users.update(user._id, {$set: {organisationId: @_id}})
    user

  updateCodeCounterFor: (alphaCode) ->
    modifier = {$inc: {"codeCounters.#{alphaCode}": 1}} # if it exists increment
    unless @codeCounters? and @codeCounters[alphaCode]? # else initialize to 1
      modifier = {$set: modifier.$inc}
    Organisations.update({_id: @_id}, modifier)
    # TODO this is kind of clunky reload and very specific, probably better and more useful to have a generally
    # applicable 'reload' function.
    reloadedSelf = Organisations.findOne({_id:@_id})
    @codeCounters = reloadedSelf.codeCounters

  nextCodeFor: (alphaCode) ->
    # Update first because we don't care if we skip one but we do care if we duplicate
    @updateCodeCounterFor(alphaCode)
    @codeCounters[alphaCode]

exports.Organisations = Organisations

Factory.define 'organisation', Organisations,
  name: -> faker.company.companyName()
  codeCounters: -> {}
