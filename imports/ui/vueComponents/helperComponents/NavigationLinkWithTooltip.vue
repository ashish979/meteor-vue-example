<template lang='pug'>
v-tooltip(top :disabled='isCordovaApp')
  navigation-link(
    :to="to"
    :icon='icon'
    :title="title"
    slot='activator'
  )
  span {{ tooltipText }}
</template>

<script lang='coffee'>
import { Meteor } from 'meteor/meteor'
import NavigationLink from '/imports/ui/vueComponents/helperComponents/NavigationLink.vue'

export default
  props: ['to', 'title', 'icon', 'tooltip']

  computed:
    tooltipText: -> @tooltip || @title

  components:
    'navigation-link': NavigationLink
</script>
