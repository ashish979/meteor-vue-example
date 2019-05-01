<template lang='pug'>
.organisation-list.scroll-container(v-if='canView')
  h1 Organisations
  v-card.pa-3.mb-2
    h3 Create Organisation
    new-organisation
  .divider
  organisation(v-for='_organisation in organisations' :organisation='_organisation' :key = "_organisation._id")
v-card.pa-3.red-text(v-else) Permission Denied
</template>

<script lang='coffee'>
import { Meteor } from 'meteor/meteor'
import { Organisations } from '/imports/api/organisations/collection.coffee'

#components
import NewOrganisation from './NewOrganisation.vue'
import Organisation from './Organisation.vue'

currentUser = -> Meteor.user()

export default
  meteor:
    organisations: -> Organisations.find({}, {sort: {name: 1}})
    canView: -> currentUser()?.isSuperAdmin()

    $subscribe:
      'organisations': []

  components:
    'new-organisation': NewOrganisation
    'organisation': Organisation
</script>
