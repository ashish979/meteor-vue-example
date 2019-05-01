import { Meteor } from 'meteor/meteor'

import '../simpleSchema.coffee'
import './registerApi.coffee'

import { Roles } from 'meteor/alanning:roles'
import { OrganisationRoles } from '/imports/api/organisationRoles/collection.coffee'
import { Stocks } from '/imports/api/stocks/collection.coffee'
import { Organisations } from '/imports/api/organisations/collection.coffee'
import { createUser } from '/imports/scripts/createUser.coffee'

Meteor.startup(() =>
# code to run on server at startup
  superAdminEmail = process.env.ADMIN_EMAIL or 'abhima9yu@gmail.com'
  superAdminPassword = process.env.ADMIN_PASSWORD or 'password'

  superAdmin = Accounts.findUserByEmail superAdminEmail
  if superAdmin?
    console.log "Found user with superAdmin email #{superAdminEmail}"
  else
    console.log "No existing superAdmin found."
    Accounts.createUser(email: superAdminEmail, password: superAdminPassword)
    console.log "Created user with superAdmin email #{superAdminEmail}"
    superAdmin = Accounts.findUserByEmail superAdminEmail

  unless superAdmin.isSuperAdmin()
    console.log "Making user with #{superAdminEmail} a superAdmin"
    Roles.addUsersToRoles(superAdmin._id, 'superAdmin', Roles.GLOBAL_GROUP)

  if Organisations.find().count() < 10
    organisations = (Factory.create('organisation') for [1..10])
    for organisation in organisations
      createUser("#{organisation._id}-#{i}", organisation._id) for i in [1..100]
      Factory.create('organisationRole', {organisationId: organisation._id}) for [1..5]
      Factory.create('stock', {organisationId: organisation._id}) for [1..20]
)
