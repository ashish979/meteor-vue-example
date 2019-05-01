<template lang="pug">
.organisation-users-list.scroll-container(v-if="canView")
  h1 Organisation Users
  organisation-user(v-for="_organisationUser in organisationUsers"
                    :key="_organisationUser._id"
                    :organisationUser="_organisationUser" class="my-1")
v-layout(v-else)
  p Permission Denied
</template>

<script lang="coffee">
import { Meteor } from 'meteor/meteor'

#components
import OrganisationUser from './OrganisationUser.vue'

export default
  meteor:
    $subscribe:
      'organisationUsers': -> [@currentOrganisationId]

    canView: -> Meteor.user().isSuperAdmin() or Meteor.user().isOrganisationAdmin()

    currentOrganisationId: -> Meteor.user()?.currentOrganisationId()

    organisationUsers: ->
      Meteor.users.find({organisationId: @currentOrganisationId}, {sort: {name: 1}})

  components:
    'organisation-user': OrganisationUser
</script>

<style>

</style>
