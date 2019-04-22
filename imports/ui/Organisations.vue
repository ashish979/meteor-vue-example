<template lang="pug">
div
  div(v-if='!(allSubsReady)') Loading...
  div(v-else='')
    p
      span This is organisations list page
      button(@click='insertOrganisation') Insert Organisation
    br
    ul
      li(v-for='o in OrganisationCursor') {{o.name}}  -  {{o._id}}

</template>

<script lang="coffee">

import { Time } from '/imports/collections/Time.coffee'
import { Organisation } from '/imports/collections/Organisation.coffee'

export default

  computed:
    allSubsReady: ->
      subscriptionKeys = Object.keys(this.$subReady);
      subsReady = subscriptionKeys[0] != null;
      for i in subscriptionKeys.length
        key = subscriptionKeys[i]
        subsReady = subsReady && @$subReady[key]
      subsReady

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
