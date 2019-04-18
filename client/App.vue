<template lang="pug">
div
  div(v-if='!(allSubsReady)') Loading...
  div(v-else='')
    p Hello {{hello}},
    br
    span The time is now: {{currentTime}}
    button(@click='updateTime') Update Time
    hr
    p Organisations list
    ul
      li(v-for='o in OrganisationCursor') {{o.name}}  -  {{o._id}}
    button(@click='insertOrganisation') Insert Organisation
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

  data: ->
    hello: 'World'
    settings: Meteor.settings.public

  methods:
    updateTime: ->
      console.log('Calling Meteor Method UpdateTime');
      Meteor.call('UpdateTime');

    insertOrganisation: ->
      Meteor.call('InsertOrganisation');

  meteor:
    $subscribe:
      'Time': []
      'Organisation': []
      'OrganisationData': -> [this.organisationIds]

    currentTime: ->
      console.log('Calculating currentTime');
      t = Time.findOne('currentTime') || {};
      t.time

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
