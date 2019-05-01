import { Meteor } from 'meteor/meteor'
import { ValidatedMethod } from 'meteor/mdg:validated-method'
import { Organisations } from './collection.coffee'
import { MethodPermissionMixin } from '/imports/api/methodMixins/methodPermissionMixin.coffee'
import SimpleSchema from 'simpl-schema'

module.exports.insert = new ValidatedMethod
  name: 'organisations.insert'
  validate: Organisations.schema.pick('name').validator()
  mixins: [MethodPermissionMixin]
  roles: ['superAdmin']
  run: (newOrganisation)->
    Organisations.insert(newOrganisation)
