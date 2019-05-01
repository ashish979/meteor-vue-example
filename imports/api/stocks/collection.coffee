import { Mongo } from 'meteor/mongo'
import SimpleSchema from 'simpl-schema'
import { Factory } from 'meteor/dburles:factory'
import faker from 'faker'
import { Organisations } from '/imports/api/organisations/collection.coffee'
import { OrganisationRoles } from '/imports/api/organisationRoles/collection.coffee'
import { HasAlphaCode } from '/imports/api/collection-mixins/hasAlphaCode.coffee'

Stocks = new Mongo.Collection('Stocks')

Stocks.alphaCode = 'St'

Stocks.includeCollectionMixins(HasAlphaCode)

Stocks.schema = new SimpleSchema
  name:
    type: String
    label: 'Name'
    max: 250
    optional: false
    min: 1
  description:
    type: String
    label: 'Description'
    max: 2000
  organisationId:
    type: String
    optional: false
    min: 1
  roles:
    type: Array
    defaultValue: []
  "roles.$":
    type: Object
  "roles.$._id":
    type: String
  "roles.$.name":
    type: String
,
  tracker: Tracker
  requiredByDefault: false

Stocks.attachSchema Stocks.schema

Stocks.findByRoleId = (roleId) ->
  @find('roles._id': roleId)

Stocks.findByOrganisationId = (organisationId) ->
  @find('organisationId': organisationId)

Stocks.helpers HasAlphaCode.helpers

Stocks.helpers
  organisation: ->
    Organisations.findOne({_id: @organisationId})

  unassociatedRoles: ->
    OrganisationRoles.find({organisationId: @organisationId, _id: $nin: (r._id for r in (@roles or []))}, {sort: {name: 1}})

  toggleRoleAssociation: (roleId)->
    roleCurrentlyAssociated = (role for role in (@roles or []) when role._id is roleId)[0]
    unless roleCurrentlyAssociated # role is not currently associated
      @associateOrganisationRole(roleId)
    else # role is associated so remove
      @dissociateOrganisationRole(roleId)

  associateOrganisationRole: (roleId) ->
    Stocks.update(
      {_id: @_id},
      {$push:
        'roles': (->{@_id,@name}).call(OrganisationRoles.findOne(roleId))
      }
    )

  dissociateOrganisationRole: (roleId) ->
    Stocks.update(
      {_id: @_id},
      {$pull:
        'roles': { _id: roleId }
      }
    )

  hasRoleId: (roleId) ->
    role = @roles?.find((role) ->
      role._id == roleId
    )
    !!role

  reload: ->
    Stocks.findOne(@_id)

exports.Stocks = Stocks

Factory.define 'stock', Stocks,
  name: -> faker.lorem.word()
  organisationId: -> Factory.get('organisation')
  description: -> 'description'
