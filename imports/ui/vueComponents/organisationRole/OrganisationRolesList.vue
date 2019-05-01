<template lang='pug'>
.roles-list.scroll-container(v-if='canView')
  h1 Organisations Roles
  organisation-role(v-for='role in organisationRoles' :role='role' :key='role._id')
v-card.pa-3.red-text(v-else) Permission Denied
</template>

<script lang='coffee'>
import { Meteor } from 'meteor/meteor'
import { OrganisationRoles } from '/imports/api/organisationRoles/collection.coffee'
import OrganisationRole from './OrganisationRole.vue'
import _ from 'lodash'

export default
  meteor:
    canView: -> Meteor.user().isSuperAdmin() or Meteor.user().isOrganisationAdmin()
    organisationRoles: -> OrganisationRoles.find({organisationId: Meteor.user().currentOrganisationId()}, {sort: {name: 1}})

  components:
    'organisation-role': OrganisationRole
</script>
