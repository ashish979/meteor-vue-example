import { Mongo } from 'meteor/mongo'
import SimpleSchema from 'simpl-schema'
import { Factory } from 'meteor/dburles:factory'
import { Tracker } from 'meteor/tracker'
import faker from 'faker'

OrganisationRoles = new Mongo.Collection('OrganisationRoles')

OrganisationRoles.schema = new SimpleSchema
  name:
    type: String
    label: 'Name'
    max: 250
    min: 1
    optional: false
  organisationId:
    type: String
    min: 1
    optional: false
,
  tracker: Tracker
  requiredByDefault: false

OrganisationRoles.attachSchema OrganisationRoles.schema

OrganisationRoles.helpers
  reload: -> OrganisationRoles.findOne(@_id)

Factory.define 'organisationRole', OrganisationRoles,
  organisationId: -> Factory.get('organisation')
  name: -> faker.lorem.word()

exports.OrganisationRoles = OrganisationRoles
