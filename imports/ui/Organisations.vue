<template lang="pug">
div
  div(v-if='allSubscriptionsReady')
    p
      span This is organisations list page
      button(@click='insertOrganisation') Insert Organisation
    br
    ul
      li(v-for='o in OrganisationCursor') {{o.name}}  -  {{o._id}}
  div(v-else) Loading...
</template>

<script lang='coffee'>

import { _ } from 'lodash'
import { Time } from '/imports/collections/Time.coffee'
import { Organisation } from '/imports/collections/Organisation.coffee'

export default
  computed:
    allSubscriptionsReady: ->
      !_.includes(@$subReady, false)

  methods:
    insertOrganisation: ->
      Meteor.call('InsertOrganisation');

  meteor:
    $subscribe:
      'Time': []
      'Organisation': []
      'OrganisationData': -> [this.organisationIds]

    OrganisationCursor: ->
      Organisation.find({})

    organisationIds: ->
      @OrganisationCursor?.map((organisation) => organisation._id)

</script>

<style scoped>
  p {
    font-size: 2em;
  }
</style>
