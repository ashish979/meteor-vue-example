<template lang='pug'>
.super-admin-links
  navigation-link(:to="{name: 'Organisations.list'}" icon='fa fa-exchange' title="Organisations")
  navigation-links-for-admin(v-if='currentOrganisation')
</template>

<script lang='coffee'>
import NavigationLinksForAdmin from './NavigationLinksForAdmin.vue'
import NavigationLink from '/imports/ui/vueComponents/helperComponents/NavigationLink.vue'

currentUser = -> Meteor.user()

export default
  meteor:
    currentOrganisation: -> currentUser()?.currentOrganisation()
  components:
    'navigation-links-for-admin': NavigationLinksForAdmin
    'navigation-link': NavigationLink
</script>
