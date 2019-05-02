<template lang='pug'>
.roles-list.scroll-container(v-if='canView')
  h1 Organisations Roles
  v-card.pa-3.mb-2
    h3 Create Role
    new-organisation-role
  v-divider
  organisation-role(v-for='role in organisationRoles' :role='role' :key='role._id')
v-card.pa-3.red-text(v-else) Permission Denied
</template>

<script lang='coffee'>
import { Meteor } from 'meteor/meteor'
import { OrganisationRoles } from '/imports/api/organisationRoles/collection.coffee'

import NewOrganisationRole from './NewOrganisationRole.vue'
import OrganisationRole from './OrganisationRole.vue'

export default
  meteor:
    canView: -> Meteor.user().isSuperAdmin() or Meteor.user().isOrganisationAdmin()
    organisationRoles: ->
      console.log("******** inside org roles meteor method ********")
      OrganisationRoles.find({organisationId: Meteor.user().currentOrganisationId()}, {sort: {name: 1}})

  components:
    'new-organisation-role': NewOrganisationRole
    'organisation-role': OrganisationRole
</script>

