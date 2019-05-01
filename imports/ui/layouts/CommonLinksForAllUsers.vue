<template lang='pug'>
.common-links
  v-list-tile(@click='logout')
    v-btn(icon)
      v-icon fa fa-sign-out
    v-list-tile-content
      v-list-tile-title Logout
</template>

<script lang='coffee'>
import NavigationLink from '/imports/ui/vueComponents/helperComponents/NavigationLink.vue'

export default
  data: ->
    insightsLink: {
      name: 'Insights'
    }

  components:
    'navigation-link': NavigationLink

  methods:
    logout: -> Meteor.logout()
</script>


