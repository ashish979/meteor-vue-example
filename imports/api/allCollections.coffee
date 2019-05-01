import { Organisations } from '/imports/api/organisations/collection.coffee'
import { OrganisationRoles } from '/imports/api/organisationRoles/collection.coffee'
import { Stocks } from '/imports/api/stocks/collection.coffee'
import '/imports/api/users/collection.coffee'

module.exports =
  Organisations: Organisations
  OrganisationRoles: OrganisationRoles
  Stocks: Stocks
