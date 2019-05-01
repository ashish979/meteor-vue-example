<template lang='pug'>
a(@click='selectOrganisation')
  v-card.pa-3.mt-2.organisation.card-panel(:hover='true') {{organisation.name}}
</template>

<script lang='coffee'>
import { Meteor } from 'meteor/meteor'

export default
  props: ['organisation']

  methods:
    selectOrganisation: ->
      Meteor.call('users.setSelectedOrganisation', { organisationId: @organisation._id })
</script>

<style lang='stylus' scoped>
  a
    text-decoration: none
</style>
