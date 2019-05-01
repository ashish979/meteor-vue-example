import { Meteor } from 'meteor/meteor'
import SimpleSchema from 'simpl-schema'
import { MethodPermissionMixin } from '/imports/api/methodMixins/methodPermissionMixin.coffee'
import { ValidatedMethod } from 'meteor/mdg:validated-method'

import './collection.coffee'

module.exports.setSelectedOrganisation = new ValidatedMethod
  name: 'users.setSelectedOrganisation'
  mixins: [MethodPermissionMixin]
  validate: Meteor.users.schema.pick('organisationId').validator()
  roles: ['superAdmin']
  run: ({organisationId})->
    @currentUser.setSelectedOrganisationId(organisationId)
