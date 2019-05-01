import { Meteor } from 'meteor/meteor'
import { Roles } from 'meteor/alanning:roles'
import SimpleSchema from 'simpl-schema'
import { Random } from 'meteor/random'
import { _ } from 'lodash'

import { Organisations } from '/imports/api/organisations/collection.coffee'
import { OrganisationRoles } from '/imports/api/organisationRoles/collection.coffee'
import { Stocks } from '/imports/api/stocks/collection.coffee'

PersonalInfo = new SimpleSchema
  username:
    type: String
  employeeId:
    type: String
  emails:
    type: Array
    defaultValue: []
  "emails.$":
    type: Object
  "emails.$.address":
    type: String
    regEx: SimpleSchema.RegEx.Email
  "emails.$.verified":
    type: Boolean
  mobilePhoneNumber:
    type: String
    regEx: /(\+61|61|0)\d{9}/
,
  tracker: Tracker
  requiredByDefault: false

Meteor.users.schema = new SimpleSchema
  createdAt:
    type: Date
  profile:
    type: Object
#  // Make sure this services field is in your schema if you're using any of the accounts packages
  services:
    type: Object
    blackbox: true
#  // Add `roles` to your schema if you use the meteor-roles package.
  roles:
    type: Object
    blackbox: true
  organisationId:
    type: String
  selectedOrganisationId:
    type: String
  organisationRoleIds:
    type: Array
    defaultValue: []
  'organisationRoleIds.$':
    type: String
,
  tracker: Tracker
  requiredByDefault: false

Meteor.users.schema.extend(PersonalInfo)

Meteor.users.attachSchema(Meteor.users.schema)

Meteor.users.findByOrganisationId = (organisationId) ->
  @find({organisationId: organisationId})

Meteor.users.findByPrimaryEmail = (email) ->
  @findOne({'emails.0.address': email})

Meteor.users.generateUniqueRandomId = ->
  loop
    randomId = Random.id()
    user = @findOne({'employeeId': randomId})
    break unless user
  randomId

Meteor.users.findOrCreateByEmailAddress = (email) ->
  Meteor.users.findOne({ 'emails.address': email })?._id || Accounts.createUser({ email: email })

Meteor.users.helpers
  isLearner: -> !@isSuperAdmin() && !@isOrganisationAdmin() && !@isManagerOfAnOrgUnit()
  isSuperAdmin: -> Roles.userIsInRole(@_id, 'superAdmin')
  isAdmin: -> @isSuperAdmin() || @isOrganisationAdmin()
  setSelectedOrganisationId: (organisationId) ->
    Meteor.users.update(@_id, {$set: {selectedOrganisationId: organisationId}})
  currentOrganisationId: ->
    if @isSuperAdmin()
      @selectedOrganisationId
    else
      @organisationId
  findCurrentOrganisation: ->
    Organisations.find({_id: @currentOrganisationId()})
  currentOrganisation: ->
    Organisations.findOne(@currentOrganisationId())
  isOrganisationAdmin: ->
    Roles.userIsInRole(@_id, 'organisationAdmin', @organisationId)
  isMemberOfOrganisation: (organisationId)->
    @organisationId == organisationId
  organisationRoles: ->
    OrganisationRoles.find({organisationId: @organisationId, _id: $in: (@organisationRoleIds or [])}, {sort: {name:1}})
  unassociatedOrganisationRoles: ->
    OrganisationRoles.find({organisationId: @organisationId, _id: $nin: (@organisationRoleIds or [])}, {sort: {name:1}})

  toggleOrganisationRoleAssociation: (organisationRoleId)->
    roleCurrentlyAssociated = (organisationRoleId in (@organisationRoleIds or []))
    unless roleCurrentlyAssociated
      @addOrganisationRoleId(organisationRoleId)
    else
      @removeOrganisationRoleId(organisationRoleId)

  addOrganisationRoleId: (organisationRoleId) ->
    Meteor.users.update(
        {_id: @_id},
        {$push: {'organisationRoleIds': organisationRoleId}}
      )

  removeOrganisationRoleId: (organisationRoleId) ->
    Meteor.users.update(
      {_id: @_id},
      {$pull: {'organisationRoleIds': organisationRoleId}}
    )


  primaryEmail: ->
    @emails[0]?.address

  displayName: ->
    @primaryEmail().replace(/@.*$/,'')

  hasAchieved: (achievement)-> @achievements[achievement._id]

  toggleIsOrganisationAdmin: ->
    if @isOrganisationAdmin()
      @removeAsOrganisationAdmin()
    else
      @addAsOrganisationAdmin()

  removeAsOrganisationAdmin: ->
    Roles.setUserRoles(@_id, [], @organisationId)

  addAsOrganisationAdmin: ->
    Roles.addUsersToRoles(@_id, 'organisationAdmin', @organisationId)

  reload: ->
    Meteor.users.findOne(@_id)
