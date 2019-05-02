import { Meteor } from 'meteor/meteor'
import { ValidatedMethod } from 'meteor/mdg:validated-method'
import SimpleSchema from 'simpl-schema'
import { OrganisationRoles } from './collection.coffee'
import { MethodPermissionMixin } from '/imports/api/methodMixins/methodPermissionMixin.coffee'

module.exports.insert = new ValidatedMethod
  name: 'organisationRoles.insert'
  mixins: [MethodPermissionMixin]
  roles: ['superAdmin', 'organisationAdmin']
  validate: OrganisationRoles.schema.pick('name').validator()
  run: (params) ->
    OrganisationRoles.insert({name: params.name, organisationId: @currentUser.currentOrganisationId()})

module.exports.update = new ValidatedMethod
  name: 'organisationRoles.update'
  mixins: [MethodPermissionMixin]
  roles: ['superAdmin', 'organisationAdmin']
  validate: new SimpleSchema(
    _id: {type: String}
    modifier: {type: Object, blackbox: true}
  ).validator()
  run: ({_id, modifier}) ->
    OrganisationRoles.update({_id: _id, organisationId: @currentUser.currentOrganisationId()}, modifier)
